package Datos;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import Entidades.Usuario;

public class DTUsuario {

	Connection cn = null;
	PreparedStatement ps =null;
	ResultSet rs =null;
	
	public ArrayList<Usuario> usuarios()
	{
		ArrayList<Usuario> listaCategoria = new ArrayList<Usuario>();
		String sql = ("SELECT * from usuario");
		try 
		{
			cn = Conexion.getConnection();
			ps = cn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = ps.executeQuery();
			
			while (rs.next()) 
			{
				Usuario u = new Usuario();
				u.setLogin(rs.getString("login"));
				u.setPass(rs.getString("pass"));
				u.setUsuario_ID(rs.getInt("Usuario_id"));
				listaCategoria.add(u);
				
			}
			ps.close();
			cn.close();
			System.out.println("datos cargados de usuarios");
		} 
		catch (Exception e) 
		{
			System.err.println("METODO CARGAR: "+e.getMessage());
		}
		
		return listaCategoria;
	}
	
	public boolean guardarUsuario(Usuario u)
	{
		try 
		{
			Connection cn = Conexion.getConnection();
			Statement s = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery("SELECT * from usuario;");
			//DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			//Date date = new Date();
			rs.moveToInsertRow();
			rs.updateString("login", u.getLogin());
			rs.updateString("pass", u.getPass());
			//rs.updateString("last_update", fecha.format(date));
			rs.insertRow();
			rs.moveToCurrentRow();
			
			s.close();
			cn.close();
			return true;
		}
		catch (Exception e) 
		{
			System.err.println("ERROR AL GUARDAR: " + e.getMessage());
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean actualizarUsuario(Usuario u){
		try {
			Connection cn = Conexion.getConnection();
			Statement s = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery("SELECT * from usuario;");
			rs.beforeFirst();
			while (rs.next()){
				System.out.println("fila "+rs.getInt("usuario_id"));
				if(rs.getInt("usuario_id") ==u.getUsuario_ID()){
					rs.updateString("login",u.getLogin());
					rs.updateString("pass", u.getPass());
					rs.updateRow();
				}
		
			}
			s.close();
			cn.close();
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	public boolean eliminarUsuario(Usuario u){
		try {
			Connection cn = Conexion.getConnection();
			Statement s = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery("SELECT * from usuario;");
			rs.beforeFirst();
			rs.beforeFirst();
			while (rs.next()){
				System.out.println("fila "+rs.getInt("usuario_id"));
				if(rs.getInt("usuario_id") ==u.getUsuario_ID()){
					rs.deleteRow();
				}
			}
			s.close();
			cn.close();
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	
}
