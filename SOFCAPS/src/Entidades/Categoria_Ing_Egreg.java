package Entidades;


public class Categoria_Ing_Egreg 
{
   private String nombreCategoria;
   private Integer categoria_Ing_Egreg_ID;
   private TipoCategoria tipoCategoria;

   public Categoria_Ing_Egreg() 
   {
   }

    public String getNombreCategoria() {
        return nombreCategoria;
    }
    public void setNombreCategoria(String nombreCategoria) {
        this.nombreCategoria = nombreCategoria;
    }
    public TipoCategoria getTipoCategoria() {
        return tipoCategoria;
    }
    public void setTipoCategoria(TipoCategoria tipoCategoria) {
        this.tipoCategoria = tipoCategoria;
    }
	public Integer getCategoria_Ing_Egreg_ID() {
		return categoria_Ing_Egreg_ID;
	}
	public void setCategoria_Ing_Egreg_ID(Integer categoria_Ing_Egreg_ID) {
		this.categoria_Ing_Egreg_ID = categoria_Ing_Egreg_ID;
	} 
   
}
