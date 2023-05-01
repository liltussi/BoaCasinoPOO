class admArchivos {
  private File usuarios;
  private File infoUsuarios;
  admArchivos(File usuarios) {
    this.usuarios = usuarios;
    this.infoUsuarios = infoUsuarios;
  }
  boolean revisar(String usuario, String contraseña) {
    try {
      String line = null;
      FileReader fileread = new FileReader(usuarios);
      BufferedReader brr = new BufferedReader(fileread);
      while ((line = brr.readLine()) != null) {
        String temp[] = line.split("\t");
        if ((temp[0].equalsIgnoreCase(usuario) && temp[1].equalsIgnoreCase(contraseña))) {
          print("xd");
          return true;
        }
      }
      brr.close();
      return false;
    }
    catch (IOException ex) {
      System.out.println("No se encontro archivo");
      return false;
    }
  }
}
//public boolean validar(String input){
//}
//public void referencia(File xd){
//  File
//  this.usuarios =
//}
