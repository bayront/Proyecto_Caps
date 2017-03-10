package Datos;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import Entidades.Cliente;


public class DTCliente {
	
	Connection cn = null;
	PreparedStatement ps =null;
	ResultSet rs =null;
	
	public ArrayList<Cliente> cliente()
	{
		ArrayList<Cliente> listaCategoria = new ArrayList<Cliente>();
		String sql = ("SELECT * from cliente where estado=false");
		try 
		{
			cn = Conexion.getConnection();
			ps = cn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = ps.executeQuery();
			
			while (rs.next()) 
			{
				Cliente c = new Cliente();
				c.setNombre1(rs.getString("nombre1"));
				c.setNombre2(rs.getString("nombre2"));
				c.setApellido1(rs.getString("apellido1"));
				c.setApellido2(rs.getString("apellido2"));
				c.setCedula(rs.getString("cedula"));
				c.setCelular(rs.getInt("celular"));
				c.setEstado(rs.getBoolean("estado"));
				c.setCliente_ID(rs.getInt("Cliente_id"));

				listaCategoria.add(c);
				
			}
			ps.close();
			cn.close();
			System.out.println("datos cargados de clientes");
		} 
		catch (Exception e) 
		{
			System.err.println("METODO CARGAR: "+e.getMessage());
		}
		
		return listaCategoria;
	}
	
	public boolean guardarCliente(Cliente c)
	{
		try 
		{
			Connection cn = Conexion.getConnection();
			Statement s = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery("SELECT * from cliente;");
			//DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			//Date date = new Date();
			rs.moveToInsertRow();
			rs.updateString("nombre1", c.getNombre1());
			rs.updateString("nombre2", c.getNombre2());
			rs.updateString("apellido1", c.getApellido1());
			rs.updateString("apellido2", c.getApellido2());
			rs.updateString("cedula", c.getCedula());
			rs.updateInt("celular", c.getCelular());
			rs.updateBoolean("estado", c.getEstado());
			//rs.updateString("last_update", fecha.format(date));
			rs.insertRow();
			rs.moveToCurrentRow();
			
			s.close();
			cn.close();
			return true;
		}
		catch (Exception e) 
		{
			System.err.println("ERROR AL GUARDAR: " + e.getMessage());
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean actualizarCliente(Cliente c){
		try {
			Connection cn = Conexion.getConnection();
			Statement s = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery("SELECT * from cliente;");
			rs.beforeFirst();
			while (rs.next()){
				System.out.println("fila "+rs.getInt("cliente_id"));
				if(rs.getInt("cliente_id") ==c.getCliente_ID()){
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
			s.close();
			cn.close();
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean eliminarCliente(Cliente c){
		try {
			Connection cn = Conexion.getConnection();
			Statement s = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery("SELECT * from cliente;");
			rs.beforeFirst();
			rs.beforeFirst();
			while (rs.next()){
				System.out.println("fila "+rs.getInt("cliente_id"));
				if(rs.getInt("cliente_id") ==c.getCliente_ID()){
					rs.updateBoolean("estado", true);
					rs.updateRow();
				}
			}
			s.close();
			cn.close();
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}

}
