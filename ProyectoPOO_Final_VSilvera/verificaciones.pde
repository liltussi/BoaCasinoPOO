import java.util.Timer;
import java.util.TimerTask;

// verificar_area se utiliza exclusivamente para determinar si se hace clic en la casilla 0 de la mesa de apuestas
// Ya que tiene un trianguanlo y un rectagunlo 
// Determinar el area del triagunlo forma por cuatro puntos, los del mouse y lo del triangulo original
// Si la suma del area de los tres triangulos generados por los cuatro puntos es igual a la del triangulo original entonces estamos dentro 

public static boolean verificar_area(int x , int y){
  // Definir los puntos de los triángulos 
  PVector a = new PVector(62, 319);
  PVector b = new PVector(106, 131);
  PVector c = new PVector(106, 505);
  PVector z = new PVector(x, y);
  
  // Calcular el vectores 
  PVector ab = PVector.sub(b, a);  
  PVector az = PVector.sub(z, a);
  PVector cz = PVector.sub(z, c);  
  PVector zb = PVector.sub(b, z);
  PVector zc = PVector.sub(c, z);  
  PVector ca = PVector.sub(a, c);
  
  
  // Calcular el producto cruzado 
  float crossProduct1 = ab.cross(az).mag();
  float crossProduct2 = cz.cross(zb).mag();
  float crossProduct3 = zc.cross(ca).mag();
  
  // Calcular el área del triángulo
  float area1 = crossProduct1/ 2;
  float area2 = crossProduct2/ 2;
  float area3 = crossProduct3/ 2;
  
  // Retorna true si la suma del área los 3 tringualos es la misma que el triangulo original
  return (area1 + area2 + area3)  ==  8228;
}


// Se utiliza para las formas circuales, tomando dos pares de puntos, sacando la magnitud del vector
// Si esta entre el 0 y el radio del circulo, entonces esta dentro

public static boolean verificar_radio(int centro_x, int centro_y, int x, int y){
  
  // Definir del vector 
  PVector a = new PVector(centro_x, centro_y);
  PVector b = new PVector(x,y);  
  
  //Definir el vector
  PVector ab = PVector.sub(b, a);
  
  //Magnitud del vector
  float magnitud_ab = ab.mag();
  
  //  return true si estamos dentro de las fichas al momento del clic 
  if(centro_x == 69 && centro_y == 59){
    return (0 <= magnitud_ab && magnitud_ab <= 57);
  }
  return (0 <= magnitud_ab && magnitud_ab <= 51);
    
}





// Valida que la apuesta del jugador se pueda realizar, si es asi la guarda
public void validar_apuesta(int[] vap){
  
 
  int cas = vap[0];
  int val = vap[1];
  

  if(orden_casillas_apostadas.contains(cas) && saldoJugador >= 500){
    int index = orden_casillas_apostadas.indexOf(cas);
    int [] repetida = {cas,val + apuestas.get(index)[1]};
    individuales.add(vap);
    apuestas.set(index,repetida);
    saldoJugador -= val;
    asignar_ficha(cas,val);

  }
  
  else if(val <= saldoJugador && saldoJugador >= 500){
    apuestas.add(vap);
    individuales.add(vap);
    saldoJugador -= val;
    orden_casillas_apostadas.add(cas);
    asignar_ficha(cas,val);
   
    
  }
  else{
    // Silvera aqui debe ir algo para cuando ya hizo apuesta pero lo queda mas salgo para apostar tipo le quedan 400 y la minima es 500
  }
  
  valorFicha = 0;
  ishandland = true;

}

// Para colocar la ficha apostada en la casilla seleccionada

public void asignar_ficha(int pos,int valfic){
  if(0 <= pos && pos <= 36){
    
    if (valfic == 500){
        casillasRuleta[pos].setFichaRoja(true);
        casillasRuleta[pos].setNapuestaColor(500,1);
    }
    else if(valfic == 1000){
      casillasRuleta[pos].setFichaAzul(true);
      casillasRuleta[pos].setNapuestaColor(1000,1);
    }
    else if(valfic == 2000){
      casillasRuleta[pos].setFichaVerde(true);
      casillasRuleta[pos].setNapuestaColor(2000,1);
    }
    else if(valfic == 5000){
      casillasRuleta[pos].setFichaMorada(true);
      casillasRuleta[pos].setNapuestaColor(5000,1);
    }
      
  }
  else{
    
    pos = numero_casillas_especiales(pos);   
    
    if (valfic == 500){
      casillasEspeciales[pos].setFichaRoja(true);
      casillasEspeciales[pos].setNapuestaColor(500,1);
    }
    else if(valfic == 1000){
      casillasEspeciales[pos].setFichaAzul(true);
      casillasEspeciales[pos].setNapuestaColor(1000,1);
    }
    else if(valfic == 2000){
      casillasEspeciales[pos].setFichaVerde(true);
      casillasEspeciales[pos].setNapuestaColor(2000,1);
    }
    else if(valfic == 5000){
      casillasEspeciales[pos].setFichaMorada(true);
      casillasEspeciales[pos].setNapuestaColor(5000,1);
    } 

  }
}


