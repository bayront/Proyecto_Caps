package Entidades;


import java.util.Date;

public class Reconexion 
{
   private Date fecha_reconexion;
   private Date f_cancel;
   private Boolean cancelado;
   private Integer reconexion_ID;
   private Factura_Maestra factura_Maestra;
   private Cliente cliente;
   private ReciboCaja_Maestro reciboCaja;
   public Reconexion() 
   {
   }

    public Date getFecha_reconexion() {
        return fecha_reconexion;
    }
    public void setFecha_reconexion(Date fecha_reconexion) {
        this.fecha_reconexion = fecha_reconexion;
    }
    public Date getF_cancel() {
        return f_cancel;
    }
    public void setF_cancel(Date f_cancel) {
        this.f_cancel = f_cancel;
    }
    public Factura_Maestra getFactura_Maestra() {
        return factura_Maestra;
    }
    public void setFactura_Maestra(Factura_Maestra factura_Maestra) {
        this.factura_Maestra = factura_Maestra;
    }
    public Cliente getCliente() {
        return cliente;
    }
    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }
	public Boolean getCancelado() {
		return cancelado;
	}
	public void setCancelado(Boolean cancelado) {
		this.cancelado = cancelado;
	}
	public Integer getReconexion_ID() {
		return reconexion_ID;
	}
	public void setReconexion_ID(Integer reconexion_ID) {
		this.reconexion_ID = reconexion_ID;
	}
	public ReciboCaja_Maestro getReciboCaja() {
		return reciboCaja;
	}
	public void setReciboCaja(ReciboCaja_Maestro reciboCaja) {
		this.reciboCaja = reciboCaja;
	}
    
}
