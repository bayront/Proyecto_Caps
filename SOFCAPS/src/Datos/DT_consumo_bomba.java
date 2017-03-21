package Datos;

import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.text.DateFormat;

import Entidades.Bomba;

public class DT_consumo_bomba {
	
	private static DT_consumo_bomba dtconsB = new DT_consumo_bomba(); //Instanciando la Clase 
	private static ResultSet rs; //ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	PreparedStatement ps =null;
	
	DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd");
	
	private DT_consumo_bomba ()
	 { 
		 
	 }
	
	public static DT_consumo_bomba getInstance() 
	 {
	   return dtconsB;
	 }

	
	public float traer_Lectura(){
		String sql =("SELECT * from bomba where estado = 0;");
		float lectura = 0;
		
		try{
			con = Conexion.getConnection();
			ps = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = ps.executeQuery();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.isLast()){
					lectura = (rs.getFloat("lecturaActual"));
					System.out.println(lectura);
				}
			}
			
		}
		catch (Exception e) 
		{
			
		}
		return lectura;
	}
	
	public float traer_LecturaParaActualizar(int id){
		String sql =("SELECT * from bomba WHERE estado = 0");
		float lectura = 0;
		try {
			con = Conexion.getConnection();
			ps = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = ps.executeQuery();
			while(rs.next()){
				if(rs.getInt("Bomba_ID") == id){
					if(rs.previous()){
						lectura = (rs.getFloat("lecturaActual"));
						System.out.println("lectura anterior a posicion actual =" + lectura);
						break;
					}
				}
					
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return lectura;
	}
		
		
	
	
	public float calcularConsumo(float lect){
		
		float lectAnt = traer_Lectura();
		float con = 0;
		
		con = lect - lectAnt;
		System.out.println(con);
		
		return con;
	}
	
	public float calcularConsumoBActualizar(float lecturaActual, int id){
		float conAct = 0;
		float lecturaParaActualizar = traer_LecturaParaActualizar(id);
		
		conAct = lecturaActual - lecturaParaActualizar;
		System.out.println("consumo del actualizar: " + conAct);
		
		return conAct;
	}
	
	public ResultSet cargarDatos()
	{
		Statement s;
		String sql = ("SELECT * FROM bomba WHERE estado = 0;");
		try
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Error en DT_consumo_bomba: "+e.getMessage());
		}
		return rs;
	}
	
	
	public boolean guardarRegBomba(Bomba b)
	{
	boolean guardado = false;
	try 
	{
		dtconsB.cargarDatos();
		rs.moveToInsertRow();
		rs.updateFloat("consumoActual", b.getConsumoActual());
		rs.updateString("fechaLecturaActual", fecha.format(b.getFechaLecturaActual()));
		rs.updateFloat("lecturaActual", b.getLecturaActual());
		rs.updateString("observaciones", b.getObservaciones());
		rs.updateBoolean("estado", false);
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
//	public ArrayList<Bomba> bomba()
//	{
//		ArrayList<Bomba> listaBomba = new ArrayList<Bomba>();
//		String sql = ("SELECT * from Bomba");
//		try 
//		{
//			con = Conexion.getConnection();
//			ps = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
//			rs = ps.executeQuery();
//			
//			while (rs.next()) 
//			{
//				Bomba b = new Bomba();
//				b.setConsumoActual(rs.getFloat("consumoActual"));
//				b.setFechaLecturaActual(rs.getDate("fechaLecturaActual"));
//				b.setLecturaActual(rs.getFloat("lectuaActual"));
//				b.setObservaciones(rs.getString("observaciones"));
//				listaBomba.add(b);
//				
//			}
//			ps.close();
//			con.close();
//			System.out.println("datos cargados de usuarios");
//		} 
//		catch (Exception e) 
//		{
//			System.err.println("METODO CARGAR: "+e.getMessage());
//		}
//		
//		return listaBomba;
//	}
	

	
//	public boolean guardarRegBomba(Bomba b)
//	{
//		calcularConsumo(b.getLecturaActual());
//		System.out.println(b.getConsumoActual());
//		try 
//		{
//			Connection cn = Conexion.getConnection();
//			Statement s = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
//			rs = s.executeQuery("SELECT * from Bomba;");
//			rs.moveToInsertRow();
//			rs.updateFloat("consumoActual", b.getConsumoActual());
//			rs.updateString("fechaLecturaActual", fecha.format(b.getFechaLecturaActual()));
//			rs.updateFloat("lecturaActual", b.getLecturaActual());
//			rs.updateString("observaciones", b.getObservaciones());
//			rs.insertRow();
//			rs.moveToCurrentRow();
//			s.close();
//			cn.close();
//			return true;
//		}
//		catch (Exception e) 
//		{
//			System.err.println("ERROR AL GUARDAR: " + e.getMessage());
//			e.printStackTrace();
//			return false;
//		}
//	}
	
	public boolean actualizarBomba(Bomba b){
		boolean actualizado = false;
		try 
		{
			dtconsB.cargarDatos();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getInt("Bomba_ID") == b.getBomba_ID()){
					rs.updateInt("Bomba_ID", b.getBomba_ID());
					rs.updateFloat("consumoActual", b.getConsumoActual());
					rs.updateString("fechaLecturaActual", fecha.format(b.getFechaLecturaActual()));
					rs.updateFloat("lecturaActual", b.getLecturaActual());
					rs.updateString("observaciones", b.getObservaciones());
					rs.updateBoolean("estado", false);
					rs.updateRow();
					actualizado = true;
				}
			}
		}
			catch (Exception e) 
			{
				System.err.println("ERROR AL ACTUALIZAR " + e.getMessage());
				e.printStackTrace();
			}
			return actualizado;
	}
	
	public boolean eliminarRegBomba(Bomba b){
		boolean eliminado = false;
		try 
		{
			dtconsB.cargarDatos();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getInt("Bomba_ID") == b.getBomba_ID()){
					rs.updateBoolean("estado", true);
					rs.updateRow();
					eliminado = true;
				}
			}
		
		}
		catch (Exception e) 
		{
			System.err.println("ERROR AL ELIMINAR " + e.getMessage());
			e.printStackTrace();
		}
		return eliminado;

	}
	
}



