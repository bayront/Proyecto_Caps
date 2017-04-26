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
import java.util.List;
import java.util.Locale;

import Entidades.Cliente;
import Entidades.Reconexion;
import Entidades.Factura_Maestra;

public class DTReconexion {
	
	private static DTReconexion dtReconexion = new DTReconexion(); //Instanciando la Clase 
	private static ResultSet rs; //ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	SimpleDateFormat formato = new SimpleDateFormat("yyyy/MM/dd");
	SimpleDateFormat parseador = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH);
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
	
	public List<Reconexion> listaReconexiones(int cliente_ID){
		List<Reconexion> listaReconexiones = new ArrayList<Reconexion>();
		String sql = ("SELECT * FROM reconexion rx where rx.cancelado = 0 and rx.Cliente_ID = "+cliente_ID+";");
		Statement s;
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("datos de reconexiones del cliente cargados");
			while(rs.next()){
				Reconexion reconexion = new Reconexion();
				Factura_Maestra factura_Maestra = new Factura_Maestra();
				reconexion.setReconexion_ID(rs.getInt("Reconexion_ID"));
				String f1 = parseador.format(rs.getDate("fecha_reconexion"));
				reconexion.setFecha_reconexion(parseador.parse(f1));
				factura_Maestra.setFactura_Maestra_ID(rs.getInt("Factura_Maestra_ID"));
				reconexion.setFactura_Maestra(factura_Maestra);
				listaReconexiones.add(reconexion);
			}
		} catch (Exception e){
			System.err.println("DATOS: ERROR " +e.getMessage());
		}
		return listaReconexiones;
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