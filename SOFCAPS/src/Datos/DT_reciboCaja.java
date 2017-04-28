package Datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import Entidades.Serie;
import Entidades.Factura_Detalle;
import Entidades.Factura_Maestra;
import Entidades.ReciboCaja;
import Entidades.Contrato;
import Entidades.Reconexion;
import Entidades.Cliente;


public class DT_reciboCaja {
	private static DT_reciboCaja dtReciboCaja = new DT_reciboCaja();
	private static ResultSet rs;
	PoolConexion pc = PoolConexion.getInstance(); 
	Connection con = PoolConexion.getConnection();
	DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd");
	
	private DT_reciboCaja () { 
	 }
	
	public static DT_reciboCaja getInstance() {
		   return dtReciboCaja;
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

	public boolean guardarRecibo(ReciboCaja r, float totalPagar) {
		boolean guardado = false;
		try {
			dtReciboCaja.cargarnumRecibo();
			rs.next();
			System.out.println("numRecibo: "+rs.getInt("numRecibo"));
			int numReciboCaja = rs.getInt("numRecibo") + 1;
			String numRecibo = String.valueOf(numReciboCaja);
			
			dtReciboCaja.cargarRecibosTabla();
			rs.moveToInsertRow();
			rs.updateString("fecha", fecha.format(r.getFecha()));
			rs.updateString("descripcion", r.getDescripcion());
			rs.updateString("numReciboCaja", numRecibo);
			rs.updateFloat("montoTotal", r.getMontoTotal());
			rs.updateInt("Serie_ID", r.getSerie().getSerie_ID());
			rs.updateInt("numDocumento", r.getNumDocumento());
			rs.updateBoolean("estado", false);
			rs.updateInt("Cliente_ID", r.getCliente().getCliente_ID());
			rs.insertRow();
			rs.moveToCurrentRow();
			guardado = true;
			System.out.println("guardado: "+guardado);
		}catch (Exception e) {
			System.err.println("ERROR GUARDAR " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}

	public ResultSet cargarRecibos() {
		Statement s;
//		String sql1 = "select r.descripcion AS descripcionRecibo, r.estado, r.numReciboCaja, "+
//        "r.numDocumento, r.montoTotal, concat(c.nombre1,' ',c.nombre2,' ',c.apellido1,' ',c.apellido2) AS nombreCompleto, "+
//		"c.Cliente_ID,  s.descripcion AS descripcionSerie, s.Serie_ID"+
//        "from ((recibocaja r join cliente c ON ((r.Cliente_ID = c.Cliente_ID)))"+
//        "join serie s ON ((r.Serie_ID = s.Serie_ID))) where r.estado = 0";
		String sql = "SELECT * FROM sofcaps.recibocajahistorial;";
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("datos de los recibos de caja cargado");
		}catch (Exception e){
			e.printStackTrace();
			System.out.println("Error en DT_reciboCaja, metodo cargarRecibos: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de ReciboCaja vacio");
		
		return rs;
	}
	
	public ResultSet cargarRecibosTabla() {
		Statement s;
		String sql = "SELECT * FROM sofcaps.recibocaja;";
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("datos de los recibos de caja cargados");
		}catch (Exception e){
			e.printStackTrace();
			System.out.println("Error en DT_reciboCaja, metodo cargarRecibosTabla: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de ReciboCaja vacio");
		
		return rs;
	}
	
	public ResultSet cargarnumRecibo() {
		Statement s;
		String sql = "SELECT count(*) as numRecibo FROM recibocaja;";
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("datos del numero de recibo cargado");
		}catch (Exception e){
			e.printStackTrace();
			System.out.println("Error en DT_reciboCaja, metodo cargarnumRecibo: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de ReciboCaja vacio");
		
		return rs;
	}
	
}
