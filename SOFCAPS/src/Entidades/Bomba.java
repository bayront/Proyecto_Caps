package Entidades;

/*Entidad bomba*/
import java.util.Date;

public class Bomba 
{
   private Float consumoActual;
   private Date fechaLecturaActual;
   private Float lecturaActual;
   private String observaciones;
   private Boolean estado;
   private String horaInicio;
   private String horaFin;
   private Float watts;
   private Integer bomba_ID;
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
    public String getObservaciones() {
        return observaciones;
    }
    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }
    public Unidad_de_Medida getUnidad_de_Medida() {
        return unidad_de_Medida;
    }
    public void setUnidad_de_Medida(Unidad_de_Medida unidad_de_Medida) {
        this.unidad_de_Medida = unidad_de_Medida;
    }
	public Integer getBomba_ID() {
		return bomba_ID;
	}
	public void setBomba_ID(Integer bomba_ID) {
		this.bomba_ID = bomba_ID;
	}
	public Boolean getEstado() {
		return estado;
	}
	public void setEstado(Boolean estado) {
		this.estado = estado;
	}
	public String getHoraInicio() {
		return horaInicio;
	}
	public void setHoraInicio(String horaInicio) {
		this.horaInicio = horaInicio;
	}
	public String getHoraFin() {
		return horaFin;
	}
	public void setHoraFin(String horaFin) {
		this.horaFin = horaFin;
	}
	public Float getWatts() {
		return watts;
	}
	public void setWatts(Float watts) {
		this.watts = watts;
	}
	
}
