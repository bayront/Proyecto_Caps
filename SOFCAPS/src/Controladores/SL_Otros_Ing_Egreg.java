package Controladores;

import Datos.DataTableObject;


import Datos.DT_categoria_Ing_Engre;
import Entidades.Categoria_Ing_Egreg ;
import Entidades.Otros_Ing_Egreg;
import Datos.DTOtros_Ing_Egreg;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import org.json.simple.JSONObject;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;



/**
 * Servlet implementation class SL_Otros_Ing_Egreg
 */
@WebServlet("/SL_Otros_Ing_Egreg")
public class SL_Otros_Ing_Egreg extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DTOtros_Ing_Egreg dtOI = DTOtros_Ing_Egreg.getInstance();
	private DT_categoria_Ing_Engre datoscat = DT_categoria_Ing_Engre.getInstance();
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();
	private PrintWriter out;
	SimpleDateFormat parseador = new SimpleDateFormat("dd/MM/yyyy");
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_Otros_Ing_Egreg() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		response.setContentType("application/json");
		System.out.println("cargar: " + request.getParameter("carga"));
		try {
			if(Integer.parseInt(request.getParameter("carga")) == 1) {
				traerOI(response);
			}else if(Integer.parseInt(request.getParameter("carga")) == 2) {
				traerCI(response);
			}
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
		int  Categoria_Ing_Egreg_ID, Otros_Ing_Egreg_ID;
		String opcion,descripcion, fecha=null;
		java.util.Date fecha1 = null;
		String fechaForm = request.getParameter("fecha");
		//la palabra entre commillas debe ser igual al id del input que recibe la fecha
		
		float monto;
		System.out.println("fecha " + fechaForm);
		opcion = request.getParameter("opcion").trim();
		System.out.println("opcion a realizar: " + opcion);
		
		try {
			switch (opcion) {
			case "actualizar":
//				lim_Inf = Integer.parseInt(request.getParameter("lim_Inf").trim());
//				if(request.getParameter("lim_Sup").equals("") || request.getParameter("lim_Sup").isEmpty()) {
//					lim_Sup = 0;
//				}else {
//					lim_Sup = Integer.parseInt(request.getParameter("lim_Sup"));
//				}
				try {
					fechaForm = request.getParameter("fecha");
					fecha1 = parseador.parse(fechaForm);
					System.out.println(fecha1);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				
				Otros_Ing_Egreg_ID = Integer.parseInt(request.getParameter("Otros_Ing_Egreg_ID").trim());
				descripcion = request.getParameter("descripcion");
				monto= Float.parseFloat(request.getParameter("monto").trim());
				
				Categoria_Ing_Egreg_ID= Integer.parseInt(request.getParameter("categoria_Ing_Egreg_ID"));
				
				actualizar( Otros_Ing_Egreg_ID ,descripcion,monto,fecha1, Categoria_Ing_Egreg_ID, response);
				break;
			
			case "eliminar":
				Otros_Ing_Egreg_ID = Integer.parseInt(request.getParameter("Otros_Ing_Egreg_ID"));
				eliminar(Otros_Ing_Egreg_ID, response);
				break;
			
			case "guardar":
//				lim_Inf = Integer.parseInt(request.getParameter("lim_Inf")); 
//				if(request.getParameter("lim_Sup").equals("") || request.getParameter("lim_Sup").isEmpty()) {
//					lim_Sup = 0;
//				}else {
//					lim_Sup = Integer.parseInt(request.getParameter("lim_Sup"));
//				}
				try {
					fechaForm = request.getParameter("fecha");
					fecha1 = parseador.parse(fechaForm);
					System.out.println(fecha1);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				descripcion = request.getParameter("descripcion");
				monto = Float.parseFloat(request.getParameter("monto").trim());
				Categoria_Ing_Egreg_ID = Integer.parseInt(request.getParameter("categoria_Ing_Egreg_ID"));
			
				//String descripcion,float monto, int categoria_Ing_Egreg_ID,
				guardar(descripcion,monto,fecha1, Categoria_Ing_Egreg_ID, response);
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
	
	private void actualizar(int otros_Ing_Egreg_ID, String descripcion, float monto,java.util.Date fecha1,
			int categoria_Ing_Egreg_ID,  HttpServletResponse response) {
		try 
		{
			Otros_Ing_Egreg t = new Otros_Ing_Egreg();
			Categoria_Ing_Egreg  cat =  new Categoria_Ing_Egreg ();
			cat.setCategoria_Ing_Egreg_ID(categoria_Ing_Egreg_ID);
			//Unidad_de_Medida um = new Unidad_de_Medida();
		//	um.setUnidad_de_Medida_ID(unidadMedida_ID);
//			t.setLim_Inf(lim_Inf);
//			t.setLim_Sup(lim_Sup);
			t.setFecha(fecha1);
			t.setDescripcion(descripcion);
			t.setMonto(monto);
			t.setOtros_Ing_Egreg_ID(otros_Ing_Egreg_ID);
			t.setCategoria_Ing_Egreg(cat);
			//t.setUnidad_de_Medida(um);
			verificar_resultado(dtOI.actualizarOI(t), response);
		} 
		catch (Exception e) 
		{
			System.err.println("SL ERROR: "+e.getMessage());
		}
		
	}

	protected void guardar(String descripcion,float monto, java.util.Date fecha1,int categoria_Ing_Egreg_ID,
			 HttpServletResponse response) {
		try 
		{
			Otros_Ing_Egreg t = new Otros_Ing_Egreg();
			Categoria_Ing_Egreg cat =  new Categoria_Ing_Egreg();
			cat.setCategoria_Ing_Egreg_ID(categoria_Ing_Egreg_ID);
			//Unidad_de_Medida um = new Unidad_de_Medida();
			//um.setUnidad_de_Medida_ID(unidadMedida_ID);
//			t.setLim_Inf(lim_Inf);
//			t.setLim_Sup(lim_Sup);
			t.setFecha(fecha1);
			t.setDescripcion(descripcion);
			t.setMonto(monto);
			t.setCategoria_Ing_Egreg(cat);
		//	t.setUnidad_de_Medida(um);
			verificar_resultado(dtOI.guardarOI(t), response);
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

	protected void eliminar(int Otros_Ing_Egreg_ID, HttpServletResponse response) {
		try 
		{
			Otros_Ing_Egreg t = new Otros_Ing_Egreg();
			t.setOtros_Ing_Egreg_ID(Otros_Ing_Egreg_ID);
			verificar_resultado(dtOI.eliminarOI(t), response);
		} 
		catch (Exception e) 
		{
			System.err.println("SL ERROR: "+e.getMessage());
		}
	}
	protected void traerOI (HttpServletResponse response)throws SQLException, IOException {
		PrintWriter out;
		out = response.getWriter();
		List<Otros_Ing_Egreg>oi = new ArrayList<>();
		ResultSet rs = dtOI.cargarCOI();
		while(rs.next()){
			Otros_Ing_Egreg t = new Otros_Ing_Egreg();
			Categoria_Ing_Egreg cat = new Categoria_Ing_Egreg();
//			Unidad_de_Medida um = new Unidad_de_Medida();
//			um.setUnidad_de_Medida_ID(rs.getInt("Unidad_de_Medida_ID"));
			cat.setCategoria_Ing_Egreg_ID(rs.getInt("Categoria_Ing_Egreg_ID"));
			cat.setNombreCategoria(rs.getString("nombreCategoria"));
			t.setOtros_Ing_Egreg_ID(rs.getInt("Otros_Ing_Egreg_ID"));
			t.setFecha(rs.getDate("fecha"));
			t.setDescripcion(rs.getString("descripcion"));
			t.setMonto(rs.getFloat("monto"));
			t.setCategoria_Ing_Egreg(cat);
//			t.setUnidad_de_Medida(um);
			oi.add(t);
			
		}
		
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for(Otros_Ing_Egreg ois : oi){
			dataTableObject.aaData.add(ois);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
	}
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
	

	private void traerCI(HttpServletResponse response) throws SQLException, IOException {
		Gson gson2 = new GsonBuilder().setPrettyPrinting().create();
		System.out.println("metodo 2");
		PrintWriter out2;
		response.setContentType("application/json");
		out2 = response.getWriter();
		List<Categoria_Ing_Egreg> categorias = new ArrayList<>();
		ResultSet rs = datoscat.cargarDatos();
		while(rs.next()){
			Categoria_Ing_Egreg cat = new Categoria_Ing_Egreg();
			
			cat.setNombreCategoria(rs.getString("nombreCategoria"));
			cat.setCategoria_Ing_Egreg_ID(rs.getInt("Categoria_Ing_Egreg_ID"));
			categorias.add(cat);
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Categoria_Ing_Egreg  categoria : categorias) {
			dataTableObject.aaData.add(categoria);
		}
		String json = gson2.toJson(dataTableObject);
		System.out.println("DATOS: " + json.toString());
		out2.print(json);
	}
	
	



}