package Entidades;


import java.util.List;


public class Opcion 
{
   private String descripcion;
   private String opcion;
   private List<Rol> roles;

   public Opcion() 
   {  
   }

    public String getDescripcion() {
        return descripcion;
    }
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    public String getOpcion() {
        return opcion;
    }
    public void setOpcion(String opcion) {
        this.opcion = opcion;
    }
   
}
