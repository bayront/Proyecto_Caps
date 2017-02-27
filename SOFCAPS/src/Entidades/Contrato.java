package Entidades;


import java.util.Date;
import java.util.List;

public class Contrato 
{
   private Boolean estado;
   private Date fechaContrato;
   private Integer numContrato;
   private String numMedidor;
   private Integer usuCrea;
   private Integer usuMod;
   private Integer usuElim;
   private Date fechaCrea;
   private Date fechaMod;
   private Date fechaElim;
   private Integer cuotas;
   private Float montoContrato;
   private Integer contrato_ID;
   private RegimenPropiedad regimenPropiedad;
   private Sector sector;
   private Categoria categoria;
   private List<Factura_Maestra> facturas_Maestras;
   private List<ReciboCaja> recibosCaja;
   

   public Contrato() 
   {
   }

    public Boolean getEstado() {
        return estado;
    }
    public void setEstado(Boolean estado) {
        this.estado = estado;
    }
    public Date getFechaContrato() {
        return fechaContrato;
    }
    public void setFechaContrato(Date fechaContrato) {
        this.fechaContrato = fechaContrato;
    }
    public Integer getNumContrato() {
        return numContrato;
    }
    public void setNumContrato(Integer numContrato) {
        this.numContrato = numContrato;
    }
    public String getNumMedidor() {
        return numMedidor;
    }
    public void setNumMedidor(String numMedidor) {
        this.numMedidor = numMedidor;
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
    public Integer getCuotas() {
        return cuotas;
    }
    public void setCuotas(Integer cuotas) {
        this.cuotas = cuotas;
    }
    public Float getMontoContrato() {
        return montoContrato;
    }
    public void setMontoContrato(Float montoContrato) {
        this.montoContrato = montoContrato;
    }
    public RegimenPropiedad getRegimenPropiedad() {
        return regimenPropiedad;
    }
    public void setRegimenPropiedad(RegimenPropiedad regimenPropiedad) {
        this.regimenPropiedad = regimenPropiedad;
    }
    public Sector getSector() {
        return sector;
    }
    public void setSector(Sector sector) {
        this.sector = sector;
    }
    public Categoria getCategoria() {
        return categoria;
    }
    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }
	public Integer getContrato_ID() {
		return contrato_ID;
	}
	public void setContrato_ID(Integer contrato_ID) {
		this.contrato_ID = contrato_ID;
	}
	public List<Factura_Maestra> getFacturas_Maestras() {
		return facturas_Maestras;
	}
	public void setFacturas_Maestras(List<Factura_Maestra> facturas_Maestras) {
		this.facturas_Maestras = facturas_Maestras;
	}
	public List<ReciboCaja> getRecibosCaja() {
		return recibosCaja;
	}
	public void setRecibosCaja(List<ReciboCaja> recibosCaja) {
		this.recibosCaja = recibosCaja;
	}   
    
}
