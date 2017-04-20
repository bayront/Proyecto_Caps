package Datos;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import Entidades.Categoria;
import Entidades.Categoria_Ing_Egreg;
import Entidades.Cliente;
import Entidades.Contrato;
import Entidades.RegimenPropiedad;
import Entidades.Sector;

public class DTContrato {

	private static DTContrato dtContrato = new DTContrato(); //Instanciando la Clase 
	private static ResultSet rs; //ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd");
	
	private int opcion;
	
	
	public static DTContrato getInstance() 
	 {
	   return dtContrato;
	 }
	
	public ResultSet cargarDatos()
	{
		Statement s;
		String sql;
		if (opcion == 1){
			sql = ("SELECT * FROM contrato WHERE estado = 0;");
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
		String sql = ("select c.fechaContrato, c.numContrato, c.numMedidor, c.cuotas, c.montoContrato, c.Contrato_ID, c.Cliente_ID, c.RegimenPropiedad_ID, c.Sector_ID, c.Categoria_ID, cl.nombre1, cl.nombre2, cl.apellido1, cl.apellido2, r.regimenPro, s.nombreSector, ca.nomCategoria from contrato c inner join cliente cl on c.Cliente_ID = cl.Cliente_ID inner join regimenpropiedad r on c.RegimenPropiedad_ID = r.RegimenPropiedad_ID inner join sector s on c.Sector_ID = s.Sector_ID inner join categoria ca on c.Categoria_ID = ca.Categoria_ID WHERE c.estado = 0;");
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
			dtContrato.cargarDatos();
			while(rs.next()) {
				if(contrato.getCliente().getCliente_ID() == rs.getInt("Cliente_ID")) {
					if(rs.getInt("numContrato") > numContrato) {
						numContrato = rs.getInt("numContrato") + 1;
					}
				}
			}
			rs.moveToInsertRow();
			rs.updateBoolean(1, false);
			rs.updateString(2, fecha.format(contrato.getFechaContrato()));
			rs.updateInt(3, numContrato);
			rs.updateString(4, contrato.getNumMedidor());
			rs.updateInt(5, 1);
			rs.updateString(8, fecha.format(contrato.getFechaContrato()));
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
			dtContrato.cargarDatos();
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
			dtContrato.cargarDatos();
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
	
	public ArrayList<RegimenPropiedad> listaRegimenPropiedad()
	{
		ArrayList<RegimenPropiedad> listaRegimenP = new ArrayList<RegimenPropiedad>();
		String sql = ("SELECT * FROM sofcaps.regimenpropiedad;");
		
		try 
		{
			Connection cn;
			cn = Conexion.getConnection();
			PreparedStatement ps = cn.prepareStatement(sql);
			ResultSet rs = null;
			rs = ps.executeQuery();
			
			while(rs.next())
			{
				RegimenPropiedad rP = new RegimenPropiedad();
				rP.setRegimenPro(rs.getString(1));
				rP.setRegimenPropiedad_ID(rs.getInt(2));
				listaRegimenP.add(rP);
			}
			ps.close();
			cn.close();
		} 
		catch (Exception e) 
		{
			System.err.println("DATOS: ERROR " +e.getMessage());
		}
		
		return listaRegimenP;
	}
	
	public ArrayList<Sector> listaSector()
	{
		ArrayList<Sector> listaSector = new ArrayList<Sector>();
		String sql = ("SELECT * FROM sofcaps.sector;");
		
		try 
		{
			Connection cn;
			cn = Conexion.getConnection();
			PreparedStatement ps = cn.prepareStatement(sql);
			ResultSet rs = null;
			rs = ps.executeQuery();
			
			while(rs.next())
			{
				Sector sector = new Sector();
				sector.setNombreSector(rs.getString(1));
				sector.setSector_ID(rs.getInt(2));
				listaSector.add(sector);
			}
			ps.close();
			cn.close();
		} 
		catch (Exception e) 
		{
			System.err.println("DATOS: ERROR " +e.getMessage());
		}
		
		return listaSector;
	}
	
	public ArrayList<Categoria> listaCategoria()
	{
		ArrayList<Categoria> listaCategoria = new ArrayList<Categoria>();
		String sql = ("SELECT * FROM sofcaps.categoria where eliminado = 0;");
		
		try 
		{
			Connection cn;
			cn = Conexion.getConnection();
			PreparedStatement ps = cn.prepareStatement(sql);
			ResultSet rs = null;
			rs = ps.executeQuery();
			
			while(rs.next())
			{
				Categoria categoria = new Categoria();
				categoria.setNomCategoria(rs.getString(1));
				categoria.setCategoria_ID(rs.getInt(4));
				listaCategoria.add(categoria);
			}
			ps.close();
			cn.close();
		} 
		catch (Exception e) 
		{
			System.err.println("DATOS: ERROR " +e.getMessage());
		}
		
		return listaCategoria;
	}

	public ArrayList<Cliente> listaCliente()
	{
		ArrayList<Cliente> listaCliente = new ArrayList<Cliente>();
		String sql = ("SELECT * FROM sofcaps.cliente where estado = 0;");
		
		try 
		{
			Connection cn;
			cn = Conexion.getConnection();
			PreparedStatement ps = cn.prepareStatement(sql);
			ResultSet rs = null;
			rs = ps.executeQuery();
			
			while(rs.next())
			{
				Cliente cliente = new Cliente();
				cliente.setCliente_ID(rs.getInt(14));
				cliente.setNombreCompleto(rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3) + " " + rs.getString(4));
				listaCliente.add(cliente);
			}
			ps.close();
			cn.close();
		} 
		catch (Exception e) 
		{
			System.err.println("DATOS: ERROR " +e.getMessage());
		}
		
		return listaCliente;
	}
	
	public ResultSet cargarVistaClienteContrato(int cliente_ID)
	{
		Statement s;
		String sql = ("select * from contrato WHERE estado = 0 and contrato.Cliente_ID = " + cliente_ID + ";");
		try
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Error en DT_Contrato: "+e.getMessage());
		}
		return rs;
	}

	public float calcularMontoRestante(int contrato_ID) throws SQLException {
		float montoRestante;
		Statement s;
		String sql = "select sum(round((r.monto),2)) as monto "+
				"from recibocaja_detalle r where r.Serie_ID = 2 and r.numDocumento = "+contrato_ID+";";
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("montoRestante de contrato cargado");
		}catch (Exception e){
			e.printStackTrace();
			System.out.println("Error en DTFacturaMaestra, metodo calcularMontoRestante: "+e.getMessage());
		}finally {
			if(rs == null) {
				System.out.println("Resultset de monto de contrato vacio");
				montoRestante = 0.0f;
			}else
				if(rs.first())
					montoRestante = rs.getFloat("monto");
				else
					montoRestante = 0.0f;
		}
		
		return montoRestante;
	}

	public int calcularCuotasRestantes(int contrato_ID) throws SQLException {
		int cuotas;
		Statement s;
		String sql = "select count(*) as cuotas "+
				"from recibocaja_detalle r where r.Serie_ID = 2 and r.numDocumento = "+contrato_ID+";";
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("cuotas restantes del contrato cargado");
		}catch (Exception e){
			e.printStackTrace();
			System.out.println("Error en DTFacturaMaestra, metodo calcularCuotasRestantes: "+e.getMessage());
		}finally {
			if(rs == null) {
				System.out.println("Resultset de cuotas contratos vacio");
				cuotas = 0;
			}else
				if(rs.first())
					cuotas = rs.getInt("cuotas");
				else
					cuotas = 0;
		}
		return cuotas;
	}
	
}
