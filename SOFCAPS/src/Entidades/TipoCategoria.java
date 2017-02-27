package Entidades;


public class TipoCategoria 
{
   private String descripcion;
   private Integer tipoCategoria_ID;

   public TipoCategoria() 
   {
   }

    public String getDescripcion() {
        return descripcion;
    }
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
	public Integer getTipoCategoria_ID() {
		return tipoCategoria_ID;
	}
	public void setTipoCategoria_ID(Integer tipoCategoria_ID) {
		this.tipoCategoria_ID = tipoCategoria_ID;
	}
    
}
