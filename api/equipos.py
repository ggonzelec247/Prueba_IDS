from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import create_engine, text
from sqlalchemy.exc import SQLAlchemyError

QUERY_TODOS_LOS_EQUIPOS = "SELECT id, nombre_equipo, ID_integrante_1, ID_integrante_2, ID_integrante_3, ID_integrante_4, promedio_ataque FROM equipos"

QUERY_EQUIPO_BY_ID = "SELECT nombre_equipo, ID_integrante_1, ID_integrante_2, ID_integrante_3, ID_integrante_4, promedio_ataque FROM equipos WHERE ID = :id"

QUERY_ADD_EQUIPO = "INSERT INTO equipos (nombre_equipo, ID_integrante_1, ID_integrante_2, ID_integrante_3, ID_integrante_4, promedio_ataque) VALUES (:nombre_equipo, :ID_integrante_1, :ID_integrante_2, :ID_integrante_3, :ID_integrante_4, :promedio_ataque)"

QUERY_UPDATE_EQUIPO = """
UPDATE equipos
SET 
  nombre_equipo = COALESCE(:nombre_equipo, nombre_equipo), 
  ID_integrante_1 = COALESCE(:ID_integrante_1, ID_integrante_1),
  ID_integrante_2 = COALESCE(:ID_integrante_2, ID_integrante_2),
  ID_integrante_3 = COALESCE(:ID_integrante_3, ID_integrante_3),
  ID_integrante_4 = COALESCE(:ID_integrante_4, ID_integrante_4),
  promedio_ataque = COALESCE(:promedio_ataque, promedio_ataque)
WHERE ID = :id
"""

QUERY_DELETE_EQUIPO = "DELETE FROM equipos WHERE ID = :id"



engine = create_engine("mysql+mysqlconnector://root:contraseña@localhost:3306/genshin")#cambiar "contraseña" por la contraseña del root

def run_query(query, parameters=None):
  with engine.connect() as conn:
    with conn.begin():
      result = conn.execute(text(query), parameters)
    return result

def all_equipos():
  return run_query(QUERY_TODOS_LOS_EQUIPOS).fetchall()

def equipo_by_id(id):
  return run_query(QUERY_EQUIPO_BY_ID, {'id': id}).fetchall()

def add_equipo(nombre_equipo, ID_integrante_1, ID_integrante_2, ID_integrante_3, ID_integrante_4, promedio_ataque):
    try:
        run_query(QUERY_ADD_EQUIPO, {'nombre_equipo': nombre_equipo, 'ID_integrante_1': ID_integrante_1, 'ID_integrante_2': ID_integrante_2, 'ID_integrante_3': ID_integrante_3, 'ID_integrante_4' : ID_integrante_4, 'promedio_ataque' : promedio_ataque})
        return {"message": "Equipo creado"}
    except SQLAlchemyError as e:
        return {"error": str(e)}

def update_equipo(id, nombre_equipo=None, ID_integrante_1=None, ID_integrante_2=None, ID_integrante_3=None, ID_integrante_4=None, promedio_ataque=None):
    try:
        result = run_query(QUERY_UPDATE_EQUIPO, {'id': id, 'nombre_equipo': nombre_equipo, 'ID_integrante_1': ID_integrante_1, 'ID_integrante_2': ID_integrante_2, 'ID_integrante_3': ID_integrante_3, 'ID_integrante_4' : ID_integrante_4, 'promedio_ataque' : promedio_ataque})
        if result.rowcount == 0:
            return {"error": "Equipo no encontrado"}
        return {"message": "Equipo actualizado"}
    except SQLAlchemyError as e:
        return {"error": str(e)}

def delete_equipo(id):
  try:
    result = run_query(QUERY_DELETE_EQUIPO,{'id':id})
    if result.rowcount == 0:
      return {"error": "Equipo no encontrado"}
    return {"message": "Equipo eliminado"}
  except SQLAlchemyError as e:
    return {"error": str(e)}
  

