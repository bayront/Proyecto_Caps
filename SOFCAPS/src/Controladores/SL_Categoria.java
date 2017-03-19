package Controladores;
import Datos.DTCategoria;


import Datos.DataTableObject;
import Entidades.Categoria;


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
@WebServlet("/SL_Categoria")
public class SL_Categoria extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DTCategoria datosCategoria = DTCategoria.getInstance();
//	private DT_UnidadMedida dtUM = DT_UnidadMedida.getInstance();
	//private DTCategoria dtCat = DTCategoria.getInstance();
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();
	
	//PrinterWriter out;
	//PrinterWriter out;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_Categoria() {
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
				traerCategorias(response);
			}else if(Integer.parseInt(request.getParameter("carga")) == 2) {
				traerCategorias(response);
			}else if(Integer.parseInt(request.getParameter("carga")) == 3) {
				traerCategorias(response);
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
		int categoria_ID;
		
		String opcion,nomCategoria;;
	
		
		opcion = request.getParameter("opcion").trim();
		System.out.println("opcion a realizar: " + opcion);
		
		try {
			switch (opcion) {
			case "actualizar":
				
//				if(request.getParameter("lim_Sup").equals("") || request.getParameter("lim_Sup").isEmpty()) {
//					lim_Sup = 0;
//				}else {
//					lim_Sup = Integer.parseInt(request.getParameter("lim_Sup"));
//				}
				
				categoria_ID = Integer.parseInt(request.getParameter("categoria_ID").trim());
				nomCategoria = request.getParameter("nomCategoria");

				actualizar( categoria_ID, nomCategoria, response);
				break;
			
			case "eliminar":
				categoria_ID= Integer.parseInt(request.getParameter("categoria_ID"));
				System.out.println("cat_id: "+categoria_ID);
				eliminar(categoria_ID, response);
				break;
			
			case "guardar":
//				lim_Inf = Integer.parseInt(request.getParameter("lim_Inf")); 
//				if(request.getParameter("lim_Sup").equals("") || request.getParameter("lim_Sup").isEmpty()) {
//					lim_Sup = 0;
//				}else {
//					lim_Sup = Integer.parseInt(request.getParameter("lim_Sup"));
//				}
//				monto = Float.parseFloat(request.getParameter("monto").trim());
				//categoria_ID = Integer.parseInt(request.getParameter("categoria_ID").trim());
				nomCategoria = request.getParameter("nomCategoria");
				guardar(nomCategoria, response);
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
	private void actualizar(int categoria_ID, String nomCategoria, HttpServletResponse response) {
		try 
		{
			
			Categoria cat =  new Categoria();
			cat.setCategoria_ID(categoria_ID);
			cat.setNomCategoria(nomCategoria);
			
			verificar_resultado(datosCategoria.actualizarCategoria(cat), response);
		} 
		catch (Exception e) 
		{
			System.err.println("SL ERROR: "+e.getMessage());
		}
		
	}

	protected void guardar(String nomCategoria, HttpServletResponse response) {
		try 
		{

			Categoria cat =  new Categoria();
			cat.setNomCategoria(nomCategoria);
			
			
			
			verificar_resultado(datosCategoria.guardarCategoria(cat), response);
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

	protected void eliminar(int categoria_ID, HttpServletResponse response) {
		try 
		{
			Categoria c = new Categoria();
			c.setCategoria_ID(categoria_ID);
			System.out.println("cat_ID_ "+categoria_ID);
			verificar_resultado(datosCategoria.eliminarCategoria(c), response);
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println("ERROR EN EL SERVLET CATEGORIA INGRESOS Y EGRESOS: " + e.getMessage());
		}
	}
//	protected void traertarifas (HttpServletResponse response)throws SQLException, IOException {
//		PrintWriter out;
//		out = response.getWriter();
//		List<Tarifa>tarifas = new ArrayList<>();
//		ResultSet rs = datosTarifa.cargarTarifaCategoria();
//		while(rs.next()){
//			Tarifa t = new Tarifa();
//			Categoria cat = new Categoria();
//			Unidad_de_Medida um = new Unidad_de_Medida();
//			um.setUnidad_de_Medida_ID(rs.getInt("Unidad_de_Medida_ID"));
//			cat.setCategoria_ID(rs.getInt("Categoria_ID"));
//			cat.setNomCategoria(rs.getString("nomCategoria"));
//			t.setTarifa_ID(rs.getInt("Tarifa_ID"));
//			t.setLim_Inf(rs.getInt("lim_Inf"));
//			int lim_Sup = rs.getInt("lim_Sup");
//			if(lim_Sup == 0) {
//				System.out.println("no hay lim_Sup: " + lim_Sup);
//			}else {
//				t.setLim_Sup(rs.getInt("lim_Sup"));
//			}
//			t.setMonto(rs.getFloat("monto"));
//			t.setCategoria(cat);
//			t.setUnidad_de_Medida(um);
//			tarifas.add(t);
//			
//		}
//		DataTableObject dataTableObject = new DataTableObject();
//		dataTableObject.aaData = new ArrayList<>();
//		for(Tarifa tarifa : tarifas){
//			dataTableObject.aaData.add(tarifa);
//		}
//		String json = gson.toJson(dataTableObject);
//		System.out.println(json.toString());
//		out.print(json);
//	}
//	private void traerUnidadMedida(HttpServletResponse response) throws SQLException, IOException {
//		Gson gson2 = new GsonBuilder().setPrettyPrinting().create();
//		PrintWriter out2;
//		out2 = response.getWriter();
//		List<Unidad_de_Medida> unidades = new ArrayList<>();
//		ResultSet rs = dtUM.cargarUnidad_Medida();
//		while(rs.next()){
//			Unidad_de_Medida um = new Unidad_de_Medida();
//			um.setTipoMedida(rs.getString("tipoMedida"));
//			um.setUnidad_de_Medida_ID(rs.getInt("Unidad_de_Medida_ID"));
//			unidades.add(um);
//		}
//		DataTableObject dataTableObject = new DataTableObject();
//		dataTableObject.aaData = new ArrayList<>();
//		for (Unidad_de_Medida unidad_de_Medida : unidades) {
//			dataTableObject.aaData.add(unidad_de_Medida);
//		}
//		String json = gson2.toJson(dataTableObject);
//		System.out.println(json.toString());
//		out2.print(json);
//	}

	private void traerCategorias(HttpServletResponse response) throws SQLException, IOException {
		Gson gson2 = new GsonBuilder().setPrettyPrinting().create();
		PrintWriter out2;
		response.setContentType("application/json");
		out2 = response.getWriter();
		List<Categoria> categorias = new ArrayList<>();
		ResultSet rs = datosCategoria.Categorias();
		while(rs.next()){
			Categoria cat = new Categoria();
			cat.setNomCategoria(rs.getString("nomCategoria"));
			cat.setCategoria_ID(rs.getInt("categoria_ID"));
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
