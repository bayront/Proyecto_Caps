package Datos;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import Entidades.Tarifa;
import Entidades.Usuario;

public class DTTarifa {
	Connection cn = null;
	PreparedStatement ps =null;
	ResultSet rs =null;
	
	
	public ArrayList<Tarifa> tarifas()
	{
		ArrayList<Tarifa> listaTarifa = new ArrayList<Tarifa>();
		String sql = ("SELECT * from tarifa");
		try 
		{
			cn = Conexion.getConnection();
			ps = cn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = ps.executeQuery();
			
			while (rs.next()) 
			{
				Tarifa u = new Tarifa();
				//u.setLogin(rs.getString("login"));
				
				u.setLim_Inf(rs.getInt("lim_Inf"));
				u.setLim_Sup(rs.getInt("lim_Sup"));
				u.setMonto(rs.getFloat("monto"));
			//	u.setPass(rs.getString("pass"));
			//	u.usuario_id = rs.getInt("Usuario_id");
				listaTarifa.add(u);
				
				
			}
			ps.close();
			cn.close();
			System.out.println("datos cargados de tarifa");
		} 
		catch (Exception e) 
		{
			System.err.println("METODO CARGAR: "+e.getMessage());
		}
		
		return listaTarifa;
	}
	
	
	public boolean guardarTarifa(Tarifa t)
	{
		try 
		{
			Connection cn = Conexion.getConnection();
			Statement s = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery("SELECT * from tarifa;");
			//DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			//Date date = new Date();
			rs.moveToInsertRow();
			//rs.updateString("login", u.getLogin());
			//rs.updateString("pass", u.getPass());
			rs.updateInt("lim_Inf", t.getLim_Inf());
			rs.updateInt("lim_Sup", t.getLim_Sup());
			rs.updateFloat("monto", t.getMonto());
			
			//rs.updateString("last_update", fecha.format(date));
			rs.insertRow();
			rs.moveToCurrentRow();
			
			s.close();
			cn.close();
			return true;
		}
		catch (Exception e) 
		{
			System.err.println("ERROR AL GUARDAR: " + e.getMessage());
			e.printStackTrace();
			return false;
		}
	}

}
