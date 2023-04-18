class Boton {
  float x, y; // coordenadas x, y del botón
  float ancho, alto; // ancho y alto del botón
  String texto; // texto en el botón
  boolean presionado; // estado del botón (presionado o no)
  Runnable accion; // función enlazada al botón

  // Constructor del botón
  Boton(float x, float y, float ancho, float alto, String texto) {
    this.x = x;
    this.y = y;
    this.ancho = ancho;
    this.alto = alto;
    this.texto = texto;
    this.presionado = false;
  }

  // Método para dibujar el botón en la pantalla
  void dibujar() {
    int colorr = presionado ? 0 : 255;
    stroke(255);
    fill(colorr);
    rect(x, y, ancho, alto);
    textAlign(CENTER, CENTER);
    fill(0);
    text(texto, x, y, ancho, alto);
  }

  // Método para verificar si el botón ha sido presionado
  boolean estaPresionado() {
    if (mouseX > x && mouseX < x + ancho && mouseY > y && mouseY < y + alto && mousePressed) {
      presionado=true;
      return true;
    } else {
      presionado=false;
      return false;
    }
  }

  // Método para enlazar una función al botón
  void enlazarAccion(Runnable accion) {
    this.accion = accion;
  }

  // Método para ejecutar la función enlazada al botón
  void ejecutarAccion() {
    if (accion != null) {
      accion.run();
    }
  }
}

//Ejemplo de instancia de botones

//Boton botonfeo;
//Boton botonBonito;
//void exito() {
//  exit();
//}
//void printalgo() {
//  print("xd");
//}
//void setup() {
//  size(900, 900);
//  botonfeo = new Boton(12, 12, 100, 100, "xd");
//  botonfeo.enlazarAccion(new Runnable() {
//    @Override
//      public void run() {
//      exito();
//    }
//  }
//  );
//  botonBonito = new Boton(120, 120, 100, 100, "lol");
//  botonBonito.enlazarAccion(new Runnable() {
//    @Override
//      public void run() {
//      printalgo();
//    }
//  }
//  );
//}
//void draw() {
//  botonfeo.dibujar();
//  if (botonfeo.estaPresionado()) {
//    botonfeo.ejecutarAccion();
//  }
//  botonBonito.dibujar();
//  if (botonBonito.estaPresionado()) {
//    botonBonito.ejecutarAccion();
//  }
//}
