package Controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.text.DateFormat;
import java.text.ParseException;



import org.json.simple.JSONObject;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import Datos.DT_categoria_Ing_Engre;
import Datos.DT_consumo_bomba;
import Datos.DataTableObject;
import Entidades.Bomba;
import Entidades.Categoria_Ing_Egreg;
import Entidades.TipoCategoria;
import Entidades.Unidad_de_Medida;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SL_Consumo_bomba
 */
@WebServlet("/SL_Consumo_bomba")
public class SL_Consumo_bomba extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PrintWriter out;
	private DT_consumo_bomba dTconsB = DT_consumo_bomba.getInstance();
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();
	
	SimpleDateFormat parseador = new SimpleDateFormat("dd/MM/yyyy");
	SimpleDateFormat parseador2 = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH);
       
    public SL_Consumo_bomba() {
        super();        
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		out = response.getWriter();
		if(Integer.parseInt(request.getParameter("carga")) == 1) {
			try {
				try {
					int anioB= Integer.parseInt(request.getParameter("anioB"));
					int periodoB= Integer.parseInt(request.getParameter("periodoB"));
					traerConsumoBomba(anioB, periodoB,response);
				} catch (ParseException e) {
					e.printStackTrace();
					System.out.println("ERROR: "+e.getMessage());
				}
			}catch (SQLException e){
				e.printStackTrace();
			}
		}else if(Integer.parseInt(request.getParameter("carga")) == 2) {
			try {
				try {
					int anioB= Integer.parseInt(request.getParameter("anioB"));
					int periodoB= Integer.parseInt(request.getParameter("periodoB"));
					traerConsumoBombaInactivos(anioB, periodoB,response);
				}catch (ParseException e) {
					e.printStackTrace();
					System.out.println("ERROR: "+e.getMessage());
				}		
			}catch (SQLException e){
				e.printStackTrace();
			}
		}
	}
	
	private void traerConsumoBomba(int anioB, int periodoB, HttpServletResponse response) throws SQLException, ParseException {
		List<Bomba> listaB = new ArrayList<>();
		int mesI=0, mesF=0;
		if(periodoB == 1) {
			mesI= 1;
			mesF= 6;
		}else if(periodoB == 2) {
			mesI= 7;
			mesF= 12;
		}
		ResultSet rs = dTconsB.cargarDatosTabla(anioB, mesI, mesF);
		System.out.println("listar resgistros de bomba");
		while(rs.next()){
			Bomba bomba = new Bomba();
			Unidad_de_Medida uniMed = new Unidad_de_Medida();
			bomba.setBomba_ID(rs.getInt("Bomba_ID"));
			bomba.setConsumoActual(rs.getFloat("consumoActual"));
			bomba.setLecturaActual(rs.getFloat("lecturaActual"));
			String f = parseador2.format(rs.getDate("fechaLecturaActual"));
			bomba.setFechaLecturaActual(parseador2.parse(f));
			String observacion = rs.getString("observaciones");
			if(observacion == "" || observacion == null) {
				bomba.setObservaciones("");
			}else {
				bomba.setObservaciones(rs.getString("observaciones"));
			}
			uniMed.setTipoMedida(rs.getNString("tipoMedida"));
			uniMed.setUnidad_de_Medida_ID(rs.getInt("Unidad_de_Medida_ID"));
			bomba.setUnidad_de_Medida(uniMed);
			listaB.add(bomba);
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Bomba bn : listaB) {
			dataTableObject.aaData.add(bn);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
		out.flush();	
	}
	
	private void traerConsumoBombaInactivos(int anioB, int periodoB, HttpServletResponse response) throws SQLException, ParseException {
		List<Bomba> listaB = new ArrayList<>();
		int mesI=0, mesF=0;
		if(periodoB == 1) {
			mesI= 1;
			mesF= 6;
		}else if(periodoB == 2) {
			mesI= 7;
			mesF= 12;
		}
		ResultSet rs = dTconsB.cargarDatosInactivos(anioB, mesI, mesF);
		System.out.println("listar resgistros de bomba");
		while(rs.next()){
			Bomba bomba = new Bomba();
			Unidad_de_Medida uniMed = new Unidad_de_Medida();
			bomba.setBomba_ID(rs.getInt("Bomba_ID"));
			bomba.setConsumoActual(rs.getFloat("consumoActual"));
			bomba.setLecturaActual(rs.getFloat("lecturaActual"));
			String f = parseador2.format(rs.getDate("fechaLecturaActual"));
			bomba.setFechaLecturaActual(parseador2.parse(f));
			String observacion = rs.getString("observaciones");
			if(observacion == "" || observacion == null) {
				bomba.setObservaciones("");
			}else {
				bomba.setObservaciones(rs.getString("observaciones"));
			}
			uniMed.setTipoMedida(rs.getNString("tipoMedida"));
			uniMed.setUnidad_de_Medida_ID(rs.getInt("Unidad_de_Medida_ID"));
			bomba.setUnidad_de_Medida(uniMed);
			listaB.add(bomba);	
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Bomba bn : listaB) {
			dataTableObject.aaData.add(bn);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
		out.flush();	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				String observaciones, opcion;
				Float consumoActual, lecturaActual;
				String fechaLecturaActual = null;
				java.util.Date fechaLecturaActual1 = null;
				int bomba_ID = 0;
				int uniMedID;
				opcion = request.getParameter("opcion").trim();
//				String fecha = request.getParameter("fecha");
//				System.out.println("fecha_actual: " + fecha);
				System.out.println("opcion a realizar: " + opcion);
				switch (opcion) {
				case "actualizar":
					
					consumoActual = Float.parseFloat(request.getParameter("consumoActual").trim());
					try {
						
						fechaLecturaActual = request.getParameter("fecha");
						
						fechaLecturaActual1 = parseador.parse(fechaLecturaActual);
						System.out.println("fecha pasada:  " + fechaLecturaActual1.toString());
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					lecturaActual = Float.parseFloat(request.getParameter("lecturaActual").trim());
					observaciones = request.getParameter("observaciones").trim();
					bomba_ID= Integer.parseInt(request.getParameter("bombaID"));
					uniMedID = Integer.parseInt(request.getParameter("unidadMedida"));
					actualizar(bomba_ID, consumoActual, fechaLecturaActual1, lecturaActual, observaciones, uniMedID, response);
					break;
				case "eliminar":
					bomba_ID= Integer.parseInt(request.getParameter("bombaID"));
					System.out.println("bomba id: "+ bomba_ID);
					eliminar(bomba_ID, response);
					break;
				case "activar":
					bomba_ID= Integer.parseInt(request.getParameter("bombaID"));
					System.out.println("bomba id: "+ bomba_ID);
					activar(bomba_ID, response);
					break;
				case "guardar":
					consumoActual = Float.parseFloat(request.getParameter("consumoActual").trim());
					try {
						
						fechaLecturaActual = request.getParameter("fecha");
						
						fechaLecturaActual1 = parseador.parse(fechaLecturaActual);
						System.out.println("fecha pasada:  " + fechaLecturaActual1.toString());
						//fechaLecturaActual = (Date) formatter.parse(request.getParameter("fechaLecturaActual").trim());
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					lecturaActual = Float.parseFloat(request.getParameter("lecturaActual").trim());
					observaciones = request.getParameter("observaciones").trim();
					uniMedID = Integer.parseInt(request.getParameter("unidadMedida"));
					guardar(bomba_ID, consumoActual, fechaLecturaActual1, lecturaActual, observaciones, uniMedID, response);
					break;
				default:
					response.setContentType("text/plain");
					out = response.getWriter();
					out.print("VACIO");
					break;
				}
	}

	private void guardar(int bomba_ID, Float consumoActual, java.util.Date fechaLecturaActual1, Float lecturaActual,
			String observaciones, int uniMedID, HttpServletResponse response) {
		try {
			Bomba bomb = new Bomba();
			Unidad_de_Medida med = new Unidad_de_Medida();
			bomb.setConsumoActual(consumoActual);
			bomb.setFechaLecturaActual(fechaLecturaActual1);
			bomb.setLecturaActual(lecturaActual);
			bomb.setObservaciones(observaciones);
			med.setUnidad_de_Medida_ID(uniMedID);
			bomb.setUnidad_de_Medida(med);
			verificarResultado(dTconsB.guardarRegBomba(bomb), response);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ERROR EN EL SERVLET CONSUMO_BOMBA: " + e.getMessage());
		}
		
	}

	private void eliminar(int bomba_ID, HttpServletResponse response) {
		try {
			Bomba bomb = new Bomba();
			bomb.setBomba_ID(bomba_ID);
			verificarResultado(dTconsB.eliminarRegBomba(bomb), response);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ERROR EN EL SERVLET CONSUMO_BOMBA: " + e.getMessage());
		}
		
	}

	private void activar(int bomba_ID, HttpServletResponse response) {
		try {
			Bomba bomb = new Bomba();
			bomb.setBomba_ID(bomba_ID);
			verificarResultado(dTconsB.activar(bomb), response);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ERROR EN EL SERVLET CONSUMO_BOMBA: " + e.getMessage());
		}
		
	}
	
	private void actualizar(int bomba_ID, Float consumoActual, java.util.Date fechaLecturaActual1, Float lecturaActual,
			String observaciones, int uniMedID, HttpServletResponse response) {
		try {
			Bomba bomb = new Bomba();
			Unidad_de_Medida med = new Unidad_de_Medida();
			bomb.setBomba_ID(bomba_ID);
			bomb.setConsumoActual(consumoActual);
			bomb.setFechaLecturaActual(fechaLecturaActual1);
			bomb.setLecturaActual(lecturaActual);
			bomb.setObservaciones(observaciones);
			med.setUnidad_de_Medida_ID(uniMedID);
			bomb.setUnidad_de_Medida(med);
			verificarResultado(dTconsB.actualizarBomba(bomb), response);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ERROR EN EL SERVLET CONSUMO_BOMBA: " + e.getMessage());
		}
		
	}
	
	private void verificarResultado(boolean r, HttpServletResponse response) {
		try {
			if(r){
				response.setContentType("text/plain");
				out = response.getWriter();
				out.print("BIEN");
			}else{
				response.setContentType("text/plain");
				out = response.getWriter();
				out.print("ERROR");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
