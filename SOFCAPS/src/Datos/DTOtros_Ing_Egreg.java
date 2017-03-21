package Datos;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import Entidades.Opcion;
import Entidades.Otros_Ing_Egreg;
import Entidades.Rol;
import Entidades.Tarifa;

public class DTOtros_Ing_Egreg {
	private static DTOtros_Ing_Egreg dtoi = new DTOtros_Ing_Egreg();
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	private static ResultSet rs;//RESULTSET estatico
	
	DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd");
	
	private DTOtros_Ing_Egreg(){
	}
	
	public static DTOtros_Ing_Egreg getInstance() {
			return dtoi;
	}
	
	 public ResultSet cargarOI()
		{
			Statement s;
			String sql = ("SELECT * FROM otros_ing_egreg where eliminado = 0;");
			try 
			{
				s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				rs = s.executeQuery(sql);
				System.out.println("datos de otros_ing_egreg cargados");
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
				System.out.println("Error en DTOtros_Ing_Egreg, metodo cargaroi: "+e.getMessage());
			}
			if(rs == null)
				System.out.println("Resultset de otros_ing_egreg vacio");
			
			return rs;
		}
	 
	 public ResultSet cargarCOI(){
			Statement s;
			String sql = ("Select  otros_ing_egreg.Otros_Ing_Egreg_ID,otros_ing_egreg.descripcion, otros_ing_egreg.monto, otros_ing_egreg.fecha,categoria_ing_egreg.Categoria_Ing_Egreg_ID, categoria_ing_egreg.nombreCategoria  From otros_ing_egreg Inner Join categoria_ing_egreg On categoria_ing_egreg.Categoria_Ing_Egreg_ID = otros_ing_egreg.Categoria_Ing_Egreg_ID where otros_ing_egreg.eliminado = 0 and categoria_ing_egreg.eliminado = 0;");
			try 
			{
				s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				rs = s.executeQuery(sql);
				System.out.println("datos de COI cargados");
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
				System.out.println("Error en DTOtros_Ing_Egre, metodo cargarCOI: "+e.getMessage());
			}
			if(rs == null)
				System.out.println("Resultset de COI vacio");
			
			return rs;
		}
	
	 public boolean guardarOI(Otros_Ing_Egreg  o)
		{
			boolean guardado = false;
			try 
			{
				dtoi.cargarOI();
				rs.moveToInsertRow();
//				rs.updateInt("lim_Inf", t.getLim_Inf());
//				if(t.getLim_Sup() != 0) {
//					rs.updateInt("lim_Sup", t.getLim_Sup());
//				}
				rs.updateString("fecha", fecha.format(o.getFecha()));
				rs.updateString("descripcion", o.getDescripcion());
				rs.updateFloat("monto", o.getMonto());
				rs.updateBoolean("eliminado", false);
			//	rs.updateInt("Unidad_de_Medida_ID", t.getUnidad_de_Medida().getUnidad_de_Medida_ID());
				rs.updateInt("Categoria_Ing_Egreg_ID", o.getCategoria_Ing_Egreg().getCategoria_Ing_Egreg_ID());
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
	 
	 
	 
	 public boolean eliminarOI(Otros_Ing_Egreg  o)
		{
			boolean eliminado = false;
			try 
			{
				dtoi.cargarOI();
				rs.beforeFirst();
				rs.beforeFirst();
				while (rs.next()){
					System.out.println("fila "+ rs.getInt("Otros_Ing_Egreg_ID"));
					if(rs.getInt("Otros_Ing_Egreg_ID") == o.getOtros_Ing_Egreg_ID()){
						rs.updateBoolean("eliminado", true);
						rs.updateRow();
						System.out.println("oie eliminada");
						eliminado  = true;
					}
				}
			}
			catch (Exception e) 
			{
				System.err.println("ERROR ELIMINAR en T " + e.getMessage());
				e.printStackTrace();
			}
			return eliminado;
		}
	 public boolean actualizarOI(Otros_Ing_Egreg  o)
		{
			boolean guardado = false;
			try 
			{
				dtoi.cargarOI();
				rs.beforeFirst();
				while (rs.next()){
					System.out.println("fila "+rs.getInt("Otros_Ing_Egreg_ID"));
					if(rs.getInt("Otros_Ing_Egreg_ID") == o.getOtros_Ing_Egreg_ID()){
						//System.out.println("lim_Sup: " + o.getLim_Sup());
//						if(t.getLim_Sup() == 0) {
//							rs.updateNull("lim_Sup");
//						}
//						rs.updateInt("lim_Inf", t.getLim_Inf());
						rs.updateString("fecha",fecha.format(o.getFecha()));
						rs.updateString("descripcion",o.getDescripcion());
						rs.updateFloat("monto", o.getMonto());
						rs.updateInt("Otros_Ing_Egreg_ID", o.getOtros_Ing_Egreg_ID());
						rs.updateBoolean("eliminado", false);
						rs.updateInt("Categoria_Ing_Egreg_ID", o.getCategoria_Ing_Egreg().getCategoria_Ing_Egreg_ID());
						//rs.updateInt("Unidad_de_Medida_ID", t.getUnidad_de_Medida().getUnidad_de_Medida_ID());
						rs.updateRow();
						System.out.println("Otros ingresos y egresos actulizada");
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
