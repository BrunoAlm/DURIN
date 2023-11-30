from flask import Blueprint
from flask_cors import CORS
# Criação do Blueprint para os endpoints da API
api_bp = Blueprint('api', __name__)
CORS(api_bp, resources={r"/api/contador": {"origins": "*"}})
# Importar os endpoints para registrar no Blueprint
from . import endpoints  # Suponha que os endpoints estejam em endpoints.py