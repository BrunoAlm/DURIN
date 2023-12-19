from pysnmp.hlapi import *
def tratar_mensagens(error):
    if "No Such Object currently exists at this OID" in error:
        print("Tratando erro: OID incorreto")
        return "OID incorreto"
    
    if "No SNMP response received before timeout" in error:
        print("Tratando erro: Inacessível")
        return "Inacessível"

    if "argument of type 'RequestTimedOut' is not iterable" in error:
        print("Tratando erro: Inacessível")
        return "Inacessível"
    
    print(f"Erro desconhecido: {error}")
    return f"Erro: {error}"

def snmpwalk(ip, oid):
    if ip == "0.0.0.0":
        return "N/A"  # Define o contador como zero se o IP for 0.0.0.0
    else:
        try:
            erroIndicado, statusErro, _, valores = next(
                getCmd(SnmpEngine(),
                       CommunityData('public'),
                       UdpTransportTarget((ip, 161)),
                       ContextData(),
                       ObjectType(ObjectIdentity(oid)))
            )

            if erroIndicado:
                return tratar_mensagens(erroIndicado)
            else:
                if statusErro:
                    return tratar_mensagens(statusErro.prettyPrint())
                else:
                    for valorEncontrado in valores:
                        valorCompleto = valorEncontrado.prettyPrint()
                        valor = valorCompleto.split('=')[-1].strip()
                        print(f'sem erro: {valor}')
                        return valor
        except Exception as e:
            return tratar_mensagens(str(e))

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
