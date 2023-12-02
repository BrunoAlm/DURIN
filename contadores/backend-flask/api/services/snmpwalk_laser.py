from pysnmp.hlapi import *

def snmpwalk(ip, oid):
    erroIndicado, statusErro, _, valores = next(
        getCmd(SnmpEngine(),
               CommunityData('public'),
               UdpTransportTarget((ip, 161)),
               ContextData(),
               ObjectType(ObjectIdentity(oid)))
    )

    if erroIndicado:
        return f"Erro: {erroIndicado}"
    else:
        if statusErro:
            return f"Erro: {statusErro.prettyPrint()}"
        else:
            for valorEncontrado in valores:
                valorCompleto = valorEncontrado.prettyPrint()
                valor = valorCompleto.split('=')[-1].strip()
                return valor
                
# Impressora teste
host = '10.1.3.5'

# IODs
oidContador = '1.3.6.1.2.1.43.10.2.1.4.1.1'
oidNivelToner = '1.3.6.1.4.1.236.11.5.1.1.3.22.0'
oidStatusImpressora = '1.3.6.1.2.1.43.16.5.1.2.1.1'

# Chamada das funções
contador = snmpwalk(host, oidContador)
nivelToner = snmpwalk(host, oidNivelToner)
status = snmpwalk(host, oidStatusImpressora)

# Exibe no console
print(f'\nContador: {contador}')
print(f'Nível de toner: {nivelToner}%')
print(f'Status da impressora: {status}\n')
