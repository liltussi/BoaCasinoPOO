public class Casilla {
    // Atributos 
    private String colores;
    private int numero;
    private boolean par;
    private int docena;
    private int fila;
    private int diezochos; 
    private int napuestasR;
    private int napuestasA;
    private int napuestasV;
    private int napuestasM;
    private boolean fichaRoja;
    private boolean fichaAzul;
    private boolean fichaVerde;
    private boolean fichaMorada;
    

    public Casilla(String colores, int numero) {
        this.colores = colores;
        this.numero = numero;
        this.par = (numero%2 == 0);
        this.docena = setDocena(numero);
        this.fila = setFila(numero);
        this.diezochos = setDO(numero);
        this.napuestasR = 0;
        this.napuestasA = 0;
        this.napuestasV = 0;
        this.napuestasM = 0;
        
        //Estos atributos son los que se utilizan para colocar las fichas sobre las casillas en la mesa de apuestas
        this.fichaRoja = false;
        this.fichaAzul = false;
        this.fichaVerde = false;
        this.fichaMorada = false;
        
    }
    
    public boolean isFichaRoja() {
      return this.fichaRoja;
    }

    public boolean isFichaAzul() {
      return this.fichaAzul;
    }

    public boolean isFichaVerde() {
      return this.fichaVerde;
    }

    public boolean isFichaMorada() {
      return this.fichaMorada;
    }
    
    public String getColores() {
        return this.colores;
    }

    public int getNumero() {
        return this.numero;
    }
    
    public boolean getIsPar(){
      return this.par;
    }
    
    public int getDocena(){
      return this.docena;
    }
    
    public int getFila(){
      return this.fila;
    }
    
    public int getDiezochos(){
      return this.diezochos;
    }
    
    
    public void setNapuestaColor(int vApuesta, int num){
     // Cuando se llama setNapuestasColor, es para contabilizar el numero de fichas que estan sobre esta casilla
     // Se pueden agregar si num es 1 o quitar sin num es -1 y el atributo napuestasR/A/V/M  es cero al restar se vuelve false
      
      if(vApuesta == 500){
        
        this.napuestasR += num;
        
        if(this.napuestasR == 0){
          this.fichaRoja = false;
        }
        
        
      }
      
      else if(vApuesta == 1000){
        this.napuestasA += num;
        
        if(this.napuestasA == 0){
          this.fichaAzul = false;
        }
        
      }
      
      else if(vApuesta == 2000){
        this.napuestasV += num;
        
        if(this.napuestasV == 0){
          this.fichaVerde = false;
        }
        
      }
      
      else{
        this.napuestasM += num;
        
        if(this.napuestasM == 0){
          this.fichaMorada = false;
        }
        
      }
       
    }
    
    // Metodo privado para asigarna fila
    private int setFila(int num){
      if((num+2)%3 == 0){
        return 1;
        
      }
      else if((num+1)%3 == 0){
        return 2;
      
      }
      else{
        return 3; 
      }
    }
    
    
    // Metodo privado para asigarna docena
    private int setDocena(int num){
      if(num <= 12){
        return 1;
        
      } 
      else if(13 <= num && num <= 24){
        return 2;
        
      }
      else{
        return 3;
      }
    }
    
    private int setDO(int num){
          
      if(num <= 18){
        return 1;
        
      } 
      else{
        return 2;
      }   
    }
    
    public void setFichaRoja(boolean valor) {
      this.fichaRoja = valor;
    }

    public void setFichaAzul(boolean valor) {
      this.fichaAzul = valor;
    }

    public void setFichaVerde(boolean valor) {
      this.fichaVerde = valor;
    }

    public void setFichaMorada(boolean valor) {
      this.fichaMorada = valor;
    }
    
    
    
}


Casilla[] casillasRuleta = {
  new Casilla("verde" , 0),
  new Casilla("rojo"  , 1),
  new Casilla("negro" , 2), 
  new Casilla("rojo"  , 3),
  new Casilla("negro" , 4),
  new Casilla("rojo"  , 5),
  new Casilla("negro" , 6),
  new Casilla("rojo"  , 7),
  new Casilla("negro" , 8),
  new Casilla("rojo"  , 9),
  new Casilla("negro" , 10),
  new Casilla("negro"  , 11),
  new Casilla("rojo" , 12),
  new Casilla("negro"  , 13),
  new Casilla("rojo" , 14),
  new Casilla("negro"  , 15),
  new Casilla("rojo" , 16),
  new Casilla("negro"  , 17),
  new Casilla("rojo" , 18),
  new Casilla("rojo"  , 19),
  new Casilla("negro" , 20),
  new Casilla("rojo"  , 21),
  new Casilla("negro" , 22),
  new Casilla("rojo"  , 23),
  new Casilla("negro" , 24),
  new Casilla("rojo"  , 25),
  new Casilla("negro" , 26),
  new Casilla("rojo"  , 27),
  new Casilla("negro" , 28),
  new Casilla("negro"  , 29),
  new Casilla("rojo" , 30),
  new Casilla("negro"  , 31),
  new Casilla("rojo" , 32),
  new Casilla("negro"  , 33),
  new Casilla("rojo" , 34),
  new Casilla("negro"  , 35),
  new Casilla("rojo" , 36)
};

Casilla[] casillasEspeciales = {
  new Casilla("fucsia", 40),
  new Casilla("fucsia", 41),
  new Casilla("fucsia", 61),
  new Casilla("fucsia", 62),
  new Casilla("fucsia", 63),
  new Casilla("fucsia", 80),
  new Casilla("fucsia", 88),
  new Casilla("fucsia", 121),
  new Casilla("fucsia", 122),
  new Casilla("fucsia", 123),
  new Casilla("fucsia", 181),
  new Casilla("fucsia", 182)
};
