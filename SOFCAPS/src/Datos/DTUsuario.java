package Datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import Entidades.Cliente;
import Entidades.Rol;
import Entidades.Usuario;

public class DTUsuario {

	//private static DTUsuario dtUsu = new DTUsuario();//instancia de la clase
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	private  ResultSet rs;//RESULTSET estatico
	
	//private DTUsuario() {
	//}
	 
	//public static DTUsuario getInstance() {
	//	return dtUsu;
	//}
	
	public ResultSet cargarUsuarios()
	{
		Statement s;
		String sql = ("SELECT * FROM usuario where eliminado=false;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("datos de usuarios cargados");
		} 
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DTUsuario, metodo cargarUsuarios: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de Usuario vacio");
		
		return rs;
	}
	
	public ResultSet cargarUsuariosInactivos()
	{
		Statement s;
		String sql = ("SELECT * FROM usuario where eliminado=true;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("datos de usuarios cargados");
		} 
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DTUsuario, metodo cargarUsuarios: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de Usuario vacio");
		
		return rs;
	}

	public boolean guardarUsuario(Usuario u){
		boolean guardado = false;
		try 
		{
			cargarUsuarios();
			rs.moveToInsertRow();
			rs.updateString("login", u.getLogin());
			rs.updateString("pass", u.getPass());
			rs.updateString("nombre_usuario", u.getNombre_usuario());
			rs.updateBoolean("eliminado", false);
			rs.insertRow();
			rs.moveToCurrentRow();
			guardado = true;
		}
		catch (Exception e) 
		{
			System.err.println("ERROR GUARDAR " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}
	
	public boolean eliminarUsuario(Usuario u){
		boolean guardado = false;
		try 
		{
			cargarUsuarios();
			rs.beforeFirst();
			while (rs.next()){
				System.out.println("fila "+rs.getInt("usuario_id"));
				if(rs.getInt("usuario_id") == u.getUsuario_ID()){
					rs.updateBoolean("eliminado", true);
					rs.updateRow();
					guardado  = true;
				}
			}
		}
		catch (Exception e) 
		{
			System.err.println("ERROR ELIMINAR en Usuario: " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}

	public boolean actualizarUsuario(Usuario u){
		try {
			cargarUsuarios();
			rs.beforeFirst();
			while (rs.next()){
				System.out.println("fila "+rs.getInt("Usuario_ID"));
				if(rs.getInt("Usuario_ID") == u.getUsuario_ID()){
					rs.updateBoolean("eliminado", u.getEliminado());
					rs.updateString("login", u.getLogin());
					rs.updateString("pass", u.getPass());
					rs.updateString("nombre_usuario", u.getNombre_usuario());
					rs.updateRow();
				}
			}
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	public boolean activarUsuario(Usuario u){
		boolean guardado = false;
		try 
		{
			cargarUsuariosInactivos();
			rs.beforeFirst();
			while (rs.next()){
				System.out.println("fila "+rs.getInt("usuario_id"));
				if(rs.getInt("usuario_id") ==u.getUsuario_ID()){
					rs.updateBoolean("eliminado", false);
					rs.updateRow();
					guardado  = true;
				}
			}
		}
		catch (Exception e) 
		{
			System.err.println("ERROR ELIMINAR en Usuario: " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}
	
	public Usuario verificarUser(Usuario us){
		PreparedStatement s;
		String sql = ("SELECT * From usuario where login = ? and pass = ? and eliminado = 0;");
		try{
			s = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			s.setString(1, us.getLogin());
			s.setString(2, us.getPass());
			rs = s.executeQuery();
			if(rs.next()){
				us.setUsuario_ID(rs.getInt("Usuario_ID"));
				us.setLogin(rs.getString("login"));
				us.setPass(rs.getString("pass"));
				us.setNombre_usuario(rs.getString("nombre_usuario"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("Error en Dt_Usuario: "+e.getMessage());
		}
		
		return us;
	}
	
}
