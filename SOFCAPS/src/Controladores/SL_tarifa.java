package Controladores;
import Datos.DTTarifa;
import Datos.DataTableObject;
import Entidades.Tarifa;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

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
	private DTTarifa datosTarifa = new DTTarifa();
	PrintWriter out;
	//PrinterWriter out;
	//PrinterWriter out;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_tarifa() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		List<Tarifa>tarifas = datosTarifa.tarifas();
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Tarifa t : tarifas) {
			dataTableObject.aaData.add(t);
		}
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	protected void guardar(int lim_Inf, int lim_Sup, float monto,HttpServletResponse response) {
		Tarifa t = new Tarifa();
		boolean resultado = false;
		try 
		{
			//u.setLogin(login);
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


}
