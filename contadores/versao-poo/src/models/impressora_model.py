from abc import ABC, abstractmethod


class Impressora(ABC):
    def __init__(self, ip, nome, selb):
        self.ip = ip
        self.nome = nome
        self.selb = selb

    @abstractmethod
    def ler_contador(self):
        pass