// Calcular si las apuestas del jugador le dan dinero 
public void calcular_pago(int index,int posBola, int tamano){
  if (index == tamano || tamano == 0 ){
    ultimaCasilla = posBola;  
  } 
  else{
    if(0 <= apuestas.get(index)[0] && apuestas.get(index)[0] <= 36 && apuestas.get(index)[0] == posBola) {
      // Jackpot
      if(posBola == ultimaCasilla){
        saldoJugador += apuestas.get(index)[1] * 72;
      
      }
      // Numero 
      else{
        saldoJugador += apuestas.get(index)[1] * 36;
      }
    }
    // Demas casos donde no se tiene en cuenta el 0 
    else if(posBola != 0){
      //filas
      if((apuestas.get(index)[0] == 61 && casillasRuleta[posBola].getFila() == 1 ) || 
      (apuestas.get(index)[0] == 62 && casillasRuleta[posBola].getFila() == 2) || 
      (apuestas.get(index)[0] == 63 && casillasRuleta[posBola].getFila() == 3)){
        
        saldoJugador += apuestas.get(index)[1] * 3;
      }
      
      // docenas
      else if((apuestas.get(index)[0] == 121 && casillasRuleta[posBola].getDocena() == 1 ) || 
      (apuestas.get(index)[0] == 122 && casillasRuleta[posBola].getDocena() == 2 ) || 
      (apuestas.get(index)[0] == 123 && casillasRuleta[posBola].getDocena() == 3)){
        
        saldoJugador += apuestas.get(index)[1] * 3;
      }
      // colores
      else if((apuestas.get(index)[0] == 80 && casillasRuleta[posBola].getColores().equals("rojo")) || 
      (apuestas.get(index)[0] == 88 && casillasRuleta[posBola].getColores().equals("negro"))){
        saldoJugador += apuestas.get(index)[1] * 2;
      }
      // paridad
      else if((apuestas.get(index)[0] == 40 && casillasRuleta[posBola].getIsPar()) || 
      (apuestas.get(index)[0] == 41 && !casillasRuleta[posBola].getIsPar())){
        saldoJugador += apuestas.get(index)[1] * 2;
      }
      //mitades
      else if((apuestas.get(index)[0] == 181 && casillasRuleta[posBola].getDiezochos() == 1) || 
      (apuestas.get(index)[0] == 182 && casillasRuleta[posBola].getDiezochos() == 2)){
        saldoJugador += apuestas.get(index)[1] * 2;
      }
    }
    calcular_pago(index+1,posBola,tamano);
  } 
}
  
// Limpiar el tablero de apuestas al comienzo de cada ronda 
public void resetTablero (int index, int tamano){
  if(index == tamano){
    apuestas.clear();
    orden_casillas_apostadas.clear();
    individuales.clear();
  }
  else{
    int num = apuestas.get(index)[0];
    if (0 <= num && num <= 36){
      casillasRuleta[num].setFichaRoja(false);
      casillasRuleta[num].setFichaAzul(false);
      casillasRuleta[num].setFichaVerde(false);
      casillasRuleta[num].setFichaMorada(false);
    }
    else{
      num = numero_casillas_especiales(num); 
      
      casillasEspeciales[num].setFichaRoja(false);
      casillasEspeciales[num].setFichaAzul(false);
      casillasEspeciales[num].setFichaVerde(false);
      casillasEspeciales[num].setFichaMorada(false);
    }
    resetTablero(index + 1,tamano);
  }
}

