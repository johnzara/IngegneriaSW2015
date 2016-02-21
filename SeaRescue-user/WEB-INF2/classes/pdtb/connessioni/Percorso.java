package pdtb.connessioni;


public class Percorso {
   private static Percorso instance;
   String percorso;
   protected Percorso() {
    percorso = "";

      // Exists only to defeat instantiation.
   }
   public static Percorso getInstance() {
      if(instance == null) {
         instance = new Percorso();
      }
      return instance;
   }
   public String getePercorso() {
    return percorso;
   }
   public void aggiungiScelta(String scelta) {
      /*if(scelta.compareTo("null")!=0 && scelta.compareTo("")!=0 && scelta!=null) {*/
          percorso = "ciao";
      

}
}
