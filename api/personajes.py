from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import create_engine, text
from sqlalchemy.exc import SQLAlchemyError

QUERY_TODOS_LOS_PERSONAJES = "SELECT id, nombre, edad, region, elemento, ataque FROM personaje"

QUERY_PERSONAJE_BY_ID = "SELECT nombre, edad, region, elemento, ataque  FROM personaje WHERE ID = :id"

QUERY_ADD_PERSONAJE = "INSERT INTO personaje (nombre, edad, region, elemento, ataque) VALUES (:nombre, :edad, :region, :elemento, :ataque)"

QUERY_UPDATE_PERSONAJE = """
UPDATE personaje
SET 
  nombre = COALESCE(:nombre, nombre), 
  edad = COALESCE(:edad, edad), 
  region = COALESCE(:region, region), 
  elemento = COALESCE(:elemento, elemento),
  ataque = COALESCE(:ataque, ataque) 
WHERE ID = :id
"""

QUERY_DELETE_PERSONAJE = "DELETE FROM personaje WHERE ID = :id"

QUERY_RETURN_ATAQUE = "SELECT ataque FROM personaje WHERE ID = :id"



engine = create_engine("mysql+mysqlconnector://root:contraseña@localhost:3306/genshin")#cambiar "contraseña" por la contraseña del root

def run_query(query, parameters=None):
  with engine.connect() as conn:
    with conn.begin():
      result = conn.execute(text(query), parameters)
    return result

def all_personajes():
  return run_query(QUERY_TODOS_LOS_PERSONAJES).fetchall()

def personaje_by_id(id):
  return run_query(QUERY_PERSONAJE_BY_ID, {'id': id}).fetchall()

def add_personaje(nombre, edad, region, elemento, ataque):
    try:
        run_query(QUERY_ADD_PERSONAJE, {'nombre': nombre, 'edad': edad, 'region': region, 'elemento': elemento, 'ataque' : ataque})
        return {"message": "Personaje creado"}
    except SQLAlchemyError as e:
        return {"error": str(e)}

def update_personaje(id, nombre=None, edad=None, region=None, elemento=None, ataque=None):
    try:
        result = run_query(QUERY_UPDATE_PERSONAJE, {'id': id, 'nombre': nombre, 'edad': edad, 'region': region, 'elemento': elemento, 'ataque' : ataque})
        if result.rowcount == 0:
            return {"error": "Personaje no encontrado"}
        return {"message": "Personaje actualizado"}
    except SQLAlchemyError as e:
        return {"error": str(e)}

def delete_personaje(id):
  try:
    result = run_query(QUERY_DELETE_PERSONAJE,{'id':id})
    if result.rowcount == 0:
      return {"error": "Personaje no encontrado"}
    return {"message": "Personaje eliminado"}
  except SQLAlchemyError as e:
    return {"error": str(e)}
  
def return_ataque(id):
    try:
        result = run_query(QUERY_RETURN_ATAQUE, {'id': id})
        if result.rowcount == 0:
            return {"error": "Personaje no encontrado"}
        
        ataque = result.fetchone()[0]  
        return {'ataque': ataque} 
    except SQLAlchemyError as e:
        return {"error": str(e)}
  

