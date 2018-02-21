package Datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import Entidades.Cliente;
import Entidades.Usuario;


public class DTCliente {
	
//	private static DTCliente dtUsu = new DTCliente();//instancia de la clase
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	private  ResultSet rs;//RESULTSET estatico
	
//	private DTCliente() {
//	}
//	
//	public static DTCliente getInstance() {
//		return dtUsu;
//	}
	
	public ResultSet cliente(){
		Statement s;
		
		String sql = ("SELECT DISTINCT (CONCAT(`cliente`.`nombre1`,' ',`cliente`.`nombre2`,' ',`cliente`.`apellido1`,' ',`cliente`.`apellido2`)FROM cliente where eliminado=0;");
		try 
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	
			;
			rs = s.executeQuery(sql);
			System.out.println("MESES OTROS ING EGREG CARGADOS");
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println("Error en DTOtros_Ing_Egreg, metodo MES: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de MES vacio");
		
		return rs;
	}

	public ResultSet cargarNombre()
	{
		Statement s;
		String sql = ("select distinct nombre_completo, Cliente_ID  from facturas_sin_cancelar;");
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

	
	public ResultSet cargarClientes()
	{
		Statement s;
		String sql = ("SELECT * FROM cliente where estado = false;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("datos de clientes cargados");
		} 
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DTCliente, metodo cargarClientes: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de Cliente vacio");
		
		return rs;
	}
	
	public ResultSet cargarClientesInactivos()
	{
		Statement s;
		String sql = ("SELECT * FROM cliente where estado = true;");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("datos de clientes cargados");
		} 
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DTCliente, metodo cargarClientes: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de Cliente vacio");
		
		return rs;
	}
	
