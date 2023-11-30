from flask import Blueprint, jsonify

api_bp = Blueprint('api', __name__)

@api_bp.route('/contador', methods=['GET'])
def obter_contador():
    # Aqui você pode colocar a lógica para obter os dados dos contadores e retorná-los
    dados_contador = {
        'impressora_1': {'contagem': 100},
        'impressora_2': {'contagem': 200},
        # Adicione mais dados conforme necessário
    }
    return jsonify(dados_contador)
