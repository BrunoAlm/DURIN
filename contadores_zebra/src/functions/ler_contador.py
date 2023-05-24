import socket
import json

def ler_contador(ip_zebra, printer_name, selb, porta, comando_zpl):
    try:
        # Abre uma conexão de socket com a impressora
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.connect((ip_zebra, porta))

        # Envia o comando ZPL para a impressora
        sock.sendall(comando_zpl.encode())

        # Recebe a resposta da impressora
        response = sock.recv(4096).decode('latin-1')

        # Analisa a resposta para obter o valor do contador não resetável
        start_index = response.find('^HH') + 3
        end_index = response.find('^H', start_index)

        # Obtem as configuracoes da impressora
        counter_value = response[start_index:end_index]

        # Encontra a linha que contém o campo 'CONT NAO REINIC'
        line = counter_value.split('\n')
        field_line = next((l for l in line if 'CONT NAO REINIC' in l), None)

        # Obtém a parte da linha antes do campo 'CONT NAO REINIC'
        cont_nao_reinic = field_line.split('CONT NAO REINIC')[0].strip()

        # Remove o IN do final da String cont_nao_reinic
        cont_nao_reinic = cont_nao_reinic[:-2]
    except Exception as e:
            print('Erro ao acessar a impressora', ip_zebra)
            cont_nao_reinic = 'INACESSÍVEL'
            exit()

    # Imprime SELB | NOME | IP | CONTADOR
    print(selb + ' | ' + printer_name + ' | ' + ip_zebra + ' → ' + cont_nao_reinic)
    contador_formatado = selb + ' | ' + printer_name + ' | ' + ip_zebra + ' → ' + cont_nao_reinic + '\n'
    
    # Fecha a conexão de socket
    sock.close()
    
    return contador_formatado
