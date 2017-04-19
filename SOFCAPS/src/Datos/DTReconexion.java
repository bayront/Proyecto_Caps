package Datos;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import Entidades.Cliente;
import Entidades.Reconexion;
import Entidades.Factura_Maestra;

public class DTReconexion {
	
	private static DTReconexion dtReconexion = new DTReconexion(); //Instanciando la Clase 
	private static ResultSet rs; //ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	SimpleDateFormat formato = new SimpleDateFormat("yyyy/MM/dd");
	Date fechaActual = new Date(); 
	
	private DTReconexion() {
	}

	public static DTReconexion getInstance() {
		return dtReconexion;
	}
	
	public ResultSet cargarReconexion()
	{
		Statement s;
		String sql = ("SELECT * FROM reconexion rx where rx.cancelado = 0;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("datos de clientes cargados");
		} 
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DTReconexion, metodo cargarReconexion: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de Reconexion vacio");
		
		return rs;
	}
	
	
	
	public ResultSet cargarDatosTabla()
	{
		Statement s;
		String sql = ("SELECT rx.fecha_reconexion, rx.f_cancel, rx.cancelado, rx.Reconexion_ID, rx.Factura_Maestra_ID, rx.Cliente_ID, cl.nombre1,  cl.nombre2, cl.apellido1, cl.apellido2, fm.numFact FROM reconexion rx inner join cliente cl ON rx.Cliente_ID = cl.Cliente_ID inner join factura_maestra fm ON rx.Factura_Maestra_ID = fm.Factura_Maestra_ID WHERE rx.cancelado = 0;");
		try
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Error en Cargar_Reconexion: "+e.getMessage());
		}
		return rs;
	}
	
	
	
	public boolean cancelarReconexion(Reconexion r){
		boolean eliminado = false;
		try 
		{
			dtReconexion.cargarReconexion();
			rs.beforeFirst();
			while (rs.next()){
				System.out.println("fila "+rs.getInt("Reconexion_ID"));
				if(rs.getInt("Reconexion_ID") == r.getReconexion_ID()){
					rs.updateBoolean("cancelado", true);
					rs.updateString("f_cancel", formato.format(fechaActual));
					rs.updateRow();
					eliminado  = true;
				}
			}
		}
		catch (Exception e) 
		{
			System.err.println("ERROR AL CANCELAR LA RECONEXION: " + e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}
	

}
