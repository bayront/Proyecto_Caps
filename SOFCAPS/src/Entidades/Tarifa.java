package Entidades;


public class Tarifa 
{
   private Integer lim_Inf;
   private Integer lim_Sup;
   private Float monto;
   private Integer tarifa_ID;
   public Unidad_de_Medida unidad_de_Medida;
   public Categoria categoria;

   public Tarifa() 
   {
   }

    public Integer getLim_Inf() {
        return lim_Inf;
    }
    public void setLim_Inf(Integer lim_Inf) {
        this.lim_Inf = lim_Inf;
    }
    public Integer getLim_Sup() {
        return lim_Sup;
    }
    public void setLim_Sup(Integer lim_Sup) {
        this.lim_Sup = lim_Sup;
    }
    public Float getMonto() {
        return monto;
    }
    public void setMonto(Float monto) {
        this.monto = monto;
    }
    public Unidad_de_Medida getUnidad_de_Medida() {
        return unidad_de_Medida;
    }
    public void setUnidad_de_Medida(Unidad_de_Medida unidad_de_Medida) {
        this.unidad_de_Medida = unidad_de_Medida;
    }
    public Categoria getCategoria() {
        return categoria;
    }
    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }
	public Integer getTarifa_ID() {
		return tarifa_ID;
	}
	public void setTarifa_ID(Integer tarifa_ID) {
		this.tarifa_ID = tarifa_ID;
	}
    
}
