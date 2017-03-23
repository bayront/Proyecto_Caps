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
		try {
			try {
				traerConsumoBomba(response);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("ERROR: "+e.getMessage());
			}
			
		}catch (SQLException e){
			e.printStackTrace();
		}

	}
	
	private void traerConsumoBomba(HttpServletResponse response) throws SQLException, ParseException {
		List<Bomba> listaB = new ArrayList<>();
		ResultSet rs = dTconsB.cargarDatos();
		System.out.println("listar resgistros de bomba");
		while(rs.next()){
//			String fechaLecturaActual = fecha.format(rs.getDate("fechaLecturaActual"));
//			System.out.println(fechaLecturaActual);
			Bomba bomba = new Bomba();
			bomba.setBomba_ID(rs.getInt("Bomba_ID"));
			bomba.setConsumoActual(rs.getFloat("consumoActual"));
			bomba.setLecturaActual(rs.getFloat("lecturaActual"));
			String f = parseador2.format(rs.getDate("fechaLecturaActual"));
			bomba.setFechaLecturaActual(parseador2.parse(f));
			bomba.setObservaciones(rs.getString("observaciones"));
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
				//System.out.println("hola post , este es el id : " + request.getParameter("Bomba_ID") + " del registro de la bomba");
				String observaciones, opcion;
				Float consumoActual, lecturaActual;
				String fechaLecturaActual = null;
				java.util.Date fechaLecturaActual1 = null;
				int bomba_ID = 0;
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
					actualizar(bomba_ID, consumoActual, fechaLecturaActual1, lecturaActual, observaciones, response);
					break;
				case "eliminar":
					bomba_ID= Integer.parseInt(request.getParameter("bombaID"));
					System.out.println("bomba id: "+ bomba_ID);
					eliminar(bomba_ID, response);
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
					guardar(bomba_ID, consumoActual, fechaLecturaActual1, lecturaActual, observaciones, response);
					break;
				default:
					response.setContentType("text/plain");
					out = response.getWriter();
					out.print("VACIO");
					break;
				}
	}

	private void guardar(int bomba_ID, Float consumoActual, java.util.Date fechaLecturaActual1, Float lecturaActual,
			String observaciones, HttpServletResponse response) {
		try {
			Bomba bomb = new Bomba();
			
			bomb.setConsumoActual(consumoActual);
			bomb.setFechaLecturaActual(fechaLecturaActual1);
			bomb.setLecturaActual(lecturaActual);
			bomb.setObservaciones(observaciones);
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

	private void actualizar(int bomba_ID, Float consumoActual, java.util.Date fechaLecturaActual1, Float lecturaActual,
			String observaciones, HttpServletResponse response) {
		try {
			Bomba bomb = new Bomba();
			bomb.setBomba_ID(bomba_ID);
			bomb.setConsumoActual(consumoActual);
			bomb.setFechaLecturaActual(fechaLecturaActual1);
			bomb.setLecturaActual(lecturaActual);
			bomb.setObservaciones(observaciones);
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
