package Datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import Entidades.Opcion;
import Entidades.Rol;

public class DT_Rol_Opcion {
	private static DT_Rol_Opcion dtRolOp = new DT_Rol_Opcion();//instancia de la clase
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	private static ResultSet rs;//RESULTSET estatico
	
	public DT_Rol_Opcion() {
	}
	
	public static DT_Rol_Opcion getInstance() {
		return dtRolOp;
	}
	
	public ResultSet cargarRol_Opcion_Opciones(){
		Statement s;
		String sql = ("SELECT * FROM opciones_rol_opcion;");
		try 
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("datos de roles cargados");
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println("Error en DTRol_opcion, metodo cargarRol_Opcion: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de rol_opcion_opciones vacio");
		
		return rs;
	}
	
	public ResultSet cargarRol_Opcion(){
		Statement s;
		String sql = ("SELECT * FROM rol_opcion;");
		try 
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("datos de roles cargados");
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println("Error en DTRol_opcion, metodo cargarRol_Opcion: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de rol_opcion_opciones vacio");
		
		return rs;
	}
	public boolean guardarRol_Opcion(Rol r, Opcion o)
	{
		boolean guardado = false;
		try 
		{
			dtRolOp.cargarRol_Opcion();
			rs.moveToInsertRow();
			rs.updateInt("Rol_ID", r.getRol_ID());
			rs.updateInt("Opcion_ID", o.getOpcion_ID());
			rs.insertRow();
			rs.moveToCurrentRow();
			guardado = true;
		}
		catch (Exception e) 
		{
			System.err.println("ERROR GUARDAR en rol_opcion " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}
	public boolean eliminarRol_Opcion(Rol r, Opcion o)
	{
		boolean guardado = false;
		try 
		{
			dtRolOp.cargarRol_Opcion();
			rs.beforeFirst();
			rs.beforeFirst();
			while (rs.next()){
				System.out.println("fila "+rs.getInt("Rol_ID"));
				if(rs.getInt("Rol_ID") == r.getRol_ID() && rs.getInt("Opcion_ID") == o.getOpcion_ID()){
					rs.deleteRow();
					guardado  = true;
				}
			}
		}
		catch (Exception e) 
		{
			System.err.println("ERROR ELIMINAR en rol_opcion " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}
	
//	public boolean actualizarRol_Opcion(Rol r, Opcion o){
//		try {
//			dtRolOp.cargarRol_Opcion();
//			rs.beforeFirst();
//			rs.beforeFirst();
//			while (rs.next()){
//				System.out.println("fila "+rs.getInt("Rol_ID"));
//				if(rs.getInt("Rol_ID") ==r.getRol_ID() && rs.getInt("Opcion_ID") == o.getOpcion_ID()){
//					rs.updateInt("R", x);
//					rs.updateRow();
//				}
//		
//			}
//			return true;
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			return false;
//		}
//	}
}
