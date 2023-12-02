from flask import Flask, render_template
from flask_socketio import SocketIO
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS

db = SQLAlchemy()
socketio = SocketIO()

def create_app():
    # Criar a instância da aplicação Flask
    app = Flask(__name__, static_folder='templates')

    # Configurações SQLAlchemy
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///../app/db/contadores.db'
    db.init_app(app)

    # Configuração SocketIO
    app.config['SECRET_KEY'] = 'sua_chave_secreta'  # Altere para sua chave secreta
    socketio.init_app(app)

    with app.app_context():
        db.create_all()

    # Adicionar CORS à aplicação
    CORS(app)

    # Registrar blueprints
    from api.endpoints import api_bp
    app.register_blueprint(api_bp, url_prefix='/api')

    # Rotas
    @app.route('/')
    def index():
        return render_template('index.html')

    return app
