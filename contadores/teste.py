from tkinter import *

import customtkinter

from pega_contador import (gera_html_multifuncionais, gera_zebra_email,
                           gera_zebra_html)


class MyTabView(customtkinter.CTkTabview):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)

        # create tabs
        self.add("Zebras")
        self.add("Multifuncionais")

        # add widgets on tabs
        self.label = customtkinter.CTkLabel(
            master=self.tab("Zebras"), text="Relátórios Zebra")
        self.label.grid(row=0, column=0, padx=20, pady=10)

        # ------ Zebra buttons
        # email
        self.button_zebra_email = customtkinter.CTkButton(
            master=self.tab("Zebras"), command=self.execute_email_zebra, text="Enviar E-mail")
        self.button_zebra_email.grid(row=1, column=0, padx=20, pady=5)

        # html
        self.button_zebra_html = customtkinter.CTkButton(
            master=self.tab("Zebras"), command=self.execute_html_zebra, text="Gerar HTML")
        self.button_zebra_html.grid(row=2, column=0, padx=20, pady=5)

    # add methods to app
    def execute_email_zebra(self):
        gera_zebra_email()
        messagebox.showinfo("Email enviado", "Email enviado com sucesso!")

    def execute_html_zebra(self):
        gera_zebra_html()
        messagebox.showinfo("HTML gerado", "HTML gerado com sucesso!")


class App(customtkinter.CTk):
    def __init__(self):
        super().__init__()
        self.geometry("600x500")
        self.title("CTk example")
        # self.grid(row=1, column=0)

        # label on top
        self.label = customtkinter.CTkLabel(
            master=self, text="Contadores DURÍN")
        self.label.grid(row=0, column=0, padx=20, pady=10)

        # tab_view
        self.tab_view = MyTabView(master=self)
        self.tab_view.grid(row=1, column=0, padx=20, pady=10)


app = App()
app.mainloop()
