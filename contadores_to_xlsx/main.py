import openpyxl
import sys
sys.path.append('..\\contadores_zebra')
print(sys.path)

from pega_contador import pega_contador

# Carregar a planilha
workbook = openpyxl.load_workbook('C:\\Users\\bruno.almeida\\Pictures\\Rateio ZEBRA TESTE 2023.xlsx')

# Selecionar a pasta que deseja editar
sheet = workbook['CONTADORES']

# Criar uma lista das linhas da planilha
rows = list(sheet.iter_rows(min_row=3, values_only=True))

# Obter a lista de contadores
contadores = pega_contador()

# Iterar por cada linha na lista
for row in rows:
    selb = row[0]  # Coluna SELB (índice 0)

    # Procurar o contador com o mesmo 'selb' na lista de contadores
    for contador in contadores:
        if contador['selb'] == selb:
            print(selb)
            cont_nao_reinic = contador['cont_nao_reinic']
            print(cont_nao_reinic)
            # Converter a tupla em uma lista
            row = list(row)
            # Atualizar a coluna CONTADOR ATUAL (índice 2)
            row[2] = cont_nao_reinic
            print('row[2] -> ' + row[2])
            # Converter a lista de volta em uma tupla
            row = tuple(row)
            break  # Parar a busca após encontrar o 'selb' correspondente
        

print("Salvando alterações...")
# Salvar as alterações em um novo arquivo ou sobrescrever o arquivo existente
workbook.save('C:\\Users\\bruno.almeida\\Pictures\\Rateio ZEBRA TESTE 2023 modificadaa.xlsx')
print("Alterações salvas com sucesso.")