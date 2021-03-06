package Entidades;


import java.util.List;


public class Opcion 
{
   private String descripcion;
   private String opcion;
   private Boolean eliminado;
   private Integer opcion_ID;
   private List<Rol> roles;

   public Opcion() 
   {  
   }

    public String getDescripcion() {
        return descripcion;
    }
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    public String getOpcion() {
        return opcion;
    }
    public void setOpcion(String opcion) {
        this.opcion = opcion;
    }
	public Integer getOpcion_ID() {
		return opcion_ID;
	}
	public void setOpcion_ID(Integer opcion_ID) {
		this.opcion_ID = opcion_ID;
	}
	public List<Rol> getRoles() {
		return roles;
	}
	public void setRoles(List<Rol> roles) {
		this.roles = roles;
	}
	public Boolean getEliminado() {
		return eliminado;
	}
	public void setEliminado(Boolean eliminado) {
		this.eliminado = eliminado;
	}
}
