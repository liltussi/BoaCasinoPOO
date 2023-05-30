import java.util.Timer;
import java.util.TimerTask;
import java.util.ArrayList;
PImage fondoRuleta, fichaNegra, fichaNegrab, fichaAzul, fichaVerde, fichaMorada, fichaRoja, botonApostar1, botonApostar2, saldoImagen;
PImage rojo32, azul32, verde32, morado32;
PFont miFuente;
int spr = 1;
int tamApuestas, comprabarApuesta, rondaJuego = 0;
boolean mostrarImagen = false;
boolean finalRulete = false;
boolean mouseEncima = false;
boolean mouseDesahacer = false;

public boolean ishandland = true;

PImage ruleta;
Timer timer;


public static int ultimaCasilla = 2350;
public static ArrayList<Integer> orden_casillas_apostadas = new ArrayList<Integer>();
public static ArrayList<int[]> individuales = new ArrayList<int[]>();
public static ArrayList<int[]> apuestas = new ArrayList<int[]>();
public int valorFicha = 0;

Bola bola = new Bola();
public String pantalla = "";

class PestañaRuleta implements Pestaña {
  Boton exit;
  admArchivos arc;
  void setup() {
    arc = new admArchivos();
    pantalla = "mesa";
    spr = 1;
    mostrarImagen = false;
    finalRulete = false;
    mouseEncima = false;
    mouseDesahacer = false;
    //size(1280, 640);
    cursor(HAND);
    fondoRuleta = loadImage("mesadeapuesta.png");
    fichaRoja = loadImage("fichas/rojaficha.png");
    fichaAzul = loadImage("fichas/azulficha.png");
    fichaVerde = loadImage("fichas/verdeficha.png");
    fichaMorada = loadImage("fichas/moradaficha.png");
    fichaNegra = loadImage("fichas/negroficha.png");
    fichaNegrab = loadImage("fichas/negrofichab.png");
    rojo32 = loadImage("fichas/roja32.png");
    azul32 = loadImage("fichas/azul32.png");
    verde32 = loadImage("fichas/verde32.png");
    morado32 = loadImage("fichas/morado32.png");
    botonApostar1 = loadImage("botonrul1.png");
    botonApostar2 = loadImage("botonrul2.png");
    saldoImagen = loadImage("saldo.png");
    miFuente = createFont("Oruguitas.otf", 36);
    textFont(miFuente);
  }

