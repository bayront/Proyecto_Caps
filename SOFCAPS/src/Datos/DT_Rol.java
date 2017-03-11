package Datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import Entidades.Cliente;
import Entidades.Opcion;
import Entidades.Rol;


public class DT_Rol {
	private static DT_Rol dtRol = new DT_Rol();//instancia de la clase
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	private static ResultSet rs;//RESULTSET estatico
	
	 private DT_Rol(){
		 
		 
	 }
	 
	 public static DT_Rol getInstance() {
			return dtRol;
		}
	 
	 public ResultSet cargarRol()
		{
			Statement s;
			String sql = ("SELECT * FROM rol where eliminado=0;");
			try 
			{
				s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				rs = s.executeQuery(sql);
				System.out.println("datos de rol cargados");
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
				System.out.println("Error en DTRol, metodo cargarConsumos: "+e.getMessage());
			}
			if(rs == null)
				System.out.println("Resultset de Rol vacio");
			
			return rs;
		}
	 
	 public boolean guardarRol(Rol r)
		{
			boolean guardado = false;
			try 
			{
				dtRol.cargarRol();
				rs.moveToInsertRow();
				rs.updateString("nomRol", r.getNomRol());
				rs.updateBoolean("eliminado", false);
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
	 
	 public boolean actualizarRol(Rol r){
			try {
				dtRol.cargarRol();
				rs.beforeFirst();
				while (rs.next()){
					System.out.println("fila "+rs.getInt("Rol_ID"));
					if(rs.getInt("Rol_ID") ==r.getRol_ID()){
						System.out.println(r.getNomRol());
						
						rs.updateString("nomRol", r.getNomRol());
						
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
	 
	 public boolean eliminarRol(Rol r)
		{
			boolean guardado = false;
			try 
			{
				dtRol.cargarRol();
				rs.beforeFirst();
				while (rs.next()){
					System.out.println("fila "+rs.getInt("Rol_ID"));
					if(rs.getInt("Rol_ID") == r.getRol_ID()){
						rs.updateBoolean("eliminado", true);
						rs.updateRow();
						guardado  = true;
					}
				}
			}
			catch (Exception e) 
			{
				System.err.println("ERROR ELIMINAR en rol: " + e.getMessage());
				e.printStackTrace();
			}
			return guardado;
		}
}
