from tkinter import *

import customtkinter

from pega_contador import (gera_html_multifuncionais, gera_zebra_email,
                           gera_zebra_html)


def execute_html_zebra():
    gera_zebra_html()
    messagebox.showinfo("HTML gerado", "HTML gerado com sucesso!")


def execute_email_zebra():
    gera_zebra_email()
    messagebox.showinfo("Email enviado", "Email enviado com sucesso!")


def execute_html_multifuncionais():
    gera_html_multifuncionais()
    messagebox.showinfo("HTML gerado", "HTML gerado com sucesso!")


# # Create a GUI window
# customtkinter.set_appearance_mode("dark")
# customtkinter.set_default_color_theme("green")
root = customtkinter.CTk()
# root.title("Contadores das impressoras")
root.geometry("300x400")
grid_columnconfigure(0, weight=1)

label = customtkinter.CTkLabel(master=root,
                               text="CTkLabel",
                               width=120,
                               height=25,
                               corner_radius=8)
label.grid(row=0, column=0, padx=20, pady=20)


# Create buttons
html_zebra_button = customtkinter.CTkButton(master=root, text="Gerar relatório HTML (ZEBRA)",
                                            command=execute_html_zebra)
html_zebra_button.place(relx=0.5, rely=0.5, anchor=CENTER)

# email_zebra_button = customtkinter.CTkButton(master=root, text="Gerar e relatório e enviar por email",
#                                              command=execute_email_zebra)
# email_zebra_button.place(relx=0.5, rely=0.5, anchor=SE)

# html_multifuncionais_button = customtkinter.CTkButton(master=root, text="Gerar relatório HTML (MULTIFUNCIONAIS)",
#                                                       command=execute_email_zebra)
# html_multifuncionais_button.place(relx=0.5, rely=1.5, anchor=CENTER)

# Run the GUI event loop
root.mainloop()
