package Entidades;


import java.util.List;

public class Categoria 
{
   private String nomCategoria;
   private List<Tarifa> tarifas;
   
   public Categoria() 
   {
    
   }

    public String getNomCategoria() {
        return nomCategoria;
    }
    public void setNomCategoria(String nomCategoria) {
        this.nomCategoria = nomCategoria;
    }  
   
}
