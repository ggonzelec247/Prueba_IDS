from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import create_engine, text
from sqlalchemy.exc import SQLAlchemyError

QUERY_TODAS_LAS_STATS = "SELECT id, vida, ataque, defensa, maestria, recarga_energia, probabilidad_critico, danio_critico FROM stats_principales"

QUERY_STATS_BY_ID = "SELECT vida, ataque, defensa, maestria, recarga_energia, probabilidad_critico, danio_critico FROM stats_principales WHERE ID = :id"

QUERY_ADD_STATS = "INSERT INTO stats_principales (id, vida, ataque, defensa, maestria, recarga_energia, probabilidad_critico, danio_critico) VALUES (:id, :vida, :ataque, :defensa, :maestria, :recarga_energia, :probabilidad_critico, :danio_critico)"

QUERY_UPDATE_STATS = """
UPDATE stats_principales
SET
  vida = COALESCE(:vida, vida),
  ataque = COALESCE(:ataque, ataque),
  defensa = COALESCE(:defensa, defensa),
  maestria = COALESCE(:maestria, maestria),
  recarga_energia = COALESCE(:recarga_energia, recarga_energia),
  probabilidad_critico = COALESCE(:probabilidad_critico, probabilidad_critico),
  danio_critico = COALESCE(:danio_critico, danio_critico)
WHERE ID = :id
"""

QUERY_DELETE_STATS = "DELETE FROM stats_principales WHERE ID = :id"

engine = create_engine("mysql+mysqlconnector://root:contraseña@localhost:3306/genshin")#cambiar "contraseña" por la contraseña del root

def run_query(query, parameters=None):
  with engine.connect() as conn:
    with conn.begin():
      result = conn.execute(text(query), parameters)
    return result

def all_stats():
  return run_query(QUERY_TODAS_LAS_STATS).fetchall()

def stats_by_id(id):
  return run_query(QUERY_STATS_BY_ID, {'id': id}).fetchall()

def add_stats(id, vida, ataque, defensa, maestria, recarga_energia, probabilidad_critico, danio_critico):
    try:
        run_query(QUERY_ADD_STATS, {'id': id, 'vida': vida, 'ataque': ataque, 'defensa': defensa, 'maestria': maestria, 'recarga_energia': recarga_energia, 'probabilidad_critico': probabilidad_critico, 'danio_critico': danio_critico})
        return {"message": "Stats creadas"}
    except SQLAlchemyError as e:
        return {"error": str(e)}

def update_stats(id, vida=None, ataque=None, defensa=None, maestria=None, recarga_energia=None, probabilidad_critico=None, danio_critico=None):
    try:
        result = run_query(QUERY_UPDATE_STATS, {'id': id, 'vida': vida, 'ataque': ataque, 'defensa': defensa, 'maestria': maestria, 'recarga_energia': recarga_energia, 'probabilidad_critico': probabilidad_critico, 'danio_critico': danio_critico})
        if result.rowcount == 0:
            return {"error": "Stats no encontradas"}
        return {"message": "Stats actualizada"}
    except SQLAlchemyError as e:
        return {"error": str(e)}

def delete_stats(id):
  try:
    result = run_query(QUERY_DELETE_STATS,{'id':id})
    if result.rowcount == 0:
      return {"error": "Stats no encontradas"}
    return {"message": "Stats eliminadas"}
  except SQLAlchemyError as e:
    return {"error": str(e)}
