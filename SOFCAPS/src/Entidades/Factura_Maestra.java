package Entidades;


import java.util.Date;
import java.util.List;

public class Factura_Maestra 
{
   private Float deslizamiento;
   private Boolean estadoFac;
   private Date fechaFactura;
   private Date fechaVencimiento;
   private String numFact;
   private Integer usuCrea;
   private Integer usuMod;
   private Integer usuElim;
   private Date fechaCrea;
   private Date fechaMod;
   private Date fechaElim;
   private Boolean anulado;
   private Integer factura_Maestra_ID;
   private Contrato contrato;
   private Cliente cliente;
   private Consumo consumo;
   private List<ReciboCaja> recibosCaja;
   private List<Factura_Detalle> facturas_Detalle;
  
   public Factura_Maestra() 
   {
   }

    public Float getDeslizamiento() {
        return deslizamiento;
    }
    public void setDeslizamiento(Float deslizamiento) {
        this.deslizamiento = deslizamiento;
    }
    public Boolean getEstadoFac() {
        return estadoFac;
    }
    public void setEstadoFac(Boolean estadoFac) {
        this.estadoFac = estadoFac;
    }
    public Date getFechaFactura() {
        return fechaFactura;
    }
    public void setFechaFactura(Date fechaFactura) {
        this.fechaFactura = fechaFactura;
    }
    public String getNumFact() {
        return numFact;
    }
    public void setNumFact(String numFact) {
        this.numFact = numFact;
    }
    public Integer getUsuCrea() {
        return usuCrea;
    }
    public void setUsuCrea(Integer usuCrea) {
        this.usuCrea = usuCrea;
    }
    public Integer getUsuMod() {
        return usuMod;
    }
    public void setUsuMod(Integer usuMod) {
        this.usuMod = usuMod;
    }
    public Integer getUsuElim() {
        return usuElim;
    }
    public void setUsuElim(Integer usuElim) {
        this.usuElim = usuElim;
    }
    public Date getFechaCrea() {
        return fechaCrea;
    }
    public void setFechaCrea(Date fechaCrea) {
        this.fechaCrea = fechaCrea;
    }
    public Date getFechaMod() {
        return fechaMod;
    }
    public void setFechaMod(Date fechaMod) {
        this.fechaMod = fechaMod;
    }
    public Date getFechaElim() {
        return fechaElim;
    }
    public void setFechaElim(Date fechaElim) {
        this.fechaElim = fechaElim;
    }
    public Boolean getAnulado() {
        return anulado;
    }
    public void setAnulado(Boolean anulado) {
        this.anulado = anulado;
    }
    public Contrato getContrato() {
        return contrato;
    }
    public void setContrato(Contrato contrato) {
        this.contrato = contrato;
    }
    public Cliente getCliente() {
        return cliente;
    }
    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }
    public Consumo getConsumo() {
        return consumo;
    }
    public void setConsumo(Consumo consumo) {
        this.consumo = consumo;
    }
	public Integer getFactura_Maestra_ID() {
		return factura_Maestra_ID;
	}
	public void setFactura_Maestra_ID(Integer factura_Maestra_ID) {
		this.factura_Maestra_ID = factura_Maestra_ID;
	}
	public List<ReciboCaja> getRecibosCaja() {
		return recibosCaja;
	}
	public void setRecibosCaja(List<ReciboCaja> recibosCaja) {
		this.recibosCaja = recibosCaja;
	}
	public List<Factura_Detalle> getFacturas_Detalle() {
		return facturas_Detalle;
	}
	public void setFacturas_Detalle(List<Factura_Detalle> facturas_Detalle) {
		this.facturas_Detalle = facturas_Detalle;
	}
	public Date getFechaVencimiento() {
		return fechaVencimiento;
	}
	public void setFechaVencimiento(Date fechaVencimiento) {
		this.fechaVencimiento = fechaVencimiento;
	} 
}
