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
//	private static DTTarifa dttari = new DTTarifa();
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	private  ResultSet rs;//RESULTSET estatico
	
//	private DTTarifa(){
//	}
//	
//	public static DTTarifa getInstance() {
//			return dttari;
//	}
	
	 public ResultSet cargarTarifa()
		{
			Statement s;
			String sql = ("SELECT * FROM tarifa where estado = 0;");
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
	 
	 public ResultSet cargarTarifaCategoria(){
			Statement s;
			String sql = ("select t.Tarifa_ID, t.lim_Inf, t.lim_Sup, t.monto, t.Unidad_de_Medida_ID, t.Categoria_ID,"+
			" c.nomCategoria from tarifa t, categoria c where c.Categoria_ID = t.Categoria_ID and t.estado = 0 and c.eliminado = 0;");
			try 
			{
				s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				rs = s.executeQuery(sql);
				System.out.println("datos de tarifasCategorias cargados");
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
				System.out.println("Error en DTTarifa, metodo cargarTarifasCategorias: "+e.getMessage());
			}
			if(rs == null)
				System.out.println("Resultset de tarifaCategoria vacio");
			
			return rs;
		}
	
	 public boolean guardarTarifa(Tarifa t)
		{
			boolean guardado = false;
			try 
			{
				cargarTarifa();
				rs.moveToInsertRow();
				rs.updateInt("lim_Inf", t.getLim_Inf());
				if(t.getLim_Sup() >= 0) {
					rs.updateInt("lim_Sup", t.getLim_Sup());
				}
				rs.updateFloat("monto", t.getMonto());
				rs.updateBoolean("estado", false);
				rs.updateInt("Unidad_de_Medida_ID", t.getUnidad_de_Medida().getUnidad_de_Medida_ID());
				rs.updateInt("Categoria_ID", t.getCategoria().getCategoria_ID());
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
				cargarTarifa();
				rs.beforeFirst();
				while (rs.next()){
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
				cargarTarifa();
				rs.beforeFirst();
				while (rs.next()){
					if(rs.getInt("Tarifa_ID") == t.getTarifa_ID()){
						if(t.getLim_Sup() == 0) {
							rs.updateNull("lim_Sup");
						}else {
							rs.updateInt("lim_Sup", t.getLim_Sup());
						}
						rs.updateInt("lim_Inf", t.getLim_Inf());
						rs.updateFloat("monto", t.getMonto());
						rs.updateInt("Tarifa_ID", t.getTarifa_ID());
						rs.updateBoolean("estado", false);
						rs.updateInt("Categoria_ID", t.getCategoria().getCategoria_ID());
						rs.updateInt("Unidad_de_Medida_ID", t.getUnidad_de_Medida().getUnidad_de_Medida_ID());
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
