import java.io.FileReader;
import java.io.*;
import java.io.IOException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import controlP5.*;
import java.security.MessageDigest;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.util.Timer;
import java.util.TimerTask;
import java.util.ArrayList;
import ddf.minim.*;
import ddf.minim.spi.*;
ControlP5 cp5;
PImage boton;
PImage Ficha;
PImage Banner;
PImage BannerCuenta;
PImage volverr;
UserAccount usuario;
public int saldoJugador;

// Implementación de una pestaña con contenido específico

class PestañaInicio implements Pestaña {
  File usuarios;
  ControlP5 cp5;
  boolean controlador;
  Textfield inputUsuario;
  Textfield inputContraseña;
  rectResponsive registro;
  Boton boton1;
  Boton text;
  boolean control;
  String perfil, contraseña;
  admArchivos arc;
  color Color1 = color(176, 147, 152); //B09398
  color Color2 = color(100, 49, 115); //643173
  color Color3 = color(122, 34, 78);
  color Color4 = color(2255, 255, 255);
  color Color5 = color(20, 89, 29);
  color Color6 = color(0, 0, 0);
  color Color7 = color(237, 174, 73);
  color Color8 = color(191, 4, 19);
  color AzulOscuro = color(#060623);
  color Amarillo = color(#FFAF30);
  color Blanco = color(#FFFFFF);
  PFont fontt = createFont("Oruguitas", 10);
  //INIT
  PestañaInicio(ControlP5 cp5) {
    this.cp5 = cp5;
    this.arc = new admArchivos();
  }
  void setup() {
    Banner = loadImage("fondos/banner.png");
    background(Banner);
    Ficha = loadImage("fichas/rojaficha.png");
    controlador = true;
  }

  void draw() {
    if (controlador) {
      registro = new rectResponsive(width, 0, 20, 680, Color3);
      registro.dibujar();
      fill(Blanco);
      boton1 = new Boton(cp5, 970, 450, 180, 45, "Iniciar sesion", Amarillo, AzulOscuro);
      text = new Boton(cp5, 970, 490, 180, 20, Amarillo);
      text.enlazarAccion(new Runnable() {
        @Override
          public void run() {
          PestañaContenidoInter p3 = new PestañaContenidoInter(cp5);
          pestañaActual.cambiarPestaña(p3);
          cp5.remove("Usuario");
          cp5.remove("Contraseña");
          filter(BLUR, 2);
        }
      }
      );
      text.dibujarTexto("Registrarse", Amarillo);
      boton1.enlazarAccion(new Runnable() {
        @Override
          public void run() {
          perfil = inputUsuario.getText();
          contraseña = inputContraseña.getText();
          if (arc.revisar(perfil, contraseña) && perfil.trim().length() > 0 && contraseña.trim().length() > 0) {
            usuario.asignarInfo(perfil);
            usuario.asignarSaldo(arc.asignarSaldo(perfil));
            saldoJugador = Integer.parseInt(usuario.getsal());
            PestañaContenido2 p2 = new PestañaContenido2(cp5);
            pestañaActual.cambiarPestaña(p2);
            cp5.remove("Usuario");
            cp5.remove("Contraseña");
            mouseY = 630;
            delay(10);
            //obtiene valores del textfield
          }
        }
      }
      );
      ControlFont fontInterna = new ControlFont(createFont("Oruguitas", 16));
      ControlFont fontExterna = new ControlFont(createFont("Oruguitas", 13));
      inputUsuario = cp5.addTextfield("Usuario", 880, 250, 170, 25).setColor(AzulOscuro).setColorBackground(Amarillo).setColorForeground(AzulOscuro).setColorLabel(Blanco).setFont(fontInterna);
      inputContraseña = cp5.addTextfield("Contraseña", 880, 340, 170, 25).setColor(AzulOscuro).setColorBackground(Amarillo).setColorForeground(AzulOscuro).setColorLabel(Blanco).setFont(fontInterna);
      inputContraseña.setPasswordMode(true);
      inputUsuario.getCaptionLabel().setFont(fontExterna);
      inputContraseña.getCaptionLabel().setFont(fontExterna);
      controlador = false;
    }
    boton1.dibujar();

    if (boton1.estaPresionado()) {
      boton1.ejecutarAccion();
      boton1.removeBoton();
    }
    if (text.estaPresionado()) {
      mouseX = 100;
      mouseY = 100;
      text.ejecutarAccion();
      text.removeBoton();
    }
  }
}

class PestañaContenidoInter implements Pestaña {
  File usuarios, info;
  ControlP5 cp5;
  boolean controlador;
  Textfield inputUsuario;
  Textfield inputContraseña;
  Textfield confirmar;
  rectResponsive registro1;
  Boton boton1;
  Boton text;
  boolean control;
  String perfil, contraseña, confirmarS;
  admArchivos arc;
  color Color1 = color(176, 147, 152); //B09398
  color Color2 = color(100, 49, 115); //643173
  color Color3 = color(122, 34, 78);
  color Color4 = color(2255, 255, 255);
  color Color5 = color(20, 89, 29);
  color Color6 = color(0, 0, 0);
  color Color7 = color(237, 174, 73);
  color Color8 = color(191, 4, 19);
  color AzulOscuro = color(#060623);
  color Amarillo = color(#FFAF30);
  color Blanco = color(#FFFFFF);
  //INIT
  PestañaContenidoInter(ControlP5 cp5) {
    this.cp5 = cp5;
    this.arc = new admArchivos();
  }
  void setup() {
    registro1 = new rectResponsive(width, 0, 20, 680, Amarillo);
    registro1.moverA(750);
    controlador = true;
  }

  void draw() {
    if (controlador) {
      registro1.dibujar();
      boton1 = new Boton(cp5, 970, 450, 180, 45, "Registrarse", AzulOscuro, Amarillo);
      text = new Boton(cp5, 970, 490, 180, 20, AzulOscuro);
      text.enlazarAccion(new Runnable() {
        @Override
          public void run() {
          exit();
        }
      }
      );
      text.dibujarTexto("Ya tienes cuenta?", AzulOscuro);
      text.enlazarAccion(new Runnable() {
        @Override
          public void run() {
          PestañaInicio p1 = new PestañaInicio(cp5);
          pestañaActual.cambiarPestaña(p1);
          cp5.remove("Usuario");
          cp5.remove("Contraseña");
          cp5.remove("Repita su contraseña");
        }
      }
      );
      boton1.enlazarAccion(new Runnable() {
        @Override
          public void run() {
          perfil = inputUsuario.getText();
          contraseña = inputContraseña.getText(); //toca convertir todo esto a privado
          confirmarS = confirmar.getText();
          if (arc.revisarExistencia(perfil) && contraseña.equals(confirmarS) && perfil.trim().length() > 0 && contraseña.trim().length() > 0) {
            arc.crearCuenta(perfil, contraseña);
            arc.crearIndividual(perfil);
            PestañaInicio p2 = new PestañaInicio(cp5);
            pestañaActual.cambiarPestaña(p2);
            cp5.remove("Usuario");
            cp5.remove("Contraseña");
            cp5.remove("Repita su contraseña");
            //obtiene valores del textfield
          } else {
            //mensaje de equivocacion
          }
        }
      }
      );

      ControlFont fontInterna = new ControlFont(createFont("Oruguitas", 16));
      ControlFont fontExterna = new ControlFont(createFont("Oruguitas", 13));
      inputUsuario = cp5.addTextfield("Usuario", 880, 250, 170, 25).setColor(Blanco).setColorBackground(AzulOscuro).setColorForeground(100).setColorLabel(Blanco).setFont(fontInterna);
      inputContraseña = cp5.addTextfield("Contraseña", 880, 300, 170, 25).setColor(Blanco).setColorBackground(AzulOscuro).setColorForeground(100).setColorLabel(Blanco).setFont(fontInterna);
      confirmar = cp5.addTextfield("Repita su contraseña", 880, 350, 170, 25).setColor(Blanco).setColorBackground(AzulOscuro).setColorForeground(100).setColorLabel(Blanco).setFont(fontInterna);
      confirmar.setPasswordMode(true);
      inputContraseña.setPasswordMode(true);
      inputUsuario.getCaptionLabel().setFont(fontExterna);
      inputContraseña.getCaptionLabel().setFont(fontExterna);
      confirmar.getCaptionLabel().setFont(fontExterna);
      controlador = false;
    }
    boton1.dibujar();

    if (boton1.estaPresionado()) {
      boton1.ejecutarAccion();
      boton1.removeBoton();
      text.removeBoton();
    }
    if (text.estaPresionado()) {
      mouseX = 100;
      text.ejecutarAccion();
      text.removeBoton();
      boton1.removeBoton();
    }
  }
}

// Implementación de otra pestaña con contenido específico
class PestañaContenido2 implements Pestaña {
  Boton boton1;
  Boton boton2;
  Boton boton3;
  Boton boton4;
  PImage ruleta1 = loadImage("MENUruleta1.png");
  PImage cartas1 = loadImage("MENUblack1.png");
  PImage traga1 = loadImage("MENUtraga1.png");
  PImage ruleta2 = loadImage("MENUruleta2.png");
  PImage cartas2 = loadImage("MENUblack2.png");
  PImage traga2 = loadImage("MENUtraga2.png");
  PImage fondo = loadImage("fondos/fondojj.png");
  rectResponsive R;
  ControlP5 cp5;
  PImage menu = loadImage("menu.png");
  color Color1 = color(176, 147, 152); //B09398
  color Color2 = color(100, 49, 115); //643173
  color Color3 = color(122, 34, 78);
  color Color4 = color(255, 255, 255);
  color Color5 = color(45, 49, 66);
  color Color6 = color(0, 0, 0);
  color Color7 = color(191, 192, 192);
  color Color8 = color(223, 183, 165);
  color AzulOscuro = color(#060623);
  color Amarillo = color(#FFAF30);
  color Blanco = color(#FFFFFF);
  PestañaContenido2(ControlP5 cp5) {
    this.cp5 = cp5;
  }
  void setup() {
    background(fondo);
    boton = loadImage("boca.png");
    Ficha = loadImage("fichas/rojaficha.png");
    boton1 = new Boton(cp5, 375, 325, 200, 400, ruleta1, ruleta2);
    boton2 = new Boton(cp5, 720, 325, 200, 400, cartas1, cartas2);
    boton3 = new Boton(cp5, 1065, 325, 200, 400, traga1, traga2);
    R = new rectResponsive(0, 0, 100, 640, Amarillo);
    fill(Amarillo);
    rect(1155, 40, 200, 50);
    fill(AzulOscuro);
    textSize(20);
    text(usuario.saldo, 1155, 40);
  }

  void draw() {
    background(fondo);
    fill(Amarillo);
    rect(1155, 40, 200, 50);
    fill(AzulOscuro);
    textSize(20);
    text(usuario.saldo, 1155, 40);
    R.dibujar();
    //mouseX = 0;
    //mouseY= 640;
    imageMode(CENTER);
    image(menu, 50, 50);
    R.revisarPresion();
    boton1.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        PestañaRuleta Ruleta = new PestañaRuleta();
        pestañaActual.cambiarPestaña(Ruleta);
      }
    }

    );
    boton2.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        PestañaBlackJJack Poker = new PestañaBlackJJack();
        pestañaActual.cambiarPestaña(Poker);
      }
    }

    );
    boton3.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        PestañaTragaMone Traga = new PestañaTragaMone();
        pestañaActual.cambiarPestaña(Traga);
      }
    }

    );
    boton1.dibujarIH(Amarillo);
    boton2.dibujarIH(Amarillo);
    boton3.dibujarIH(Amarillo);
    //si no tienen más de 500, no puedes entrar
    if (boton1.estaPresionado()) {
      if (int(usuario.saldo) >= 500) {
        boton1.ejecutarAccion();
        boton1.removeBoton();
      }
    } else if (boton2.estaPresionado()) {
      if (int(usuario.saldo) >= 500) {
        boton2.ejecutarAccion();
        boton2.removeBoton();
      }
    } else if (boton3.estaPresionado()) {
      if (int(usuario.saldo) >= 500) {
        boton3.ejecutarAccion();
        boton3.removeBoton();
      }
    } else if (R.estado == true) {
      filter(BLUR, 2);
      boton1.removeBoton();
      boton2.removeBoton();
      boton3.removeBoton();
      PestañaContenidoInter2 p2 = new PestañaContenidoInter2(cp5);
      pestañaActual.cambiarPestaña(p2);
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
class PestañaContenidoInter2 implements Pestaña {
  ControlP5 cp5;
  boolean controlador;
  Boton boton1, boton2, boton3, boton4;
  rectResponsive R;
  boolean control, estado;
  color Color1 = color(176, 147, 152); //B09398
  color Color2 = color(100, 49, 115); //643173
  color Color3 = color(122, 34, 78);
  color Color4 = color(255, 255, 255);
  color Color5 = color(91, 99, 134);
  color Color6 = color(0, 0, 0);
  color Color7 = color(191, 192, 192);
  color Color8 = color(223, 183, 165);
  color AzulOscuro = color(#060623);
  color Amarillo = color(#FFAF30);
  color Blanco = color(#FFFFFF);
  //INIT
  PestañaContenidoInter2(ControlP5 cp5) {
    this.cp5 = cp5;
    //revisar si es necesario poner todo en el constructor
  }
  void setup() {
    Ficha = loadImage("fichas/rojaficha.png");
    R = new rectResponsive(0, 0, 100, 640, Amarillo);
    R.moverA(270);
    controlador = true;
  }

  void draw() {
    if (controlador) {
      boton1 = new Boton(cp5, 185, 230, 370, 50, "Cuenta", AzulOscuro, Amarillo);
      boton2 = new Boton(cp5, 185, 314, 370, 50, "Opciones", AzulOscuro, Amarillo);
      boton3 = new Boton(cp5, 185, 396, 370, 50, "Salir", AzulOscuro, Amarillo);
      boton1.enlazarAccion(new Runnable() {
        @Override
          public void run() {
          PestañaCuentas1 cuentas = new PestañaCuentas1(cp5);
          pestañaActual.cambiarPestaña(cuentas);
          mouseY = 630;
          delay(10);
          //obtiene valores del textfield
        }
      }
      );
      boton2.enlazarAccion(new Runnable() {
        @Override
          public void run() {
          PestañaOpciones Opcion = new PestañaOpciones(cp5);
          pestañaActual.cambiarPestaña(Opcion);
          mouseY = 630;
          delay(10);
          //obtiene valores del textfield
        }
      }
      );
      boton3.enlazarAccion(new Runnable() {
        @Override
          public void run() {
          boton1.removeBoton();
          boton2.removeBoton();
          boton3.removeBoton();
          //filter(BLUR, 2);
          Salir salir = new Salir(cp5);
          pestañaActual.cambiarPestaña(salir);
          mouseY = 630;
          delay(10);
        }
      }
      );
      controlador = false;
    }
    boton1.dibujar();
    boton2.dibujar();
    boton3.dibujar();
    if (mouseX > 250 && mousePressed ) {
      mouseX = 1000;
      PestañaContenido2 p2 = new PestañaContenido2(cp5);
      pestañaActual.cambiarPestaña(p2);
    }
    if (boton1.estaPresionado()) {
      boton1.ejecutarAccion();
      boton1.removeBoton();
    }
    if (boton2.estaPresionado()) {
      boton2.ejecutarAccion();
      boton2.removeBoton();
    }
    if (boton3.estaPresionado()) {
      boton3.ejecutarAccion();
      boton3.removeBoton();
    }
  }
}
class Salir implements Pestaña {
  Boton boton1;
  Boton boton2;
  Boton boton3;
  PFont font = createFont("Oruguitas", 10);
  PImage cerrar = loadImage("cerrar.png");
  color AzulOscuro = color(#060623);
  color Amarillo = color(#FFAF30);
  color Blanco = color(#FFFFFF);
  ControlP5 cp5;
  Salir (ControlP5 cp5) {
    this.cp5 = cp5;
  }
  void setup() {
    boton1 = new Boton(cp5, 760, 380, 150, 70, "Salir", Amarillo, Blanco);
    boton2 = new Boton(cp5, 530, 380, 150, 70, "Cerrar Sesión", Amarillo, Blanco);
    boton3 = new Boton(cp5, 865, 220, 40, 40, "X", Amarillo, AzulOscuro);
    rectMode(CENTER);
    fill(AzulOscuro);
    rect(width/2, height/2, 500, 250, 10, 10, 10, 10);
    fill(Blanco);
    textFont(font);
    textSize(20);
    text("Qué quiere hacer?", 640, 270);
    boton1.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        exit();
      }
    }
    );
    boton2.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        PestañaInicio c1 = new PestañaInicio(cp5);
        pestañaActual.cambiarPestaña(c1);
      }
    }
    );
    boton3.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        PestañaContenido2 c2 = new PestañaContenido2(cp5);
        pestañaActual.cambiarPestaña(c2);
      }
    }
    );
  }
  void draw() {
    boton1.dibujar();
    boton2.dibujar();
    boton3.dibujar();
    if (boton1.estaPresionado()) {
      boton1.ejecutarAccion();
      boton1.removeBoton();
    }
    if (boton2.estaPresionado()) {
      boton2.ejecutarAccion();
      boton2.removeBoton();
    }
    if (boton3.estaPresionado()) {
      boton3.ejecutarAccion();
      boton3.removeBoton();
    }
  }
}
//Recargar
class PestañaCuentas1 implements Pestaña {
  Boton boton1;
  Boton boton2;
  Boton boton3;
  Boton boton4;
  rectResponsive R;
  ControlP5 cp5;
  admArchivos arc;
  PFont fontt = createFont("Oruguitas", 10);
  color Color1 = color(176, 147, 152); //B09398
  color Color2 = color(100, 49, 115); //643173
  color Color3 = color(122, 34, 78);
  color Color4 = color(255, 255, 255);
  color Color5 = color(45, 49, 66);
  color Color6 = color(0, 0, 0);
  color Color7 = color(191, 192, 192);
  color Color8 = color(223, 183, 165);
  color AzulOscuro = color(#070729);
  color Amarillo = color(#FFAF30);
  color Blanco = color(#FFFFFF);
  Textfield inputSaldo;
  String x;
  int recarga;
  String monto;
  PestañaCuentas1(ControlP5 cp5) {
    this.cp5 = cp5;
  }
  void setup() {
    BannerCuenta = loadImage("Fondo de cuentas.png");
    background(BannerCuenta);
    arc = new admArchivos();
    boton = loadImage("flecha_blanca.png");
    Ficha = loadImage("ficharoja.png");
    boton1 = new Boton(cp5, 40, 40, 40, 40, boton);
    boton2 = new Boton(cp5, 410, 390, 150, 35, "Confirmar", AzulOscuro, Blanco);
    boton3 = new Boton(cp5, 980, 330, 150, 35, "Cambiar contraseña", Amarillo, AzulOscuro);
    boton4 = new Boton(cp5, 980, 390, 150, 35, "Eliminar cuenta", Amarillo, AzulOscuro);

    fill(AzulOscuro);
    rect(1155, 50, 200, 50);
    fill(Blanco);
    text(usuario.saldo, 1155, 50);

    fill(AzulOscuro);
    textFont(fontt);
    textMode(CENTER);
    textSize(20);
    text("RECARGAR", 410, 260);
    fill(AzulOscuro);
    rect(975, 350, 375, 450);
    fill(Amarillo);
    textFont(fontt);
    textMode(CENTER);
    textSize(20);
    text("¿Qué desea hacer?", 980, 250);
    ControlFont font = new ControlFont(createFont("Oruguitas", 12));
    ControlFont fontExterna = new ControlFont(createFont("Oruguitas", 16));
    inputSaldo = cp5.addTextfield("Ingrese el monto", 255, 290, 300, 40).setColor(Blanco).setColorBackground(AzulOscuro).setColorForeground(100).setColorLabel(AzulOscuro).setFont(font);
    inputSaldo.setFont(fontExterna);
  }

  void draw() {
    boton2.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        try {
          mouseX = 10;
          delay(10);
          monto = inputSaldo.getText();
          x = arc.recargar(monto, usuario.usuario);
          usuario.asignarSaldo(x);
          background(Amarillo);
          cp5.remove("Ingrese el monto");
          PestañaCuentas1 cr = new PestañaCuentas1(cp5);
          pestañaActual.cambiarPestaña(cr);
        }
        catch(NumberFormatException e) {
        }
      }
    }
    );
    boton3.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        background(Amarillo);
        cp5.remove("Ingrese el monto");
        PestañaCuentas2 cr = new PestañaCuentas2(cp5);
        pestañaActual.cambiarPestaña(cr);
        mouseX = 10;
        delay(10);
      }
    }
    );
    boton4.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        background(Amarillo);
        cp5.remove("Ingrese el monto");
        PestañaCuentas3 cr = new PestañaCuentas3(cp5);
        pestañaActual.cambiarPestaña(cr);
        mouseX = 10;
        delay(10);
      }
    }
    );
    boton1.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        PestañaContenido2 p2 = new PestañaContenido2(cp5);
        pestañaActual.cambiarPestaña(p2);
        cp5.remove("Ingrese el monto");
      }
    }

    );
    boton1.dibujarI();
    boton2.dibujar();
    boton3.dibujar();
    boton4.dibujar();
    if (boton1.estaPresionado()) {
      boton1.ejecutarAccion();
      boton1.removeBoton();
    }
    if (boton2.estaPresionado()) {
      boton2.ejecutarAccion();
      boton2.removeBoton();
    }
    if (boton3.estaPresionado()) {
      boton3.ejecutarAccion();
      boton3.removeBoton();
    }
    if (boton4.estaPresionado()) {
      boton4.ejecutarAccion();
      boton4.removeBoton();
    }
  }
}
//Cambiar contraseña
class PestañaCuentas2 implements Pestaña {
  Boton boton1;
  Boton boton2;
  Boton boton3;
  Boton boton4;
  rectResponsive R;
  ControlP5 cp5;
  admArchivos arc;
  PFont fontt = createFont("Oruguitas", 10);
  color Color1 = color(176, 147, 152); //B09398
  color Color2 = color(100, 49, 115); //643173
  color Color3 = color(122, 34, 78);
  color Color4 = color(255, 255, 255);
  color Color5 = color(45, 49, 66);
  color Color6 = color(0, 0, 0);
  color Color7 = color(191, 192, 192);
  color Color8 = color(223, 183, 165);
  color AzulOscuro = color(#070729);
  color Amarillo = color(#FFAF30);
  color Blanco = color(#FFFFFF);
  Textfield inputContra;
  String x;
  int recarga;
  String nContra;
  PestañaCuentas2(ControlP5 cp5) {
    this.cp5 = cp5;
  }
  void setup() {
    BannerCuenta = loadImage("Fondo de cuentas.png");
    background(BannerCuenta);
    arc = new admArchivos();
    boton = loadImage("flecha_blanca.png");
    boton1 = new Boton(cp5, 40, 40, 40, 40, boton);
    boton2 = new Boton(cp5, 410, 390, 150, 35, "Confirmar", AzulOscuro, Blanco);
    boton3 = new Boton(cp5, 980, 330, 150, 35, "Recargar", Amarillo, AzulOscuro);
    boton4 = new Boton(cp5, 980, 390, 150, 35, "Eliminar cuenta", Amarillo, AzulOscuro);

    fill(AzulOscuro);
    rect(1155, 50, 200, 50);
    fill(Blanco);
    text(usuario.saldo, 1155, 50);

    fill(AzulOscuro);
    textFont(fontt);
    textMode(CENTER);
    textSize(20);
    text("CAMBIAR CONTRASEÑA", 410, 260);
    fill(AzulOscuro);
    rect(975, 350, 375, 450);
    fill(Amarillo);
    textFont(fontt);
    textMode(CENTER);
    textSize(20);
    text("¿Qué desea hacer?", 980, 250);
    ControlFont font = new ControlFont(createFont("Oruguitas", 12));
    inputContra = cp5.addTextfield("Ingrese su nueva contraseña", 255, 290, 300, 40).setColor(Blanco).setColorBackground(AzulOscuro).setColorForeground(100).setColorLabel(AzulOscuro).setFont(font);
  }

  void draw() {
    boton2.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        try {
          nContra = inputContra.getText();
          arc.cambiarContraseña(usuario.usuario, nContra);
          cp5.remove("Ingrese su nueva contraseña");
          PestañaInicio cr = new PestañaInicio(cp5);
          pestañaActual.cambiarPestaña(cr);
        }
        catch(NumberFormatException e) {
        }
      }
    }
    );
    boton1.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        PestañaContenido2 p2 = new PestañaContenido2(cp5);
        pestañaActual.cambiarPestaña(p2);
        cp5.remove("Ingrese su nueva contraseña");
      }
    }
    );
    boton3.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        background(Amarillo);
        cp5.remove("Ingrese su nueva contraseña");
        PestañaCuentas1 cr = new PestañaCuentas1(cp5);
        pestañaActual.cambiarPestaña(cr);
        mouseX = 10;
        delay(10);
      }
    }
    );
    boton4.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        background(Amarillo);
        cp5.remove("Ingrese su nueva contraseña");
        PestañaCuentas3 cr = new PestañaCuentas3(cp5);
        pestañaActual.cambiarPestaña(cr);
        mouseX = 10;
        delay(10);
      }
    }
    );
    boton1.dibujarI();
    boton2.dibujar();
    boton3.dibujar();
    boton4.dibujar();
    if (boton1.estaPresionado()) {
      boton1.ejecutarAccion();
      boton1.removeBoton();
    }
    if (boton2.estaPresionado()) {
      boton2.ejecutarAccion();
      boton2.removeBoton();
    }
    if (boton3.estaPresionado()) {
      boton3.ejecutarAccion();
      boton3.removeBoton();
    }
    if (boton4.estaPresionado()) {
      boton4.ejecutarAccion();
      boton4.removeBoton();
    }
  }
}
//Eliminar cuenta
class PestañaCuentas3 implements Pestaña {
  Boton boton1;
  Boton boton2;
  Boton boton3;
  Boton boton4;
  rectResponsive R;
  ControlP5 cp5;
  admArchivos arc;
  PFont fontt = createFont("Oruguitas", 10);
  color Color1 = color(176, 147, 152); //B09398
  color Color2 = color(100, 49, 115); //643173
  color Color3 = color(122, 34, 78);
  color Color4 = color(255, 255, 255);
  color Color5 = color(45, 49, 66);
  color Color6 = color(0, 0, 0);
  color Color7 = color(191, 192, 192);
  color Color8 = color(223, 183, 165);
  color AzulOscuro = color(#070729);
  color Amarillo = color(#FFAF30);
  color Blanco = color(#FFFFFF);
  Textfield inputSaldo;
  String x;
  int recarga;
  String contraseña;
  PestañaCuentas3(ControlP5 cp5) {
    this.cp5 = cp5;
  }
  void setup() {
    BannerCuenta = loadImage("Fondo de cuentas.png");
    background(BannerCuenta);
    arc = new admArchivos();
    boton = loadImage("flecha_blanca.png");
    boton1 = new Boton(cp5, 40, 40, 40, 40, boton);
    boton2 = new Boton(cp5, 410, 390, 150, 35, "Confirmar", AzulOscuro, Blanco);
    boton3 = new Boton(cp5, 980, 330, 150, 35, "Recargar", Amarillo, AzulOscuro);
    boton4 = new Boton(cp5, 980, 390, 150, 35, "Cambiar contraseña", Amarillo, AzulOscuro);

    fill(AzulOscuro);
    rect(1155, 50, 200, 50);
    fill(Blanco);
    text(usuario.saldo, 1155, 50);

    fill(AzulOscuro);
    textFont(fontt);
    textMode(CENTER);
    textSize(20);
    text("ELIMINAR CUENTA", 410, 260);
    fill(AzulOscuro);
    rect(975, 350, 375, 450);
    fill(Amarillo);
    textFont(fontt);
    textMode(CENTER);
    textSize(20);
    text("¿Qué desea hacer?", 980, 250);
    ControlFont font = new ControlFont(createFont("Oruguitas", 12));
    inputSaldo = cp5.addTextfield("Ingrese su contraseña", 255, 290, 300, 40).setColor(Blanco).setColorBackground(AzulOscuro).setColorForeground(100).setColorLabel(AzulOscuro).setFont(font);
  }

  void draw() {
    boton2.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        try {
          contraseña = inputSaldo.getText();
          arc.eliminarCuenta(usuario.usuario, contraseña);
          cp5.remove("Ingrese su contraseña");
          PestañaInicio p2 = new PestañaInicio(cp5);
          pestañaActual.cambiarPestaña(p2);
        }
        catch(NumberFormatException e) {
        }
      }
    }
    );
    boton1.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        PestañaContenido2 p2 = new PestañaContenido2(cp5);
        pestañaActual.cambiarPestaña(p2);
        cp5.remove("Ingrese su contraseña");
      }
    }
    );
    boton3.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        background(Amarillo);
        cp5.remove("Ingrese su contraseña");
        PestañaCuentas1 cr = new PestañaCuentas1(cp5);
        pestañaActual.cambiarPestaña(cr);
        mouseX = 10;
        delay(10);
      }
    }
    );
    boton4.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        background(Amarillo);
        cp5.remove("Ingrese su contraseña");
        PestañaCuentas2 cr = new PestañaCuentas2(cp5);
        pestañaActual.cambiarPestaña(cr);
        mouseX = 10;
        delay(10);
      }
    }
    );
    boton1.dibujarI();
    boton2.dibujar();
    boton3.dibujar();
    boton4.dibujar();
    if (boton1.estaPresionado()) {
      boton1.ejecutarAccion();
      boton1.removeBoton();
    }
    if (boton2.estaPresionado()) {
      boton2.ejecutarAccion();
      boton2.removeBoton();
    }
    if (boton3.estaPresionado()) {
      boton3.ejecutarAccion();
      boton3.removeBoton();
    }
    if (boton4.estaPresionado()) {
      boton4.ejecutarAccion();
      boton4.removeBoton();
    }
  }
}
class PestañaOpciones implements Pestaña {
  Boton boton1;
  Boton boton2;
  Boton boton3;
  Boton boton4;
  Boton boton5;
  Boton boton6;
  ControlP5 cp5;
  PFont fontt = createFont("Oruguitas", 10);
  color Color1 = color(176, 147, 152); //B09398
  color Color2 = color(100, 49, 115); //643173
  color Color3 = color(122, 34, 78);
  color Color4 = color(255, 255, 255);
  color Color5 = color(45, 49, 66);
  color Negro = color(0, 0, 0);
  color Color7 = color(237, 174, 73);
  color Color8 = color(223, 183, 165);
  color AzulOscuro = color(#070729);
  color Amarillo = color(#FFAF30);
  color Blanco = color(#FFFFFF);
  PestañaOpciones(ControlP5 cp5) {
    this.cp5 = cp5;
  }
  void setup() {
    background(AzulOscuro);
    boton = loadImage("volver.png");
    Ficha = loadImage("CuadradoBlanco.png");
    boton1 = new Boton(cp5, 40, 40, 40, 40, boton);
    boton3 = new Boton(cp5, 700, 400, 200, 50, "VOLUMEN", Blanco, Negro);
    boton4 = new Boton(cp5, 400, 250, 200, 50, "BLACKJACK",Blanco, Negro);
    boton5 = new Boton(cp5, 400, 350, 200, 50, "RULETA", Blanco, Negro);
    boton6 = new Boton(cp5, 400, 450, 200, 50, "TRAGAMONEDAS", Blanco, Negro);
    fill(Amarillo);
    rect(1155, 50, 200, 50);
    fill(Blanco);
    text(usuario.saldo, 1155, 50);
    fill(Blanco);
    rect(700, 400, 200, 50);
    rect(400, 250, 200, 50);
    rect(400, 350, 200, 50);
    rect(400, 450, 200, 50);
    fill(Amarillo);
    rect(0,0, 200, 1600);
    textFont(fontt);
    fill(Blanco);
    textSize(50);
    text("OPCIONES", 600, 50);
    textSize(16);
    text("INSTRUCIONES", 400, 200);
    fill(Negro);
    text("CANCIONES", 700, 400);
    
  }

  void draw() {
    boton1.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        PestañaContenido2 p2 = new PestañaContenido2(cp5);
        pestañaActual.cambiarPestaña(p2);
      }
    }
    
    );
    boton3.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        PestañaVolumen p2 = new PestañaVolumen(cp5);
        pestañaActual.cambiarPestaña(p2);
      }
    }

    );
    boton4.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        PestañaInstruciones21BJ p2 = new PestañaInstruciones21BJ(cp5);
        pestañaActual.cambiarPestaña(p2);
      }
    }

    );
    boton5.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        PestañaInstrucionesRuleta p2 = new PestañaInstrucionesRuleta(cp5);
        pestañaActual.cambiarPestaña(p2);
      }
    }

    );
    boton6.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        PestañaInstrucionesTraga p2 = new PestañaInstrucionesTraga(cp5);
        pestañaActual.cambiarPestaña(p2);
      }
    }
    );
    boton1.dibujarI();
    boton3.dibujar();
    boton4.dibujar();
    boton5.dibujar();
    boton6.dibujar();
    if (boton1.estaPresionado()) {
      boton1.ejecutarAccion();
      boton1.removeBoton();
    }
    if (boton3.estaPresionado()) {
      boton3.ejecutarAccion();
      boton3.removeBoton();
    }
    if (boton4.estaPresionado()) {
      boton4.ejecutarAccion();
      boton4.removeBoton();
    }
    if (boton5.estaPresionado()) {
      boton5.ejecutarAccion();
      boton5.removeBoton();
    }
    
    if (boton6.estaPresionado()) {
      boton6.ejecutarAccion();
      boton6.removeBoton();
    }
  }
}

