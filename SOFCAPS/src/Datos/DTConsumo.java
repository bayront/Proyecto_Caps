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
		String sql = "SELECT * FROM consumo cs JOIN contrato ct ON cs.Contrato_ID = ct.Contrato_ID "+
		"WHERE cs.eliminado = 0 and cs.actual = 1 and ct.estado = 0;";
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("datos de consumo cargados");
		}catch (Exception e){
			e.printStackTrace();
			System.out.println("Error en DTConsumo, metodo cargarConsumos: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de Consumo vacio");
		
		return rs;
	}
	
	public ResultSet cargarTodosConsumos()
	{
		Statement s;
		String sql = ("SELECT * FROM consumo cs WHERE cs.eliminado = 0;");
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("datos de consumo totales cargados");
		}catch (Exception e){
			e.printStackTrace();
			System.out.println("Error en DTConsumo, metodo cargarTodosConsumos: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de Consumo vacio");
		
		return rs;
	}
	
	public ResultSet cargarClienteContrato()
	{
		Statement s;
		String sql = ("SELECT * FROM cliente_contrato;");
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			
			System.out.println("datos de Cliente_Consumo cargados");
		}catch (Exception e){
			e.printStackTrace();
			System.out.println("Error en DTConsumo, metodo cargarClienteContrato: "+e.getMessage());
		}
		return rs;
	}

	public boolean guardarConsumo(Consumo consumo) {
		boolean guardado = false;
		try {
			boolean encontrado = false;
			dtConsumo.cargarTodosConsumos();
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
				agregarPrimerConsumo(consumo);
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
		}catch (Exception e){
			System.err.println("ERROR GUARDAR " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}

	private void agregarPrimerConsumo(Consumo consumo) {
		try {
			dtConsumo.cargarTodosConsumos();
			rs.moveToInsertRow();
			rs.updateInt("Cliente_ID", consumo.getCliente().getCliente_ID());
			rs.updateInt("Contrato_ID", consumo.getContrato().getContrato_ID());
			rs.updateString("fecha_fin", fecha.format(consumo.getFecha_fin()));
			rs.updateFloat("lectura_Actual", 0.0f); 
			rs.updateFloat("consumoTotal", 0.0f); 
			rs.updateBoolean("eliminado", consumo.getEliminado());
			rs.updateBoolean("actual", false);
			rs.insertRow();
			rs.moveToCurrentRow();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public boolean actualizarConsumo(Consumo consumo) {
		boolean guardado = false;
		try {
			dtConsumo.cargarTodosConsumos();
			rs.beforeFirst();
			while (rs.next()) {
				if(rs.getInt("Consumo_ID") == consumo.getConsumo_ID()) {
					float lecturaVieja = rs.getFloat("lectura_Actual") - rs.getFloat("consumoTotal");
					consumo.setConsumoTotal(consumo.getLectura_Actual() - lecturaVieja);
					rs.updateFloat("consumoTotal", consumo.getConsumoTotal()); 
					rs.updateFloat("lectura_Actual", consumo.getLectura_Actual()); 
					rs.updateInt("Consumo_ID", consumo.getConsumo_ID());
					rs.updateString("fecha_fin", fecha.format(consumo.getFecha_fin()));
					rs.updateBoolean("eliminado", consumo.getEliminado());
					rs.updateBoolean("actual", consumo.getActual());
					rs.updateInt("Cliente_ID", rs.getInt("Cliente_ID"));
					rs.updateInt("Contrato_ID", rs.getInt("Contrato_ID"));
					rs.updateRow();
					rs.moveToCurrentRow();
					
					guardado = true;
				}
			}
		}catch (Exception e){
			System.err.println("ERROR ACTUALIZAR " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}
	
	public boolean eliminarConsumo(Consumo consumo) {
		boolean guardado = false;
		try {
			float lectura_anterior = 0;
			float lecturaRound = 0.0f;
			int contrato_ID = 0;
			dtConsumo.cargarTodosConsumos();
			rs.beforeFirst();
			while (rs.next()) {
				if(rs.getInt("Consumo_ID") == consumo.getConsumo_ID()) {
					contrato_ID = rs.getInt("Contrato_ID");
					System.out.println("consumo a eliminar encontrado");
					lectura_anterior = rs.getFloat("lectura_Actual") - rs.getFloat("consumoTotal");
					lecturaRound= (float) (Math.round(lectura_anterior * 100.0) / 100.0);
					rs.updateBoolean("actual", rs.getBoolean("actual"));
					rs.updateBoolean("eliminado", consumo.getEliminado());
					rs.updateRow();
					rs.moveToCurrentRow();
					
					guardado = true;
				}
			}
			rs.beforeFirst();
			while(rs.next()) {
				if(rs.getFloat("lectura_Actual") == lecturaRound && contrato_ID == rs.getInt("Contrato_ID")){
					rs.updateBoolean("actual", true);
					System.out.println("actualizar lectura anterior");
					if(lectura_anterior == 0) {
						rs.updateBoolean("eliminado", true);
					}else {
						rs.updateBoolean("eliminado", false);
					}
					rs.updateRow();
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return guardado;
	}

	public ResultSet cargarHistorial(int contrato_ID) {
		Statement s;
		String sql = ("SELECT * FROM consumo cs WHERE cs.eliminado = 0 and Contrato_ID = "+contrato_ID+";");
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			System.out.println("historial de consumos cargados");
		}catch (Exception e){
			e.printStackTrace();
			System.out.println("Error en DTConsumo, metodo cargarHistorial: "+e.getMessage());
		}
		if(rs == null)
			System.out.println("Resultset de Consumo vacio");
		
		return rs;
	}
}
