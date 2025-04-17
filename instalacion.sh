#!/bin/bash

# Entra al virtual-env
python3 -m venv .venv
source .venv/bin/activate

# Instala las librerias necesarias de requeriments.txt
pip install -r requirements.txt

