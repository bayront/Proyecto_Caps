package Entidades;


import java.util.List;


public class Municipio 
{
   private String nomMuni;
   private List<Comunidad> comunidades;
  
   public Municipio() 
   {
   }

    public String getNomMuni() {
        return nomMuni;
    }
    public void setNomMuni(String nomMuni) {
        this.nomMuni = nomMuni;
    }   
   
}
