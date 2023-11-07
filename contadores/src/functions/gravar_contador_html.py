def gravar_contador(total_contadores, tipo, selbetti):
    # Cabeçalho da tabela
    if selbetti:
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
                tr:hover {
                    background-color: #f4f4f4;
                }
            </style>
        </head>
        <body>
            <table>
                <tr>
                    <th>SELB</th>
                    <th>CONTADOR</th>
                </tr>
        '''
    else:
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
                tr:hover {
                    background-color: #f4f4f4;
                }
            </style>
        </head>
        <body>
            <table>
                <tr>
                    <th>TIPO</th>
                    <th>SELB</th>
                    <th>IMPRESSORA</th>
                    <th>IP</th>
                    <th>CONTADOR</th>
                </tr>
        '''
    # Conteúdo da tabela
    for contador in total_contadores:
        if selbetti:
            html += '''
                <tr>
                    <td>{}</td>
                    <td>{}</td>
                </tr>
            '''.format(contador['selb'], contador['cont_nao_reinic'])

        else:
            html += '''
                <tr>
                    <td>{}</td>
                    <td>{}</td>
                    <td>{}</td>
                    <td>{}</td>
                    <td>{}</td>
                </tr>
            '''.format(tipo, contador['selb'], contador['nome'], contador['ip'], contador['cont_nao_reinic'])

    # Fechamento do HTML
    html += '''
        </table>
    </body>
    </html>
    '''

    # Grava o HTML no arquivo
    with open(f'generated/contador-{tipo}.html', 'w') as arquivo:
        arquivo.write(html)

    return html
