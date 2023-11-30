import socket

def ler_contador_zebra(ip_zebra, printer_name, selb, porta, comando_zpl):
    try:
        if ip_zebra == '0.0.0.0':
            contador = {
                'selb': selb,
                'nome': printer_name,
                'ip': ip_zebra,
                'cont_nao_reinic': 'INACESSÍVEL'
            }
            return contador

        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.connect((ip_zebra, porta))
        sock.sendall(comando_zpl.encode())

        response = sock.recv(4096).decode('latin-1')

        start_index = response.find('^HH') + 3
        end_index = response.find('^H', start_index)
        counter_value = response[start_index:end_index]

        line = counter_value.split('\n')
        field_line = next((l for l in line if 'CONT NAO REINIC' in l or 'NT-RESET TLR' in l), None)

        cont_nao_reinic = field_line.split('CONT NAO REINIC')[0].strip()
        cont_nao_reinic = cont_nao_reinic[:-3]

        contador = {
            'selb': selb,
            'nome': printer_name,
            'ip': ip_zebra,
            'cont_nao_reinic': cont_nao_reinic
        }

        sock.close()

        return contador

    except Exception as e:
        contador = {
            'selb': selb,
            'nome': printer_name,
            'ip': ip_zebra,
            'cont_nao_reinic': 'INACESSÍVEL'
        }
        return contador
