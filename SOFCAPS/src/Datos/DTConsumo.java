package Datos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import Entidades.Consumo;

public class DTConsumo {
	private static DTConsumo dtConsumo = new DTConsumo();//instancia de la clase
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	private static ResultSet rs;//RESULTSET estatico
	DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd");
	
	public DTConsumo() {
	}
	
	public static DTConsumo getInstance() {
		return dtConsumo;
	}
	
	public ResultSet cargarConsumos()
	{
		Statement s;
		String sql = ("SELECT * FROM consumo WHERE eliminado = 0 and actual = 1;");
		try 
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("datos de consumo cargados");
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println("Error en DTConsumo, metodo cargarConsumos: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de Consumo vacio");
		
		return rs;
	}
	
	public ResultSet cargarClienteContrato()
	{
		Statement s;
		String sql = ("SELECT * FROM cliente_contrato;");
		try 
		{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			
			System.out.println("datos de Cliente_Consumo cargados");
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println("Error en DTConsumo, metodo cargarClienteContrato: "+e.getMessage());
		}
		return rs;
	}

	public boolean guardarConsumo(Consumo consumo) {
		boolean guardado = false;
		try 
		{
			boolean encontrado = false;
			dtConsumo.cargarConsumos();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getBoolean("actual") == true && rs.getInt("Contrato_ID") == consumo.getContrato().getContrato_ID()){
					float lectura_anterior = (rs.getFloat("lectura_Actual"));
					consumo.setConsumoTotal(consumo.getLectura_Actual() - lectura_anterior);
					encontrado = true;
					System.out.println("lectura anterior encontrada");
					rs.updateBoolean("actual", false);
					rs.updateInt("Consumo_ID", rs.getInt("Consumo_ID"));
					rs.updateInt("Contrato_ID", rs.getInt("Contrato_ID"));
					rs.updateInt("Cliente_ID", rs.getInt("Cliente_ID"));
					rs.updateFloat("lectura_Actual", rs.getFloat("lectura_Actual"));
					rs.updateFloat("consumoTotal", rs.getFloat("consumoTotal"));
					rs.updateBoolean("eliminado", rs.getBoolean("eliminado"));
					rs.updateRow();
					rs.moveToCurrentRow();
				}
			}
			if(encontrado == false) {
				System.out.println("no hay consumo anterior, este es el primero");
				agregarPrimerConsumo(consumo, rs);
				consumo.setConsumoTotal(consumo.getLectura_Actual());
			}
			rs.moveToInsertRow();
			rs.updateInt("Cliente_ID", consumo.getCliente().getCliente_ID());
			rs.updateInt("Contrato_ID", consumo.getContrato().getContrato_ID());
			rs.updateString("fecha_fin", fecha.format(consumo.getFecha_fin()));
			rs.updateFloat("lectura_Actual", consumo.getLectura_Actual()); 
			rs.updateFloat("consumoTotal", consumo.getConsumoTotal()); 
			rs.updateBoolean("eliminado", consumo.getEliminado());
			rs.updateBoolean("actual", consumo.getActual());
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

	private void agregarPrimerConsumo(Consumo consumo, ResultSet rs2) {
		try {
			rs2.moveToInsertRow();
			rs2.updateInt("Cliente_ID", consumo.getCliente().getCliente_ID());
			rs2.updateInt("Contrato_ID", consumo.getContrato().getContrato_ID());
			rs2.updateString("fecha_fin", fecha.format(consumo.getFecha_fin()));
			rs2.updateFloat("lectura_Actual", 0.0f); 
			rs2.updateFloat("consumoTotal", 0.0f); 
			rs2.updateBoolean("eliminado", consumo.getEliminado());
			rs2.updateBoolean("actual", false);
			rs2.insertRow();
			rs2.moveToCurrentRow();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
