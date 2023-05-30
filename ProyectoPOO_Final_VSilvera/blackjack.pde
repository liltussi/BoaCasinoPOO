import java.util.Random;
import java.util.ArrayList;
PFont fuentePeq;
PImage carta1, carta2, carta3, carta4, carta5, carta6, carta7, carta8, carta9, carta10, carta11, mesaBJ, fichaApostadaBJ, ganadorImageBJ;
public boolean primeraPBJ, jugadorPasada, casaPasada, voltearCartaCrupier, rondaTerminadaBJ, mouseEnabled, comenzoRonda, juegeC;
public ArrayList<String> cartasSalidasJugador = new ArrayList<String>();
public ArrayList<String> cartasSalidasCasa = new ArrayList<String>();
public int stop, puntajeJugador, puntajeCasa ;
public int numAcesJ, numAcesC ;
public int apuestaBJ, preapuestaBJ;
String ganadorBJ = "";
class PestañaBlackJJack implements Pestaña {
  Boton exit;

  admArchivos arc;
  void setup() {
    arc = new admArchivos();
    miFuente = createFont("Oruguitas.otf", 36);
    textFont(miFuente);
    apuestaBJ = 0;
    preapuestaBJ = 0;
    comenzoRonda = false;
    jugadorPasada = false;
    casaPasada = false;
    voltearCartaCrupier = false;
    rondaTerminadaBJ = false;
    mouseEnabled = true;
    juegeC = true;
    puntajeJugador = 0;
    puntajeCasa = 0;
    pantalla = "BlackJack";
    boton = loadImage("volverG.png");
    mesaBJ = loadImage("mesablack.png");
    stop = 0;
    primeraPBJ = true;
    exit = new Boton(cp5, 80, 410, 40, 40, boton);

    exit.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        mouseX = 630;
        mouseY = 1280;
        pantalla = "";
        resetBJ();
        arc.actualizarDatos(String.valueOf(saldoJugador), usuario.usuario);
        usuario.asignarSaldo(String.valueOf(saldoJugador));
        PestañaContenido2 p3 = new PestañaContenido2(cp5);
        pestañaActual.cambiarPestaña(p3);
      }
    }
    );
  }

  void draw() {
    
    image(mesaBJ, 640, 320);
    fill(#000000);
    stroke(0);
    text(saldoJugador, 140, 100);
    textSize(28);

    text(puntajeJugador, 200, 600);
    // Mostrar cartas para jugador
    if (cartasSalidasJugador.size() >= 1) {
      carta1 = loadImage("cartas/" + cartasSalidasJugador.get(0) + ".png");
      image(carta1, 330, 520);
    }
    if (cartasSalidasJugador.size() >= 2) {
      carta2 = loadImage("cartas/" + cartasSalidasJugador.get(1) + ".png");
      image(carta2, 430, 520);
    }
    if (cartasSalidasJugador.size() >= 3) {
      carta3 = loadImage("cartas/" + cartasSalidasJugador.get(2) + ".png");

      image(carta3, 530, 520);
    }
    if (cartasSalidasJugador.size() >= 4) {
      carta4 = loadImage("cartas/" + cartasSalidasJugador.get(3) + ".png");

      image(carta4, 630, 520);
    }
    if (cartasSalidasJugador.size() >= 5) {
      carta5 = loadImage("cartas/" + cartasSalidasJugador.get(4) + ".png");

      image(carta5, 730, 520);
    }
    if (cartasSalidasJugador.size() >= 6) {
      carta6 = loadImage("cartas/" + cartasSalidasJugador.get(5) + ".png");

      image(carta6, 830, 520);
    }
    if (cartasSalidasJugador.size() >= 7) {
      carta7 = loadImage("cartas/" + cartasSalidasJugador.get(6) + ".png");

      image(carta7, 930, 520);
    }

    // Mostrar cartas para casa
    if (cartasSalidasCasa.size() >= 1) {
      carta8 = loadImage("cartas/" + cartasSalidasCasa.get(0) + ".png");
      image(carta8, 330, 290);
    }

    if (cartasSalidasCasa.size() >= 2) {
      if (voltearCartaCrupier && !jugadorPasada) {
        carta9 = loadImage("cartas/" + cartasSalidasCasa.get(1) + ".png");
        text(puntajeCasa, 200, 250);
      } else {
        textSize(32);
        carta9 = loadImage("cartas/REVES.png");
        text("?", 200, 250);
      }


      image(carta9, 430, 290);
    }

    if (cartasSalidasCasa.size() >= 3) {
      carta10 = loadImage("cartas/" + cartasSalidasCasa.get(2) + ".png");

      image(carta10, 530, 290);
    }

    if (cartasSalidasCasa.size() >= 4) {
      carta11 = loadImage("cartas/" + cartasSalidasCasa.get(3) + ".png");

      image(carta11, 630, 290);
    }



    if (apuestaBJ == 500) {
      fichaApostadaBJ = loadImage("fichas/rojaficha.png");
      image(fichaApostadaBJ, 1156, 162);
    } else if (apuestaBJ == 1000) {
      fichaApostadaBJ = loadImage("fichas/azulficha.png");
      image(fichaApostadaBJ, 1156, 162);
    } else if (apuestaBJ == 2000) {
      fichaApostadaBJ = loadImage("fichas/verdeficha.png");
      image(fichaApostadaBJ, 1156, 162);
    } else if (apuestaBJ == 5000) {
      fichaApostadaBJ = loadImage("fichas/moradaficha.png");
      image(fichaApostadaBJ, 1156, 162);
    }

    if (ganadorBJ.equals("Crupier")) {
      ganadorImageBJ = loadImage("SLmesablack2.png");
      image(ganadorImageBJ, 640, 10);
    } else if (ganadorBJ.equals("Jugador")) {
      ganadorImageBJ = loadImage("SLmesablack1.png");
      image(ganadorImageBJ, 640, 10);
    } else if (ganadorBJ.equals("Empate")) {
      ganadorImageBJ = loadImage("SLmesablack3.png");
      image(ganadorImageBJ, 640, 10);
    }
      exit.dibujarI();
      if (exit.estaPresionado()) {
        exit.ejecutarAccion();
        exit.removeBoton();
      }
  }

}

