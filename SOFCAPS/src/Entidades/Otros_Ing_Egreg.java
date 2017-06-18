package Entidades;


import java.util.Date;

public class Otros_Ing_Egreg 
{
   private String descripcion;
   private String mes;
   private String anio;
   private Date fecha;
   private Float monto;
   private Boolean eliminado;
   private Integer otros_Ing_Egreg_ID; 
   private Categoria_Ing_Egreg categoria_Ing_Egreg;

   public Otros_Ing_Egreg() 
   {
   }

   public String getMmmes() {
		return mes;
	}
	public String getAanio() {
		return anio;
	}
	public void setAanio(String aanio) {
		this.anio = aanio;
	}
    public String getDescripcion() {
        return descripcion;
    }
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    public Date getFecha() {
        return fecha;
    }
    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
    public Float getMonto() {
        return monto;
    }
    public void setMonto(Float monto) {
        this.monto = monto;
    }
    public Categoria_Ing_Egreg getCategoria_Ing_Egreg() {
        return categoria_Ing_Egreg;
    }
    public void setCategoria_Ing_Egreg(Categoria_Ing_Egreg categoria_Ing_Egreg) {
        this.categoria_Ing_Egreg = categoria_Ing_Egreg;
    }
	public Integer getOtros_Ing_Egreg_ID() {
		return otros_Ing_Egreg_ID;
	}
	public void setOtros_Ing_Egreg_ID(Integer otros_Ing_Egreg_ID) {
		this.otros_Ing_Egreg_ID = otros_Ing_Egreg_ID;
	}
	public Boolean getEliminado() {
		return eliminado;
	}
	public void setEliminado(Boolean eliminado) {
		this.eliminado = eliminado;
	}

	public void setMmmes(String messs) {
		// TODO Auto-generated method stub
		
	} 
}
