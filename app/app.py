from flask import Flask, request, render_template, url_for, redirect
import requests

import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from api import personajes, equipos

API_URL = 'http://127.0.0.1:5001/api/'

app: Flask = Flask(__name__)

@app.route("/")
def home():
    return render_template("home.html")

@app.route("/mapa_interactivo")
def mapa_interactivo():
    return render_template("mapa_interactivo.html")

@app.route("/personaje", methods=["GET"])
def personaje():
    try:
        response = personajes.all_personajes()
        personajes_data = [
            {
                "id": row[0],
                "nombre": row[1],
                "edad": row[2],
                "region": row[3],
                "elemento": row[4],
                "ataque" : row[5]
            }
            for row in response
        ]
    except Exception as e:
        print(f"Error fetching personajes: {e}")
        personajes_data = []
    return render_template("menu/personajes.html", personajes=personajes_data)

@app.route("/personaje/add", methods=["POST"])
def add_personaje():
    try:
        nombre = request.form["nombre"]
        edad = int(request.form["edad"])
        region = request.form["region"]
        elemento = request.form["elemento"]
        ataque = int(request.form["ataque"])
        response = personajes.add_personaje(nombre, edad, region, elemento, ataque)
        if "error" in response:
            return f"Error: {response['error']}", 400
    except Exception as e:
        return f"Error al agregar personaje: {e}", 500
    return redirect(url_for("personaje"))

@app.route("/personaje/delete/<int:personaje_id>", methods=["POST"])
def delete_personaje(personaje_id):
    try:
        response = personajes.delete_personaje(personaje_id)
        if "error" in response:
            return f"Error: {response['error']}", 400
    except Exception as e:
        return f"Error al eliminar personaje: {e}", 500
    return redirect(url_for("personaje"))

@app.route("/personaje/edit/<int:personaje_id>", methods=["GET", "POST"])
def edit_personaje(personaje_id):
    if request.method == "POST":
        try:
            nombre = request.form.get("nombre")
            edad = request.form.get("edad", type=int)
            region = request.form.get("region")
            elemento = request.form.get("elemento")
            ataque = request.form.get("ataque", type=int)

            response = personajes.update_personaje(
                personaje_id, nombre=nombre, edad=edad, region=region, elemento=elemento, ataque=ataque
            )
            if "error" in response:
                return f"Error: {response['error']}", 400
        except Exception as e:
            return f"Error al actualizar personaje: {e}", 500

        return redirect(url_for("personaje"))
    else:
        try:
            personaje = personajes.personaje_by_id(personaje_id)[0]
        except Exception as e:
            return f"Error: {e}", 500

        return render_template(
            "menu/edit_personaje.html",
            personaje={
                "id": personaje_id,
                "nombre": personaje[0],
                "edad": personaje[1],
                "region": personaje[2],
                "elemento": personaje[3],
                "ataque" : personaje[4]
            },
        )
    
##########################################################
## EQUIPOS
@app.route("/equipos", methods=["GET"])
def equipos_f():
    try:
        response = equipos.all_equipos()
        equipos_data = [
            {
                "id": row[0],
                "nombre_equipo": row[1],
                "ID_integrante_1": row[2],
                "ID_integrante_2": row[3],
                "ID_integrante_3": row[4],
                "ID_integrante_4" : row[5],
                "promedio_ataque" : row[6]
            }
            for row in response
        ]
    except Exception as e:
        print(f"Error fetching equipos: {e}")
        equipos_data = []

    try:
        response = personajes.all_personajes()
        personajes_data = [
            {
                "id": row[0],
                "nombre": row[1],
                "edad": row[2],
                "region": row[3],
                "elemento": row[4],
                "ataque" : row[5]
            }
            for row in response
        ]

        personajes_dic = {personaje.id: personaje.nombre for personaje in response}
    except Exception as e:
        print(f"Error fetching personajes: {e}")
        personajes_data = []

    
    
    return render_template("menu/equipos.html", equipos=equipos_data, personajes=personajes_data, personajes_dic=personajes_dic)

