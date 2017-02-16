package Entidades;


import java.util.Date;

public class Reconexion 
{
   private Date fecha_reconexion;
   private Float monto;
   private Date f_cancel;
   public Factura_Maestra factura_Maestra;
   public Cliente cliente;
   private ReciboCaja reciboCaja;
   public Reconexion() 
   {
   }

    public Date getFecha_reconexion() {
        return fecha_reconexion;
    }
    public void setFecha_reconexion(Date fecha_reconexion) {
        this.fecha_reconexion = fecha_reconexion;
    }
    public Float getMonto() {
        return monto;
    }
    public void setMonto(Float monto) {
        this.monto = monto;
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
   
}
