package Entidades;


public class Unidad_de_Medida 
{
   private String tipoMedida;
   private Integer unidad_de_Medida_ID;

   public Unidad_de_Medida() 
   {
   }

    public String getTipoMedida() {
        return tipoMedida;
    }
    public void setTipoMedida(String tipoMedida) {
        this.tipoMedida = tipoMedida;
    }
	public Integer getUnidad_de_Medida_ID() {
		return unidad_de_Medida_ID;
	}
	public void setUnidad_de_Medida_ID(Integer unidad_de_Medida_ID) {
		this.unidad_de_Medida_ID = unidad_de_Medida_ID;
	}  
    
}
