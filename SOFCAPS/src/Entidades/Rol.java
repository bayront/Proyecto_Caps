package Entidades;


import java.util.List;


public class Rol 
{
   private String nomRol;
   private List<Opcion> opciones;
   private List<Usuario> usuarios;
   
   public Rol() 
   {
   }

    public String getNomRol() {
        return nomRol;
    }
    public void setNomRol(String nomRol) {
        this.nomRol = nomRol;
    }  
   
}
