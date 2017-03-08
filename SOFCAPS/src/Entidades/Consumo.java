package Entidades;


import java.util.Date;

public class Consumo 
{
   private Date fecha_fin;
   private Float consumoTotal;
   private Float lectura_Actual;
   private Boolean actual;
   private Boolean eliminado; 
   private Integer consumo_ID;
   private Cliente cliente;
   private Contrato contrato;
   
   public Consumo() 
   {    
   }

    public Consumo(Date fecha_fin, Float consumoTotal, Float lectura_Actual,
		Integer consumo_ID, Cliente cliente, Contrato contrato) {
    	super();
    	this.fecha_fin = fecha_fin;
    	this.consumoTotal = consumoTotal;
    	this.lectura_Actual = lectura_Actual;
    	this.consumo_ID = consumo_ID;
    	this.cliente = cliente;
    	this.contrato = contrato;
    }
    
	public Date getFecha_fin() {
        return fecha_fin;
    }
    public void setFecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }
    public Float getConsumoTotal() {
        return consumoTotal;
    }
    public void setConsumoTotal(Float consumoTotal) {
        this.consumoTotal = consumoTotal;
    }
    public Float getLectura_Actual() {
        return lectura_Actual;
    }
    public void setLectura_Actual(Float lectura_Actual) {
        this.lectura_Actual = lectura_Actual;
    }
    public Cliente getCliente() {
        return cliente;
    }
    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }
	public Integer getConsumo_ID() {
		return consumo_ID;
	}
	public void setConsumo_ID(Integer consumo_ID) {
		this.consumo_ID = consumo_ID;
	}
	public Contrato getContrato() {
		return contrato;
	}
	public void setContrato(Contrato contrato) {
		this.contrato = contrato;
	}
	public Boolean getActual() {
		return actual;
	}
	public void setActual(Boolean actual) {
		this.actual = actual;
	}
	public Boolean getEliminado() {
		return eliminado;
	}
	public void setEliminado(Boolean eliminado) {
		this.eliminado = eliminado;
	} 
}
