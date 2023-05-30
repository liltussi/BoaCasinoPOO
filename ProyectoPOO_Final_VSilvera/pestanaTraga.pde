public boolean tragaJugando,ayudaPres;
class PestañaTragaMone implements Pestaña {
  TragaMoneda juego;
  Boton exit;
  admArchivos arc;
  void setup() {
    arc = new admArchivos();
    size(1280, 640);
    background(#000000);
    tragaJugando = false;
    ayudaPres = false;
    pantalla = "Traga"; 
    juego = new TragaMoneda(arc);
    
    
  }

  void draw() {
    juego.draw();
    if (mousePressed) {
      juego.mousePressed();
    }
    

  }
}
