package Datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import Entidades.Cliente;
import Entidades.TipoCategoria;
import Datos.Conexion;
import Entidades.Categoria_Ing_Egreg;
import Datos.PoolConexion;

public class DT_categoria_Ing_Engre {
	
	//private static DT_categoria_Ing_Engre dtcatIE = new DT_categoria_Ing_Engre(); //Instanciando la Clase 
	private ResultSet rs; //ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	
//	 private DT_categoria_Ing_Engre (){
//	 }

	 /* Static 'instance' method */
//	 public static DT_categoria_Ing_Engre getInstance() 
//	 {
//	   return new DT_categoria_Ing_Engre();
//	 }
	 
	public ResultSet cargarDatos(){
		Statement s;
		String sql = ("SELECT * FROM categoria_ing_egreg WHERE eliminado = 0;");
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		} catch(Exception e){
			e.printStackTrace();
			System.out.println("Error en DT_categoria_Ing_Engreg: "+e.getMessage());
		}
		return rs;
	}
	
	public ResultSet cargarDatosTabla(){
		Statement s;
		String sql = ("SELECT cie.Categoria_Ing_Egreg_ID, cie.nombreCategoria, tc.descripcion, cie.TipoCategoria_ID FROM categoria_ing_egreg cie inner join tipocategoria tc on cie.TipoCategoria_ID = tc.TipoCategoria_ID WHERE cie.eliminado = 0;");
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		} catch(Exception e){
			e.printStackTrace();
			System.out.println("Error en DT_categoria_Ing_Engreg: "+e.getMessage());
		}
		return rs;
	}
	
	public boolean guardarcarIE(Categoria_Ing_Egreg catIE){
		boolean guardado = false;
		try{
			cargarDatos();
			rs.moveToInsertRow();
			rs.updateString("nombreCategoria", catIE.getNombreCategoria());
			rs.updateInt("TipoCategoria_ID", catIE.getTipoCategoria().getTipoCategoria_ID());
			rs.updateBoolean("eliminado", false);
			rs.insertRow();
			rs.moveToCurrentRow();
			guardado = true;
		} catch (Exception e){
			System.err.println("ERROR GUARDAR " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}
	
	public boolean actualizarCatIE(Categoria_Ing_Egreg catIE){
		boolean actualizado = false;
		try {
			cargarDatos();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getInt("Categoria_Ing_Egreg_ID") == catIE.getCategoria_Ing_Egreg_ID()){
					rs.updateInt("Categoria_Ing_Egreg_ID", catIE.getCategoria_Ing_Egreg_ID());
					rs.updateString("nombreCategoria", catIE.getNombreCategoria());
					rs.updateInt("TipoCategoria_ID", catIE.getTipoCategoria().getTipoCategoria_ID());
					rs.updateBoolean("eliminado", false);
					rs.updateRow();
					actualizado = true;
				}
			}
		} catch (Exception e){
			System.err.println("ERROR AL ACTUALIZAR " + e.getMessage());
			e.printStackTrace();
		}
		return actualizado;
	}
	
	public boolean eliminarCatIE(Categoria_Ing_Egreg catIE){
		boolean eliminado = false;
		try{
			cargarDatos();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getInt("Categoria_Ing_Egreg_ID") == catIE.getCategoria_Ing_Egreg_ID()){
					rs.updateBoolean("eliminado", true);
					rs.updateRow();
					eliminado = true;
				}
			}
		} catch (Exception e){
			System.err.println("ERROR AL ELIMINAR " + e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}
	
	public ArrayList<TipoCategoria> listaCategoriaIE(){
		ArrayList<TipoCategoria> listaCatIE = new ArrayList<TipoCategoria>();
		String sql = ("SELECT * FROM sofcaps.tipocategoria;");
		
		try{
			Connection cn;
			cn = Conexion.getConnection();
			PreparedStatement ps = cn.prepareStatement(sql);
			ResultSet rs= ps.executeQuery();
			
			while(rs.next()){
				TipoCategoria catIE = new TipoCategoria();
				catIE.setDescripcion(rs.getString("descripcion"));
				catIE.setTipoCategoria_ID(rs.getInt("TipoCategoria_ID"));
				listaCatIE.add(catIE);
			}
			ps.close();
			cn.close();
		} catch (Exception e) {
			System.err.println("DATOS: ERROR " +e.getMessage());
		}
		return listaCatIE;
	}
	
}