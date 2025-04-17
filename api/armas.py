from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import create_engine, text
from sqlalchemy.exc import SQLAlchemyError

QUERY_TODAS_LAS_ARMAS = "SELECT id, nivel, refinamiento FROM arma"

QUERY_ARMA_BY_ID = "SELECT nivel, refinamiento FROM arma WHERE ID = :id"

QUERY_ADD_ARMA = "INSERT INTO arma (id, nivel, refinamiento) VALUES (:id, :nivel, :refinamiento)"

QUERY_UPDATE_ARMA = """
UPDATE arma
SET
  nivel = COALESCE(:nivel, nivel),
  refinamiento = COALESCE(:refinamiento, refinamiento)
WHERE ID = :id
"""

QUERY_DELETE_ARMA = "DELETE FROM arma WHERE ID = :id"

engine = create_engine("mysql+mysqlconnector://root:contraseña@localhost:3306/genshin")#cambiar "contraseña" por la contraseña del root

def run_query(query, parameters=None):
  with engine.connect() as conn:
    with conn.begin():
      result = conn.execute(text(query), parameters)
    return result

def all_armas():
  return run_query(QUERY_TODAS_LAS_ARMAS).fetchall()

def arma_by_id(id):
  return run_query(QUERY_ARMA_BY_ID, {'id': id}).fetchall()

def add_arma(id, nivel, refinamiento):
    try:
        run_query(QUERY_ADD_ARMA, {'id': id, 'nivel': nivel, 'refinamiento': refinamiento})
        return {"message": "Arma creada"}
    except SQLAlchemyError as e:
        return {"error": str(e)}

def update_arma(id, nivel=None, refinamiento=None):
    try:
        result = run_query(QUERY_UPDATE_ARMA, {'id': id, 'nivel': nivel, 'refinamiento': refinamiento})
        if result.rowcount == 0:
            return {"error": "Arma no encontrada"}
        return {"message": "Arma actualizada"}
    except SQLAlchemyError as e:
        return {"error": str(e)}

def delete_arma(id):
  try:
    result = run_query(QUERY_DELETE_ARMA,{'id':id})
    if result.rowcount == 0:
      return {"error": "Arma no encontrada"}
    return {"message": "Arma eliminada"}
  except SQLAlchemyError as e:
    return {"error": str(e)}
