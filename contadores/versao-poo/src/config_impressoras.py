import json


# Classe de configuração para carregar informações das impressoras a partir do arquivo JSON
class ConfiguracaoImpressoras:
    def __init__(self, arquivo_configuracao):
        with open(arquivo_configuracao, 'r') as arquivo_json:
            dados = json.load(arquivo_json)
        self.impressoras_zebra = dados["impressoras"]["zebras"]
        self.impressoras_multifuncionais = dados["impressoras"]["multifuncionais"]

    def criar_impressoras(self):
        impressoras = []

        # Criar instâncias de ImpressoraZebra para cada impressora Zebra
        for impressora_id, info in self.impressoras_zebra.items():
            impressora = ImpressoraZebra(
                selb=info["selb"], nome=impressora_id, ip=info["ip"], setor=info["setor"])
            impressoras.append(impressora)

        # Criar instâncias de ImpressoraMultifuncional para cada impressora Multifuncional
        for impressora_id, info in self.impressoras_multifuncionais.items():
            impressora = ImpressoraMultifuncional(
                selb=info["selb"], nome=impressora_id, ip=info["ip"], setor=info["setor"])
            impressoras.append(impressora)

        return impressoras


# Uso da classe de configuração
arquivo_configuracao = 'caminho_para_seu_arquivo_json.json'
configuracao_impressoras = ConfiguracaoImpressoras(arquivo_configuracao)
impressoras = configuracao_impressoras.criar_impressoras()

# Agora você tem uma lista de objetos de impressora prontos para uso
for impressora in impressoras:
    contador = impressora.ler_contador()
    print(f'Impressora {impressora.nome} - Contador: {contador}')
