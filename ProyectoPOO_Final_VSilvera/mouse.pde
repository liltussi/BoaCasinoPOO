
void mouseMoved() {
  
  
  // Para crear la ilusion de boton del apostar y el desahacer que estan entre la linea 64 - 79 en la pestaña ruleta
  if (1093 <= mouseX && mouseX <= 1280 && 517 <= mouseY && mouseY <= 640 && pantalla.equals("mesa")) {
    mouseEncima = true;
  } else {
    mouseEncima = false;
  }

  // Explicacion de verificar_radio en verificaciones
  if (verificar_radio(70, 65, mouseX, mouseY) && pantalla.equals("mesa")) {
    mouseDesahacer = true;
  } else {
    mouseDesahacer = false;
  }
}

void mousePressed() {

  
  cursor(HAND);
  
  // codigo para BlackJack
  //Fichas
  if(25 <= mouseY && mouseY<= 123 && pantalla.equals("BlackJack") ){
    
    // Ficha azul
    if ( 288 <= mouseX && mouseX <= 382 && verificar_radio(334, 73, mouseX, mouseY) && saldoJugador >= 1000 && !comenzoRonda) {
      apuestaBJ = 1000;
      saldoJugador += preapuestaBJ - apuestaBJ;
      preapuestaBJ = 1000;
    }

    // Ficha morada
    if (468 <= mouseX && mouseX <= 563 && verificar_radio(517, 73, mouseX, mouseY) && saldoJugador >= 5000 && !comenzoRonda) {
      apuestaBJ = 5000;
      saldoJugador += preapuestaBJ - apuestaBJ;
      preapuestaBJ = 5000;      
    }

    // Ficha verde
    if (648 <= mouseX && mouseX <= 743 && verificar_radio(695, 73, mouseX, mouseY) && saldoJugador >= 2000 && !comenzoRonda) {
      apuestaBJ = 2000;
      saldoJugador += preapuestaBJ - apuestaBJ;
      preapuestaBJ = 2000;
    }

    // Ficha roja
    if (825 <= mouseX && mouseX <= 921 && verificar_radio(870, 73, mouseX, mouseY) && saldoJugador >= 1000 && !comenzoRonda) {
      apuestaBJ = 500;
      saldoJugador += preapuestaBJ - apuestaBJ;
      preapuestaBJ = 500;
    } 
  }
  
  
  //Pedir 
  if(1094 <= mouseX && mouseX <= 1254 && 383 <= mouseY && mouseY <= 610 && pantalla.equals("BlackJack") && !rondaTerminadaBJ && mouseEnabled && apuestaBJ > 0){
    comenzoRonda = true;
    mouseEnabled = false;
    if(primeraPBJ){
    
      TimerTask task = new TimerTask() {
        public void run() {
          generar_carta_aleatoria("casa");
         
          TimerTask task2 = new TimerTask() {
            public void run() {
              generar_carta_aleatoria("jugador");
             
              TimerTask task3 = new TimerTask() {
                public void run() {
                  generar_carta_aleatoria("casa");
                  juegeC = false;
                }
              };
              Timer timer3 = new Timer();
              timer3.schedule(task3, 350); // Retraso de 0.3 segundos para la segunda llamada a generar_carta_aleatoria("casa")
            }
          };
          Timer timer2 = new Timer();
          timer2.schedule(task2, 350); // Retraso de 0.3 segundos para la segunda llamada a generar_carta_aleatoria("casa")
        }
      };
      
      Timer timer = new Timer();
      timer.schedule(task, 350); // Retraso de 0.3 segundos para la primera llamada a generar_carta_aleatoria("casa")
      primeraPBJ = false;
    }
    
    generar_carta_aleatoria("jugador");
    mouseX = 640;
    mouseY = 320;
    
  }
  
  
  //Plantarse
  if(1077 <= mouseX && mouseX <= 1260 && 270 <= mouseY && mouseY <= 312 && pantalla.equals("BlackJack") && !rondaTerminadaBJ && apuestaBJ > 0 && mouseEnabled){
    stop = 1;
    juege_crupier();
   
    
  }
  
  
  
  
  
  
  
  
  // Codigo para ruleta
  if (valorFicha != 0 && ishandland&& pantalla.equals("mesa")) {
    valorFicha = 0;
  } else {
    ishandland = true;
  }


  // Interación del jugador con la mesa de apuestas determinada por clicks
  // Para apostar, seleccionar fichas, situarlas en casillas , etc.

  if (pantalla.equals("mesa") && 1095 <= mouseX && mouseX <= 1277 && 515 <= mouseY && mouseY <= 640 && !apuestas.isEmpty() ) {
    pantalla = "ruleta";
  }

  //Fichas

  // Ficha Desahacer / negra
  // Explicacion de verificar_radio en verificaciones
  if (6 <= mouseY && mouseY <= 116 && 16 <= mouseX && mouseX <= 125 && verificar_radio(69, 59, mouseX, mouseY) && !apuestas.isEmpty() && mouseDesahacer) {
    borrarUltimaApuesta();
    ishandland = false;
  }

  if (pantalla.equals("mesa") && 12 <= mouseY && mouseY <= 116 ) {

    // Ficha roja
    if ( 185 <= mouseX && mouseX <= 282 && verificar_radio(235, 65, mouseX, mouseY)) {
      cursor(rojo32);
      valorFicha = 500;
      ishandland = false;
    }

    // Ficha azul
    if (385 <= mouseX && mouseX <= 482 && verificar_radio(435, 65, mouseX, mouseY)) {
      cursor(azul32);
      valorFicha = 1000;
      ishandland = false;
    }

    // Ficha verde
    if (585 <= mouseX && mouseX <= 682 && verificar_radio(635, 65, mouseX, mouseY)) {
      cursor(verde32);
      valorFicha = 2000;
      ishandland = false;
    }

    // Ficha morada
    if (785 <= mouseX && mouseX <= 882 && verificar_radio(835, 65, mouseX, mouseY)) {
      cursor(morado32);
      valorFicha = 5000;
      ishandland = false;
    }
  }


  if (valorFicha >= 500) {
    //Tercera fila
    if (pantalla.equals("mesa") && 130 <= mouseY && mouseY <= 252 ) {

      //3
      if (125 <= mouseX && mouseX <= 189) {
        int [] vapuestas = {casillasRuleta[3].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }


      //6
      if (207 <= mouseX && mouseX <= 270 ) {

        int [] vapuestas = {casillasRuleta[6].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      //9
      if (288 <= mouseX && mouseX <= 351 ) {

        int [] vapuestas = {casillasRuleta[9].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 12
      if (370 <= mouseX && mouseX <= 432 ) {



        int [] vapuestas = {casillasRuleta[12].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 15
      if (450 <= mouseX && mouseX <= 514) {

        int [] vapuestas = {casillasRuleta[15].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 18
      if (531 <= mouseX && mouseX <= 593) {

        int [] vapuestas = {casillasRuleta[18].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 21
      if (613 <= mouseX && mouseX <= 674 ) {

        int [] vapuestas = {casillasRuleta[21].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }


      // 24
      if (693 <= mouseX && mouseX <= 755  ) {

        int [] vapuestas = {casillasRuleta[24].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 27
      if (774 <= mouseX && mouseX <= 837 ) {

        int [] vapuestas = {casillasRuleta[27].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 30
      if (854 <= mouseX && mouseX <= 918 ) {

        int [] vapuestas = {casillasRuleta[30].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 33
      if (936 <= mouseX && mouseX <= 1001) {

        int [] vapuestas = {casillasRuleta[33].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 36
      if (1016 <= mouseX && mouseX <= 1079) {

        int [] vapuestas = {casillasRuleta[36].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // Fila 3
      if (1098 <= mouseX && mouseX <= 1161) {
        // La casilla "63" hace referencia a la la tercera fila

        int [] vapuestas = {casillasEspeciales[4].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }
    }


    // Segunda fila
    if (pantalla.equals("mesa") && 263 <= mouseY && mouseY <= 373) {

      // 2
      if (125 <= mouseX && mouseX <= 189) {

        int [] vapuestas = {casillasRuleta[2].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 5
      if (207 <= mouseX && mouseX <= 270 ) {

        int [] vapuestas = {casillasRuleta[5].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 8
      if (288 <= mouseX && mouseX <= 351 ) {

        int [] vapuestas = {casillasRuleta[8].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 11
      if (367 <= mouseX && mouseX <= 431 ) {

        int [] vapuestas = {casillasRuleta[11].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 14
      if (450 <= mouseX && mouseX <= 514) {

        int [] vapuestas = {casillasRuleta[14].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 17
      if (531 <= mouseX && mouseX <= 593) {

        int [] vapuestas = {casillasRuleta[17].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 20
      if (613 <= mouseX && mouseX <= 674 ) {

        int [] vapuestas = {casillasRuleta[20].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 23
      if (693 <= mouseX && mouseX <= 755  ) {

        int [] vapuestas = {casillasRuleta[23].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 26
      if (774 <= mouseX && mouseX <= 837 ) {

        int [] vapuestas = {casillasRuleta[26].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      //29
      if (854 <= mouseX && mouseX <= 918 ) {

        int [] vapuestas = {casillasRuleta[29].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }


      // 32
      if (936 <= mouseX && mouseX <= 1001) {

        int [] vapuestas = {casillasRuleta[32].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 35
      if (1016 <= mouseX && mouseX <= 1079) {

        int [] vapuestas = {casillasRuleta[35].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }


      // Fila 2
      if (1096 <= mouseX && mouseX <= 1161) {

        // La casilla "62" hace referencia a la segunda fila
        int [] vapuestas = {casillasEspeciales[3].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }
    }


    //Primera fila
    if (pantalla.equals("mesa") && 384 <= mouseY && mouseY <= 504) {

      // 1
      if (125 <= mouseX && mouseX <= 189) {

        int [] vapuestas = {casillasRuleta[1].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 4
      if (207 <= mouseX && mouseX <= 270 ) {

        int [] vapuestas = {casillasRuleta[4].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 7
      if (288 <= mouseX && mouseX <= 351 ) {

        int [] vapuestas = {casillasRuleta[7].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 10
      if (370 <= mouseX && mouseX <= 432 ) {

        int [] vapuestas = {casillasRuleta[10].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 13
      if (450 <= mouseX && mouseX <= 514) {

        int [] vapuestas = {casillasRuleta[13].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 16
      if (531 <= mouseX && mouseX <= 593) {

        int [] vapuestas = {casillasRuleta[16].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 19
      if (613 <= mouseX && mouseX <= 674 ) {

        int [] vapuestas = {casillasRuleta[19].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 22
      if (693 <= mouseX && mouseX <= 755  ) {

        int [] vapuestas = {casillasRuleta[22].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 25
      if (774 <= mouseX && mouseX <= 837 ) {

        int [] vapuestas = {casillasRuleta[25].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 28
      if (854 <= mouseX && mouseX <= 918 ) {

        int [] vapuestas = {casillasRuleta[28].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 31
      if (936 <= mouseX && mouseX <= 1001) {

        int [] vapuestas = {casillasRuleta[31].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 34
      if (1016 <= mouseX && mouseX <= 1079) {

        int [] vapuestas = {casillasRuleta[34].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // fila 1
      if (1098 <= mouseX && mouseX <= 1161) {

        // La casilla "61" hace referencia a la primera fila

        int [] vapuestas = {casillasEspeciales[2].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }
    }

    // Docenas
    if (pantalla.equals("mesa") && 517 <= mouseY && mouseY <= 549) {

      // Primera docena
      if (121 <= mouseX && mouseX <= 432) {
        // La casilla "121" hace referencia a la primera docena
        int [] vapuestas = {casillasEspeciales[7].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }


      //Segunda docena
      if (444 <= mouseX && mouseX <= 758) {
        // La casilla "122" hace referencia a la segunda docena
        int [] vapuestas = {casillasEspeciales[8].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }


      //Tercera docena
      if (770 <= mouseX && mouseX <= 1084) {
        // La casilla "123" hace referencia a la tercera docena
        int [] vapuestas = {casillasEspeciales[9].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }
    }


    // Comodines

    if (pantalla.equals("mesa") && 566 <= mouseY && mouseY <=  595) {


      // 1 - 18
      if (121 <= mouseX &&  mouseX <= 268) {
        // La casilla "181" hace referencia a los números entre 1 - 18
        int [] vapuestas = {casillasEspeciales[10].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }


      // Par
      if (278 <= mouseX &&  mouseX <= 434) {
        // La casilla "40" hace referencia a los números pares
        int [] vapuestas = {casillasEspeciales[0].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // Rojo
      if (444 <= mouseX && mouseX <= 587) {
        // La casilla "80" hace referencia a los numeros rojos
        int [] vapuestas = {casillasEspeciales[5].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // Negro
      if (599 <= mouseX && mouseX  <= 759 ) {
        // La casilla "88" hace referencia a los numeros negros
        int [] vapuestas = {casillasEspeciales[6].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // Impar
      if (770 <= mouseX &&  mouseX <= 910) {
        // La casilla "41" hace referencia a los numeros impares
        int [] vapuestas = {casillasEspeciales[1].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }

      // 19 - 36
      if (920 <= mouseX && mouseX <= 1083) {
        // La casilla "182" hace referencia a los números entre 19 - 36
        int [] vapuestas = {casillasEspeciales[11].getNumero(), valorFicha};
        validar_apuesta(vapuestas);
      }
    }

    // 0

    // Explicacion de verificar_area en verificaciones
    if (pantalla.equals("mesa") && 107 <= mouseX && mouseX <= 116 && 130 <= mouseY && mouseY <= 504 || 63 <= mouseX
      && mouseX <= 107 && 130 <= mouseY && mouseY <= 504 && verificar_area(mouseX, mouseY)) {
      println(0);
      int [] vapuestas = {casillasRuleta[0].getNumero(), valorFicha};
      validar_apuesta(vapuestas);
    }
  }
}
