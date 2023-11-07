import tkinter as tk
from tkinter import ttk

import customtkinter as ctk

# window
window = ctk.CTk()
window.title('customtkinter app')
window.geometry('600x400')

# widgets
string_var = tk.StringVar(value='a custom string')
label = ctk.CTkLabel(
    window,
    text= 'A ctk label',
    fg_color = ('blue','red'),
    text_color= 'white',
    corner_radius = 10,
    textvariable = string_var)
label.pack()

button = ctk.CTkButton(
    window,
    text = 'A ctk button',
    fg_color = '#FF0',
    text_color = '#000',
    hover_color = '#AA0',
    command = lambda: ctk.set_appearance_mode('dark'))
button.pack()

frame = ctk.CTkFrame(window, fg_color='transparent')
frame.pack()

slider = ctk.CTkSlider(frame)
slider.pack()



# run
window.mainloop()