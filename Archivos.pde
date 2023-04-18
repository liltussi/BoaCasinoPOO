class admArchivos{
  private File usuarios;
  private File infoUsuarios;
  admArchivos(File usuarios, File infoUsuarios){
    this.usuarios = usuarios;
    this.infoUsuarios = infoUsuarios;
  }
  //public boolean validar(String input){
  //}
  //public void referencia(File xd){
  //  File
  //  this.usuarios = 
  //}
  public File getUsuarios(){
    return usuarios;
  }
  public File getInfo(){
    return infoUsuarios;
  }
  
}