class PestañaInstrucionesRuleta implements Pestaña {
  Boton boton1;
  Boton boton4;
  ControlP5 cp5;
  PFont fontt = createFont("Oruguitas", 10);
  PFont xd;
  color Color1 = color(176, 147, 152); //B09398
  color Color2 = color(100, 49, 115); //643173
  color Color3 = color(245, 200, 36);
  color Color4 = color(122, 104, 82);
  color Color5 = color(45, 49, 66);
  color Negro = color(0, 0, 0);
  color Color7 = color(237, 174, 73);
  color Color8 = color(223, 183, 165);
  color AzulOscuro = color(#070729);
  color Amarillo = color(#FFAF30);
  color Blanco = color(#FFFFFF);
  PestañaInstrucionesRuleta(ControlP5 cp5) {
    this.cp5 = cp5;
  }
  void setup() {
    background(AzulOscuro);
    boton = loadImage("volver.png");
    Ficha = loadImage("ficharoja.png");
    xd = loadFont("MicrosoftSansSerif-48.vlw");
    boton1 = new Boton(cp5, 40, 40, 40, 40, boton);
    fill(Blanco);
    rect(700, 323, 979, 555);
    fill(Amarillo);
    rect(0, 0, 200, 1600);
    textFont(xd);
    textFont(fontt);
    textSize(32);
    fill(Negro);
    text("*Para el juego de la ruleta, una vez iniciado, el usuario encontrada", 700, 75);
    text("primero la mesa de apuesta donde vera una mesa europea de apuestas,", 700, 120);
    text("para apostar el usuario deberá seleccionar (haciendo clic)la ficha", 700, 165);
    text("con el valor de la apuesta que se desea realizar, esto hará que tenga", 700, 210);
    text("la ficha en la mano y solo tendrá que seleccionar el tipo de apuesta", 700, 255);
    text("que desea, ya sea un número, por filas, por docenas, etc., Una vez ya", 700, 300);
    text("completada todas la apuestas, en el lugar donde se ve el cuadro verde", 700, 345);
    text("será cambiado por un botón) para ir a la ruleta a ver en que casilla", 700, 390);
    text("cayo la bola. Una vez en esta pestaña el usuario vera una animación", 700, 435);
    text("de la ruleta y al final la ubicación de la bola Y ya una vez vea la ubicación,", 700, 480);
    text("para volver a la mesa de apuesta debe seleccionar el cuadro fucsia", 700, 525);
    text("será cambiado por un botón) para ir a la mesa de apuesta para volver a jugar", 700, 570);
  }

  void draw() {
    boton1.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        PestañaContenido2 p2 = new PestañaContenido2(cp5);
        pestañaActual.cambiarPestaña(p2);
      }
    }

    );
    boton1.dibujarI();
    if (boton1.estaPresionado()) {
      boton1.ejecutarAccion();
      boton1.removeBoton();
    }
  }
}
class PestañaInstrucionesTraga implements Pestaña {
  Boton boton1;
  Boton boton4;
  ControlP5 cp5;
  PFont xd;
  color Color1 = color(176, 147, 152); //B09398
  color Color2 = color(100, 49, 115); //643173
  color Color3 = color(245, 200, 36);
  color Color4 = color(122, 104, 82);
  color Color5 = color(45, 49, 66);
  color Negro = color(0, 0, 0);
  color Color7 = color(237, 174, 73);
  color Color8 = color(223, 183, 165);
  color AzulOscuro = color(#070729);
  color Amarillo = color(#FFAF30);
  color Blanco = color(#FFFFFF);
  PestañaInstrucionesTraga(ControlP5 cp5) {
    this.cp5 = cp5;
  }
  void setup() {
    background(AzulOscuro);
    boton = loadImage("volver.png");
    Ficha = loadImage("ficharoja.png");
    xd = loadFont("MicrosoftSansSerif-48.vlw");
    boton1 = new Boton(cp5, 40, 40, 40, 40, boton);
    fill(Blanco);
    rect(700, 323, 979, 555);
    fill(Amarillo);
    rect(0, 0, 200, 1600);
    textFont(xd);
    textSize(21);
    fill(Negro);
    text("*Para el juego del tragamonedas de 3x3 al momento de iniciar se mostrará la maquina en la", 700, 75);
    text("cual la parte superior del tragamonedas se encuentra el cuadro para escribir el valor apostar", 700, 120);
    text("luego de ello el usuario debe hacer clic en el botón rojo para hacer girar la maquina el cual empezará", 700, 165);
    text("y de manera aleatoria generará una combinación.Una vez generada la combinación si el resultado es:", 700, 210);
    text("1. Las tres cerezas el valor apostado se multiplicará por quince (X15", 700, 255);
    text("2. Los tres sietes el valor apostado será multiplicado por treinta (X25)", 700, 300);
    text("3. Los tres símbolos del casino el valor apostado será multiplicado por (X35", 700, 345);
    text("Y si no genero ninguna de esas combinaciones puede volver a jugar cada que escriba el valor apostar de ", 700, 390);
    text("esa manera puede volver a presionar el botón y jugar.", 700, 435);
  }

  void draw() {
    boton1.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        PestañaContenido2 p2 = new PestañaContenido2(cp5);
        pestañaActual.cambiarPestaña(p2);
      }
    }

    );
    boton1.dibujarI();
    if (boton1.estaPresionado()) {
      boton1.ejecutarAccion();
      boton1.removeBoton();
    }
  }
}
class PestañaInstruciones21BJ implements Pestaña {
  Boton boton1;
  Boton boton4;
  ControlP5 cp5;
  PFont xd;
  color Color1 = color(176, 147, 152); //B09398
  color Color2 = color(100, 49, 115); //643173
  color Color3 = color(245, 200, 36);
  color Color4 = color(122, 104, 82);
  color Color5 = color(45, 49, 66);
  color Negro = color(0, 0, 0);
  color Color7 = color(237, 174, 73);
  color Color8 = color(223, 183, 165);
  color AzulOscuro = color(#070729);
  color Amarillo = color(#FFAF30);
  color Blanco = color(#FFFFFF);
  PestañaInstruciones21BJ(ControlP5 cp5) {
    this.cp5 = cp5;
  }
  void setup() {
    background(AzulOscuro);
    boton = loadImage("volver.png");
    Ficha = loadImage("fichas/rojaficha.png");
    xd = loadFont("MicrosoftSansSerif-48.vlw");
    boton1 = new Boton(cp5, 40, 40, 40, 40, boton);
    fill(Blanco);
    rect(700, 323, 979, 555);
    fill(Amarillo);
    rect(0, 0, 200, 1600);
    textFont(xd);
    textSize(24);
    fill(Negro);
    text("*Para el juego de la ruleta, una vez iniciado, el usuario encontrada", 700, 100);
    text("primero la mesa de apuesta donde vera una mesa europea de apuestas,", 700, 135);
    text("para apostar el usuario deberá seleccionar (haciendo clic )la ficha", 700, 165);
    text("con el valor de la apuesta que se desea realizar, esto hará que tenga", 700, 195);
    text("la ficha en la mano y solo tendrá que seleccionar el tipo de apuesta", 700, 225);
    text("que desea, ya sea un número, por filas, por docenas, etc., Una vez ya", 700, 255);
    text("completada todas la apuestas, en el lugar donde se ve el cuadro verde", 700, 285);
    text("será cambiado por un botón) para ir a la ruleta a ver en que casilla", 700, 315);
    text("cayo la bola. Una vez en esta pestaña el usuario vera una animación", 700, 345);
    text("de la ruleta y al final la ubicación de la bola Y ya una vez vea la ubicación,", 700, 375);
    text("para volver a la mesa de apuesta debe seleccionar el cuadro fucsia", 700, 405);
    text("será cambiado por un botón) para ir a la mesa de apuesta para volver a jugar", 700, 435);
  }

  void draw() {
    boton1.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        PestañaContenido2 p2 = new PestañaContenido2(cp5);
        pestañaActual.cambiarPestaña(p2);
      }
    }

    );
    boton1.dibujarI();
    if (boton1.estaPresionado()) {
      boton1.ejecutarAccion();
      boton1.removeBoton();
    }
  }
}
class PestañaMusica implements Pestaña {
  Boton boton1;
  Boton boton4;
  ControlP5 cp5;
  PFont fontt = createFont("Oruguitas", 10);
  PFont xd;
  color Color1 = color(176, 147, 152); //B09398
  color Color2 = color(100, 49, 115); //643173
  color Color3 = color(245, 200, 36);
  color Color4 = color(122, 104, 82);
  color Color5 = color(45, 49, 66);
  color Negro = color(0, 0, 0);
  color Color7 = color(237, 174, 73);
  color Color8 = color(223, 183, 165);
  color AzulOscuro = color(#070729);
  color Amarillo = color(#FFAF30);
  color Blanco = color(#FFFFFF);
  PestañaMusica(ControlP5 cp5) {
    this.cp5 = cp5;
  }
  void setup() {
    background(AzulOscuro);
    boton = loadImage("volver.png");
    Ficha = loadImage("ficharoja.png");
    xd = loadFont("MicrosoftSansSerif-48.vlw");
    boton1 = new Boton(cp5, 40, 40, 40, 40, boton);
    fill(Blanco);
    rect(700, 323, 979, 555);
    fill(Amarillo);
    rect(0, 0, 200, 1600);
    textFont(xd);
    textFont(fontt);
    textSize(32);
    fill(Negro);
    text("*Para el juego de la ruleta, una vez iniciado, el usuario encontrada", 700, 75);
    text("primero la mesa de apuesta donde vera una mesa europea de apuestas,", 700, 120);
    text("para apostar el usuario deberá seleccionar (haciendo clic)la ficha", 700, 165);
    text("con el valor de la apuesta que se desea realizar, esto hará que tenga", 700, 210);
    text("la ficha en la mano y solo tendrá que seleccionar el tipo de apuesta", 700, 255);
    text("que desea, ya sea un número, por filas, por docenas, etc., Una vez ya", 700, 300);
    text("completada todas la apuestas, en el lugar donde se ve el cuadro verde", 700, 345);
    text("será cambiado por un botón) para ir a la ruleta a ver en que casilla", 700, 390);
    text("cayo la bola. Una vez en esta pestaña el usuario vera una animación", 700, 435);
    text("de la ruleta y al final la ubicación de la bola Y ya una vez vea la ubicación,", 700, 480);
    text("para volver a la mesa de apuesta debe seleccionar el cuadro fucsia", 700, 525);
    text("será cambiado por un botón) para ir a la mesa de apuesta para volver a jugar", 700, 570);
  }

  void draw() {
    boton1.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        PestañaContenido2 p2 = new PestañaContenido2(cp5);
        pestañaActual.cambiarPestaña(p2);
      }
    }

    );
    boton1.dibujarI();
    if (boton1.estaPresionado()) {
      boton1.ejecutarAccion();
      boton1.removeBoton();
    }
  }
}
class PestañaVolumen implements Pestaña {
  Boton boton1;
  Boton boton4;
  AudioPlayer audio;
  Minim minim;
  Cancion c;
  ControlP5 cp5;
  int volume = 0; // Valor inicial del volumen
  Slider volumeSlider; // Variable para almacenar el slider de volumen
  PFont fontt = createFont("Oruguitas", 10);
  PFont xd;
  color Color1 = color(176, 147, 152); //B09398
  color Color2 = color(100, 49, 115); //643173
  color Color3 = color(245, 200, 36);
  color Color4 = color(122, 104, 82);
  color Color5 = color(45, 49, 66);
  color Negro = color(0, 0, 0);
  color Color7 = color(237, 174, 73);
  color Color8 = color(223, 183, 165);
  color AzulOscuro = color(#070729);
  color Amarillo = color(#FFAF30);
  color Blanco = color(#FFFFFF);
  PestañaVolumen(ControlP5 cp5) {
    this.cp5 = cp5;
  }
  void setup() {
    volumeSlider = cp5.addSlider("volume")
     .setPosition(400, 250)
     .setWidth(600)
     .setHeight(50)
     .setRange(0, 100) // Rango de valores del slider
     .setValue(volume); // Establece el valor inicial del volumen
     
    // Oculta la barra de volumen
    volumeSlider.setVisible(true);
    background(AzulOscuro);
    boton = loadImage("volver.png");
    Ficha = loadImage("ficharoja.png");
    xd = loadFont("MicrosoftSansSerif-48.vlw");
    boton1 = new Boton(cp5, 40, 40, 40, 40, boton);
    fill(Blanco);
    rect(700, 323, 979, 555);
    fill(Amarillo);
    rect(0,0, 200, 1600);
    fill(Negro);
    textFont(fontt);
    textSize(100);
    text("VOLUMEN", 700, 125);
    textSize(45);
    text("Arrastra el rectangulo para subir o bajar el volumen", 690, 350);

   }

  void draw() {
    boton1.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        PestañaContenido2 p2 = new PestañaContenido2(cp5);
        pestañaActual.cambiarPestaña(p2);
      }
    }
    
    );
    boton1.dibujarI();
    if (boton1.estaPresionado()) {
      boton1.ejecutarAccion();
      boton1.removeBoton();
      volumeSlider.setVisible(false);
    }
  }
  void volume(int value) {
  volume = value;
  
  // Aquí puedes realizar las acciones necesarias con el valor del volumen, como ajustar el volumen de audio, por ejemplo.
}
}
