package Datos;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

//import entidades.Actor;
//import datos.PoolConexion;

public class DT_Actor 
{
		private static DT_Actor dtact = new DT_Actor(); //Instanciando la Clase 
		private static ResultSet rs; //ResultSet Global
		PoolConexion pc = PoolConexion.getInstance(); //
		Connection con = PoolConexion.getConnection();
		
		 private DT_Actor() 
		 { 
			 
		 }

		 /* Static 'instance' method */
		 public static DT_Actor getInstance() 
		 {
		   return dtact;
		 }
		 
		public ResultSet cargarDatos()
		{
			Statement s;
			String sql = ("SELECT * From SOFCAPS.CLASE;");
			try
			{
				s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				rs = s.executeQuery(sql);
			}
			catch(Exception e)
			{
				e.printStackTrace();
				System.out.println("Error en DT_Actor: "+e.getMessage());
			}
			return rs;
		}
		
//		public boolean guardarActor(Actor a)
//		{
//			boolean guardado = false;
//			try 
//			{
//				Date date = new Date();
//				DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
//				dtact.cargarDatos();
//				rs.moveToInsertRow();
//				rs.updateString("first_name", a.getFirst_name());
//				rs.updateString("last_name", a.getLast_name());
//				rs.updateString("last_update", fecha.format(date));
//				rs.insertRow();
//				rs.moveToCurrentRow();
//				guardado = true;
//			}
//			catch (Exception e) 
//			{
//				System.err.println("ERROR GUARDAR " + e.getMessage());
//				e.printStackTrace();
//			}
//			return guardado;
//		}

}
