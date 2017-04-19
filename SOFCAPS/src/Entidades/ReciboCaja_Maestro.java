package Entidades;


import java.util.Date;

public class ReciboCaja_Maestro
{
   private String descripcion;
   private Boolean estado;
   private String numReciboCaja;
   private Date fecha;
   private Float montoTotal;
   private Integer usuaCrea;
   private Integer usuaMod;
   private Integer usuaElim;
   private Date fechaCrea;
   private Date fechaMod;
   private Date fechaElim;
   private Integer reciboCaja_Maestro_ID;
   private Cliente cliente;

   public ReciboCaja_Maestro() 
   {
   }

    public String getDescripcion() {
        return descripcion;
    }
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    public Boolean getEstado() {
        return estado;
    }
    public void setEstado(Boolean estado) {
        this.estado = estado;
    }
    public Date getFecha() {
        return fecha;
    }
    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
    public Float getMontoTotal() {
        return montoTotal;
    }
    public void setMontoTotal(Float montoTotal) {
        this.montoTotal = montoTotal;
    }
    public String getNumReciboCaja() {
		return numReciboCaja;
	}
	public void setNumReciboCaja(String numReciboCaja) {
		this.numReciboCaja = numReciboCaja;
	}
	public Integer getUsuaCrea() {
        return usuaCrea;
    }
    public void setUsuaCrea(Integer usuaCrea) {
        this.usuaCrea = usuaCrea;
    }
    public Integer getUsuaMod() {
        return usuaMod;
    }
    public void setUsuaMod(Integer usuaMod) {
        this.usuaMod = usuaMod;
    }
    public Integer getUsuaElim() {
        return usuaElim;
    }
    public void setUsuaElim(Integer usuaElim) {
        this.usuaElim = usuaElim;
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
    public Cliente getCliente() {
        return cliente;
    }
    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }
	public Integer getReciboCaja_Maestro_ID() {
		return reciboCaja_Maestro_ID;
	}
	public void setReciboCaja_Maestro_ID(Integer reciboCaja_Maestro_ID) {
		this.reciboCaja_Maestro_ID = reciboCaja_Maestro_ID;
	}
	
}
