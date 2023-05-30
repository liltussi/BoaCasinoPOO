import java.util.Base64;
import java.security.MessageDigest;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
class admArchivos {
  private File usuarios;
  private File infoUsuarios;
  admArchivos() {
    this.usuarios = usuarios;
    this.usuarios = new File(dataPath(""), "/usuarios.txt"); //vaina con usuarios y contraseñas
    this.infoUsuarios = infoUsuarios;
    this.infoUsuarios = new File(dataPath(""), "/cuentas.txt"); //vaina con usuarios y saldos
  }
  void actualizarDatos(String nuevo, String usuario) {
    try {
      print("xd");
      String linen = null;
      FileReader fileread = new FileReader(this.infoUsuarios);
      BufferedReader brr = new BufferedReader(fileread);

      File rnuevo = new File("Nuevot" + ".txt");
      FileWriter fw = new FileWriter(rnuevo, true);
      BufferedWriter buffer = new BufferedWriter(fw);
      PrintWriter pwt = new PrintWriter(buffer);
      while ((linen = brr.readLine()) != null) {
        String temp[] = linen.split("\t");
        if (!usuario.equals(temp[0])) {
          pwt.println(linen);
        }
      }
      pwt.println(usuario + "\t" + nuevo);
      brr.close();
      pwt.close();
      fw.close();
      buffer.close();
      this.infoUsuarios.delete();
      rnuevo.renameTo(this.infoUsuarios);
    }

    catch (IOException ex) {
      System.out.println("No se encontró algún archivo");
    }
  }
  String recargar(String valor, String usuario) { //si
    int x = 0;
    try {
      // Validación de valor entero y no negativo
      int valorRecarga = Integer.parseInt(valor);
      if (valorRecarga < 0) {
        throw new IllegalArgumentException("El valor de recarga no puede ser negativo");
      }

      String linen = null;
      if (!this.infoUsuarios.exists()) {
        throw new FileNotFoundException("El archivo de información de usuarios no existe");
      }

      FileReader fileread = new FileReader(this.infoUsuarios);
      BufferedReader brr = new BufferedReader(fileread);

      File nuevoFile = new File("NuevoT.txt");
      FileWriter fw = new FileWriter(nuevoFile, true);
      BufferedWriter buffer = new BufferedWriter(fw);
      PrintWriter pwt = new PrintWriter(buffer);

      while ((linen = brr.readLine()) != null) {
        String temp[] = linen.split("\t");
        if (temp[0].equalsIgnoreCase(usuario)) {
          x = Integer.parseInt(temp[1]) + valorRecarga;
          pwt.println(usuario + "\t" + String.valueOf(x));
        } else {
          pwt.println(linen);
        }
      }

      brr.close();
      pwt.close();
      buffer.close();
      fw.close();

      if (!this.infoUsuarios.delete()) {
        throw new IOException("No se pudo eliminar el archivo de información de usuarios");
      }

      if (!nuevoFile.renameTo(this.infoUsuarios)) {
        throw new IOException("No se pudo renombrar el archivo nuevo");
      }

      return String.valueOf(x);
    }
    catch (IllegalArgumentException ex) {
      System.out.println(ex.getMessage());
      return String.valueOf(x);
    }
    catch (FileNotFoundException ex) {
      System.out.println(ex.getMessage());
      return String.valueOf(x);
    }
    catch (IOException ex) {
      System.out.println("Error de E/S: " + ex.getMessage());
      return String.valueOf(x);
    }
    catch (Exception e) {
      e.printStackTrace();
      return String.valueOf(x);
    }
  }


