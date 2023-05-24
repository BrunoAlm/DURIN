import json

def obter_impressoras_zebra():
    # Abre o arquivo JSON de configurações das impressoras
    with open('src/data/impressoras_zebra.json', 'r', encoding= 'utf-8') as arquivo_json:
        # Faz a leitura do conteúdo do arquivo
        json_data = arquivo_json.read()

        # Faz o parsing do JSON
        data = json.loads(json_data)

        # Acessa os dados do JSON
        impressoras_zebra = data['impressoras']['zebras']

        # Lista para armazenar os dados das impressoras
        dados_impressoras = []

        # Itera sobre as impressoras
        for impressora, info in impressoras_zebra.items():
            nome = impressora
            ip = info['ip']
            selb = info['selb']

            # Armazena os dados da impressora na lista
            dados_impressoras.append({
                'nome': nome,
                'ip': ip,
                'selb': selb
            })

        # Retorna os dados das impressoras
        return dados_impressoras
