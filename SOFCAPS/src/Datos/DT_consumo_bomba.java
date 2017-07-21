package Datos;

import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.text.DateFormat;

import Entidades.Bomba;
import Entidades.Mes;
import Entidades.TipoCategoria;
import Entidades.Unidad_de_Medida;

public class DT_consumo_bomba {
	
	private static DT_consumo_bomba dtconsB = new DT_consumo_bomba(); //Instanciando la Clase 
	private static ResultSet rs; //ResultSet Global
	PoolConexion pc = PoolConexion.getInstance(); //
	Connection con = PoolConexion.getConnection();
	PreparedStatement ps =null;
	DateFormat fecha = new SimpleDateFormat("yyyy/MM/dd");
	
	private DT_consumo_bomba () { 
	 }
	
	public static DT_consumo_bomba getInstance() {
	   return dtconsB;
	 }

	public float traer_Lectura(){
		String sql =("SELECT * from bomba where estado = 0;");
		float lectura = 0;
		Statement s;
		try{
			con = Conexion.getConnection();
			s= con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			rs.beforeFirst();
			while(rs.next()){
				if(rs.isLast()){
					lectura = (rs.getFloat("lecturaActual"));
					System.out.println(lectura);
				}
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return lectura;
	}
	
	public float traer_LecturaParaActualizar(int id){
		String sql =("SELECT * from bomba WHERE estado = 0");
		float lectura = 0;
		Statement s;
		try {
			con = Conexion.getConnection();
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			while(rs.next()){
				if(rs.getInt("Bomba_ID") == id){
					if(rs.previous()){
						lectura = (rs.getFloat("lecturaActual"));
						System.out.println("lectura anterior a posicion actual =" + lectura);
						break;
					}
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return lectura;
	}
	
	public float calcularConsumo(float lect){
		float lectAnt = traer_Lectura();
		float con = 0;
		
		con = lect - lectAnt;
		System.out.println(con);
		
		return con;
	}
	
	public float calcularConsumoBActualizar(float lecturaActual, int id){
		float conAct = 0;
		float lecturaParaActualizar = traer_LecturaParaActualizar(id);
		
		conAct = lecturaActual - lecturaParaActualizar;
		System.out.println("consumo del actualizar: " + conAct);
		
		return conAct;
	}
	
	public ResultSet cargarDatos(){
		Statement s;
		String sql = ("SELECT * FROM bomba WHERE estado = 0;");
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("Error en DT_consumo_bomba: "+e.getMessage());
		}
		return rs;
	}
	
	public ResultSet DatosInactivos(){
		Statement s;
		String sql = ("SELECT * FROM bomba WHERE estado = 1;");
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("Error en DT_consumo_bomba: "+e.getMessage());
		}
		return rs;
	}
	
	public ResultSet cargarDatosTabla(){
		Statement s;
		String sql = ("SELECT b.Bomba_ID, b.consumoActual, b.fechaLecturaActual, b.lecturaActual, b.observaciones, um.tipoMedida, um.Unidad_de_Medida_ID FROM bomba b inner join unidad_de_medida um on b.Unidad_de_Medida_ID = um.Unidad_de_Medida_ID WHERE b.estado = 0;");
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("Error en DT_consumo_bomba: "+e.getMessage());
		}
		return rs;
	}
	
	public ResultSet cargarDatosInactivos(){
		Statement s;
		String sql = ("SELECT b.Bomba_ID, b.consumoActual, b.fechaLecturaActual, b.lecturaActual, b.observaciones, um.tipoMedida, um.Unidad_de_Medida_ID FROM bomba b inner join unidad_de_medida um on b.Unidad_de_Medida_ID = um.Unidad_de_Medida_ID WHERE b.estado = 1;");
		try{
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("Error en DT_consumo_bomba: "+e.getMessage());
		}
		return rs;
	}

	public boolean guardarRegBomba(Bomba b){
		boolean guardado = false;
		try {
			dtconsB.cargarDatos();
		
			rs.moveToInsertRow();
			rs.updateFloat("consumoActual", b.getConsumoActual());
			rs.updateInt("Unidad_de_Medida_ID", b.getUnidad_de_Medida().getUnidad_de_Medida_ID());
			rs.updateString("fechaLecturaActual", fecha.format(b.getFechaLecturaActual()));
			rs.updateFloat("lecturaActual", b.getLecturaActual());
			if(b.getObservaciones().isEmpty() || b.getObservaciones() == null) {
				rs.updateNull("observaciones");
			}else {
				rs.updateString("observaciones", b.getObservaciones());
			}
			rs.updateBoolean("estado", false);
			rs.insertRow();
			rs.moveToCurrentRow();
			guardado = true;
		}catch (Exception e) {
			System.err.println("ERROR GUARDAR " + e.getMessage());
			e.printStackTrace();
		}
		return guardado;
	}
	
	public boolean actualizarBomba(Bomba b){
		boolean actualizado = false;
		try {
			dtconsB.cargarDatos();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getInt("Bomba_ID") == b.getBomba_ID()){
					rs.updateInt("Bomba_ID", b.getBomba_ID());
					rs.updateFloat("consumoActual", b.getConsumoActual());
					rs.updateInt("Unidad_de_Medida_ID", b.getUnidad_de_Medida().getUnidad_de_Medida_ID());
					rs.updateString("fechaLecturaActual", fecha.format(b.getFechaLecturaActual()));
					rs.updateFloat("lecturaActual", b.getLecturaActual());
					if(b.getObservaciones().isEmpty() || b.getObservaciones() == null) {
						rs.updateNull("observaciones");
					}else {
						rs.updateString("observaciones", b.getObservaciones());
					}
					rs.updateBoolean("estado", false);
					rs.updateRow();
					actualizado = true;
				}
			}
		}catch (Exception e){
			System.err.println("ERROR AL ACTUALIZAR " + e.getMessage());
			e.printStackTrace();
		}
		return actualizado;
	}
	
