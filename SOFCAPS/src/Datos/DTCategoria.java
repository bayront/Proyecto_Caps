package Datos;

import java.sql.*;
import java.util.ArrayList;

import Entidades.Categoria;



public class DTCategoria {
//	private static DTCategoria dtal = new DTCategoria(); //Instanciando la Clase 
	private  ResultSet rs; //ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection cn = PoolConexion.getConnection();
	/* Static 'instance' method */
//	 public static DTCategoria getInstance() {
//	   return dtal;
//	 }
	 
	public ResultSet Categorias() {
		Statement s;
		String sql = ("SELECT * from categoria where eliminado=0;");
		try{
			s = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		} catch (Exception e) {
			System.err.println("DATOS: ERROR "+e.getMessage());
			e.printStackTrace();
		}
		return rs;
	}
	
	public boolean guardarCategoria(Categoria a){	
		boolean g = false;
		try{
			Categorias();
			rs.moveToInsertRow();
			rs.updateString("nomCategoria", a.getNomCategoria());
			if(a.getDescripcion().isEmpty() || a.getDescripcion() == null) {
				rs.updateNull("descripcion");
			}else {
				rs.updateString("descripcion", a.getDescripcion());
			}
			rs.updateBoolean("eliminado", false);
			rs.insertRow();
			rs.moveToCurrentRow();
			g = true;
		}catch (Exception e){
			System.err.println("ERROR GUARDAR " + e.getMessage());
			e.printStackTrace();
		}
		return g;
	}
	
	public boolean eliminarCategoria(Categoria u){
		try {
			Categorias();
			rs.beforeFirst();
			rs.beforeFirst();
			while (rs.next()){
				System.out.println("fila "+rs.getInt("categoria_ID"));
				if(rs.getInt("categoria_ID") ==u.getCategoria_ID()){
					rs.updateBoolean("eliminado", true);
					rs.updateRow();
					System.out.println("eliminado");
				}
			}
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean actualizarCategoria(Categoria u){
		try {
			Categorias();
			rs.beforeFirst();
			while (rs.next()){
				if(rs.getInt("categoria_ID") ==u.getCategoria_ID()){
					System.out.println("actualizar: " + u.getNomCategoria());
					rs.updateInt("categoria_ID", u.getCategoria_ID());
					rs.updateString("nomCategoria",u.getNomCategoria());
					rs.updateBoolean("eliminado", false); 
					if(u.getDescripcion().isEmpty() || u.getDescripcion() == null) { 
						rs.updateNull("descripcion");
					}else { 
						rs.updateString("descripcion", u.getDescripcion());
					}
					rs.updateRow();
				}
			}
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			return false;
		}
	}
}