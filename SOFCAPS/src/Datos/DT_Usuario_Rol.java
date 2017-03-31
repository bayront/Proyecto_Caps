package Datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import Entidades.Rol;
import Entidades.Usuario_Rol;
import Entidades.Usuario;
import Datos.PoolConexion;

public class DT_Usuario_Rol {
	
	private static DT_Usuario_Rol dtru = new DT_Usuario_Rol(); //Instanciando la Clase 
	private static ResultSet rs; //ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	
	private DT_Usuario_Rol() 
	{ 
		 
	}
	
	/* Static 'instance' method */
	public static DT_Usuario_Rol getInstance() 
	{
	   return dtru;
	}
	
	 public ResultSet cargarUsuarioRol()
		{
			Statement s;
			String sql = ("SELECT * FROM usuario_rol;");
			try 
			{
				s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				rs = s.executeQuery(sql);
				System.out.println("datos de usuario_rol cargados");
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
				System.out.println("Error en DT_Usuario_Rol: "+e.getMessage());
			}
			if(rs == null)
				System.out.println("Resultset de Usuario_Rol vacio");
			
			return rs;
		}
	 
	 public boolean verificarRol(Usuario us, Rol r)
		{
			boolean verificado = false;
			Statement s;
			String sql = ("SELECT * From usuario_rol where Usuario_ID="+us.getUsuario_ID()+" and Rol_ID="+r.getRol_ID()+";");
			try
			{
				s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				rs = s.executeQuery(sql);
				if(rs.next())
				{
					verificado=true;
				}
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
				System.out.println("Error en DT_Usuario_Rol: "+e.getMessage());
			}
			
			return verificado;

		}
	 
	

	
}
