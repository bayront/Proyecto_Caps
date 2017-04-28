package Datos;
import java.sql.CallableStatement;
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
	
	
	public ResultSet cargarPro(String messs, String aniooo)
	{
		Otros_Ing_Egreg n = new Otros_Ing_Egreg();
		try 
		{	 
			
			CallableStatement p = con.prepareCall("{CALL p(?, ?)}");
			p.setString("messs", messs);
			p.setString("aniooo", aniooo);
			
			rs = p.executeQuery();
//			if(rs.next())
//			{
//				n.setMmmes(messs);
//				n.setAanio(aniooo);
//				
//			}
		} 
		catch (SQLException e) 
		{
			System.out.println("Error en Dortso ingresos metodo cargar pro " +e.getMessage());
			e.printStackTrace();
		}
		
		return rs;
	}
	
	public ResultSet cargarSI(String cci, String mss,String aoo)
	{
		Otros_Ing_Egreg n = new Otros_Ing_Egreg();
		try 
		{	 
			
			CallableStatement p = con.prepareCall("{CALL ci(?, ?,?)}");
			p.setString("ci", cci);
			p.setString("mi", mss);
			p.setString("ai", aoo);
			
			rs = p.executeQuery();
//			if(rs.next())
//			{
//				n.set
//				n.setMmmes(messs);
//				n.setAanio(aniooo);
//				
//			}
		} 
		catch (SQLException e) 
		{
			System.out.println("Error en Dortso ingresos metodo cargar pro " +e.getMessage());
			e.printStackTrace();
		}
		
		return rs;
	}
	
	
	public ResultSet cargarSE( String cce,String msse,String aooe)
	{
		Otros_Ing_Egreg n = new Otros_Ing_Egreg();
		try 
		{	 
			
			CallableStatement p = con.prepareCall("{CALL cee(?, ?,?)}");
			p.setString("ce", cce);
			p.setString("me", msse);
			p.setString("ae", aooe);
			
			rs = p.executeQuery();
//			if(rs.next())
//			{
//				n.set
//				n.setMmmes(messs);
//				n.setAanio(aniooo);
//				
//			}
		} 
		catch (SQLException e) 
		{
			System.out.println("Error en Dortso ingresos metodo cargar pro " +e.getMessage());
			e.printStackTrace();
		}
		
		return rs;
	}
	
	
	public ResultSet mes(){
		Statement s;
		String sql1=("set lc_time_names = 'es_ES';");
		String sql = ("SELECT DISTINCT DATE_FORMAT(fecha, '%M')FROM otros_ing_egreg where eliminado=0;");
		try 
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	
			rs = s.executeQuery(sql1);
			rs = s.executeQuery(sql);
			System.out.println("MESES OTROS ING EGREG CARGADOS");
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println("Error en DTOtros_Ing_Egreg, metodo MES: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de MES vacio");
		
		return rs;
	}
	
	
	
	
	public ResultSet ing(){
		Statement s;
//		String sql1 = ("SET lc_time_names = 'es_VE';");
		String sql = ("select distinct ELT(1, 'Ingresos') FROM otros_ing_egreg o Inner Join categoria_ing_egreg c  On o.Categoria_Ing_Egreg_ID = c.Categoria_Ing_Egreg_ID where TipoCategoria_ID=1 and o.eliminado = 0 and c.eliminado = 0 ; ");
		try 
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		//	rs = s.executeQuery(sql1);
			rs = s.executeQuery(sql);
			System.out.println("INGRESO CARGADOS");
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println("Error en DTOtros_Ing_Egreg, metodo ing: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de ING vacio");
		
		return rs;
	}
	
	
	public ResultSet egre(){
		Statement s;
//		String sql1 = ("SET lc_time_names = 'es_VE';");
		String sql = ("select distinct ELT(1, 'Egresos') FROM otros_ing_egreg o Inner Join categoria_ing_egreg c  On o.Categoria_Ing_Egreg_ID = c.Categoria_Ing_Egreg_ID where TipoCategoria_ID=2 and o.eliminado = 0 and c.eliminado = 0 ; ");
		try 
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		//	rs = s.executeQuery(sql1);
			rs = s.executeQuery(sql);
			System.out.println("egresos CARGADOS");
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println("Error en DTOtros_Ing_Egreg, metodo egreg: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de egreg vacio");
		
		return rs;
	}
	
	
	
	public ResultSet anio(){
		Statement s;
//		String sql1 = ("SET lc_time_names = 'es_VE';");
		String sql = ("SELECT DISTINCT DATE_FORMAT(fecha, '%Y')FROM otros_ing_egreg where eliminado=0;");
		try 
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		//	rs = s.executeQuery(sql1);
			rs = s.executeQuery(sql);
			System.out.println("AÑOS OTROS ING EGREG CARGADOS");
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println("Error en DTOtros_Ing_Egreg, metodo ANIO: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de ANIO vacio");
		
		return rs;
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
			String sql = ("Select  o.Otros_Ing_Egreg_ID, o.descripcion, o.monto, o.fecha, c.Categoria_Ing_Egreg_ID, c.nombreCategoria  From otros_ing_egreg o Inner Join categoria_ing_egreg c On o.Categoria_Ing_Egreg_ID = c.Categoria_Ing_Egreg_ID where o.eliminado = 0 and c.eliminado = 0;");
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
						rs.updateString("fecha",fecha.format(o.getFecha()));
						rs.updateString("descripcion",o.getDescripcion());
						rs.updateFloat("monto", o.getMonto());
						rs.updateInt("Otros_Ing_Egreg_ID", o.getOtros_Ing_Egreg_ID());
						rs.updateBoolean("eliminado", false);
						rs.updateInt("Categoria_Ing_Egreg_ID", o.getCategoria_Ing_Egreg().getCategoria_Ing_Egreg_ID());
						rs.updateRow();
						System.out.println("Otros ingresos y egresos actulizada");
						guardado  = true;
					}
				}
				rs.moveToCurrentRow();
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
