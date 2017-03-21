package Datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.mysql.jdbc.PreparedStatement;

import Datos.DT_Opcion;
import Datos.PoolConexion;
import Entidades.Opcion;
import Entidades.Rol;

public class DT_Opcion {
	
	private static DT_Opcion dtOp = new DT_Opcion(); //Instanciando la Clase 
	private static ResultSet rs; //ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	
	 public DT_Opcion() 
	 {
		 
	 }

	 public static DT_Opcion getInstance() 
	 {
	   return dtOp;
	 }
	 
	public ResultSet cargarDatos(int rol_ID)
	{
		java.sql.PreparedStatement ps;
		String sql = "SELECT o.opcion, ro.Rol_ID, ro.Opcion_ID FROM opcion o INNER JOIN rol_opcion ro ON "+
				"o.Opcion_ID = ro.Opcion_ID WHERE ro.Rol_ID=?";
		try
		{
			ps = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			ps.setInt(1, rol_ID);
			rs = ps.executeQuery();
			System.out.println("datos de opcion cargados");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Error en DT_Opcion: "+e.getMessage());
		}
		return rs;
	}
	
	public ResultSet cargarDatos2() {
		// TODO Auto-generated method stub
		Statement s;
		String sql = "SELECT * from opcion where eliminado = 0;";
		try
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("datos de opcion cargados");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Error en DT_Opcion: "+e.getMessage());
		}
		return rs;
	}
	
	public boolean guardarOpcion(Opcion o)
	{
		boolean guardado = false;
		try 
		{
//			dtOp.cargarDatos();
			rs.moveToInsertRow();
			rs.updateString("descripcion", o.getDescripcion());
			rs.updateString("opcion", o.getOpcion());
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
	
	public boolean actualizarOpcion(Opcion o){
		try {
//			dtOp.cargarDatos();
			rs.beforeFirst();
			rs.beforeFirst();
			while (rs.next()){
				System.out.println("fila "+rs.getInt("Opcion_ID"));
				if(rs.getInt("Opcion_ID") ==o.getOpcion_ID()){
					rs.updateString("descripcion", o.getDescripcion());
					rs.updateString("opcion", o.getOpcion());
					rs.updateInt("Opcion_ID", o.getOpcion_ID());
					rs.updateBoolean("eliminado", false);
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
	
	public boolean eliminarOpcion(Opcion o)
	{
		boolean guardado = false;
		try 
		{
//			dtOp.cargarDatos();
			rs.beforeFirst();
			rs.beforeFirst();
			while (rs.next()){
				System.out.println("fila "+rs.getInt("Opcion_ID"));
				if(rs.getInt("Opcion_ID") == o.getOpcion_ID()){
					rs.updateBoolean("eliminado", true);
					rs.updateRow();
					guardado  = true;
				}
			}
		}
		catch (Exception e) 
		{
			System.err.println("ERROR ELIMINAR en opcion: " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}
}
