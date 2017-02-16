package Entidades;


import java.util.Date;

public class Consumo 
{
   private Date fecha_inicio;
   private Date fecha_fin;
   private Float consumoTotal;
   private Float lectura_Actual;
   private Float lectura_Anterior;
   public Cliente cliente;
   
   public Consumo() 
   {    
   }

    public Date getFecha_inicio() {
        return fecha_inicio;
    }
    public void setFecha_inicio(Date fecha_inicio) {
        this.fecha_inicio = fecha_inicio;
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
    public Float getLectura_Anterior() {
        return lectura_Anterior;
    }
    public void setLectura_Anterior(Float lectura_Anterior) {
        this.lectura_Anterior = lectura_Anterior;
    }
    public Cliente getCliente() {
        return cliente;
    }
    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }  
   
}
