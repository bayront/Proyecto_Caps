package Datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class DT_UnidadMedida {
	private static DT_UnidadMedida dtUM = new DT_UnidadMedida();//instancia de la clase
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	private static ResultSet rs;//RESULTSET estatico
	
	private DT_UnidadMedida() {
	}
	
	public static DT_UnidadMedida getInstance() {
		return dtUM;
	}
	
	public ResultSet cargarUnidad_Medida(){
		Statement s;
		String sql = ("SELECT * FROM unidad_de_medida");
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("datos de Unidad_medida cargados");
		} 
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en DT_UnidadMedida, metodo cargarUnidad_Medida: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de unidad_de_medida vacio");
		
		return rs;
	}
}
