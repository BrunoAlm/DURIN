import cria_txt as txt
import socket

def ler_contador(ips_zebras, porta, comando_zpl):
    contadores = []
    for printer_ip in ips_zebras:
        try:
            # Abre uma conexão de socket com a impressora
            sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            sock.connect((printer_ip, porta))
        except Exception as e:
            print('Erro ao acessar a impressora', printer_ip)
            print(e)
            sock.close()
            exit()

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

        # Imprime o valor do campo 'CONT NAO REINIC'
        print(printer_ip + ' → ' + cont_nao_reinic)
        contadores = contadores + [cont_nao_reinic + '\n']
        txt.gravar_contador(contadores)
        # Fecha a conexão de socket
        sock.close()
