class rectResponsive {
  float x, y, ancho, alto;
  boolean estado;
  color colorr;
  PImage fotal;
  rectResponsive(float x, float y, float ancho, float alto, color colorr) {
    this.x = x;
    this.y = y;
    this.ancho = ancho;
    this.alto = alto;
    this.colorr = colorr;
    this.estado = false;
  }
  void dibujar() {
    rectMode(CORNER);
    noStroke();
    fill(colorr);
    rect(x, y, ancho, alto);
  }
  void revisarPresion(){
    if (mouseX < x+ancho && mouseY < y + alto && mousePressed){
      this.estado = true;
    } 
  }
  void setPresion(boolean so){
    this.estado = so;
  }
  void moverA(float nuevaX) {
    float velocidad = 1.0; // La velocidad a la que se moverá el rectángulo
    float distancia = dist(this.x, this.y, nuevaX, this.y); // La distancia entre el rectángulo y el nuevo punto

    while (distancia > 0.1) { // Mientras la distancia sea mayor a 0.1 pixels
      // Calcula la dirección y la magnitud del vector de movimiento
      float direccionX = (nuevaX - this.x) / distancia;

      float movimientoX = direccionX * velocidad;


      // Actualiza la posición del rectángulo y dibújalo en cada iteración
      this.x += movimientoX;

      this.dibujar();

      // Actualiza la distancia para la próxima iteración
      distancia = dist(this.x, this.y, nuevaX, this.y);

      // Pequeña pausa para animar el movimiento
      //delay(10);
    }

    // Asegúrate de que el rectángulo termine en el punto exacto
    this.x = nuevaX;
    this.dibujar();
  }
}
