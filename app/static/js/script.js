function mostrar_alerta(nombre_nacion) {
    window.onload = () => {
        alert(`${nombre_nacion}, proximamente...`);
    };
}

function redireccionar(nombre_ruta, espera_explicita = 1000) {
    setTimeout(() => {window.location.href = nombre_ruta;}, espera_explicita);
}