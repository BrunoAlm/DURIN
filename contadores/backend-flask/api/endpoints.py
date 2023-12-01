from flask import Blueprint, jsonify, Response, request
import json
from datetime import datetime
from app.models.models import Impressora, Contador, db

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
@api_bp.route('/impressoras/<int:impressora_id>', methods=['POST'])
def adicionar_contador(impressora_id):
    # Obter os dados do contador do corpo da solicitação POST
    dados_contador = request.json

    # Obter contador_atual dos dados fornecidos
    contador_atual = dados_contador.get('contador_atual')

    # Obter data_registro dos dados fornecidos, se não fornecido, usar datetime.now()
    data_registro = dados_contador.get('data_registro')
    if data_registro is None:
        data_registro = datetime.now()

    # Criar uma nova instância de Contador
    novo_contador = Contador(contador_atual=contador_atual, data_registro=data_registro, impressora_id=impressora_id)

    # Salvar o novo contador no banco de dados
    db.session.add(novo_contador)
    db.session.commit()

    return jsonify({'message': 'Novo contador adicionado com sucesso!'}), 201  # 201 significa Created
