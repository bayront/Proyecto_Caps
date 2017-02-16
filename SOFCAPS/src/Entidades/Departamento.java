package Entidades;


import java.util.List;


public class Departamento 
{
   private String dep;
   private List<Municipio> municipios;
   
   public Departamento() 
   {
   }

    public String getDep() {
        return dep;
    }
    public void setDep(String dep) {
        this.dep = dep;
    }  
   
}
