package Datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import Entidades.Categoria;
import Entidades.Cliente;
import Entidades.Contrato;
import Entidades.RegimenPropiedad;
import Entidades.Sector;

public class DTFacturaMaestra {

	private static DTFacturaMaestra dtFactura = new DTFacturaMaestra(); //Instanciando la Clase 
	private static ResultSet rs; //ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	
	private int opcion;
	
	
	public static DTFacturaMaestra getInstance() 
	 {
	   return dtFactura;
	 }
	
	public ResultSet cargarDatosFactura()
	{
		Statement s;
		String sql;
		if (opcion == 1){
			sql = ("SELECT * FROM factura_maestra WHERE anulado = 0;");
		} else {
			sql = ("SELECT c.numContrato, c.numMedidor, c.cuotas, c.montoContrato, c.Contrato_ID, c.Cliente_ID, c.RegimenPropiedad_ID, c.Sector_ID, c.Categoria_ID FROM contrato c WHERE estado = 0;");
		}
			
		try
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Error en DTContrato: "+e.getMessage());
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
	
	public boolean guardarContrato(Contrato contrato)
	{
		opcion = 1;
		boolean guardado = false;
		try 
		{
			int numContrato = 1;
//			dtContrato.cargarDatos();
			while(rs.next()) {
				if(contrato.getCliente().getCliente_ID() == rs.getInt("Cliente_ID")) {
					if(rs.getInt("numContrato") > numContrato) {
						numContrato = rs.getInt("numContrato") + 1;
					}
				}
			}
			rs.moveToInsertRow();
			rs.updateBoolean(1, false);
//			rs.updateString(2, fecha.format(contrato.getFechaContrato()));
			rs.updateInt(3, numContrato);
			rs.updateString(4, contrato.getNumMedidor());
			rs.updateInt(5, 1);
//			rs.updateString(8, fecha.format(contrato.getFechaContrato()));
			rs.updateInt(11, contrato.getCuotas());
			rs.updateFloat(12, contrato.getMontoContrato());
			rs.updateInt(14, contrato.getCliente().getCliente_ID());
			rs.updateInt(15, contrato.getRegimenPropiedad().getRegimenPropiedad_ID());
			rs.updateInt(16, contrato.getSector().getSector_ID());
			rs.updateInt(17, contrato.getCategoria().getCategoria_ID());
			 
			rs.insertRow();
			rs.moveToCurrentRow();
			guardado = true;
		}
		catch (Exception e) 
		{
			System.err.println("ERROR al GUARDAR " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}
	
	/**
	 * @param contrato
	 * @return
	 */
	public boolean actualizarContrato(Contrato contrato)
	{
		opcion = 2;
		boolean actualizado = false;
		try 
		{
			int numContrato =1;
//			dtContrato.cargarDatos();
			while(rs.next()) {
				if(rs.getInt("Contrato_ID") == contrato.getContrato_ID()) {
					if(contrato.getCliente().getCliente_ID() == rs.getInt("Cliente_ID")) {
						numContrato = rs.getInt("numContrato");
						break;
					}
				}else if(contrato.getCliente().getCliente_ID() == rs.getInt("Cliente_ID")) {
					if(rs.getInt("numContrato") > numContrato) {
						numContrato = rs.getInt("numContrato") + 1;
					}
				}
			}
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getInt("Contrato_ID") == contrato.getContrato_ID()){
					rs.updateInt("numContrato", numContrato);
					rs.updateInt("Contrato_ID", contrato.getContrato_ID());
					rs.updateString("numMedidor", contrato.getNumMedidor());
					rs.updateInt("cuotas", contrato.getCuotas());
					rs.updateFloat("montoContrato", contrato.getMontoContrato());
					rs.updateInt("Cliente_ID", contrato.getCliente().getCliente_ID());
					rs.updateInt("RegimenPropiedad_ID", contrato.getRegimenPropiedad().getRegimenPropiedad_ID());
					rs.updateInt("Sector_ID", contrato.getSector().getSector_ID());
					rs.updateInt("Categoria_ID", contrato.getCategoria().getCategoria_ID());
					rs.updateRow();
					actualizado = true;
				}
			}
			
			
		}
		catch (Exception e) 
		{
			System.err.println("ERROR AL ACTUALIZAR " + e.getMessage());
			e.printStackTrace();
		}
		return actualizado;
	}
	
	public boolean eliminarContratro(Contrato contrato)
	{
		opcion = 1;
		boolean eliminado = false;
		try 
		{
			System.err.println("ERROR AL ELIMINAR CONTRATO NUMERO: " + contrato.getContrato_ID());
//			dtContrato.cargarDatos();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getInt("Contrato_ID") == contrato.getContrato_ID()){
					rs.updateBoolean(1, true);
					rs.updateRow();
					eliminado = true;
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
	
	
}
