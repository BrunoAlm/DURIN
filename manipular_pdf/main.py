import fitz
from PIL import Image

def alterar_cor_pdf(input_path, output_path):
    pdf = fitz.open(input_path)
    total_paginas = len(pdf)

    for pagina_num in range(total_paginas):
        pagina = pdf[pagina_num]
        blocos = pagina.get_text("blocks")

        for bloco in blocos:
            if bloco["type"] == 1:  # Bloco de imagem
                imagem = bloco["bbox"]
                imagem_obj = pagina.get_pixmap(matrix=fitz.Matrix(1, 1).pre_rotate(0), clip=imagem)
                imagem_pil = Image.frombytes("RGB", [imagem_obj.width, imagem_obj.height], imagem_obj.samples)
                pixels = imagem_pil.load()

                # Altera a cor para azul
                for i in range(imagem_obj.width):
                    for j in range(imagem_obj.height):
                        pixels[i, j] = (0, 0, 255)  # R, G, B

                imagem_obj = fitz.Pixmap(imagem_pil.tobytes(), len(imagem_pil.tobytes()), "rgb")
                pagina.set_pixmap(imagem_obj, imagem)

    pdf.save(output_path)

# Exemplo de uso
input_path = 'relatorio-de-estagio.pdf'
output_path = 'arquivo_destino.pdf'

alterar_cor_pdf(input_path, output_path)
