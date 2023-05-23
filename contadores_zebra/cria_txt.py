# grava uma lista de contadores em um arquivo txt

def gravar_contador(list_cont_nao_reinic):
    # Abre o arquivo em modo de escrita (w)
    with open('contador.txt', 'w') as arquivo:
        # Escrever várias linhas no arquivo
        arquivo.writelines(list_cont_nao_reinic)