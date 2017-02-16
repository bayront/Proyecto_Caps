package Entidades;

/*Entidad bomba*/
import java.util.Date;

public class Bomba 
{
   private Float consumoActual;
   private Date fechaLecturaActual;
   private Float lecturaActual;
   private Float lecturaAnterior;
   private String observaciones;
   private Integer usuCrea;
   private Integer usuMod;
   private Integer usuElim;
   private Date fechaCrea;
   private Date fechaMod;
   private Date fechaElim;
   public Unidad_de_Medida unidad_de_Medida;

   public Bomba() 
   {  
   }

    public Float getConsumoActual() {
        return consumoActual;
    }
    public void setConsumoActual(Float consumoActual) {
        this.consumoActual = consumoActual;
    }
    public Date getFechaLecturaActual() {
        return fechaLecturaActual;
    }
    public void setFechaLecturaActual(Date fechaLecturaActual) {
        this.fechaLecturaActual = fechaLecturaActual;
    }
    public Float getLecturaActual() {
        return lecturaActual;
    }
    public void setLecturaActual(Float lecturaActual) {
        this.lecturaActual = lecturaActual;
    }
    public Float getLecturaAnterior() {
        return lecturaAnterior;
    }
    public void setLecturaAnterior(Float lecturaAnterior) {
        this.lecturaAnterior = lecturaAnterior;
    }
    public String getObservaciones() {
        return observaciones;
    }
    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
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
    public Unidad_de_Medida getUnidad_de_Medida() {
        return unidad_de_Medida;
    }
    public void setUnidad_de_Medida(Unidad_de_Medida unidad_de_Medida) {
        this.unidad_de_Medida = unidad_de_Medida;
    }  
   
}
