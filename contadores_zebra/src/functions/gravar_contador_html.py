def gravar_contador(total_contadores):
    # Cabeçalho da tabela
    html = '''
    <html>
    <head>
        <style>
            table {
                border-collapse: collapse;
                width: 100%;
            }
            th, td {
                padding: 8px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }
            th {
                background-color: #f2f2f2;
            }
        </style>
    </head>
    <body>
        <table>
            <tr>
                <th>SELB</th>
                <th>IMPRESSORA</th>
                <th>IP</th>
                <th>CONTADOR</th>
            </tr>
    '''

    # Conteúdo da tabela
    for contador in total_contadores:
        html += '''
            <tr>
                <td>{}</td>
                <td>{}</td>
                <td>{}</td>
                <td>{}</td>
            </tr>
        '''.format(contador['selb'], contador['printer_name'], contador['ip'], contador['cont_nao_reinic'])

    # Fechamento do HTML
    html += '''
        </table>
    </body>
    </html>
    '''

    # Grava o HTML no arquivo
    with open('generated/contador.html', 'w') as arquivo:
        arquivo.write(html)

    return html
