package Entidades;


import java.util.List;


public class Comunidad 
{
   private String comunidad;
   private List<Sector> sectores;
   
   public Comunidad() 
   { 
   }

    public String getComunidad() {
        return comunidad;
    }
    public void setComunidad(String comunidad) {
        this.comunidad = comunidad;
    }  
   
}
