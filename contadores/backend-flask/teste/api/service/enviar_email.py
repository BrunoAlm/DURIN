import os
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
# dotenv serve para carregar as variáveis de ambiente do arquivo .env
from dotenv import load_dotenv


def enviar_email(html_gerado):

    # Configurações do servidor de e-mail
    host = 'smtp.durin.com.br'
    porta = 587
    remetente = 'suporte@durin.com.br'
    senha = 'Home@durin'

    # Cria o objeto de mensagem
    mensagem = MIMEMultipart()
    mensagem['From'] = remetente
    mensagem['To'] = remetente
    mensagem['Subject'] = 'Contadores Zebra'

    # Adiciona o corpo da mensagem
    mensagem.attach(MIMEText(html_gerado, 'html'))

    # Conecta-se ao servidor de e-mail
    servidor = smtplib.SMTP(host, porta)
    servidor.connect(host, porta)
    servidor.starttls()
    servidor.login(remetente, senha)

    # Envia o e-mail
    servidor.send_message(mensagem)
    servidor.quit()
