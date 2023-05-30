class Cancion {
  String titulo;
  String archivo;
  Cancion siguiente;

  Cancion(String titulo, String archivo) {
    this.titulo = titulo;
    this.archivo = archivo;
    this.siguiente = null;
  }
}
Minim minim;
AudioPlayer reproductor;
Cancion inicioLista;
Cancion cancionActual;

Thread hiloReproduccion;

void reproducirCancion(Cancion cancion) {
  // Detiene la canción actual (si está reproduciendo)
  if (reproductor != null && reproductor.isPlaying()) {
    reproductor.pause();
    reproductor.close();
  }

  // Carga y reproduce la nueva canción
  reproductor = minim.loadFile(cancion.archivo);
  reproductor.play();

  // Espera hasta que la canción termine de reproducirse
  while (reproductor.isPlaying()) {
    delay(100);
  }

  // Pasa a la siguiente canción en la lista
  cancionActual = cancionActual.siguiente;
  reproducirCancion(cancionActual);
}

void stopp() {
  // Detiene el hilo de reproducción y cierra Minim al salir de la aplicación
  if (hiloReproduccion != null) {
    hiloReproduccion.interrupt();
  }
  if (reproductor != null) {
    reproductor.close();
  }
  minim.stop();
  super.stop(); //esto para TODO
}
