package Entidades;


import java.util.List;


public class Rol 
{
   private String nomRol;
   private Integer rol_ID;
   private List<Opcion> opciones;
   private List<Usuario> usuarios;
   
   public Rol() 
   {
   }

    public String getNomRol() {
        return nomRol;
    }
    public void setNomRol(String nomRol) {
        this.nomRol = nomRol;
    }
	public Integer getRol_ID() {
		return rol_ID;
	}
	public void setRol_ID(Integer rol_ID) {
		this.rol_ID = rol_ID;
	}
	public List<Opcion> getOpciones() {
		return opciones;
	}
	public void setOpciones(List<Opcion> opciones) {
		this.opciones = opciones;
	}
	public List<Usuario> getUsuarios() {
		return usuarios;
	}
	public void setUsuarios(List<Usuario> usuarios) {
		this.usuarios = usuarios;
	}  
    
}
