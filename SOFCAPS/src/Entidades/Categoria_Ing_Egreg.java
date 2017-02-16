package Entidades;


public class Categoria_Ing_Egreg 
{
   private String nombreCategoria;
   public TipoCategoria tipoCategoria;

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
   
}
