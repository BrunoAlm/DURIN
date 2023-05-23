# grava uma lista de contadores em um arquivo txt

def gravar_contador(contadores):
    # Abre o arquivo em modo de escrita (w)
    with open('contador.txt', 'w', encoding='utf-8') as arquivo:
        # Escrever várias linhas no arquivo
        arquivo.writelines(contadores)