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
	
	 public DT_Opcion() {
	 }

	 public static DT_Opcion getInstance() {
	   return dtOp;
	 }
	
	public ResultSet cargarDatos() {
		Statement s;
		String sql = "SELECT * from opcion";
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
	
}
