package Controladores;
import Datos.DTCategoria;
import Datos.DTTarifa;
import Datos.DT_UnidadMedida;
import Datos.DataTableObject;
import Entidades.Categoria;
import Entidades.Tarifa;
import Entidades.Unidad_de_Medida;

import java.sql.SQLException;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	private DT_UnidadMedida dtUM = DT_UnidadMedida.getInstance();
	private DTCategoria dtCat = DTCategoria.getInstance();
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();
	
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
		System.out.println("cargar: " + request.getParameter("carga"));
		try {
			if(Integer.parseInt(request.getParameter("carga")) == 1) {
				traertarifas(response);
			}else if(Integer.parseInt(request.getParameter("carga")) == 2) {
				traerCategorias(response);
			}else if(Integer.parseInt(request.getParameter("carga")) == 3) {
				traerUnidadMedida(response);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @throws IOException 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		System.out.println("hola post");
		int lim_Inf, lim_Sup, categoria_ID, unidadMedida_ID;
		String opcion;
		float monto, montoRound;
		int Tarifa_ID;
		opcion = request.getParameter("opcion").trim();
		System.out.println("opcion a realizar: " + opcion);
		
		try {
			switch (opcion) {
			case "actualizar":
				lim_Inf = Integer.parseInt(request.getParameter("lim_Inf").trim());
				if(request.getParameter("lim_Sup").equals("") || request.getParameter("lim_Sup").isEmpty()) {
					lim_Sup = 0;
				}else {
					lim_Sup = Integer.parseInt(request.getParameter("lim_Sup"));
				}
				monto= Float.parseFloat(request.getParameter("monto").trim());
				montoRound = (float) (Math.round(monto * 100.0) / 100.0);
				Tarifa_ID = Integer.parseInt(request.getParameter("Tarifa_ID").trim());
				categoria_ID = Integer.parseInt(request.getParameter("categoria_ID").trim());
				unidadMedida_ID = Integer.parseInt(request.getParameter("unidadMedida_ID").trim());
				actualizar(Tarifa_ID,lim_Inf,lim_Sup,montoRound, categoria_ID, unidadMedida_ID, response);
				break;
			
			case "eliminar":
				Tarifa_ID= Integer.parseInt(request.getParameter("tarifa_ID"));
				eliminar(Tarifa_ID, response);
				break;
			
			case "guardar":
				lim_Inf = Integer.parseInt(request.getParameter("lim_Inf")); 
				if(request.getParameter("lim_Sup").equals("") || request.getParameter("lim_Sup").isEmpty()) {
					lim_Sup = 0;
				}else {
					lim_Sup = Integer.parseInt(request.getParameter("lim_Sup"));
				}
				monto = Float.parseFloat(request.getParameter("monto").trim());
				montoRound = (float) (Math.round(monto * 100.0) / 100.0);
				categoria_ID = Integer.parseInt(request.getParameter("categoria_ID").trim());
				unidadMedida_ID = Integer.parseInt(request.getParameter("unidadMedida_ID").trim());
				guardar(lim_Inf, lim_Sup,montoRound, categoria_ID, unidadMedida_ID, response);
				break;
			default:
				response.setContentType("text/plain");
				PrintWriter out;
				out = response.getWriter();
				out.print("VACIO");
				break;
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			verificar_resultado(false, response);
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}
	private void actualizar(int tarifa_ID, int lim_Inf, int lim_Sup, float monto,
			int categoria_ID, int unidadMedida_ID, HttpServletResponse response) {
		try 
		{
			Tarifa t = new Tarifa();
			Categoria cat =  new Categoria();
			cat.setCategoria_ID(categoria_ID);
			Unidad_de_Medida um = new Unidad_de_Medida();
			um.setUnidad_de_Medida_ID(unidadMedida_ID);
			t.setLim_Inf(lim_Inf);
			t.setLim_Sup(lim_Sup);
			t.setMonto(monto);
			t.setTarifa_ID(tarifa_ID);
			t.setCategoria(cat);
			t.setUnidad_de_Medida(um);
			verificar_resultado(datosTarifa.actualizarTarifa(t), response);
		} 
		catch (Exception e) 
		{
			System.err.println("SL ERROR: "+e.getMessage());
		}
		
	}

	protected void guardar(int lim_Inf, int lim_Sup, float monto, int categoria_ID,
			int unidadMedida_ID, HttpServletResponse response) {
		try 
		{
			Tarifa t = new Tarifa();
			Categoria cat =  new Categoria();
			cat.setCategoria_ID(categoria_ID);
			Unidad_de_Medida um = new Unidad_de_Medida();
			um.setUnidad_de_Medida_ID(unidadMedida_ID);
			t.setLim_Inf(lim_Inf);
			t.setLim_Sup(lim_Sup);
			t.setMonto(monto);
			t.setCategoria(cat);
			t.setUnidad_de_Medida(um);
			verificar_resultado(datosTarifa.guardarTarifa(t), response);
		} 
		catch (Exception e) 
		{
			System.err.println("SL ERROR: "+e.getMessage());
		}
	}
	
	protected void verificar_resultado(boolean r, HttpServletResponse response) throws IOException {
		response.setContentType("text/plain");
		PrintWriter out;
		if(r) {
			out = response.getWriter();
			out.print("BIEN");
		}else {
			out = response.getWriter();
			out.print("ERROR");
		}
	}

	protected void eliminar(int Tarifa_ID, HttpServletResponse response) {
		try 
		{
			Tarifa t = new Tarifa();
			t.setTarifa_ID(Tarifa_ID);
			verificar_resultado(datosTarifa.eliminarTarifa(t), response);
		} 
		catch (Exception e) 
		{
			System.err.println("SL ERROR: "+e.getMessage());
		}
	}
	protected void traertarifas (HttpServletResponse response)throws SQLException, IOException {
		PrintWriter out;
		out = response.getWriter();
		List<Tarifa>tarifas = new ArrayList<>();
		ResultSet rs = datosTarifa.cargarTarifaCategoria();
		while(rs.next()){
			Tarifa t = new Tarifa();
			Categoria cat = new Categoria();
			Unidad_de_Medida um = new Unidad_de_Medida();
			um.setUnidad_de_Medida_ID(rs.getInt("Unidad_de_Medida_ID"));
			cat.setCategoria_ID(rs.getInt("Categoria_ID"));
			cat.setNomCategoria(rs.getString("nomCategoria"));
			t.setTarifa_ID(rs.getInt("Tarifa_ID"));
			t.setLim_Inf(rs.getInt("lim_Inf"));
			int lim_Sup = rs.getInt("lim_Sup");
			if(lim_Sup == 0) {
				System.out.println("no hay lim_Sup: " + lim_Sup);
			}else {
				t.setLim_Sup(rs.getInt("lim_Sup"));
			}
			t.setMonto(rs.getFloat("monto"));
			t.setCategoria(cat);
			t.setUnidad_de_Medida(um);
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
	private void traerUnidadMedida(HttpServletResponse response) throws SQLException, IOException {
		Gson gson2 = new GsonBuilder().setPrettyPrinting().create();
		PrintWriter out2;
		out2 = response.getWriter();
		List<Unidad_de_Medida> unidades = new ArrayList<>();
		ResultSet rs = dtUM.cargarUnidad_Medida();
		while(rs.next()){
			Unidad_de_Medida um = new Unidad_de_Medida();
			um.setTipoMedida(rs.getString("tipoMedida"));
			um.setUnidad_de_Medida_ID(rs.getInt("Unidad_de_Medida_ID"));
			unidades.add(um);
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Unidad_de_Medida unidad_de_Medida : unidades) {
			dataTableObject.aaData.add(unidad_de_Medida);
		}
		String json = gson2.toJson(dataTableObject);
		System.out.println(json.toString());
		out2.print(json);
	}

	private void traerCategorias(HttpServletResponse response) throws SQLException, IOException {
		Gson gson2 = new GsonBuilder().setPrettyPrinting().create();
		PrintWriter out2;
		response.setContentType("application/json");
		out2 = response.getWriter();
		List<Categoria> categorias = new ArrayList<>();
		ResultSet rs = dtCat.Categorias();
		while(rs.next()){
			Categoria cat = new Categoria();
			cat.setNomCategoria(rs.getString("nomCategoria"));
			cat.setCategoria_ID(rs.getInt("Categoria_ID"));
			categorias.add(cat);
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Categoria categoria : categorias) {
			dataTableObject.aaData.add(categoria);
		}
		String json = gson2.toJson(dataTableObject);
		System.out.println("DATOS: " + json.toString());
		out2.print(json);
	}
	
	


}
