import java.io.FileReader;
import java.io.IOException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import controlP5.*;
ControlP5 cp5;

// Implementación de una pestaña con contenido específico

class PestañaContenido1 implements Pestaña {
  ControlP5 cp5;
  boolean xd;
  Textfield inputUsuario;
  Textfield inputContraseña;
  PestañaContenido1(ControlP5 cp5) {
    this.cp5 = cp5;
  }
  void setup() {
    size(10, 10);
    background(0);
    xd = true;
  }

  void draw() {
    rect(100, 100, 10, 10);
    if (xd) {
      inputUsuario = cp5.addTextfield("textA", 100, 290, 100, 20);
      inputContraseña = cp5.addTextfield("textB", 100, 350, 100, 20);
      inputContraseña.setPasswordMode(true);
      xd = false;
    }
    if (mousePressed && mouseX >100 && mouseY < 100) {
      PestañaContenido2 p2 = new PestañaContenido2();
      pestañaActual.cambiarPestaña(p2);
      cp5.remove("textA");
      cp5.remove("textB");
    }
  }
}

// Implementación de otra pestaña con contenido específico
class PestañaContenido2 implements Pestaña {
  void setup() {
    background(100);
  }

  void draw() {
    background(100);
    rect(mouseX, mouseY, 10, 70);
    if (mousePressed && mouseX >100 && mouseY > 100) {
      PestañaContenido1 p1 = new PestañaContenido1(cp5);
      pestañaActual.cambiarPestaña(p1);
    }
  }
}

// Clase que representa la pestaña actual
class PestañaActual {
  Pestaña pestaña;

  // Constructor que recibe una pestaña inicial
  PestañaActual(Pestaña p) {
    pestaña = p;
    pestaña.setup();
  }

  // Método para cambiar la pestaña actual
  void cambiarPestaña(Pestaña p) {
    pestaña = p;
    pestaña.setup();
  }

  // Método para dibujar la pestaña actual
  void draw() {
    pestaña.draw();
  }
}
