package Entidades;

public class Usuario_Rol {
	private Integer rol_id;
	private Integer usuario_id;
	private Usuario usuario;
	private Rol rol;
	
	public Integer getRol_id() {
		return rol_id;
	}
	public void setRol_id(Integer rol_id) {
		this.rol_id = rol_id;
	}
	public Integer getUsuario_id() {
		return usuario_id;
	}
	public void setUsuario_id(Integer usuario_id) {
		this.usuario_id = usuario_id;
	}
	public Usuario getUsuario() {
		return usuario;
	}
	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}
	public Rol getRol() {
		return rol;
	}
	public void setRol(Rol rol) {
		this.rol = rol;
	}
}
