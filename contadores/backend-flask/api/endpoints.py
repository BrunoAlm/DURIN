from flask import Blueprint, jsonify, Response, request
import json
from datetime import datetime
from app.models.models import Impressora, Contador, db
from api.services.snmpwalk_laser import snmpwalk, oidContador
from flask_socketio import emit
from app import socketio

api_bp = Blueprint('api', __name__)

@api_bp.route('/impressoras', methods=['GET'])
def obter_impressoras_com_contadores():
    impressoras = Impressora.query.all()

    dados_impressoras = []
    for impressora in impressoras:
        # Obter os contadores associados a esta impressora
        contadores = Contador.query.filter_by(impressora_id=impressora.id).all()

        # Serializar os contadores associados a esta impressora
        contadores_serializados = [{
            'id': contador.id,
            'contador_atual': contador.contador_atual,
            'data_registro': contador.data_registro.strftime('%Y-%m-%d %H:%M:%S')
            # Adicione mais campos, se necessário
        } for contador in contadores]

        # Serializar os dados da impressora e adicionar os contadores
        dados_impressora = {
            'id': impressora.id,
            'nome': impressora.nome,
            'ip': impressora.ip,
            'selb': impressora.selb,
            'setor': impressora.setor,
            'tipo': impressora.tipo,
            'contadores': contadores_serializados
        }

        dados_impressoras.append(dados_impressora)

    # Retornar a resposta JSON com a codificação correta
    response = Response(json.dumps(dados_impressoras, ensure_ascii=False), content_type='application/json; charset=utf-8')
    return response

@socketio.on('atualizar_contadores')
def atualizar_contadores():
    todas_impressoras = Impressora.query.all()
    total_impressoras = len(todas_impressoras)
    progresso_intervalo = 5  # Emitir progresso a cada 5%

    for idx, impressora in enumerate(todas_impressoras, start=1):
        # Atualiza o contador via snmp
        impressora.contadores.append(Contador(contador_atual=snmpwalk(impressora.ip,oidContador)))
        
        # Emitir o progresso via WebSocket a cada intervalo
        progresso = int((idx / total_impressoras) * 100)
        if progresso % progresso_intervalo == 0 or idx == total_impressoras:
            emit('progresso_atualizacao', {'progresso': progresso})
        print(f'atualiando contador {impressora.nome}')

        
    # Commit após o loop de atualização de contadores
    db.session.commit()
    
    # Indicar que a operação foi concluída
    emit('progresso_atualizacao', {'progresso': 100})