  void draw() {
    boton = loadImage("volverG.png");
    exit = new Boton(cp5, 40, 600, 40, 40, boton);
    
    exit.enlazarAccion(new Runnable() {
      @Override
        public void run() {
        pantalla = "";
        orden_casillas_apostadas.add(1); 
        int [] previas = {1,200};
        individuales.add(previas);
        apuestas.add(previas);
        
        for(int teo = 0; teo <= apuestas.size(); teo++){
          borrarUltimaApuesta();
        }
        mouseX = 630;
        mouseY = 1280;
        resetTablero(0, apuestas.size());
        arc.actualizarDatos(String.valueOf(saldoJugador), usuario.usuario);  
        usuario.asignarSaldo(String.valueOf(saldoJugador));
        PestañaContenido2 p3 = new PestañaContenido2(cp5);
        pestañaActual.cambiarPestaña(p3);
      }
    }
    );
    switch(pantalla) {
      // Mostrar en pantalla mesa de apuestas
    case "mesa":
      timer = null;
      frameRate(60);
      imageMode(CORNER);
      image(fondoRuleta, 0, 0);
      image(fichaRoja, 183, 13);
      image(fichaAzul, 383, 13);
      image(fichaVerde, 583, 13);
      image(fichaMorada, 783, 13);
      image(saldoImagen, 923, 20);
      fill(#000000);
      stroke(0);
      text(saldoJugador, 1080, 78);
      exit.dibujarI();
      if (exit.estaPresionado()) {
        exit.ejecutarAccion();
        exit.removeBoton();
      }
      // Si el jugador esta encima se cambia de imagen, estas imagenes solo aparecen si hay minimo una apuesta

      // Boton de apostar
      imageMode(CORNER);
      if (mouseEncima && !apuestas.isEmpty()) {
        image(botonApostar1, 1093, 517);
      } else if (!mouseEncima && !apuestas.isEmpty()) {
        image(botonApostar2, 1093, 517);
      }


      // ficha Desahacer/ negra
      if (mouseDesahacer && !apuestas.isEmpty()) {
        image(fichaNegrab, 12, 3);
      } else if (!mouseDesahacer && !apuestas.isEmpty()) {
        image(fichaNegra, 8, 13);
      }


      // Colocar la ficha que el jugador aposto en la casilla numerica correspondiente

      // 0

      // Aplica para todos, isFichaRoja/Azul/Verde/Morada devuelve un booleano es el get de esos atributos, si es True se "dibuja"
      // la imagen de la ficha correspiente sobre la casilla correspondiente
      imageMode(CORNER);
      if (casillasRuleta[0].isFichaRoja()) {
        image(rojo32, 85, 227);
      }

      if (casillasRuleta[0].isFichaAzul()) {
        image(azul32, 85, 287);
      }

      if (casillasRuleta[0].isFichaVerde()) {
        image(verde32, 85, 337);
      }

      if (casillasRuleta[0].isFichaMorada()) {
        image(morado32, 85, 387);
      }


      // 1

      if (casillasRuleta[1].isFichaRoja()) {
        image(rojo32, 125, 385);
      }

      if (casillasRuleta[1].isFichaAzul()) {
        image(azul32, 160, 385);
      }

      if (casillasRuleta[1].isFichaVerde()) {
        image(verde32, 125, 475);
      }

      if (casillasRuleta[1].isFichaMorada()) {
        image(morado32, 160, 475);
      }

      // 2

      if (casillasRuleta[2].isFichaRoja()) {
        image(rojo32, 125, 265);
      }

      if (casillasRuleta[2].isFichaAzul()) {
        image(azul32, 160, 265);
      }

      if (casillasRuleta[2].isFichaVerde()) {
        image(verde32, 125, 345);
      }

      if (casillasRuleta[2].isFichaMorada()) {
        image(morado32, 160, 345);
      }

      // 3
      if (casillasRuleta[3].isFichaRoja()) {
        image(rojo32, 125, 130);
      }

      if (casillasRuleta[3].isFichaAzul()) {
        image(azul32, 160, 130);
      }

      if (casillasRuleta[3].isFichaVerde()) {
        image(verde32, 125, 225);
      }

      if (casillasRuleta[3].isFichaMorada()) {
        image(morado32, 160, 225);
      }

      // 4

      if (casillasRuleta[4].isFichaRoja()) {
        image(rojo32, 205, 385);
      }

      if (casillasRuleta[4].isFichaAzul()) {
        image(azul32, 240, 385);
      }

      if (casillasRuleta[4].isFichaVerde()) {
        image(verde32, 205, 475);
      }

      if (casillasRuleta[4].isFichaMorada()) {
        image(morado32, 240, 475);
      }

      // 5

      if (casillasRuleta[5].isFichaRoja()) {
        image(rojo32, 205, 265);
      }

      if (casillasRuleta[5].isFichaAzul()) {
        image(azul32, 240, 265);
      }

      if (casillasRuleta[5].isFichaVerde()) {
        image(verde32, 205, 345);
      }

      if (casillasRuleta[5].isFichaMorada()) {
        image(morado32, 240, 345);
      }

      // 6

      if (casillasRuleta[6].isFichaRoja()) {
        image(rojo32, 205, 130);
      }

      if (casillasRuleta[6].isFichaAzul()) {
        image(azul32, 240, 130);
      }

      if (casillasRuleta[6].isFichaVerde()) {
        image(verde32, 205, 225);
      }

      if (casillasRuleta[6].isFichaMorada()) {
        image(morado32, 240, 225);
      }

      // 7
      if (casillasRuleta[7].isFichaRoja()) {
        image(rojo32, 285, 385);
      }

      if (casillasRuleta[7].isFichaAzul()) {
        image(azul32, 320, 385);
      }

      if (casillasRuleta[7].isFichaVerde()) {
        image(verde32, 285, 475);
      }

      if (casillasRuleta[7].isFichaMorada()) {
        image(morado32, 320, 475);
      }

      // 8
      if (casillasRuleta[8].isFichaRoja()) {
        image(rojo32, 285, 265);
      }

      if (casillasRuleta[8].isFichaAzul()) {
        image(azul32, 320, 265);
      }

      if (casillasRuleta[8].isFichaVerde()) {
        image(verde32, 285, 345);
      }

      if (casillasRuleta[8].isFichaMorada()) {
        image(morado32, 320, 345);
      }

      // 9
      if (casillasRuleta[9].isFichaRoja()) {
        image(rojo32, 285, 130);
      }

      if (casillasRuleta[9].isFichaAzul()) {
        image(azul32, 320, 130);
      }

      if (casillasRuleta[9].isFichaVerde()) {
        image(verde32, 285, 225);
      }

      if (casillasRuleta[9].isFichaMorada()) {
        image(morado32, 320, 225);
      }

      // 10
      if (casillasRuleta[10].isFichaRoja()) {
        image(rojo32, 365, 385);
      }

      if (casillasRuleta[10].isFichaAzul()) {
        image(azul32, 400, 385);
      }

      if (casillasRuleta[10].isFichaVerde()) {
        image(verde32, 365, 475);
      }

      if (casillasRuleta[10].isFichaMorada()) {
        image(morado32, 400, 475);
      }

      // 11
      if (casillasRuleta[11].isFichaRoja()) {
        image(rojo32, 365, 265);
      }

      if (casillasRuleta[11].isFichaAzul()) {
        image(azul32, 400, 265);
      }

      if (casillasRuleta[11].isFichaVerde()) {
        image(verde32, 365, 345);
      }

      if (casillasRuleta[11].isFichaMorada()) {
        image(morado32, 400, 345);
      }

      // 12
      if (casillasRuleta[12].isFichaRoja()) {
        image(rojo32, 365, 130);
      }

      if (casillasRuleta[12].isFichaAzul()) {
        image(azul32, 400, 130);
      }

      if (casillasRuleta[12].isFichaVerde()) {
        image(verde32, 365, 225);
      }

      if (casillasRuleta[12].isFichaMorada()) {
        image(morado32, 400, 225);
      }

      // 13
      if (casillasRuleta[13].isFichaRoja()) {
        image(rojo32, 450, 385);
      }

      if (casillasRuleta[13].isFichaAzul()) {
        image(azul32, 485, 385);
      }

      if (casillasRuleta[13].isFichaVerde()) {
        image(verde32, 450, 475);
      }

      if (casillasRuleta[13].isFichaMorada()) {
        image(morado32, 485, 475);
      }

      // 14
      if (casillasRuleta[14].isFichaRoja()) {
        image(rojo32, 450, 265);
      }

      if (casillasRuleta[14].isFichaAzul()) {
        image(azul32, 485, 265);
      }

      if (casillasRuleta[14].isFichaVerde()) {
        image(verde32, 450, 345);
      }

      if (casillasRuleta[14].isFichaMorada()) {
        image(morado32, 485, 345);
      }

      // 15
      if (casillasRuleta[15].isFichaRoja()) {
        image(rojo32, 450, 130);
      }

      if (casillasRuleta[15].isFichaAzul()) {
        image(azul32, 485, 130);
      }

      if (casillasRuleta[15].isFichaVerde()) {
        image(verde32, 450, 225);
      }

      if (casillasRuleta[15].isFichaMorada()) {
        image(morado32, 485, 225);
      }

      // 16
      if (casillasRuleta[16].isFichaRoja()) {
        image(rojo32, 530, 385);
      }

      if (casillasRuleta[16].isFichaAzul()) {
        image(azul32, 565, 385);
      }

      if (casillasRuleta[16].isFichaVerde()) {
        image(verde32, 530, 475);
      }

      if (casillasRuleta[16].isFichaMorada()) {
        image(morado32, 565, 475);
      }

      // 17
      if (casillasRuleta[17].isFichaRoja()) {
        image(rojo32, 530, 265);
      }

      if (casillasRuleta[17].isFichaAzul()) {
        image(azul32, 565, 265);
      }

      if (casillasRuleta[17].isFichaVerde()) {
        image(verde32, 530, 345);
      }

      if (casillasRuleta[17].isFichaMorada()) {
        image(morado32, 565, 345);
      }

      // 18
      if (casillasRuleta[18].isFichaRoja()) {
        image(rojo32, 530, 130);
      }

      if (casillasRuleta[18].isFichaAzul()) {
        image(azul32, 565, 130);
      }

      if (casillasRuleta[18].isFichaVerde()) {
        image(verde32, 525, 225);
      }

      if (casillasRuleta[18].isFichaMorada()) {
        image(morado32, 565, 225);
      }

      // 19
      if (casillasRuleta[19].isFichaRoja()) {
        image(rojo32, 610, 385);
      }

      if (casillasRuleta[19].isFichaAzul()) {
        image(azul32, 645, 385);
      }

      if (casillasRuleta[19].isFichaVerde()) {
        image(verde32, 610, 475);
      }

      if (casillasRuleta[19].isFichaMorada()) {
        image(morado32, 645, 475);
      }

      // 20
      if (casillasRuleta[20].isFichaRoja()) {
        image(rojo32, 610, 265);
      }

      if (casillasRuleta[20].isFichaAzul()) {
        image(azul32, 645, 265);
      }

      if (casillasRuleta[20].isFichaVerde()) {
        image(verde32, 610, 345);
      }

      if (casillasRuleta[20].isFichaMorada()) {
        image(morado32, 645, 345);
      }

      // 21
      if (casillasRuleta[21].isFichaRoja()) {
        image(rojo32, 610, 130);
      }

      if (casillasRuleta[21].isFichaAzul()) {
        image(azul32, 645, 130);
      }

      if (casillasRuleta[21].isFichaVerde()) {
        image(verde32, 615, 225);
      }

      if (casillasRuleta[21].isFichaMorada()) {
        image(morado32, 645, 225);
      }

      // 22
      if (casillasRuleta[22].isFichaRoja()) {
        image(rojo32, 690, 385);
      }

      if (casillasRuleta[22].isFichaAzul()) {
        image(azul32, 725, 385);
      }

      if (casillasRuleta[22].isFichaVerde()) {
        image(verde32, 690, 475);
      }

      if (casillasRuleta[22].isFichaMorada()) {
        image(morado32, 725, 475);
      }

      // 23
      if (casillasRuleta[23].isFichaRoja()) {
        image(rojo32, 690, 265);
      }

      if (casillasRuleta[23].isFichaAzul()) {
        image(azul32, 725, 265);
      }

      if (casillasRuleta[23].isFichaVerde()) {
        image(verde32, 690, 345);
      }

      if (casillasRuleta[23].isFichaMorada()) {
        image(morado32, 725, 345);
      }

      // 24
      if (casillasRuleta[24].isFichaRoja()) {
        image(rojo32, 690, 130);
      }

      if (casillasRuleta[24].isFichaAzul()) {
        image(azul32, 725, 130);
      }

      if (casillasRuleta[24].isFichaVerde()) {
        image(verde32, 690, 225);
      }

      if (casillasRuleta[24].isFichaMorada()) {
        image(morado32, 725, 225);
      }

      // 25
      if (casillasRuleta[25].isFichaRoja()) {
        image(rojo32, 770, 385);
      }

      if (casillasRuleta[25].isFichaAzul()) {
        image(azul32, 805, 385);
      }

      if (casillasRuleta[25].isFichaVerde()) {
        image(verde32, 770, 475);
      }

      if (casillasRuleta[25].isFichaMorada()) {
        image(morado32, 805, 475);
      }

      // 26
      if (casillasRuleta[26].isFichaRoja()) {
        image(rojo32, 770, 265);
      }

      if (casillasRuleta[26].isFichaAzul()) {
        image(azul32, 805, 265);
      }

      if (casillasRuleta[26].isFichaVerde()) {
        image(verde32, 770, 345);
      }

      if (casillasRuleta[26].isFichaMorada()) {
        image(morado32, 805, 345);
      }

      // 27
      if (casillasRuleta[27].isFichaRoja()) {
        image(rojo32, 770, 130);
      }

      if (casillasRuleta[27].isFichaAzul()) {
        image(azul32, 805, 130);
      }

      if (casillasRuleta[27].isFichaVerde()) {
        image(verde32, 770, 225);
      }

      if (casillasRuleta[27].isFichaMorada()) {
        image(morado32, 805, 225);
      }

      // 28
      if (casillasRuleta[28].isFichaRoja()) {
        image(rojo32, 855, 385);
      }

      if (casillasRuleta[28].isFichaAzul()) {
        image(azul32, 890, 385);
      }

      if (casillasRuleta[28].isFichaVerde()) {
        image(verde32, 855, 475);
      }

      if (casillasRuleta[28].isFichaMorada()) {
        image(morado32, 890, 475);
      }

      // 29
      if (casillasRuleta[29].isFichaRoja()) {
        image(rojo32, 855, 265);
      }

      if (casillasRuleta[29].isFichaAzul()) {
        image(azul32, 890, 265);
      }

      if (casillasRuleta[29].isFichaVerde()) {
        image(verde32, 855, 345);
      }

      if (casillasRuleta[29].isFichaMorada()) {
        image(morado32, 890, 345);
      }

      // 30
      if (casillasRuleta[30].isFichaRoja()) {
        image(rojo32, 855, 130);
      }

      if (casillasRuleta[30].isFichaAzul()) {
        image(azul32, 890, 130);
      }

      if (casillasRuleta[30].isFichaVerde()) {
        image(verde32, 855, 225);
      }

      if (casillasRuleta[30].isFichaMorada()) {
        image(morado32, 890, 225);
      }

      // 31
      if (casillasRuleta[31].isFichaRoja()) {
        image(rojo32, 935, 385);
      }

      if (casillasRuleta[31].isFichaAzul()) {
        image(azul32, 970, 385);
      }

      if (casillasRuleta[31].isFichaVerde()) {
        image(verde32, 935, 475);
      }

      if (casillasRuleta[31].isFichaMorada()) {
        image(morado32, 970, 475);
      }

      // 32
      if (casillasRuleta[32].isFichaRoja()) {
        image(rojo32, 935, 265);
      }

      if (casillasRuleta[32].isFichaAzul()) {
        image(azul32, 970, 265);
      }

      if (casillasRuleta[32].isFichaVerde()) {
        image(verde32, 935, 345);
      }

      if (casillasRuleta[32].isFichaMorada()) {
        image(morado32, 970, 345);
      }

      // 33
      if (casillasRuleta[33].isFichaRoja()) {
        image(rojo32, 935, 130);
      }

      if (casillasRuleta[33].isFichaAzul()) {
        image(azul32, 970, 130);
      }

      if (casillasRuleta[33].isFichaVerde()) {
        image(verde32, 935, 225);
      }

      if (casillasRuleta[33].isFichaMorada()) {
        image(morado32, 970, 225);
      }

      // 34
      if (casillasRuleta[34].isFichaRoja()) {
        image(rojo32, 1015, 385);
      }

      if (casillasRuleta[34].isFichaAzul()) {
        image(azul32, 1050, 385);
      }

      if (casillasRuleta[34].isFichaVerde()) {
        image(verde32, 1015, 475);
      }

      if (casillasRuleta[34].isFichaMorada()) {
        image(morado32, 1050, 475);
      }

      // 35
      if (casillasRuleta[35].isFichaRoja()) {
        image(rojo32, 1015, 265);
      }

      if (casillasRuleta[35].isFichaAzul()) {
        image(azul32, 1050, 265);
      }

      if (casillasRuleta[35].isFichaVerde()) {
        image(verde32, 1015, 345);
      }

      if (casillasRuleta[35].isFichaMorada()) {
        image(morado32, 1050, 345);
      }

      // 36
      if (casillasRuleta[36].isFichaRoja()) {
        image(rojo32, 1015, 130);
      }

      if (casillasRuleta[36].isFichaAzul()) {
        image(azul32, 1050, 130);
      }

      if (casillasRuleta[36].isFichaVerde()) {
        image(verde32, 1015, 225);
      }

      if (casillasRuleta[36].isFichaMorada()) {
        image(morado32, 1050, 225);
      }


      //Colocar la ficha que el jugador aposto en la casilla comodin

      // Par
      if (casillasEspeciales[0].isFichaRoja()) {
        image(rojo32, 275, 567.8);
      }

      if (casillasEspeciales[0].isFichaAzul()) {
        image(azul32, 300, 567.8);
      }

      if (casillasEspeciales[0].isFichaVerde()) {
        image(verde32, 380, 567.8);
      }

      if (casillasEspeciales[0].isFichaMorada()) {
        image(morado32, 402, 567.8);
      }

      // Impar
      if (casillasEspeciales[1].isFichaRoja()) {
        image(rojo32, 765, 567.8);
      }

      if (casillasEspeciales[1].isFichaAzul()) {
        image(azul32, 790, 567.8);
      }

      if (casillasEspeciales[1].isFichaVerde()) {
        image(verde32, 860, 567.8);
      }

      if (casillasEspeciales[1].isFichaMorada()) {
        image(morado32, 882, 567.8);
      }

      // Fila 1
      if (casillasEspeciales[2].isFichaRoja()) {
        image(rojo32, 1095, 385);
      }

      if (casillasEspeciales[2].isFichaAzul()) {
        image(azul32, 1130, 385);
      }

      if (casillasEspeciales[2].isFichaVerde()) {
        image(verde32, 1095, 475);
      }

      if (casillasEspeciales[2].isFichaMorada()) {
        image(morado32, 1130, 475);
      }

      // Fila 2
      if (casillasEspeciales[3].isFichaRoja()) {
        image(rojo32, 1095, 265);
      }

      if (casillasEspeciales[3].isFichaAzul()) {
        image(azul32, 1130, 265);
      }

      if (casillasEspeciales[3].isFichaVerde()) {
        image(verde32, 1095, 345);
      }

      if (casillasEspeciales[3].isFichaMorada()) {
        image(morado32, 1130, 345);
      }

      // Fila 3
      if (casillasEspeciales[4].isFichaRoja()) {
        image(rojo32, 1095, 130);
      }

      if (casillasEspeciales[4].isFichaAzul()) {
        image(azul32, 1130, 130);
      }

      if (casillasEspeciales[4].isFichaVerde()) {
        image(verde32, 1095, 225);
      }

      if (casillasEspeciales[4].isFichaMorada()) {
        image(morado32, 1130, 225);
      }

      // Rojo
      if (casillasEspeciales[5].isFichaRoja()) {
        image(rojo32, 442, 567.8);
      }

      if (casillasEspeciales[5].isFichaAzul()) {
        image(azul32, 465, 567.8);
      }

      if (casillasEspeciales[5].isFichaVerde()) {
        image(verde32, 535, 567.8);
      }

      if (casillasEspeciales[5].isFichaMorada()) {
        image(morado32, 558, 567.8);
      }

      // Negro
      if (casillasEspeciales[6].isFichaRoja()) {
        image(rojo32, 596, 567.8);
      }

      if (casillasEspeciales[6].isFichaAzul()) {
        image(azul32, 625, 567.8);
      }

      if (casillasEspeciales[6].isFichaVerde()) {
        image(verde32, 702, 567.8);
      }

      if (casillasEspeciales[6].isFichaMorada()) {
        image(morado32, 728, 567.8);
      }

      // Primera Docena
      if (casillasEspeciales[7].isFichaRoja()) {
        image(rojo32, 125, 518.6);
      }

      if (casillasEspeciales[7].isFichaAzul()) {
        image(azul32, 222.5, 518.6);
      }

      if (casillasEspeciales[7].isFichaVerde()) {
        image(verde32, 302.5, 518.6);
      }

      if (casillasEspeciales[7].isFichaMorada()) {
        image(morado32, 400, 518.6);
      }

      // Segunda Docena
      if (casillasEspeciales[8].isFichaRoja()) {
        image(rojo32, 443, 518.6);
      }

      if (casillasEspeciales[8].isFichaAzul()) {
        image(azul32, 547.5, 518.6);
      }

      if (casillasEspeciales[8].isFichaVerde()) {
        image(verde32, 627.5, 518.6);
      }

      if (casillasEspeciales[8].isFichaMorada()) {
        image(morado32, 725, 518.6);
      }

      // Tercera Docena
      if (casillasEspeciales[9].isFichaRoja()) {
        image(rojo32, 770, 518.6);
      }

      if (casillasEspeciales[9].isFichaAzul()) {
        image(azul32, 872.5, 518.6);
      }

      if (casillasEspeciales[9].isFichaVerde()) {
        image(verde32, 952.5, 518.6);
      }

      if (casillasEspeciales[9].isFichaMorada()) {
        image(morado32, 1050, 518.6);
      }

      // 1 - 18
      if (casillasEspeciales[10].isFichaRoja()) {
        image(rojo32, 118, 567.8);
      }

      if (casillasEspeciales[10].isFichaAzul()) {
        image(azul32, 134, 567.8);
      }

      if (casillasEspeciales[10].isFichaVerde()) {
        image(verde32, 220, 567.8);
      }

      if (casillasEspeciales[10].isFichaMorada()) {
        image(morado32, 240, 567.8);
      }

      // 19 - 36
      if (casillasEspeciales[11].isFichaRoja()) {
        image(rojo32, 916.3, 567.8);
      }

      if (casillasEspeciales[11].isFichaAzul()) {
        image(azul32, 932.3, 567.8);
      }

      if (casillasEspeciales[11].isFichaVerde()) {
        image(verde32, 1035, 567.8);
      }

      if (casillasEspeciales[11].isFichaMorada()) {
        image(morado32, 1055, 567.8);
      }

      break;

      // Mostrar en pantalla ruleta
    case "ruleta":

      noCursor();
      // Se utuliza un timer para ir cargando las imagenes en el momento que lo necesitamos
      // y asi no sobreexigir el programa al inicio guardandolos en un vector
      if (timer == null) {
        timer = new Timer();
        TimerTask task = new TimerTask() {
          @Override
            public void run() {
            if (spr <= 67) {
              String imageName = "ruletaanimada/Sprite" + spr + "-03.png";
              ruleta = loadImage(imageName);
              spr++;
              mostrarImagen = true;
            } else {
              finalRulete = true;
              timer.cancel();
            }
          }
        };
        timer.scheduleAtFixedRate(task, 0, 105);
      }
      //Mostrar imagen para crear el efecto del "gif"
      if (mostrarImagen) {
        image(ruleta, 0, 0);
        mostrarImagen = false;
      }
      // Cuando ya se llego al final del "gif", se imprime la imagen ganadora
      // Pasados 5 segundos y medio se cambia de pantalla automaticamente
      if (finalRulete) {
        timer = null;

        //El metodo getPosicion de la bola genera un ramdon especial cada vez que se llama por eso se guarda en una variable

        int posicionBola = bola.getPosicion();
        ruleta = loadImage("resultados/"+posicionBola+".png");
        image(ruleta, 0, 0);
        image(saldoImagen, 30, 120);
        finalRulete = false;
        calcular_pago(0, posicionBola, apuestas.size());
        fill(#000000);
        stroke(0);
        text(saldoJugador, 190, 178);
        resetTablero(0, apuestas.size());

        if (timer == null) {
          timer = new Timer();
          TimerTask task = new TimerTask() {
            @Override
              public void run() {
              pantalla = "mesa";
              timer.cancel();
              cursor(HAND);
              spr = 1;
            }
          };
          timer.scheduleAtFixedRate(task, 5500, 1000);
        }
      }
      break;
    }
  }
}
