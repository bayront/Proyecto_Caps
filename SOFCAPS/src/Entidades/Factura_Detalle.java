package Entidades;


public class Factura_Detalle 
{
   private Float consumo;
   private Float monto;
   private Integer factura_Detalle_ID;
   public Factura_Maestra factura_Maestra;
   public Tarifa tarifa;

   public Factura_Detalle() 
   {
   }

    public Float getConsumo() {
        return consumo;
    }
    public void setConsumo(Float consumo) {
        this.consumo = consumo;
    }
    public Float getMonto() {
        return monto;
    }
    public void setMonto(Float monto) {
        this.monto = monto;
    }
    public Factura_Maestra getFactura_Maestra() {
        return factura_Maestra;
    }
    public void setFactura_Maestra(Factura_Maestra factura_Maestra) {
        this.factura_Maestra = factura_Maestra;
    }
    public Tarifa getTarifa() {
        return tarifa;
    }
    public void setTarifa(Tarifa tarifa) {
        this.tarifa = tarifa;
    }
	public Integer getFactura_Detalle_ID() {
		return factura_Detalle_ID;
	}
	public void setFactura_Detalle_ID(Integer factura_Detalle_ID) {
		this.factura_Detalle_ID = factura_Detalle_ID;
	}  
   
}
