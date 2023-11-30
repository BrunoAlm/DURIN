import json5
import requests
from lxml import html
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait


def construir_urls(ip):
    urls = [
        f'http://{ip}/sws/app/information/counters/counters.json',
        f'http://{ip}/web/guest/br/websys/status/getUnificationCounter.cgi',
        f'http://{ip}/web/guest/pt/websys/status/getUnificationCounter.cgi',
        f'http://{ip}/cgi-bin/dynamic/printer/config/reports/devicestatistics.html',
        f'http://{ip}/counter.asp?Lang=en-us',

        # Adicione mais URLs conforme necessário
    ]
    return urls


def obter_dados_json(url):
    try:
        response = requests.get(url)
        response.raise_for_status()
        return json5.loads(response.text)
    except Exception as e:
        # Logar o erro específico para debug
        print(f"Erro ao obter dados JSON da URL {url}: {e}")
        return None


def obter_dados_xpath(url, xpath):
    # Inicializa o driver do Selenium (neste caso, usando Chrome)
    driver = webdriver.Chrome()

    try:
        # Abre a URL no navegador
        driver.get(url)
        # Espera até que o elemento esteja presente na página
        elemento = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, xpath))
        )
        # Obtém o texto do elemento
        texto = elemento.text.strip()
        return texto

    except Exception as e:
        print(f"Erro ao obter dados usando XPath da URL {url}: {e}")
        return None

    finally:
        # Fecha o navegador após a execução
        driver.quit()


def ler_contador_multifuncionais(ip, selb, nome):
    modelo = 'N/A'  # Inicializa a variável modelo com um valor padrão
    total_impressoes = 'N/A'  # Inicializa a variável total_impressoes com um valor padrão

    try:
        # Tentar obter contadores para cada URL
        for url in construir_urls(ip):
            print(f'Verificando url: {url}')
            try:
                # Fazendo a solicitação HTTP à impressora
                response = requests.get(url)
                response.raise_for_status()

                if "counters.json" in url:
                    dados = obter_dados_json(url)
                    if dados:
                        modelo = 'SAMSUNG SL-M4020ND'
                        total_impressoes = dados.get(
                            "GXI_BILLING_TOTAL_IMP_CNT", 'N/A')
                        break  # Saindo do loop após obter os dados com sucesso
                elif "getUnificationCounter.cgi" in url:
                    xpath = "/html/body/table/tbody/tr/td[3]/table[3]/tbody/tr/td[2]/table[1]/tbody/tr/td[4]"
                    dados = obter_dados_xpath(url, xpath)
                    if dados:
                        modelo = 'RICOH IM 430'
                        total_impressoes = dados
                        print(total_impressoes)
                        break  # Saindo do loop após obter os dados com sucesso
                elif "devicestatistics.html" in url:
                    xpath = "/html/body/table[3]/tbody/tr[9]/td[2]/p"
                    dados = obter_dados_xpath(url, xpath)
                    if dados:
                        modelo = 'Lexmark MX511e'
                        total_impressoes = dados
                        print(total_impressoes)
                        break  # Saindo do loop após obter os dados com sucesso
                elif "counter.asp" in url:
                    xpath = "/html/body/div/table/tbody/tr/td[2]/table[2]/tbody/tr[2]/td/table/tbody/tr/td[2]/table/tbody/tr/td/table/tbody/tr[3]/td/table/tbody/tr[2]/td[3]"
                    dados = obter_dados_xpath(url, xpath)
                    if dados:
                        modelo = 'RICOH Aficio SP 3510DN'
                        total_impressoes = dados
                        print(total_impressoes)
                        break  # Saindo do loop após obter os dados com sucesso

            except requests.exceptions.HTTPError as e:
                print(f"Erro HTTP: {e}")
            except Exception as e:
                print(f"Erro: {e}")

    except Exception as e:
        print(f"Erro ao obter contadores: {e}")

    print(f"Modelo da impressora: {modelo}")
    print(f"Total de impressões: {total_impressoes}")

    contador = {
        'selb': selb,
        'nome': nome,
        'ip': ip,
        'cont_nao_reinic': total_impressoes
    }

    return contador
