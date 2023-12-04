from flask import Blueprint, jsonify, Response, request
import json
from datetime import datetime
from app.models.models import Impressora, Contador, db
from api.services.snmpwalk_laser import snmpwalk
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


# Definindo a rota POST para adicionar um contador a uma impressora
# @api_bp.route('/atualizar-contadores', methods=['PUT'])
# def atualizar_contadores():
#     impressoras = Impressora.query.all()

#     for impressora in impressoras:
#         ip_impressora = impressora.ip
#         if ip_impressora:
#             oid_contador = '1.3.6.1.2.1.43.10.2.1.4.1.1'

#             valor_contador = snmpwalk(ip_impressora, oid_contador)

#             if valor_contador is not None:
#                 novo_contador = Contador(contador_atual=valor_contador, impressora_id=impressora.id)
#                 db.session.add(novo_contador)
#                 db.session.commit()

#     return jsonify({'message': 'Contadores atualizados com sucesso!'}), 201

@socketio.on('atualizar_contadores')
def atualizar_contadores():
    todas_impressoras = Impressora.query.all()
    total_impressoras = len(todas_impressoras)
    progresso_intervalo = 5  # Emitir progresso a cada 5%
    print('ta coisando')

    for idx, impressora in enumerate(todas_impressoras, start=1):
        # Atualiza o contador para algum valor específico, por exemplo, 100
        impressora.contadores.append(Contador(contador_atual=100))
        
        # Emitir o progresso via WebSocket a cada intervalo
        progresso = int((idx / total_impressoras) * 100)
        if progresso % progresso_intervalo == 0 or idx == total_impressoras:
            emit('progresso_atualizacao', {'progresso': progresso})
        print(impressora)

        
    # Commit após o loop de atualização de contadores
    db.session.commit()
    
    # Indicar que a operação foi concluída
    emit('progresso_atualizacao', {'progresso': 100})