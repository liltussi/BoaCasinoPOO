PestañaActual pestañaActual;

void setup() {
  size(1280, 640);
  cp5 = new ControlP5(this);
  PestañaContenido1 p1 = new PestañaContenido1(cp5);
  pestañaActual = new PestañaActual(p1);
}

void draw() {
  pestañaActual.draw();
}
