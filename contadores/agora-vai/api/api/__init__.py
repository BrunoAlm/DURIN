from fastapi import FastAPI
from .push_router import push_router
app = FastAPI()

app.include_router(push_router)