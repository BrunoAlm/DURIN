from datetime import datetime
from typing import Optional, List
from uuid import uuid4 as uuid
from sqlmodel import Field, SQLModel, create_engine, Relationship

sql_file_name = "db.db"
sqlite_path = f"sqlite:///{sql_file_name}"

engine = create_engine(sqlite_path, echo= True)

def create_db_and_tables():
    SQLModel.metadata.create_all(engine)
    
def get_default_uuid():
    return str(uuid())

class Contador(SQLModel, table=True):
    id: Optional[str] = Field(
        default_factory=get_default_uuid,
        primary_key=True,
    )
    impressora_id: str = Field(
        foreign_key="impressora.id",
        default=None,
        nullable=False,
    )
    data_registro: datetime = Field(default_factory=datetime.now)
    contador: str = Field(default='N/A')

class Impressora(SQLModel, table=True):
    id: Optional[str] = Field(default_factory=get_default_uuid, primary_key=True)
    nome: str = Field(min_length=1, max_length=8)
    ip: str = Field(min_length=1, max_length=15)
    selb: str = Field(default='N/A', min_length=1, max_length=4)
    nivel_toner: int = Field(default=0)
    status: str = Field(default='N/A', min_length=1, max_length=30)
    contadores: List[Contador] = Relationship(
        back_populates="impressora",
        sa_relationship_kwargs={"cascade": "all, delete-orphan, delete"},
    )
    
    
    