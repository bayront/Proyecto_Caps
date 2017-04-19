package Datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import Entidades.Serie;
import Entidades.Factura_Detalle;
import Entidades.Factura_Maestra;
import Entidades.Contrato;
import Entidades.Reconexion;
import Entidades.Cliente;


public class DT_reciboCaja {
	private static DT_reciboCaja tdReciboCaja = new DT_reciboCaja();
	private static ResultSet rs;
	PoolConexion pc = PoolConexion.getInstance(); 
	Connection con = PoolConexion.getConnection();
	
	private DT_reciboCaja () { 
	 }
	
	public static DT_reciboCaja getInstance() {
		   return tdReciboCaja;
		 }
	
	public ArrayList<Serie> listaSeries(){
		ArrayList<Serie> listaSeries = new ArrayList<Serie>();
		String sql = ("SELECT * FROM sofcaps.serie;");
		Statement s;
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			while(rs.next()){
				Serie serie = new Serie();
				serie.setSerie_ID(rs.getInt("Serie_ID"));
				serie.setDescripcion(rs.getString("descripcion"));
				listaSeries.add(serie);
			}
		} catch (Exception e){
			System.err.println("DATOS: ERROR " +e.getMessage());
		}
		return listaSeries;
	}
	
	public ArrayList<Factura_Maestra> listaFacturas(){
		ArrayList<Factura_Maestra> listaFacturas = new ArrayList<Factura_Maestra>();
		String sql = ("SELECT * FROM sofcaps.factura_maestra;");
		Statement s;
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			while(rs.next()){
				Factura_Maestra factura = new Factura_Maestra();
				factura.setFactura_Maestra_ID(rs.getInt("Factura_Maestra_ID"));
				factura.setNumFact(rs.getString("numFact"));
				listaFacturas.add(factura);
			}
		} catch (Exception e){
			System.err.println("DATOS: ERROR " +e.getMessage());
		}
		return listaFacturas;
	}
	
	public ArrayList<Reconexion> listaReconexiones(){
		ArrayList<Reconexion> listaReconexiones = new ArrayList<Reconexion>();
		String sql = ("SELECT * FROM sofcaps.reconexion;");
		Statement s;
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			while(rs.next()){
				Reconexion reconexion = new Reconexion();
				reconexion.setReconexion_ID(rs.getInt("Reconexion_ID"));
				listaReconexiones.add(reconexion);
			}
		} catch (Exception e){
			System.err.println("DATOS: ERROR " +e.getMessage());
		}
		return listaReconexiones;
	}
	 
	
}