// Desahacer ultima apuesta
public void borrarUltimaApuesta(){
  // iker casillas
  int iker = individuales.get(individuales.size() - 1)[0];
  int plata = individuales.get(individuales.size() - 1)[1];
  int index = orden_casillas_apostadas.indexOf(iker);
 
  
  if (0 <= iker && iker <= 36){
    
    if (plata == 500){
      casillasRuleta[iker].setNapuestaColor(plata,-1);
      int [] vap = {iker,apuestas.get(index)[1] - plata};
      apuestas.set(index,vap);
      saldoJugador += plata;
      individuales.remove(individuales.size() - 1);
      if(apuestas.get(index)[1] == 0){
        apuestas.remove(index);
        orden_casillas_apostadas.remove(index);
      }
      
      
      
    }
    else if (plata == 1000){
      casillasRuleta[iker].setNapuestaColor(plata,-1);
      int [] vap = {iker,apuestas.get(index)[1] - plata};
      apuestas.set(index,vap);
      saldoJugador += plata;
      individuales.remove(individuales.size() - 1);
      if(apuestas.get(index)[1] == 0){
        apuestas.remove(index);
        orden_casillas_apostadas.remove(index);
      }
      
    }
    else if (plata == 2000){
      casillasRuleta[iker].setNapuestaColor(plata,-1);
      int [] vap = {iker,apuestas.get(index)[1] - plata};
      apuestas.set(index,vap);
      saldoJugador += plata;
      individuales.remove(individuales.size() - 1);
      if(apuestas.get(index)[1] == 0){
        apuestas.remove(index);
        orden_casillas_apostadas.remove(index);
      }
      
    }
    else if (plata == 5000){  
      casillasRuleta[iker].setNapuestaColor(plata,-1);
      int [] vap = {iker,apuestas.get(index)[1] - plata};
      apuestas.set(index,vap);
      saldoJugador += plata;
      individuales.remove(individuales.size() - 1);
      if(apuestas.get(index)[1] == 0){
        apuestas.remove(index);
        orden_casillas_apostadas.remove(index);
      }
      
    }
  }
  else{
    iker = numero_casillas_especiales(iker); 
    
    if (plata == 500){
      casillasEspeciales[iker].setNapuestaColor(plata,-1);
      int [] vap = {iker,apuestas.get(index)[1] - plata};
      apuestas.set(index,vap);
      saldoJugador += plata;
      individuales.remove(individuales.size() - 1);
      if(apuestas.get(index)[1] == 0){
        apuestas.remove(index);
        orden_casillas_apostadas.remove(index);
      }
      
      
      
    }
    else if (plata == 1000){
      casillasEspeciales[iker].setNapuestaColor(plata,-1);
      int [] vap = {iker,apuestas.get(index)[1] - plata};
      apuestas.set(index,vap);
      saldoJugador += plata;
      individuales.remove(individuales.size() - 1);
      if(apuestas.get(index)[1] == 0){
        apuestas.remove(index);
        orden_casillas_apostadas.remove(index);
      }
      
    }
    else if (plata == 2000){
      casillasEspeciales[iker].setNapuestaColor(plata,-1);
      int [] vap = {iker,apuestas.get(index)[1] - plata};
      apuestas.set(index,vap);
      saldoJugador += plata;
      individuales.remove(individuales.size() - 1);
      if(apuestas.get(index)[1] == 0){
        apuestas.remove(index);
        orden_casillas_apostadas.remove(index);
      }
      
    }
    else if (plata == 5000){  
      casillasEspeciales[iker].setNapuestaColor(plata,-1);
      int [] vap = {iker,apuestas.get(index)[1] - plata};
      apuestas.set(index,vap);
      saldoJugador += plata;
      individuales.remove(individuales.size() - 1);
      if(apuestas.get(index)[1] == 0){
        apuestas.remove(index);
        orden_casillas_apostadas.remove(index);
      }
      
    }
  
  }
 
}  


    
    
// Se utiliza para hallar el indice las casillas especiales
    
public int numero_casillas_especiales(int pos){
  int pox = 13;
  if(pos == 40){
    pox = 0;
  }
  else if(pos == 41){
    pox = 1;
  }
  else if(pos == 61){
    pox = 2;
  }
  else if(pos == 62){
    pox= 3;
  }
  else if(pos == 63){
    pox = 4;
  }
  else if(pos == 80){
    pox = 5;
  }
  else if(pos == 88){
    pox = 6;
  }
  else if(pos == 121){
    pox = 7;
  }
  else if(pos == 122){
    pox = 8;
  }
  else if(pos == 123){
    pox = 9;
  }
  else if(pos == 181){
    pox = 10;
  }
  else if(pos == 182){
    pox = 11;
  }
    
  return pox;
}    
 
