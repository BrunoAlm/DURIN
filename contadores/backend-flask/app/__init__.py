from flask import Flask, render_template, send_from_directory
from app.models.models import db, Contador
from flask_cors import CORS
import os

def create_app():
    # Criar a instância da aplicação Flask
    app = Flask(__name__, static_folder='templates')

    # Configurações SQLAlchemy
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///../app/db/contadores.db'
    db.init_app(app)
    with app.app_context():
        db.create_all()

    # Registrar blueprints
    from api.endpoints import api_bp
    app.register_blueprint(api_bp, url_prefix='/api')

    # Adicionar CORS à aplicação
    CORS(app)

    print(app.static_url_path)
    print(app.static_folder)

    # Rotas
    @app.route('/')
    def index():
        return render_template('index.html')

    return app
