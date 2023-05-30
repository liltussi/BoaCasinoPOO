class TragaMoneda {
  Boton exit;
  admArchivos arc;
  
  String pantalla = "Traga";
  int apuestaTGM;                      //Apuesta del jugador
  int premioTGM;                       //Premio de la jugada
  CintaTragaMonedas[] resultados;      //Cintas de la máquina
  boolean jugando = false;             //Activar jugada de máquina

  boolean ayuda = false;
  PImage vent_ayuda;
  PImage boton_ayuda;

  boolean boton_presionado = false;    //Botón presionado
  boolean ani_activada = false;        //Activación de la animación de botón
  boolean en_juego = false;            //Activación de la animación en juego
  PImage saldo_img;                    //Cuadro del saldo
  PImage[] ani_fondo;                  //Animación del fondo
  PImage[] ani_boton;                  //Animación de botón presionado
  PImage[] apuesta_boton;              //Botón de cada apuesta
  int ani_vel;                         //Velocidad de la animación
  int desv;                            //Desviación de visualización de secuencia

  int inc_ad;                          //Inicio de una advertencia
  int dur_ad;                          //Duración del mensaje
  String advertencia;                  //Mensaje de advertencia

  PImage cinta;                        //Cinta del tragamonedas
  int[] despl_cintas;                  //Desplazamiento de las cintas

  TragaMoneda (admArchivos arc) {
    this.arc = arc;
    resultados = new CintaTragaMonedas[] { new CintaTragaMonedas(270, 210),
      new CintaTragaMonedas(520, 210),
      new CintaTragaMonedas(765, 210) };
    apuestaTGM = 0;
    premioTGM = 0;

    ani_fondo = new PImage [6];
    ani_boton = new PImage [6];
    apuesta_boton = new PImage [4];
    ani_vel = 200;
    desv = 0;
    advertencia = "Sin error";
    inc_ad = -5001;
    dur_ad = 5000;  //5 segundos

    //Leer imágenes de fondo
    String carpeta1 = "NoHundido/", carpeta2 = "Hundir/";
    for (int i = 0; i < 6; i++) {
      ani_fondo[i] = loadImage(carpeta1 + "tp-botonNOundido" + (i+1) + ".png");
      ani_boton[i] = loadImage(carpeta2 + "tp-undirboton" + (i+1) + ".png");
    }

    for (int i = 0; i < 4; i++) {
      apuesta_boton[i] = loadImage("apuesta" + (i+1) + ".png");
    }
    cinta = loadImage("cinta.png");
    saldo_img = loadImage("Saldo.jpeg");
    vent_ayuda = loadImage("ayuda.png");
    boton_ayuda = loadImage("ayuda_boton.png");
  }


  void setup () {
    saldoJugador = Integer.parseInt(usuario.getsal());
  }

  void draw () {
    boton = loadImage("volverG.png");
    exit = new Boton(cp5, 40, 40, 40, 40, boton);

    exit.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        mouseX = 630;
        mouseY = 1280;
        pantalla = "";
        arc.actualizarDatos(String.valueOf(saldoJugador), usuario.usuario);
        usuario.asignarSaldo(String.valueOf(saldoJugador));
        PestañaContenido2 p3 = new PestañaContenido2(cp5);
        pestañaActual.cambiarPestaña(p3);
      }
    }
    );
  
    int cont_tiempo = (millis()/ani_vel)%6;

    if (ani_activada) {
      mostrarAnimacion(cont_tiempo);
    } else {

      if (ayuda) {
        imageMode(CORNER);

        image(vent_ayuda, 0, 0, 1280, 640);
      } else {

        for (int i = 0; i < resultados.length; i++)
          resultados[i].dibujarCinta();

        mostrarFondo(cont_tiempo);

        if (boton_presionado)
          activarAnimacionBoton(cont_tiempo);

        decidirVictoria();
    if (!tragaJugando) {
      exit.dibujarI();
      if (exit.estaPresionado()) {
      exit.ejecutarAccion();
      exit.removeBoton();
    }
    }
    
        fill(255);
        imageMode(CORNER);
        image(apuesta_boton[0], 1050, 250, 80, 80);
        imageMode(CORNER);
        image(apuesta_boton[1], 1150, 250, 80, 80);
        imageMode(CORNER);
        image(apuesta_boton[2], 1050, 350, 80, 80);
        imageMode(CORNER);
        image(apuesta_boton[3], 1150, 350, 80, 80);

        fill(0);
        textSize(20);
        text(apuestaTGM, 1150, 170);
        text(premioTGM, 135, 170);

        image(saldo_img, 0, 560);
        fill(0);
        textSize(28);
        text(saldoJugador, 160, 620);

        if (millis() < inc_ad + dur_ad) {
          fill(#ED0E0E);
          textSize(20);
          text(advertencia, 200, 50);
        }
        imageMode(CORNER);
        if (!jugando) {
          image(boton_ayuda, 1200, 0, 80, 80);
        }
      }
    }
    

  }

  private void decidirVictoria () {
    if (!finResultados() || !jugando)
      return;

    int[] res = new int[resultados.length];
    println();
    for (int i = 0; i < resultados.length; i++) {
      res[i] = resultados[i].resultado();
      println(res[i]);
    }

    premioTGM = apuestaTGM * premio(res);
    saldoJugador += premioTGM;
    jugando = false;
    apuestaTGM = 0;
    tragaJugando = false;
  }

  private int premio (int[] res) {
    //Si son el símbolo del casino
    if (res[0] == 1 && res[1] == 1 && res[2] == 1)
      return 5;

    //Si las casillas son iguales
    if (res[0] == res[1] && res[1] == res[2])
      return 3;

    //Si hay dos iguales seguidas
    if (res[0] == res[1] || res[1] == res[2])
      return 2;

    //Si hay dos iguales no seguidas
    if (res[0] == res[2])
      return 1;

    return 0;
  }

  private boolean finResultados () {
    for (CintaTragaMonedas cinta : resultados) {
      if (!cinta.finMovimiento())
        return false;
    }
    return true;
  }

  private void activarAnimacionBoton (int imagen) {
    boton_presionado = false;
    ani_activada = true;
    desv = 6 - imagen;
    tragaJugando = true;
    jugando = true;
    saldoJugador -= apuestaTGM;

    for (int i = 0; i < resultados.length; i++)
      resultados[i].activarMovimiento();

    print("-> Activada animacion de presionar boton");
  }

  private void mostrarFondo (int imagen) {
    int sec = (imagen + desv)%ani_fondo.length;
    imageMode(CORNER);
    image(ani_fondo[sec], 0, 0);
  }

  private void mostrarAnimacion (int imagen) {
    int sec = (imagen + desv)%ani_fondo.length;

    if (sec == ani_fondo.length - 1) {    //Finalizar Animación
      ani_activada = false;
    }
    imageMode(CORNER);
    image(ani_boton[sec], 0, 0);
  }

  private void setApuesta (int apuesta) {
    if (saldoJugador < apuesta) {
      advertencia = "No tienes saldo suficiente para esta apuesta";
      inc_ad = millis();
      return;
    }

    premioTGM = 0;
    apuestaTGM = apuesta;
  }


  void mousePressed () {
    if (!ayuda && !jugando && mouseX > 560 && mouseX < 720 && mouseY > 400 && mouseY < 520 && pantalla.equals("Traga")) {
      if (apuestaTGM > 0) {
        boton_presionado = true;
        print("Presionado el botón de Jugar");
      } else {
        advertencia = "Escoge una apuesta antes de empezar a jugar";
        inc_ad = millis();
      }
    }

    if (mouseX > 1200 && mouseX < 1280 && mouseY > 0 && mouseY < 80 && pantalla.equals("Traga") && !ayudaPres && !jugando) {
      Timer timer = new Timer();
      timer.schedule(new TimerTask() {
        @Override
          public void run() {
          ayudaPres = !ayudaPres;
        }
      }
      , 250);


      ayuda = !ayuda;
      ayudaPres = !ayudaPres;
    }

    if (!ayuda && !jugando && mouseX > 1050 && mouseX < 1150 && mouseY > 250 && mouseY < 350 && pantalla.equals("Traga")) {
      println("Apostando 500");
      setApuesta(500);
    } else if (!ayuda && !jugando && mouseX > 1150 && mouseX < 1250 && mouseY > 250 && mouseY < 350 && pantalla.equals("Traga")) {
      println("Apostando 1000");
      setApuesta(1000);
    } else if (!ayuda && !jugando && mouseX > 1050 && mouseX < 1150 && mouseY > 350 && mouseY < 450 && pantalla.equals("Traga")) {
      println("Apostando 1500");
      setApuesta(1500);
    } else if (!ayuda && !jugando && mouseX > 1150 && mouseX < 1250 && mouseY > 350 && mouseY < 450 && pantalla.equals("Traga")) {
      println("Apostando 2000");
      setApuesta(2000);
    }
  }
}
