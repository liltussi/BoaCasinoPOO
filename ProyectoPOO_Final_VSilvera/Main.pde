PestañaActual pestañaActual;

void setup() {
  size(1280, 640);
  
  surface.setIcon(loadImage("fichas/azul32.png"));
  surface.setTitle("Boa Sorte");
  usuario = new UserAccount();
  cp5 = new ControlP5(this);
  minim = new Minim(this);

  // Crea la lista de reproducción
  Cancion cancion1 = new Cancion("Canción 1", "canciones/cancion1.mp3");
  Cancion cancion2 = new Cancion("Canción 2", "canciones/cancion2.mp3");
  Cancion cancion3 = new Cancion("Canción 3", "canciones/cancion3.mp3");

  cancion1.siguiente = cancion2;
  cancion2.siguiente = cancion3;
  cancion3.siguiente = cancion1;

  inicioLista = cancion1;
  cancionActual = inicioLista;

  // Crea un hilo para la reproducción de canciones
  hiloReproduccion = new Thread(new Runnable() {
    public void run() {
      reproducirCancion(cancionActual);
    }
  }
  );

  // Inicia el hilo de reproducción
  hiloReproduccion.start();
  PestañaInicio p1 = new PestañaInicio(cp5);
  pestañaActual = new PestañaActual(p1);
}

void draw() {
  pestañaActual.draw();
}
