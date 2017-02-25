package Entidades;


import java.util.List;

public class Categoria 
{
   private String nomCategoria;
   private Integer categoria_ID;
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
	public Integer getCategoria_ID() {
		return categoria_ID;
	}
	public void setCategoria_ID(Integer categoria_ID) {
		this.categoria_ID = categoria_ID;
	}
	public List<Tarifa> getTarifas() {
		return tarifas;
	}
	public void setTarifas(List<Tarifa> tarifas) {
		this.tarifas = tarifas;
	}  
   
}
