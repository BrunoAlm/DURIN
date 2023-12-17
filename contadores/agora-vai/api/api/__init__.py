from fastapi import FastAPI
from .routes import router as routes_router
from fastapi.middleware.cors import CORSMiddleware
from . import database

app = FastAPI()

# Configuração das políticas de CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Isso permite que todos os origens acessem a API
    allow_credentials=True,
    allow_methods=["*"],  # Isso permite todos os métodos HTTP (GET, POST, etc.)
    allow_headers=["*"],  # Isso permite todos os headers
)

app.include_router(routes_router)

@app.on_event("startup")
def startup():
    database.init_db()

@app.on_event("shutdown")
async def shutdown():
    database.shutdown_db()
