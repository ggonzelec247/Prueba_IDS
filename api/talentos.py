from sqlalchemy import create_engine, text
from sqlalchemy.exc import SQLAlchemyError

# Consultas SQL para la tabla talentos
QUERY_TODOS_LOS_TALENTOS = "SELECT ID, ataque, elemental, ultimate FROM talentos"

QUERY_TALENTO_BY_ID = "SELECT ataque, elemental, ultimate FROM talentos WHERE ID = :ID"

QUERY_ADD_TALENTO = "INSERT INTO talentos (ID, ataque, elemental, ultimate) VALUES (:ID, :ataque, :elemental, :ultimate)"

QUERY_UPDATE_TALENTO = """
UPDATE talentos 
SET ataque = COALESCE(:ataque, ataque), 
    elemental = COALESCE(:elemental, elemental), 
    ultimate = COALESCE(:ultimate, ultimate) 
WHERE ID = :ID
"""

QUERY_DELETE_TALENTO = "DELETE FROM talentos WHERE ID = :ID"

# Configuración del motor SQLAlchemy
engine = create_engine("mysql+mysqlconnector://root:contraseña@localhost:3306/genshin") 

# Función genérica para ejecutar consultas
def run_query(query, parameters=None):
    with engine.connect() as conn:
        with conn.begin():
            result = conn.execute(text(query), parameters)
        return result

# Función para obtener todos los talentos
def all_talentos():
    return run_query(QUERY_TODOS_LOS_TALENTOS).fetchall()

# Función para obtener un talento por ID
def talento_by_id(id):
    return run_query(QUERY_TALENTO_BY_ID, {'ID': id}).fetchall()

# Función para agregar un nuevo talento
def add_talento(id, ataque, elemental, ultimate):
    try:
        run_query(QUERY_ADD_TALENTO, {'ID': id, 'ataque': ataque, 'elemental': elemental, 'ultimate': ultimate})
        return {"message": "Talento creado"}
    except SQLAlchemyError as e:
        return {"error": str(e)}

# Función para actualizar un talento
def update_talento(id, ataque=None, elemental=None, ultimate=None):
    try:
        result = run_query(QUERY_UPDATE_TALENTO, {'ID': id, 'ataque': ataque, 'elemental': elemental, 'ultimate': ultimate})
        if result.rowcount == 0:
            return {"error": "Talento no encontrado"}
        return {"message": "Talento actualizado"}
    except SQLAlchemyError as e:
        return {"error": str(e)}

# Función para eliminar un talento
def delete_talento(id):
    try:
        result = run_query(QUERY_DELETE_TALENTO, {'ID': id})
        if result.rowcount == 0:
            return {"error": "Talento no encontrado"}
        return {"message": "Talento eliminado"}
    except SQLAlchemyError as e:
        return {"error": str(e)}
