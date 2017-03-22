package Datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import Entidades.Consumo;

public class DTConsumo {
	private static DTConsumo dtConsumo = new DTConsumo();//instancia de la clase
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	private static ResultSet rs;//RESULTSET estatico
	
	public DTConsumo() {
	}
	
	public static DTConsumo getInstance() {
		return dtConsumo;
	}
	
	public ResultSet cargarConsumos()
	{
		Statement s;
		String sql = ("SELECT * FROM consumo WHERE eliminado = 0 and actual = 1;");
		try 
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("datos de consumo cargados");
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println("Error en DTConsumo, metodo cargarConsumos: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de Consumo vacio");
		
		return rs;
	}
	
	public ResultSet cargarClienteContrato()
	{
		Statement s;
		String sql = ("SELECT * FROM cliente_contrato;");
		try 
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			
			System.out.println("datos de Cliente_Consumo cargados");
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println("Error en DTConsumo, metodo cargarClienteContrato: "+e.getMessage());
		}
		return rs;
	}

	public boolean guardarConsumo(Consumo consumo) {
		// TODO Auto-generated method stub
		return false;
	}
}
