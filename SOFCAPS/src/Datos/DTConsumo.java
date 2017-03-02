package Datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Entidades.Consumo;

public class DTConsumo {
	Connection cn = null;
	PreparedStatement ps =null;
	ResultSet rs =null;
	public ArrayList<Consumo> listarConsumos()
	{
		ArrayList<Consumo> listaConsumo = new ArrayList<>();
		String sql = ("SELECT * from consumo");
		try 
		{
			cn = Conexion.getConnection();
			ps = cn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = ps.executeQuery();
			
			while (rs.next()) 
			{
				Consumo c = new Consumo();
				c.setFecha_fin(rs.getDate("fecha_fin"));
				c.setConsumoTotal(rs.getFloat("consumoTotal"));
				c.setLectura_Actual(rs.getFloat("lectura_Actual"));
				c.setActual(rs.getBoolean("actual"));
				c.setConsumo_ID(rs.getInt("Consumo_ID"));
				listaConsumo.add(c);
				
			}
			ps.close();
			cn.close();
			System.out.println("datos cargados de consumos");
		} 
		catch (Exception e) 
		{
			System.err.println("METODO CARGAR: "+e.getMessage());
		}
		
		return listaConsumo;
	}
}
