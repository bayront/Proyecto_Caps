package Entidades;


import java.util.Date;
import java.util.List;

public class ReciboCaja
{
   private String descripcion;
   private Boolean estado;
   private String numReciboCaja;
   private Date fecha;
   private Float montoTotal;
   private int numDocumento;
   private Integer usuaCrea;
   private Integer usuaMod;
   private Integer usuaElim;
   private Date fechaCrea;
   private Date fechaMod;
   private Date fechaElim;
   private Integer reciboCaja_ID;
   private Cliente cliente;
   private Serie serie;
   public Reconexion reconexion;
   public Factura_Maestra factura_Maestra;
   public Contrato contrato;

   public ReciboCaja() 
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
	public Integer getReciboCaja_ID() {
		return reciboCaja_ID;
	}
	public void setReciboCaja_ID(Integer reciboCaja_ID) {
		this.reciboCaja_ID = reciboCaja_ID;
	}
	public int getNumDocumento() {
		return numDocumento;
	}
	public void setNumDocumento(int numDocumento) {
		this.numDocumento = numDocumento;
	}
	public Serie getSerie() {
		return serie;
	}
	public void setSerie(Serie serie) {
		this.serie = serie;
	}
}
