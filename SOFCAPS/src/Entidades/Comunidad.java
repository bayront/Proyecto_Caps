package Entidades;


import java.util.List;


public class Comunidad 
{
   private String comunidad;
   private Integer comunidad_ID;
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
	public Integer getComunidad_ID() {
		return comunidad_ID;
	}
	public void setComunidad_ID(Integer comunidad_ID) {
		this.comunidad_ID = comunidad_ID;
	}
	public List<Sector> getSectores() {
		return sectores;
	}
	public void setSectores(List<Sector> sectores) {
		this.sectores = sectores;
	}  
    
}
