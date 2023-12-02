from app import create_app

# Criar a aplicação Flask
app = create_app()

if __name__ == '__main__':
    # Executar a aplicação Flask
    app.run(debug=True)