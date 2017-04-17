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
import Entidades.Contrato;
import Entidades.RegimenPropiedad;
import Entidades.Sector;

public class DTFacturaMaestra {

	private static DTFacturaMaestra dtFactura = new DTFacturaMaestra(); //Instanciando la Clase 
	private static ResultSet rs; //ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd");
	
	private int opcion;
	
	
	public static DTFacturaMaestra getInstance() 
	 {
	   return dtFactura;
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
		String sql = ("SELECT * FROM facturascliente where facturascliente.numMedidor = '"+numMedidor+"' order by facturascliente.fecha_fin;");
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
	
	public ResultSet facturasSinCancelar() {
		Statement s;
		String sql = ("SELECT * FROM facturassincancelar;");
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
	
	
}
