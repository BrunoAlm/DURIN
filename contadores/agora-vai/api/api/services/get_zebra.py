import socket
def get_info_zebra(ip):
    if ip == '0.0.0.0':
        return 'N/A'

    comando_zpl = '^XA^HH^XZ'
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    try:
        sock.connect((ip, 9100))
        sock.sendall(comando_zpl.encode())

        response = sock.recv(4096).decode('latin-1')
        start_index = response.find('^HH') + 3
        end_index = response.find('^H', start_index)
        counter_value = response[start_index:end_index]

        line = counter_value.split('\n')
        field_line = next((l for l in line if 'CONT NAO REINIC' in l or 'NT-RESET TLR' in l))

        cont_nao_reinic = field_line.split('CONT NAO REINIC')[0].strip()
        contador_atual = cont_nao_reinic[:-3]
        sock.close()
        return contador_atual

    except Exception as e:
        print(f"Erro ao ler contador da impressora Zebra ({ip}): {str(e)}")
        return "Indisponível" 
    
    