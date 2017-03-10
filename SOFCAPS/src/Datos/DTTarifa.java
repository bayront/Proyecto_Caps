package Datos;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import Entidades.Opcion;
import Entidades.Rol;
import Entidades.Tarifa;

public class DTTarifa {
	private static DTTarifa dttari = new DTTarifa();
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	private static ResultSet rs;//RESULTSET estatico
	
	private DTTarifa(){
		 
		
	 }
	
	 public static DTTarifa getInstance() {
			return dttari;
		}
	
	
	
	 public ResultSet cargartarifa()
		{
			Statement s;
			String sql = ("SELECT * FROM sofcaps.tarifa where estado = 0;");
			try 
			{
				s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				rs = s.executeQuery(sql);
				System.out.println("datos de tarifas cargados");
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
				System.out.println("Error en DTTarifa, metodo cargartarifas: "+e.getMessage());
			}
			if(rs == null)
				System.out.println("Resultset de tarifa vacio");
			
			return rs;
		}
	
	 public boolean guardarTarifa(Tarifa t)
		{
			boolean guardado = false;
			try 
			{
//				Date date = new Date();
//				DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
				dttari.cargartarifa();
				rs.moveToInsertRow();
				rs.updateInt("lim_Inf", t.getLim_Inf());
				rs.updateInt("lim_Sup", t.getLim_Sup());
				rs.updateFloat("monto", t.getMonto());
				rs.updateBoolean("estado", false);
				//rs.updateOpcion("opciones", r.getOpciones());
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
	 
	 
	 
	 public boolean eliminarTarifa(Tarifa t)
		{
			boolean guardado = false;
			try 
			{
				dttari.cargartarifa();
				rs.beforeFirst();
				rs.beforeFirst();
				while (rs.next()){
					System.out.println("fila "+rs.getInt("Tarifa_ID"));
					if(rs.getInt("Tarifa_ID") == t.getTarifa_ID()){
						rs.updateBoolean("estado", true);
						rs.updateRow();
						System.out.println("tarifa eliminada");
						guardado  = true;
					}
				}
			}
			catch (Exception e) 
			{
				System.err.println("ERROR ELIMINAR en T " + e.getMessage());
				e.printStackTrace();
			}
			return guardado;
		}
	 public boolean actualizarTarifa(Tarifa t)
		{
			boolean guardado = false;
			try 
			{
				dttari.cargartarifa();
				rs.beforeFirst();
				while (rs.next()){
					System.out.println("fila "+rs.getInt("Tarifa_ID"));
					if(rs.getInt("Tarifa_ID") == t.getTarifa_ID()){
						rs.updateInt("lim_Sup", t.getLim_Sup());
						rs.updateInt("lim_Inf", t.getLim_Inf());
						rs.updateFloat("monto", t.getMonto());
						rs.updateRow();
						System.out.println("tarifa actulizada");
						guardado  = true;
					}
				}
			}
			catch (Exception e) 
			{
				System.err.println("ERROR ACTUALIZAR en DTtarifa " + e.getMessage());
				e.printStackTrace();
			}
			return guardado;
		}
	
	
	
	
	
	
	
	
	
	
	
//	Connection cn = null;
//	PreparedStatement ps =null;
//	ResultSet rs =null;
//	
	
//	public ArrayList<Tarifa> tarifas()
//	{
//		ArrayList<Tarifa> listaTarifa = new ArrayList<Tarifa>();
//		String sql = ("SELECT * from tarifa");
//		try 
//		{
//			cn = Conexion.getConnection();
//			ps = cn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
//			rs = ps.executeQuery();
//			
//			while (rs.next()) 
//			{
//				Tarifa u = new Tarifa();
//				//u.setLogin(rs.getString("login"));
//				
//				u.setLim_Inf(rs.getInt("lim_Inf"));
//				u.setLim_Sup(rs.getInt("lim_Sup"));
//				u.setMonto(rs.getFloat("monto"));
//			//	u.setPass(rs.getString("pass"));
//			//	u.usuario_id = rs.getInt("Usuario_id");
//				listaTarifa.add(u);
//				
//				
//			}
//			ps.close();
//			cn.close();
//			System.out.println("datos cargados de tarifa");
//		} 
//		catch (Exception e) 
//		{
//			System.err.println("METODO CARGAR: "+e.getMessage());
//		}
//		
//		return listaTarifa;
//	}
//	
//	
//	public boolean guardarTarifa(Tarifa t)
//	{
//		try 
//		{
//			Connection cn = Conexion.getConnection();
//			Statement s = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
//			rs = s.executeQuery("SELECT * from tarifa;");
//			//DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
//			//Date date = new Date();
//			rs.moveToInsertRow();
//			//rs.updateString("login", u.getLogin());
//			//rs.updateString("pass", u.getPass());
//			rs.updateInt("lim_Inf", t.getLim_Inf());
//			rs.updateInt("lim_Sup", t.getLim_Sup());
//			rs.updateFloat("monto", t.getMonto());
//			
//			//rs.updateString("last_update", fecha.format(date));
//			rs.insertRow();
//			rs.moveToCurrentRow();
//			
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

}
