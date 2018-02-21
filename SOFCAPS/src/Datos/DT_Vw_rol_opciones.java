package Datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import Entidades.Rol;

public class DT_Vw_rol_opciones {
//	private static DT_Vw_rol_opciones dtvro = new DT_Vw_rol_opciones(); //Instanciando la Clase 
	private  ResultSet rs; //ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	
//	private DT_Vw_rol_opciones() 
//	{ 
//		 
//	}
//	
//	/* Static 'instance' method */
//	public static DT_Vw_rol_opciones getInstance() 
//	{
//	   return dtvro;
//	}
	
	public ResultSet cargarDatos()
	{
		Statement s;
		String sql = ("SELECT * FROM vw_rol_opciones;");
		try
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = s.executeQuery(sql);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Error en Dt_Vw_rol_opciones: "+e.getMessage());
		}
		return rs;
	}
	
	public ResultSet obtenerOpc(Rol r)
	{
		Statement s;
		String sql = ("SELECT * FROM vw_rol_opciones where Rol_ID ="+r.getRol_ID()+";");
		try
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = s.executeQuery(sql);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Error en Dt_Vw_rol_opciones: "+e.getMessage());
		}
		return rs;
	}
	
}
