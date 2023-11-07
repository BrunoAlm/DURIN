import json5
import requests

# Defina o endereço IP da impressora
ip_address = '10.0.3.4'

# URL para obter os contadores da impressora
url = f'http://{ip_address}/sws/app/information/counters/counters.json'

# Fazendo a solicitação HTTP à impressora
response = requests.get(url)
if response.status_code == 200:
    parsed_data = json5.loads(response.text)
    toner_black = parsed_data["GXI_BILLING_PRINT_TOTAL_IMP_CNT"]
    print(toner_black)

else:
    print("Impressora inacessível")
