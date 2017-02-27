package Entidades;


import java.util.List;


public class Municipio 
{
   private String nomMuni;
   private Integer municipio_ID;
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
	public Integer getMunicipio_ID() {
		return municipio_ID;
	}
	public void setMunicipio_ID(Integer municipio_ID) {
		this.municipio_ID = municipio_ID;
	}
	public List<Comunidad> getComunidades() {
		return comunidades;
	}
	public void setComunidades(List<Comunidad> comunidades) {
		this.comunidades = comunidades;
	}   
    
}