  boolean revisar(String usuario, String contraseña) {
    try {
      if (usuario.trim().length() > 0 && contraseña.trim().length() > 0) {
        String line = null;
        String comparedcontraseña = encrypt(contraseña);
        FileReader fileread = new FileReader(this.usuarios);
        BufferedReader brr = new BufferedReader(fileread);
        while ((line = brr.readLine()) != null) {
          String temp[] = line.split("\t");
          if ((temp[0].equals(usuario) && temp[1].equals(comparedcontraseña))) {
            brr.close();
            return true;
          }
        }
        brr.close();
        return false;
      }
      return false;
    }
    catch (IOException ex) {
      System.out.println("No se encontró algún archivo");
      return false;
    }
    catch (Exception e) {
      e.printStackTrace();
      return false;
    }
  }
  //relacionado con el registro
  boolean revisarExistencia(String usuario) {
    try {
      String line = null;
      FileReader fileread = new FileReader(this.usuarios);
      BufferedReader brr = new BufferedReader(fileread);
      while ((line = brr.readLine()) != null) {
        String temp[] = line.split("\t");
        if (temp[0].equalsIgnoreCase(usuario)) {
          brr.close();
          return false;
        }
      }
      brr.close();
      return true;
    }
    catch (IOException ex) {
      System.out.println("No se encontro archivo");
      return false;
    }
  }
  void crearCuenta(String usuario, String contraseña) {
    try {
      String encryptedPassword = encrypt(contraseña);
      String linen = null;
      FileReader fileread = new FileReader(this.usuarios);
      BufferedReader brr = new BufferedReader(fileread);

      File rnuevo = new File("Nuevot" + ".txt");
      FileWriter fw = new FileWriter(rnuevo, true);
      BufferedWriter buffer = new BufferedWriter(fw);
      PrintWriter pwt = new PrintWriter(buffer);

      while ((linen = brr.readLine()) != null) {
        pwt.println(linen);
      }
      pwt.println(usuario + "\t" + encryptedPassword);
      brr.close();
      pwt.close();
      fw.close();
      buffer.close();
      this.usuarios.delete();
      rnuevo.renameTo(this.usuarios);
    }
    catch (IOException ex) {
      System.out.println("No se encontró algún archivo");
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }


  void cambiarContraseña(String usuario, String contraseña) {
    try {
      // Validación de contraseña vacía
      if (contraseña.isEmpty()) {
        throw new IllegalArgumentException("La contraseña no puede estar vacía");
      }

      String encryptedPassword = encrypt(contraseña);
      String linen = null;

      if (!this.usuarios.exists()) {
        throw new FileNotFoundException("El archivo de usuarios no existe");
      }

      FileReader fileread = new FileReader(this.usuarios);
      BufferedReader brr = new BufferedReader(fileread);

      File nuevoFile = new File("Nuevot.txt");
      FileWriter fw = new FileWriter(nuevoFile, true);
      BufferedWriter buffer = new BufferedWriter(fw);
      PrintWriter pwt = new PrintWriter(buffer);

      while ((linen = brr.readLine()) != null) {
        String temp[] = linen.split("\t");
        if (!temp[0].equalsIgnoreCase(usuario)) {
          pwt.println(linen);
        }
      }

      pwt.println(usuario + "\t" + encryptedPassword);

      brr.close();
      pwt.close();
      buffer.close();
      fw.close();

      if (!this.usuarios.delete()) {
        throw new IOException("No se pudo eliminar el archivo de usuarios");
      }

      if (!nuevoFile.renameTo(this.usuarios)) {
        throw new IOException("No se pudo renombrar el archivo nuevo");
      }
    }
    catch (FileNotFoundException ex) {
      System.out.println(ex.getMessage());
    }
    catch (IOException ex) {
      System.out.println("Error de E/S: " + ex.getMessage());
    }
    catch (IllegalArgumentException ex) {
      System.out.println(ex.getMessage());
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }


  void eliminarCuenta(String usuario, String contraseña) {
    boolean con = false;
    try {
      String encryptedPassword = encrypt(contraseña);
      String linen = null;

      if (!this.usuarios.exists()) {
        throw new FileNotFoundException("El archivo de usuarios no existe");
      }

      FileReader fileread = new FileReader(this.usuarios);
      BufferedReader brr = new BufferedReader(fileread);

      File nuevoFile = new File("Nuevot.txt");
      FileWriter fw = new FileWriter(nuevoFile, true);
      BufferedWriter buffer = new BufferedWriter(fw);
      PrintWriter pwt = new PrintWriter(buffer);

      while ((linen = brr.readLine()) != null) {
        String temp[] = linen.split("\t");
        if (!temp[0].equalsIgnoreCase(usuario)) {
          pwt.println(linen);
        } else if (temp[1].equalsIgnoreCase(encryptedPassword) && temp[0].equalsIgnoreCase(usuario)) {
          con = true;
        }
      }

      brr.close();
      pwt.close();
      buffer.close();
      fw.close();

      if (!this.usuarios.delete()) {
        throw new IOException("No se pudo eliminar el archivo de usuarios");
      }

      if (!nuevoFile.renameTo(this.usuarios)) {
        throw new IOException("No se pudo renombrar el archivo nuevo");
      }

      String linen2 = null;
      if (!this.infoUsuarios.exists()) {
        throw new FileNotFoundException("El archivo de información de usuarios no existe");
      }

      FileReader fileread2 = new FileReader(this.infoUsuarios);
      BufferedReader brr2 = new BufferedReader(fileread2);

      File nuevoFile2 = new File("Nuevot.txt");
      FileWriter fw2 = new FileWriter(nuevoFile2, true);
      BufferedWriter buffer2 = new BufferedWriter(fw2);
      PrintWriter pwt2 = new PrintWriter(buffer2);

      while ((linen2 = brr2.readLine()) != null) {
        String temp[] = linen2.split("\t");
        if (!temp[0].equalsIgnoreCase(usuario) || !con) {
          pwt2.println(linen2);
        }
      }

      brr2.close();
      pwt2.close();
      buffer2.close();
      fw2.close();

      if (!this.infoUsuarios.delete()) {
        throw new IOException("No se pudo eliminar el archivo de información de usuarios");
      }

      if (!nuevoFile2.renameTo(this.infoUsuarios)) {
        throw new IOException("No se pudo renombrar el archivo nuevo");
      }
    }
    catch (FileNotFoundException ex) {
      System.out.println(ex.getMessage());
    }
    catch (IOException ex) {
      System.out.println("Error de E/S: " + ex.getMessage());
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  String encrypt(String input) throws Exception {
    byte[] key = "0123456789abcdef".getBytes(); // Clave secreta de 16 caracteres
    byte[] data = input.getBytes();

    Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
    SecretKeySpec secretKey = new SecretKeySpec(key, "AES");
    cipher.init(Cipher.ENCRYPT_MODE, secretKey);

    byte[] encryptedData = cipher.doFinal(data);

    return Base64.getEncoder().encodeToString(encryptedData);
  }
  void crearIndividual(String usuario) {
    //cuentas individuales sirve
    try {
      String line = null;
      File original = this.infoUsuarios;
      FileReader filereade = new FileReader(original);
      BufferedReader br = new BufferedReader(filereade);

      File nuevo = new File("Nuevo.txt");
      FileWriter fww = new FileWriter(nuevo, true);
      BufferedWriter bufffer = new BufferedWriter(fww);
      PrintWriter pw = new PrintWriter(bufffer);

      while ((line = br.readLine()) != null) {
        pw.println(line);
      }
      pw.println(usuario + "\t" + "0");
      br.close();
      pw.close();
      fww.close();
      bufffer.close();
      original.delete();
      nuevo.renameTo(original);
    }
    catch (IOException ex) {
      System.out.println("No se encontro algun archivo");
    }
  }
  String asignarSaldo(String u) {
    try {
      String line = null;
      FileReader fileread = new FileReader(this.infoUsuarios);
      BufferedReader brr = new BufferedReader(fileread);
      while ((line = brr.readLine()) != null) {
        String temp[] = line.split("\t");
        if (temp[0].equalsIgnoreCase(u)) {
          brr.close();
          return temp[1];
        }
      }
      brr.close();
      return null;
    }
    catch (IOException ex) {
      System.out.println("No se encontro archivo");
      return null;
    }
  }
}




//public boolean validar(String input){
//}
//public void referencia(File xd){
//  File
//  this.usuarios =
//}