public void generar_carta_aleatoria(String para) {
  Random random = new Random();
  String[] letras = {"C", "D", "P", "T"};
  String[] numeros = {"2", "3", "4", "5", "6", "7", "8", "9", "10"};
  String[] letrasEspeciales = {"A", "J", "Q", "K"};

  String letra = letras[random.nextInt(letras.length)];

  String numero;

  if (random.nextBoolean()) {
    numero = numeros[random.nextInt(numeros.length)];
  } else {
    numero = letrasEspeciales[random.nextInt(letrasEspeciales.length)];
  }

  String carta = letra + numero;

  // Verificar si la carta ya ha salido, generar una nueva si es el caso
  if (cartasSalidasJugador.contains(carta) || cartasSalidasCasa.contains(carta)) {
    if (para.equals("jugador") && stop == 0) {
      generar_carta_aleatoria("jugador");
    } else if (para.equals("casa") || stop == 1 ) {
      generar_carta_aleatoria("casa");
    }
  }

  if (para.equals("jugador") && stop == 0 && !mouseEnabled) {
    cartasSalidasJugador.add(carta);
    agregar_puntaje(carta, "jugador");
  } else if (para.equals("casa") &&  juegeC) {
    cartasSalidasCasa.add(carta);
    agregar_puntaje(carta, "casa");
  }
}

