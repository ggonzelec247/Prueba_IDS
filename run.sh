# crea un terminal aparte para correr la api
gnome-terminal -- sh -c "cd api && python app.py; exec sh"
# crea un terminal aparte para correr la app
gnome-terminal -- sh -c "cd app && python app.py; exec sh"