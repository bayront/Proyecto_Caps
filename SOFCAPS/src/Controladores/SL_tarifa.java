package Controladores;
import Datos.DTTarifa;
import Datos.DataTableObject;
import Entidades.Tarifa;
import java.sql.SQLException;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import java.sql.ResultSet;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Servlet implementation class SL_tarifa
 */
@WebServlet("/SL_tarifa")
public class SL_tarifa extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DTTarifa datosTarifa = DTTarifa.getInstance();
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();
	PrintWriter out;
	
	//PrinterWriter out;
	//PrinterWriter out;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_tarifa() {
        super();
        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json");
		out = response.getWriter();
		try {
			traertarifas(response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("hola post");
		int lim_Inf, lim_Sup;
		String opcion;
		float monto;
		int Tarifa_ID;
		opcion = request.getParameter("opcion").trim();
		System.out.println("opcion a realizar: " + opcion);
		
		switch (opcion) {
		case "actualizar":
			lim_Inf = Integer.parseInt(request.getParameter("lim_Inf").trim());
			lim_Sup = Integer.parseInt(request.getParameter("lim_Sup").trim());
			monto= Float.parseFloat(request.getParameter("monto").trim());
			Tarifa_ID = Integer.parseInt(request.getParameter("Tarifa_ID").trim());
			actualizar(Tarifa_ID,lim_Inf,lim_Sup,monto,response);
			break;
		
		case "eliminar":
			Tarifa_ID= Integer.parseInt(request.getParameter("tarifa_ID"));
			eliminar(Tarifa_ID, response);
			break;
		
		case "guardar":
			lim_Inf = Integer.parseInt(request.getParameter("lim_Inf")); 
			lim_Sup = Integer.parseInt(request.getParameter("lim_Sup"));
			monto = Float.parseFloat(request.getParameter("monto").trim());
			//Tarifa_ID= Integer.parseInt(request.getParameter("Tarifa_ID").trim());
			guardar(lim_Inf, lim_Sup,monto, response);
			break;
		default:
			final JSONObject json = new JSONObject();
			response.setContentType("application/json");
			out = response.getWriter();
			json.put("respuesta", "OPCION_VACIA");
			System.out.println(json.toJSONString());
			out.print(json.toJSONString());
			break;
		}
	}
	private void actualizar(int tarifa_ID, int lim_Inf, int lim_Sup, float monto, HttpServletResponse response) {
		// TODO Auto-generated method stub
		Tarifa t = new Tarifa();
		boolean resultado = false;
		try 
		{
			//u.setLogin(login);
			t.setLim_Inf(lim_Inf);
			t.setLim_Sup(lim_Sup);
			t.setMonto(monto);
			t.setTarifa_ID(tarifa_ID);
			 resultado = datosTarifa.actualizarTarifa(t);
			 verificar_resultado(resultado, response);
			//response.sendRedirect("index.jsp?guardado");
		} 
		catch (Exception e) 
		{
			System.err.println("SL ERROR: "+e.getMessage());
		}
		
	}

	protected void guardar(int lim_Inf, int lim_Sup, float monto,HttpServletResponse response) {
		try 
		{
			Tarifa t = new Tarifa();
			boolean resultado = false;
			t.setLim_Inf(lim_Inf);
			t.setLim_Sup(lim_Sup);
			t.setMonto(monto);
			 resultado = datosTarifa.guardarTarifa(t);
			 verificar_resultado(resultado, response);
			//response.sendRedirect("index.jsp?guardado");
		} 
		catch (Exception e) 
		{
			System.err.println("SL ERROR: "+e.getMessage());
		}
	}
	
	protected void verificar_resultado(boolean r, HttpServletResponse response) throws IOException {
		final JSONObject json = new JSONObject();
		if(r) {
			response.setContentType("application/json");
			out = response.getWriter();
			json.put("respuesta", "BIEN");
			System.out.println(json.toJSONString());
			out.print(json.toJSONString());
		}else {
			response.setContentType("application/json");
			out = response.getWriter();
			json.put("respuesta", "ERROR");
			System.out.println(json.toJSONString());
			out.print(json.toJSONString());
		}
	}

	protected void eliminar(int Tarifa_ID, HttpServletResponse response) {
			Tarifa t = new Tarifa();
		boolean resultado = false;
		try 
		{
			
			t.setTarifa_ID(Tarifa_ID);
			resultado = datosTarifa.eliminarTarifa(t);
			verificar_resultado(resultado, response);
		} 
		catch (Exception e) 
		{
			System.err.println("SL ERROR: "+e.getMessage());
		}
	}
	protected void traertarifas (HttpServletResponse response)throws SQLException {
		
		List<Tarifa>tarifas = new ArrayList<>();
		ResultSet rs = datosTarifa.cargartarifa();
		while(rs.next()){
			Tarifa t = new Tarifa();
			t.setTarifa_ID(rs.getInt("Tarifa_ID"));
			t.setLim_Inf(rs.getInt("lim_Inf"));
			t.setLim_Sup(rs.getInt("lim_Sup"));
			t.setMonto(rs.getFloat("monto"));
			tarifas.add(t);
			
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for(Tarifa tarifa : tarifas){
			dataTableObject.aaData.add(tarifa);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
	}
	
	
	


}
