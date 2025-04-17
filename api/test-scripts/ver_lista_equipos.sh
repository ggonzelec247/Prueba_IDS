#!/bin/bash

# URL de la API
API_URL="https://kryss.pythonanywhere.com"

# Credenciales de inicio de sesión
USERNAME="test"
PASSWORD="test"

# Iniciar sesión y obtener el token de acceso
TOKEN=$(curl -s -X POST "$API_URL/login" -H "Content-Type: application/json" -d "{\"username\": \"$USERNAME\", \"password\": \"$PASSWORD\"}" | jq -r '.access_token')

# Verificar si el token fue obtenido correctamente
if [ "$TOKEN" == "null" ]; then
  echo "Error: No se pudo obtener el token de acceso"
  exit 1
fi

# Hacer una solicitud GET a /api/equipos con el token de acceso
curl -s -X GET "$API_URL/api/equipos" -H "Authorization: Bearer $TOKEN" | jq .