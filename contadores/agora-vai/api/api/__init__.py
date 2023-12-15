from fastapi import FastAPI
from .routes import router as routes_router
from . import database

app = FastAPI()

app.include_router(routes_router)

@app.on_event("startup")
def startup():
    database.init_db()

@app.on_event("shutdown")
async def shutdown():
    database.shutdown_db()
