
# Função para gravar o contador no arquivo contador.txt
def gravar_contador(contadores):
    # Abre o arquivo em modo de escrita (w)
    with open('generated/contador.txt', 'w', encoding='utf-8') as arquivo:
        # Escrever várias linhas no arquivo
        arquivo.writelines(contadores)