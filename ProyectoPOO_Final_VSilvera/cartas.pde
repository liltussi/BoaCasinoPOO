public class Carta {
  private String codigo;
  private int valor;

  public Carta(String codigo, int valor) {
    this.codigo = codigo;
    this.valor = valor;
  }

  public String getCodigo() {
    return this.codigo;
  }
  
  public int getValor() {
    return this.valor;
  }

}

public Carta[] cartasBJ = {
  new Carta("CA", 11),
  new Carta("C2", 2),
  new Carta("C3", 3),
  new Carta("C4", 4),
  new Carta("C5", 5),
  new Carta("C6", 6),
  new Carta("C7", 7),
  new Carta("C8", 8),
  new Carta("C9", 9),
  new Carta("C10", 10),
  new Carta("CJ", 10),
  new Carta("CQ", 10),
  new Carta("CK", 10),
  
  new Carta("DA", 11),
  new Carta("D2", 2),
  new Carta("D3", 3),
  new Carta("D4", 4),
  new Carta("D5", 5),
  new Carta("D6", 6),
  new Carta("D7", 7),
  new Carta("D8", 8),
  new Carta("D9", 9),
  new Carta("D10", 10),
  new Carta("DJ", 10),
  new Carta("DQ", 10),
  new Carta("DK", 10),
  
  new Carta("PA", 11),
  new Carta("P2", 2),
  new Carta("P3", 3),
  new Carta("P4", 4),
  new Carta("P5", 5),
  new Carta("P6", 6),
  new Carta("P7", 7),
  new Carta("P8", 8),
  new Carta("P9", 9),
  new Carta("P10", 10),
  new Carta("PJ", 10),
  new Carta("PQ", 10),
  new Carta("PK", 10),
  
  new Carta("TA", 11),
  new Carta("T2", 2),
  new Carta("T3", 3),
  new Carta("T4", 4),
  new Carta("T5", 5),
  new Carta("T6", 6),
  new Carta("T7", 7),
  new Carta("T8", 8),
  new Carta("T9", 9),
  new Carta("T10", 10),
  new Carta("TJ", 10),
  new Carta("TQ", 10),
  new Carta("TK", 10)
};
