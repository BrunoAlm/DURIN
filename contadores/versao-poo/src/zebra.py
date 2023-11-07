from models.impressora_model import Impressora


class Zebra(Impressora):
    def ler_contador(self):
        try:
            if self.ip == '0.0.0.0':
                return {
                    'selb': self.selb,
                    'nome': self.nome,
                    'ip': self.ip,
                    'cont_nao_reinic': 'INACESSÍVEL'
                }

            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
                sock.connect((self.ip, self.porta))
                sock.sendall(self.comando_zpl.encode())

                response = sock.recv(4096).decode('latin-1')

                start_index = response.find('^HH') + 3
                end_index = response.find('^H', start_index)
                counter_value = response[start_index:end_index]

                line = counter_value.split('\n')
                field_line = next(
                    (l for l in line if 'CONT NAO REINIC' in l or 'NT-RESET TLR' in l), None)

                cont_nao_reinic = field_line.split(
                    'CONT NAO REINIC')[0].strip()
                cont_nao_reinic = cont_nao_reinic[:-3]

                contador = {
                    'selb': self.selb,
                    'nome': self.nome,
                    'ip': self.ip,
                    'cont_nao_reinic': cont_nao_reinic
                }

                return contador

        except Exception as e:
            contador = {
                'selb': self.selb,
                'nome': self.nome,
                'ip': self.ip,
                'cont_nao_reinic': 'INACESSÍVEL'
            }
            return contador