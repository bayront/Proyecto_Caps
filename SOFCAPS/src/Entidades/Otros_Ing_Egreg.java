package Entidades;


import java.util.Date;

public class Otros_Ing_Egreg 
{
   private String descripcion;
   private Date fecha;
   private Float monto;
   public Categoria_Ing_Egreg categoria_Ing_Egreg;

   public Otros_Ing_Egreg() 
   {
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
   
}