	public boolean guardarCliente(Cliente c){
		boolean guardado = false;
		try 
		{
			cargarClientes();
			rs.moveToInsertRow();
			rs.updateString("nombre1", c.getNombre1());
			rs.updateString("nombre2", c.getNombre2());
			rs.updateString("apellido1", c.getApellido1());
			rs.updateString("apellido2", c.getApellido2());
			rs.updateString("cedula", c.getCedula());
			rs.updateInt("celular", c.getCelular());
			rs.updateBoolean("estado", false);
			rs.insertRow();
			rs.moveToCurrentRow();
			guardado = true;
		}
		catch (Exception e) 
		{
			System.err.println("ERROR GUARDAR " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}
	
	public boolean eliminarCliente(Cliente c){
		boolean guardado = false;
		try 
		{
			cargarClientes();
			rs.beforeFirst();
			while (rs.next()){
				System.out.println("fila "+rs.getInt("cliente_id"));
				if(rs.getInt("cliente_id") ==c.getCliente_ID()){
					rs.updateBoolean("estado", true);
					rs.updateRow();
					guardado  = true;
				}
			}
		}
		catch (Exception e) 
		{
			System.err.println("ERROR ELIMINAR en Cliente: " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}
	
	public boolean actualizarCliente(Cliente c){
		try {
			cargarClientes();
			rs.beforeFirst();
			while (rs.next()){
				System.out.println("fila "+rs.getInt("cliente_id"));
				if(rs.getInt("cliente_id") ==c.getCliente_ID()){
					//System.out.println(c.getLogin());
					rs.updateString("nombre1",c.getNombre1());
					rs.updateString("nombre2", c.getNombre2());
					rs.updateString("apellido1", c.getApellido1());
					rs.updateString("apellido2", c.getApellido2());
					rs.updateString("cedula", c.getCedula());
					rs.updateInt("celular", c.getCelular());
					rs.updateBoolean("estado", c.getEstado());
					rs.updateRow();
				}
			}
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean activarCliente(Cliente c){
		boolean guardado = false;
		try 
		{
			cargarClientesInactivos();
			rs.beforeFirst();
			while (rs.next()){
				System.out.println("fila "+rs.getInt("cliente_id"));
				if(rs.getInt("cliente_id") ==c.getCliente_ID()){
					rs.updateBoolean("estado", false);
					rs.updateRow();
					guardado  = true;
				}
			}
		}
		catch (Exception e) 
		{
			System.err.println("ERROR ELIMINAR en Cliente: " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}
}
	
//	public ArrayList<Cliente> cliente()
//	{
//		ArrayList<Cliente> listaCategoria = new ArrayList<Cliente>();
//		String sql = ("SELECT * from cliente where estado=false");
//		try 
//		{
//			cn = Conexion.getConnection();
//			ps = cn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
//			rs = ps.executeQuery();
//			
//			while (rs.next()) 
//			{
//				Cliente c = new Cliente();
//				c.setNombre1(rs.getString("nombre1"));
//				c.setNombre2(rs.getString("nombre2"));
//				c.setApellido1(rs.getString("apellido1"));
//				c.setApellido2(rs.getString("apellido2"));
//				c.setCedula(rs.getString("cedula"));
//				c.setCelular(rs.getInt("celular"));
//				c.setEstado(rs.getBoolean("estado"));
//				c.setCliente_ID(rs.getInt("Cliente_id"));
//
//				listaCategoria.add(c);
//				
//			}
//			ps.close();
//			cn.close();
//			System.out.println("datos cargados de clientes");
//		} 
//		catch (Exception e) 
//		{
//			System.err.println("METODO CARGAR: "+e.getMessage());
//		}
//		
//		return listaCategoria;
//	}
//	
//	public boolean guardarCliente(Cliente c)
//	{
//		try 
//		{
//			Connection cn = Conexion.getConnection();
//			Statement s = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
//			rs = s.executeQuery("SELECT * from cliente;");
//			//DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
//			//Date date = new Date();
//			rs.moveToInsertRow();
//			rs.updateString("nombre1", c.getNombre1());
//			rs.updateString("nombre2", c.getNombre2());
//			rs.updateString("apellido1", c.getApellido1());
//			rs.updateString("apellido2", c.getApellido2());
//			rs.updateString("cedula", c.getCedula());
//			rs.updateInt("celular", c.getCelular());
//			rs.updateBoolean("estado", c.getEstado());
//			//rs.updateString("last_update", fecha.format(date));
//			rs.insertRow();
//			rs.moveToCurrentRow();
//			
//			s.close();
//			cn.close();
//			return true;
//		}
//		catch (Exception e) 
//		{
//			System.err.println("ERROR AL GUARDAR: " + e.getMessage());
//			e.printStackTrace();
//			return false;
//		}
//	}
//	
//	public boolean actualizarCliente(Cliente c){
//		try {
//			Connection cn = Conexion.getConnection();
//			Statement s = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
//			rs = s.executeQuery("SELECT * from cliente;");
//			rs.beforeFirst();
//			while (rs.next()){
//				System.out.println("fila "+rs.getInt("cliente_id"));
//				if(rs.getInt("cliente_id") ==c.getCliente_ID()){
//					rs.updateString("nombre1",c.getNombre1());
//					rs.updateString("nombre2", c.getNombre2());
//					rs.updateString("apellido1", c.getApellido1());
//					rs.updateString("apellido2", c.getApellido2());
//					rs.updateString("cedula", c.getCedula());
//					rs.updateInt("celular", c.getCelular());
//					rs.updateBoolean("estado", c.getEstado());
//					rs.updateRow();
//				}
//		
//			}
//			s.close();
//			cn.close();
//			return true;
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			return false;
//		}
//	}
//	
//	public boolean eliminarCliente(Cliente c){
//		try {
//			Connection cn = Conexion.getConnection();
//			Statement s = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
//			rs = s.executeQuery("SELECT * from cliente;");
//			rs.beforeFirst();
//			rs.beforeFirst();
//			while (rs.next()){
//				System.out.println("fila "+rs.getInt("cliente_id"));
//				if(rs.getInt("cliente_id") ==c.getCliente_ID()){
//					rs.updateBoolean("estado", true);
//					rs.updateRow();
//				}
//			}
//			s.close();
//			cn.close();
//			return true;
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			return false;
//		}
//	}
//