@app.route("/equipos/add", methods=["POST"])
def add_equipo_f():
    try:
        
        response = personajes.all_personajes()
        personajes_data = [
            {
                "id": row[0],
                "nombre": row[1],
                "edad": row[2],
                "region": row[3],
                "elemento": row[4],
                "ataque": row[5]
            }
            for row in response
        ]
    except Exception as e:
        print(f"Error fetching personajes: {e}")
        personajes_data = []

    try:
        
        nombre_equipo = request.form["nombre_equipo"]
        ID_integrante_1 = int(request.form["ID_integrante_1"])
        ID_integrante_2 = int(request.form["ID_integrante_2"])
        ID_integrante_3 = int(request.form["ID_integrante_3"])
        ID_integrante_4 = int(request.form["ID_integrante_4"])

        ataque_1 = personajes.return_ataque(ID_integrante_1).get('ataque', 0)
        ataque_2 = personajes.return_ataque(ID_integrante_2).get('ataque', 0)
        ataque_3 = personajes.return_ataque(ID_integrante_3).get('ataque', 0)
        ataque_4 = personajes.return_ataque(ID_integrante_4).get('ataque', 0)

        
        promedio_ataque = (ataque_1 + ataque_2 + ataque_3 + ataque_4) // 4

        
        response = equipos.add_equipo(
            nombre_equipo, ID_integrante_1, ID_integrante_2, ID_integrante_3, ID_integrante_4, promedio_ataque
        )

        if "error" in response:
            return f"Error: {response['error']}", 400
    except Exception as e:
        return f"Error al agregar equipo: {e}", 500

    return redirect(url_for("equipos_f"))

@app.route("/equipos/delete/<int:equipo_id>", methods=["POST"])
def delete_equipo_f(equipo_id):
    try:
        response = equipos.delete_equipo(equipo_id)
        if "error" in response:
            return f"Error: {response['error']}", 400
    except Exception as e:
        return f"Error al eliminar equipo: {e}", 500
    return redirect(url_for("equipos_f"))


##########################################################

@app.route("/nosotros")
def about_us():
    integrantes = [
        {"apellido":"Gonzales", "nombre":"Gabriel Leonel", "padron":"112607"},
        {"apellido":"Noriega Nuti", "nombre":"Sofia belen", "padron":"110502"},
        {"apellido":"Rojas Calizaya", "nombre":"Kevin Edgardo", "padron":"109948"},
        {"apellido":"Julian Gilio", "nombre":"Agustin Nahuel", "padron":"111876"},
        {"apellido":"Siciliano", "nombre":"Franco", "padron":"108157"},
        {"apellido":"Lopez", "nombre":"Lazaro", "padron":"111312"},
        {"apellido":"Moyano", "nombre":"Benjamin", "padron":"111613"},
    ]
    return render_template("menu/nosotros.html", integrantes=integrantes)


@app.route("/guia")
def guide():
    return render_template("menu/guia.html")

@app.route("/mondstadt")
def mondstadt():
    return render_template("naciones/mondstadt/mondstadt.html")

@app.route("/sonata")
def sonata():
    return render_template("naciones/mondstadt/sonata.html")

@app.route("/liyue")
def liyue():
    return render_template("naciones/liyue/liyue.html")

@app.route("/contrato")
def contrato():
    return render_template("naciones/liyue/contrato.html")

@app.route("/inazuma")
def inazuma():
    nombre_nacion = "Inazuma"
    return render_template("naciones/inazuma/inazuma.html", nombre_nacion=nombre_nacion)

@app.route("/sumeru")
def sumeru():
    return render_template("naciones/sumeru/sumeru.html")

@app.route("/cuento")
def cuento():
    return render_template("naciones/sumeru/cuento.html")

@app.route("/fontaine")
def fontaine():
    nombre_nacion = "Fontaine"
    return render_template("naciones/fontaine/fontaine.html", nombre_nacion=nombre_nacion)

@app.route("/natlan")
def natlan():
    nombre_nacion = "Natlan"
    return render_template("naciones/natlan/natlan.html", nombre_nacion=nombre_nacion)

if __name__ == "__main__":
    app.run(host="127.0.0.1", port=5000, debug=True)
