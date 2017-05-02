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

import Entidades.Categoria;
import Entidades.Cliente;
import Entidades.Consumo;
import Entidades.Contrato;
import Entidades.Factura_Maestra;
import Entidades.RegimenPropiedad;
import Entidades.Sector;

public class DTFacturaMaestra {

	private static DTFacturaMaestra dtFactura = new DTFacturaMaestra(); //Instanciando la Clase 
	private static ResultSet rs; //ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd");
	
	public static DTFacturaMaestra getInstance() 
	 {
	   return dtFactura;
	 }
	
	public ResultSet datosFacturaMaestra()
	{
		Statement s;
		String sql = ("SELECT factura_maestra.Factura_Maestra_ID, factura_maestra.numFact, factura_maestra.anulado, factura_maestra.Consumo_ID, factura_maestra.estadoFac FROM factura_maestra WHERE factura_maestra.anulado=False;");
		try
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Error en DT_categoria_Ing_Engreg: "+e.getMessage());
		}
		return rs;
	}
	
	public ResultSet cargarDatosTabla()
	{
		Statement s;
		String sql = ("select * from factura_actual;");
		try
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Error en DT_categoria_Ing_Engreg: "+e.getMessage());
		}
		return rs;
	}
	
	public ResultSet historialFacturasCliente(String numMedidor) {
		Statement s;
		String sql = ("SELECT * FROM facturas_cliente where facturas_cliente.numMedidor = '"+numMedidor+"' order by facturas_cliente.fecha_fin;");
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("historial de facturas cliente cargadas");
		}catch (Exception e){
			e.printStackTrace();
			System.out.println("Error en DTFacturaMaestra, metodo historialFacturasCliente: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de FacturaMaestra vacio");
		
		return rs;
	}
	
	public ResultSet historialFacturas() {
		Statement s;
		String sql = ("SELECT * FROM facturas_historial order by facturas_historial.fecha_fin;");
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("historial de facturas cliente cargadas");
		}catch (Exception e){
			e.printStackTrace();
			System.out.println("Error en DTFacturaMaestra, metodo historialFacturas: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de FacturaMaestra vacio");
		
		return rs;
	}
	
	public ResultSet facturasSinCancelar() {
		Statement s;
		String sql = ("SELECT * FROM facturas_sin_cancelar order by facturas_sin_cancelar.fecha_fin;");
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("historial de facturas sin cancelar cargadas");
		}catch (Exception e){
			e.printStackTrace();
			System.out.println("Error en DTFacturaMaestra, metodo facturasSinCancelar: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de FacturaMaestra vacio");
		
		return rs;
	}
	
	public boolean anularFacturaMaestra(Factura_Maestra factura)
	{
		boolean eliminado = false;
		try 
		{
			dtFactura.datosFacturaMaestra();
			System.out.println("Eliminado 1");
			rs.beforeFirst();
			
			while(rs.next()){
				System.out.println("Eliminado 2");
//				System.out.println("Elimando factura numero:" + factura.getNumFact() + " contra factura numero: " + );
				if(rs.getString(2).equals(factura.getNumFact())){
					System.out.println("Eliminado 3");
					rs.updateInt(1, rs.getInt(1));
					rs.updateString(2, rs.getString(2));
					rs.updateBoolean(3, true);
					rs.updateInt(4, rs.getInt(4));
					rs.updateBoolean(5, false);
					rs.updateRow();
					eliminado = true;
					DTConsumo dtConsumo = new DTConsumo();
					Consumo c = new Consumo();
					c.setConsumo_ID(rs.getInt(4));
					c.setEliminado(true);
					dtConsumo.eliminarConsumo(c);
				}
			}
		}
		catch (Exception e) 
		{
			System.err.println("ERROR AL ELIMINAR " + e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}

	public int generarFacturas(Date fechaCorte, Date fechaVence) {
		int cantidadFacturas = 0;
        try {
        	// Llamada al procedimiento almacenado
			CallableStatement cst = con.prepareCall("{call factura_maestro_add(?,?,?)}");
			cst.setString(1, fecha.format(fechaCorte));
			cst.setString(2, fecha.format(fechaVence));
			cst.registerOutParameter(3, java.sql.Types.INTEGER);
			// Ejecuta el procedimiento almacenado
            cst.execute();
            
            cantidadFacturas = cst.getInt(3);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cantidadFacturas;
	}
	
	public ResultSet cargarNumeroDeFactura(int cliente_ID)
	{
		Statement s;
		String sql = "select fa.totalPago, fa.deslizamiento, fa.numFact, fm.Factura_Maestra_ID from facturas_historial fa "
		+"inner join factura_maestra fm on fa.numFact = fm.numFact where fm.anulado = 0 "
		+ "&& fm.estadoFac = 0 &&  fm.Cliente_ID = " + cliente_ID + ";";
		try
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Error en DT_FacturaMestra: "+e.getMessage());
		}
		return rs;
	}

	public ResultSet cargarFacturaUnica(int factura_maestra_ID){
		Statement s;
		String sql = "SELECT numFact, Factura_Maestra_ID FROM factura_maestra WHERE Factura_Maestra_ID = " +factura_maestra_ID+ ";";
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("Error en DT_FacturaMestra, metodo cargarFacturaUnica: "+e.getMessage());
		}
		return rs;
	}
	
	public float calcularMontoRestante(int factura_Maestra_ID) {
		float montoRestante;
		Statement s;
		String sql = "select sum(round((r.montoTotal),2)) as monto "+
				"from recibocaja r where r.Serie_ID = 1 and r.numDocumento = "+factura_Maestra_ID+";";
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("montoRestante cargado");
		}catch (SQLException e){
			e.printStackTrace();
			System.out.println("Error en DTFacturaMaestra, metodo calcularMontoRestante: "+e.getMessage());
		}finally {
			if(rs == null) {
				System.out.println("Resultset de monto de factura vacio");
				montoRestante = 0.0f;
			} else {
				try {
					if(rs.first())
						montoRestante = rs.getFloat("monto");
					else
						montoRestante = 0.0f;
				} catch (SQLException e) {
					montoRestante = 0.0f;
					e.printStackTrace();
				}
			}
		}
		return montoRestante;
	}

	public boolean cancelarFactura(int id, boolean cancel) {
		boolean cancelado = false;
		try {
			dtFactura.datosFacturaMaestra();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getInt("Factura_Maestra_ID") == id){
					rs.updateInt(1, rs.getInt(1));
					rs.updateString(2, rs.getString(2));
					rs.updateBoolean(3, rs.getBoolean(3));
					rs.updateInt(4, rs.getInt(4));
					rs.updateBoolean(5, cancel);
					rs.updateRow();
					cancelado = true;
					break;
				}
			}
			rs.moveToCurrentRow();
		}catch (Exception e) {
			System.err.println("ERROR AL cancelar factura " + e.getMessage());
			e.printStackTrace();
		}
		return cancelado;
	}
	
	
}