public void agregar_puntaje(String cartaEnMano, String para) {
  for (Carta carta : cartasBJ) {
    if (carta.getCodigo().equals(cartaEnMano)) {
      if (para.equals("jugador")) {
        if (carta.getValor() == 11) {
          numAcesJ++;
        }
        puntajeJugador += carta.getValor();
        if (cartasSalidasJugador.size() == 2 && puntajeJugador == 21 ) {
          timer = new Timer();
          timer.schedule(new TimerTask() {
            @Override
              public void run() {
              ganadorBJ();
            }
          }
          , 1500);
        }
      } else if (para.equals("casa")) {
        puntajeCasa += carta.getValor();
        if (carta.getValor() == 11) {
          numAcesC++;
        }
      }
    }
  }

  if (puntajeJugador > 21 && numAcesJ > 0) {
    puntajeJugador -= 10;
    numAcesJ--;
  } else if (puntajeJugador > 21 && numAcesJ == 0) {
    jugadorPasada = true;
    stop = 1;
    timer = new Timer();
    timer.schedule(new TimerTask() {
      @Override
        public void run() {
        ganadorBJ();
      }
    }
    , 1500);
  }else if(puntajeJugador == 21 && numAcesJ == 0){
    stop = 1;
    juege_crupier();
  }

  if (puntajeCasa > 21 && numAcesC > 0) {
    puntajeCasa -= 10;
    numAcesC--;
  } else if (puntajeCasa > 21 && numAcesC == 0) {
    casaPasada = true;
  }


  Timer timer = new Timer();
  timer.schedule(new TimerTask() {
    @Override
      public void run() {
      mouseEnabled = true;
    }
  }
  , 2000);
}

public void juege_crupier() {
  juegeC = true;
  voltearCartaCrupier = true;
  if (cartasSalidasCasa.size() == 4 || puntajeCasa >= puntajeJugador) {
    timer = new Timer();
    timer.schedule(new TimerTask() {
      @Override
        public void run() {
        ganadorBJ();
      }
    }
    , 1500);
  } else {
    timer = new Timer();
    timer.schedule(new TimerTask() {
      @Override
        public void run() {
        generar_carta_aleatoria("casa");
        juege_crupier();
      }
    }
    , 500);
  }
}



public void ganadorBJ() {
  rondaTerminadaBJ = true;
  if (jugadorPasada) {
    ganadorBJ = "Crupier";
  } else if (casaPasada) {
    ganadorBJ = "Jugador";
    saldoJugador += apuestaBJ * 2;
  } else if (puntajeCasa == puntajeJugador) {
    ganadorBJ = "Empate";
    saldoJugador += apuestaBJ ;
  } else if (!jugadorPasada && !casaPasada) {
    if (cartasSalidasJugador.size() == 2 && puntajeJugador == 21) {

      ganadorBJ = "Jugador";
      saldoJugador += apuestaBJ * 3;
      timer = new Timer();
      timer.schedule(new TimerTask() {
        @Override
          public void run() {
          ganadorBJ();
        }
      }
      , 1500);
    } else if (puntajeCasa > puntajeJugador) {
      ganadorBJ = "Crupier";
    } else {
      ganadorBJ = "Jugador";
      saldoJugador += apuestaBJ * 2;
    }
  }

  timer = new Timer();
  timer.schedule(new TimerTask() {
    @Override
      public void run() {
      resetBJ();
    }
  }
  , 3000);
}





public void resetBJ() {
  cartasSalidasCasa.clear();
  cartasSalidasJugador.clear();
  stop = 0;
  numAcesC = 0;
  numAcesJ = 0;
  voltearCartaCrupier = false;
  puntajeJugador = 0;
  puntajeCasa = 0;
  jugadorPasada = false;
  casaPasada = false;
  primeraPBJ = true;
  apuestaBJ = 0;
  rondaTerminadaBJ = false;
  mouseEnabled = true;
  preapuestaBJ = 0;
  ganadorBJ = "";
  comenzoRonda = false;
  juegeC = true;
}