	public boolean eliminarRegBomba(Bomba b){
		boolean eliminado = false;
		try {
			dtconsB.cargarDatos();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getInt("Bomba_ID") == b.getBomba_ID()){
					rs.updateBoolean("estado", true);
					rs.updateRow();
					eliminado = true;
				}
			}
		}catch (Exception e) {
			System.err.println("ERROR AL ELIMINAR " + e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}
	
	public boolean activar(Bomba b){
		boolean eliminado = false;
		try {
			dtconsB.DatosInactivos();
			rs.beforeFirst();
			while(rs.next()){
				if(rs.getInt("Bomba_ID") == b.getBomba_ID()){
					rs.updateBoolean("estado", false);
					rs.updateRow();
					eliminado = true;
				}
			}
		}catch (Exception e) {
			System.err.println("ERROR AL ELIMINAR " + e.getMessage());
			e.printStackTrace();
		}
		return eliminado;
	}
	
	public ArrayList<Unidad_de_Medida> listaUnidadDeMedida(){
		ArrayList<Unidad_de_Medida> listaUnidadMedida = new ArrayList<Unidad_de_Medida>();
		String sql = ("SELECT * FROM sofcaps.unidad_de_medida;");
		Statement s;
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			while(rs.next()){
				Unidad_de_Medida uniMed = new Unidad_de_Medida();
				uniMed.setTipoMedida(rs.getString("tipoMedida"));
				uniMed.setUnidad_de_Medida_ID(rs.getInt("Unidad_de_Medida_ID"));
				listaUnidadMedida.add(uniMed);
			}
		} catch (Exception e){
			System.err.println("DATOS: ERROR " +e.getMessage());
		}
		return listaUnidadMedida;
	}

	public ArrayList<Mes> listaMeses(){
		ArrayList<Mes> listaMeses = new ArrayList<Mes>();
		String sql = ("SELECT * FROM sofcaps.mes;");
		Statement s;
		try {
			s = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = s.executeQuery(sql);
			while(rs.next()){
				Mes mes = new Mes();
				mes.setNombre(rs.getString("nombre"));
				
				listaMeses.add(mes);
			}
		} catch (Exception e){
			System.err.println("DATOS: ERROR " +e.getMessage());
		}
		return listaMeses;
	}
	
}



