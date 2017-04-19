package Entidades;

public class ReciboCaja_Detalle {
	private int numDocumento;
	private float monto;
	private int reciboCaja_Detalle_ID;
	private ReciboCaja_Maestro reciboCaja_Maestro;
	private Serie serie;
	
	public int getNumDocumento() {
		return numDocumento;
	}
	public void setNumDocumento(int numDocumento) {
		this.numDocumento = numDocumento;
	}
	public float getMonto() {
		return monto;
	}
	public void setMonto(float monto) {
		this.monto = monto;
	}
	public int getReciboCaja_Detalle_ID() {
		return reciboCaja_Detalle_ID;
	}
	public void setReciboCaja_Detalle_ID(int reciboCaja_Detalle_ID) {
		this.reciboCaja_Detalle_ID = reciboCaja_Detalle_ID;
	}
	public ReciboCaja_Maestro getReciboCaja_Maestro() {
		return reciboCaja_Maestro;
	}
	public void setReciboCaja_Maestro(ReciboCaja_Maestro reciboCaja_Maestro) {
		this.reciboCaja_Maestro = reciboCaja_Maestro;
	}
	public Serie getSerie() {
		return serie;
	}
	public void setSerie(Serie serie) {
		this.serie = serie;
	}
}
