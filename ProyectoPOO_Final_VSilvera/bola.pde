public class Bola {
    private int desgaste;
    private int peso;
    private int diametro;
     
    public Bola() {      
        this.desgaste = 0;
        this.peso = 0;
        this.diametro = 0;
        
    }
    
    public void setDesgaste(int desgaste){
        this.desgaste = desgaste;
    }
    
    public void setPeso(int peso){
        this.peso = peso;
    }
    
    
    public void setDiametro(int diametro){
        this.diametro = diametro;
    }

    public int getDesgaste() {
        return this.desgaste;
    }

    public int getPeso() {
        return this.peso;
    }

    public int getDiametro() {
        return this.diametro;
    }
    
    public int getPosicion(){
        return setPosicion();
    }
    
    private int setPosicion(){
      //Metodo de random especial
      int velocidad = round(random(100,150));
      int posicion  = round(random(0,36));
      this.setDesgaste(floor(random(0,5)));
      this.setDiametro(floor(random(18,23)));
      this.setPeso(floor(random(123,414)));
      
      while(velocidad >= 0){
        posicion += (velocidad / this.peso) + (velocidad * this.desgaste) - (this.diametro*this.peso + round(random(0,3)));
        velocidad -= second();
      
      
      }
      return (abs((posicion % 37)) + round(random(0,36)))% 37;
      
         
    }
    
    
 
    
}
