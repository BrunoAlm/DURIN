import argparse

from service.enviar_email import enviar_email
from functions.gravar_contador import gravar_contador
from functions.gravar_contador_html import gravar_contador as html
from functions.ler_contador_multifuncionais import \
    ler_contador_multifuncionais
from functions.ler_contador_zebra import ler_contador_zebra
from functions.obter_impressoras_multifuncionais import \
    obter_impressoras_multifuncionais
from functions.obter_impressoras_zebra import obter_impressoras_zebra

# Zebras
# Quantidade de impressoras
qtd_impressoras_zebra = len(obter_impressoras_zebra())
# IPs
ips_zebras = [impressora['ip'] for impressora in obter_impressoras_zebra()]
# Nomes
nomes_zebras = [impressora['nome'] for impressora in obter_impressoras_zebra()]
# SELBs
selbs_zebras = [impressora['selb'] for impressora in obter_impressoras_zebra()]
# Porta de comunicação com a impressora
printer_port = 9100

# Multifuncionais
# Quantidade de impressoras
qtd_impressoras_multifuncionais = len(obter_impressoras_multifuncionais())
# IPs
ips_multifuncionais = [impressora['ip']
                       for impressora in obter_impressoras_multifuncionais()]
# Nomes
nomes_multifuncionais = [impressora['nome']
                         for impressora in obter_impressoras_multifuncionais()]
# SELBs
selbs_multifuncionais = [impressora['selb']
                         for impressora in obter_impressoras_multifuncionais()]
# Cria o comando ZPL para recuperar o valor do contador
zpl_command = '^XA^HH^XZ'

print('Gerando relatório...')

# Inicialização das listas
contadores_zebra = []
contadores_multifuncionais = []

# Criação do objeto ArgumentParser
parser = argparse.ArgumentParser(
    description='Argumento para filtrar os campos do html e gerar somente SELB e CONTADOR')

# Adição do argumento
parser.add_argument('-s', '--selbetti', action='store_true',
                    help='Gravar somente SELB e CONTADOR')

# Parse dos argumentos da linha de comando
args = parser.parse_args()


def pega_contador_zebras():
    for (i) in range(qtd_impressoras_zebra):
        print('Lendo contador da impressora {}...'.format(nomes_zebras[i]))
        ip = ips_zebras[i]
        nome = nomes_zebras[i]
        selb = selbs_zebras[i]

        # Le o contador e coloca no na lista contadores_zebra
        contadores_zebra.append(ler_contador_zebra(
            ip, nome, selb, printer_port, zpl_command))

        print('Concluído!')
    return contadores_zebra


def pega_contador_multifuncionais():
    for (i) in range(qtd_impressoras_multifuncionais):
        print('Lendo contador da impressora {}...'.format(
            nomes_multifuncionais[i]))
        ip = ips_multifuncionais[i]
        nome = nomes_multifuncionais[i]
        selb = selbs_multifuncionais[i]

        # Le o contador e coloca no na lista contadores_multifuncionais
        contadores_multifuncionais.append(
            ler_contador_multifuncionais(ip, nome, selb))
        print('Concluído!\n')

    return contadores_multifuncionais


# def gera_zebra_email():
#     enviar_email(html(pega_contador_zebras(), 'zebra', selbetti=True))
# enviar_email(html(pega_contador_zebras(), 'zebra', selbetti=True))

# def gera_zebra_html():
#     html(pega_contador_zebras(), 'zebra', selbetti=False)
enviar_email(html(pega_contador_multifuncionais(),'multifuncionais', selbetti=False))

# def gera_html_multifuncionais():
#     html(pega_contador_multifuncionais(),'multifuncionais', selbetti=False)
# gera_html_multifuncionais()

print('Tudo concluído!')
