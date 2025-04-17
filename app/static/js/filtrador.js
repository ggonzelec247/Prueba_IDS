function filtrarPersonajes() {
    const input = document.getElementById('buscador').value.toLowerCase();
    const personajes = document.getElementById('lista-personajes').getElementsByTagName('li');

    for (let i = 0; i < personajes.length; i++) {
        const personajeNombre = personajes[i].querySelector('strong').innerText.toLowerCase();
        personajes[i].style.display = personajeNombre.includes(input) ? '' : 'none';
    }
}