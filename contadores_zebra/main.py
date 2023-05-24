from src.functions.ler_contador import ler_contador
from src.functions.obter_impressoras_zebra import obter_impressoras_zebra
from src.functions.gravar_contador import gravar_contador
from service.enviar_email import enviar_email
from src.functions.gravar_contador_html import gravar_contador as html

# Quantidade de impressoras
qtd_impressoras = len(obter_impressoras_zebra())

# IPs das impressoras Zebra
ips_zebras = [impressora['ip'] for impressora in obter_impressoras_zebra()]

# Nomes das impressoras Zebra
printer_names = [impressora['nome']
                 for impressora in obter_impressoras_zebra()]

# SELB das impressoras Zebra
selbs = [impressora['selb'] for impressora in obter_impressoras_zebra()]

# Porta de comunicação com a impressora
printer_port = 9100


# Cria o comando ZPL para recuperar o valor do contador

zpl_command = '^XA^HH^XZ'
total_contadores = []
# Cabeçalho da tabela
print('Gerando relatório...')
# Envia o comando ZPL para a impressora

for (i) in range(qtd_impressoras):
    print('Lendo contador da impressora {}...'.format(printer_names[i]))
    ip_zebra = ips_zebras[i]
    printer_name = printer_names[i]
    selb = selbs[i]

    # Le o contador e coloca no na lista total_contadores
    total_contadores.append(ler_contador(
        ip_zebra, printer_name, selb, printer_port, zpl_command))


html_gerado = html(total_contadores)
enviar_email(html_gerado)
print('Concluído!')
