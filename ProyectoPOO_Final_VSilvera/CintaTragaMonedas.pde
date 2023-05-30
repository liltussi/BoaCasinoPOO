class CintaTragaMonedas {

  private PImage imagen;        //Imagen de la Cinta
  private int posx, posy;       //Posición de la Cinta
  private int resultado;        //Resultado de la Cinta
  private int duracion;         //Duración de la animación
  private int inicio_mov;       //Momento de inicio de la animación
  private int desplazamiento;   //Desplazamiento de la cinta
  
  public CintaTragaMonedas (int x, int y) {
    imagen = loadImage("cinta.png");
    posx = x;
    posy = y;
    resultado = int(random(0, 3));
  }
  
  public boolean finMovimiento () {
    if (millis() > inicio_mov + duracion)
      return true;
    return false;
  }
  
  public int resultado () {
    return resultado;
  }
  
  public void activarMovimiento () {
    //Generar tiempo de duración de la animación
    inicio_mov = millis();
    
    int vueltas = int(random(5, 11));
    resultado = int(random(0, 3));
    desplazamiento = vueltas*480 - 110;
    duracion = vueltas * int(random(500, 1501));
  }
  
  private void moverCinta () {
    if (millis() > inicio_mov + duracion)
      return;
      
    float angulo = (3.1416)/2 * (millis() - inicio_mov)/duracion;
    posy = int(desplazamiento * sin(angulo));
    posy = posy%480;
       
  }
  
  public void dibujarCinta () {
    imageMode(CORNER);
    image(imagen, posx, posy - resultado*160);
    imageMode(CORNER);
    image(imagen, posx, posy - resultado*160 - 480);
    imageMode(CORNER);
    image(imagen, posx, posy - resultado*160 + 480);
    
    moverCinta();
  }
}
