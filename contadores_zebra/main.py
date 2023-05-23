import le_contadores as contadores

# Define o endereço IP e a porta da impressora Zebra
ips_zebras = [
    '10.0.3.11', '10.0.3.12', '10.0.3.13', '10.0.3.14',
    '10.0.3.15', '10.0.3.16', '10.0.3.19',
    '10.0.3.20', '10.0.3.21', '10.0.3.30',
    '10.0.3.47', '10.0.3.44', '10.0.3.41',
    '10.0.3.45', '10.0.3.49'
]
# Porta de comunicação com a impressora
printer_port = 9100

# Cria o comando ZPL para recuperar o valor do contador
zpl_command = '^XA^HH^XZ'

contadores.ler_contador(ips_zebras, printer_port, zpl_command)