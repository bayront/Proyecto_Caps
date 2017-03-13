package Datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import Entidades.Rol;
import Entidades.Usuario;

public class DTUsuario {

	private static DTUsuario dtUsu = new DTUsuario();//instancia de la clase
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	private static ResultSet rs;//RESULTSET estatico
	
	private DTUsuario() {
	}
	 
	public static DTUsuario getInstance() {
		return dtUsu;
	}
	
	public ResultSet cargarUsuarios()
	{
		Statement s;
		String sql = ("SELECT * FROM usuario where eliminado=0;");
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
			dtUsu.cargarUsuarios();
			rs.moveToInsertRow();
			rs.updateString("login", u.getLogin());
			rs.updateString("pass", u.getPass());
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
			dtUsu.cargarUsuarios();
			rs.beforeFirst();
			while (rs.next()){
				System.out.println("fila "+rs.getInt("Usuario_ID"));
				if(rs.getInt("Usuario_ID") == u.getUsuario_ID()){
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
			dtUsu.cargarUsuarios();
			rs.beforeFirst();
			while (rs.next()){
				System.out.println("fila "+rs.getInt("Usuario_ID"));
				if(rs.getInt("Usuario_ID") ==u.getUsuario_ID()){
					System.out.println(u.getLogin());
					
					rs.updateInt("Usuario_ID", u.getUsuario_ID());
					rs.updateBoolean("eliminado", false);
					rs.updateString("login", u.getLogin());
					rs.updateString("pass", u.getPass());
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
}
