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
  File usuarios;
  ControlP5 cp5;
  boolean controlador;
  Textfield inputUsuario;
  Textfield inputContraseña;
  Boton boton1;
  boolean control;
  String perfil, contraseña;
  admArchivos arc;
  //INIT
  PestañaContenido1(ControlP5 cp5) {
    this.cp5 = cp5;
    this.usuarios = new File(dataPath(""), "/usuarios.txt");
    this.arc = new admArchivos(this.usuarios);
  }
  void setup() {
    size(10, 10);
    background(241, 250, 238); //F1FAEE
    controlador = true;
  }

  void draw() {
    if (controlador) {
      fill(0);
      textFont(createFont("Arial", 25));
      textAlign(CENTER);
      text("Boa Casino", 615, 215);
      boton1 = new Boton(cp5, 560, 500, 100, 70, "Iniciar sesion");
      boton1.enlazarAccion(new Runnable() {
        @Override
          public void run() {
          perfil = inputUsuario.getText();
          contraseña = inputContraseña.getText(); //toca convertir todo esto a privado
          if (arc.revisar(perfil, contraseña)) {
            PestañaContenido2 p2 = new PestañaContenido2();
            pestañaActual.cambiarPestaña(p2);
            cp5.remove("Usuario");
            cp5.remove("Contraseña");
            //obtiene valores del textfield
          }
        }
      }
      );
      color Color1 = color(176, 147, 152); //B09398
      color Color2 = color(100, 49, 115); //643173
      ControlFont font = new ControlFont(createFont("Arial", 12));
      inputUsuario = cp5.addTextfield("Usuario", 560, 370, 100, 20).setColorBackground(Color1).setColorForeground(Color2).setColorLabel(Color2).setFont(font);
      inputContraseña = cp5.addTextfield("Contraseña", 560, 420, 100, 20).setColorBackground(Color1).setColorForeground(Color2).setColorLabel(Color2).setFont(font);
      inputContraseña.setPasswordMode(true);
      controlador = false;
    }
    boton1.dibujar();

    if (boton1.estaPresionado()) {
      boton1.ejecutarAccion();
      boton1.removeBoton();
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
