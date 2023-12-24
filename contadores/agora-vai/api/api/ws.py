from typing import Dict, Any, Set
from fastapi import WebSocket

TmessagePayload = Any
TActiveConnections = Dict[str, Set[WebSocket]]

class WSManager:
    def __init__(self):
        self.active_connections: TActiveConnections = {}

    async def connect(self, impressora_id: str, ws: WebSocket):
        self.active_connections.setdefault(impressora_id, set()).add(ws)

    async def disconnect(self, impressora_id: str, ws: WebSocket):
        self.active_connections[impressora_id].remove(ws)
    
    async def send_message(self, impressora_id: str, message: TmessagePayload):
        for ws in self.active_connections.get(impressora_id, []):
            await ws.send_json(message)


ws_manager = WSManager()