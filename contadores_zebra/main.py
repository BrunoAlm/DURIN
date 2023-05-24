from src.functions.ler_contador import ler_contador
from src.functions.obter_impressoras_zebra import obter_impressoras_zebra
from src.functions.gravar_contador import gravar_contador
from service.enviar_email import enviar_email

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
print('SELB | PRINTER NAME | IP | CONT NAO REINIC')
# Envia o comando ZPL para a impressora

for (i) in range(qtd_impressoras):

    ip_zebra = ips_zebras[i]

    printer_name = printer_names[i]

    selb = selbs[i]

    # Le o contador e coloca no na lista total_contadores
    total_contadores.append(ler_contador(
        ip_zebra, printer_name, selb, printer_port, zpl_command))

# Imprime o valor do contador no arquivo generated\contador.txt
gravar_contador(total_contadores)

enviar_email(total_contadores)
