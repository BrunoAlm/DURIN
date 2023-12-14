from fastapi import APIRouter, Request, WebSocket
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse
from pydantic import BaseModel

from .connection_manager import ws_manager


class Message(BaseModel):
    message: str


push_router = APIRouter()


# @push_router.get('/push')
# def route(request: Request, response_classe=HTMLResponse):
#     print("chegou o get")
#     return {}


@push_router.post('/push')
async def route_b(
        message: Message, response_model=Message
):
    await ws_manager.broadcast(message.message)
    return {'message': 'ok'}


@push_router.websocket('/ws/push')
async def push_endpoint(websocket: WebSocket):
    await ws_manager.connect(websocket)
    while True:
        data = await websocket.receive_text()
        await ws_manager.broadcast(data)