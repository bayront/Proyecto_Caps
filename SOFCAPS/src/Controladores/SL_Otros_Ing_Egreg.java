package Controladores;

import Datos.DataTableObject;

import Datos.DT_categoria_Ing_Engre;
import Entidades.Categoria_Ing_Egreg ;
import Entidades.Otros_Ing_Egreg;
import Datos.DTOtros_Ing_Egreg;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;

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
	SimpleDateFormat parseador = new SimpleDateFormat("dd/MM/yyyy");
	SimpleDateFormat parseador2 = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_Otros_Ing_Egreg() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		System.out.println("cargar: " + request.getParameter("carga"));
		try {
			if(Integer.parseInt(request.getParameter("carga")) == 1) {
				try {
					traerOI(response);
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}else if(Integer.parseInt(request.getParameter("carga")) == 2) {
				traerCI(response);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("hola post");
		int  Categoria_Ing_Egreg_ID, Otros_Ing_Egreg_ID;
		String opcion,descripcion;
		java.util.Date fecha1 = null;
		String fechaForm;
		float monto, montoRound;
		//la palabra entre commillas debe ser igual al id del input que recibe la fecha
		opcion = request.getParameter("opcion").trim();
		System.out.println("opcion a realizar: " + opcion);
		
		try {
			switch (opcion) {
			case "actualizar":
				try {
					fechaForm = request.getParameter("fecha");
					fecha1 = parseador.parse(fechaForm);
					System.out.println(fecha1);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				Otros_Ing_Egreg_ID = Integer.parseInt(request.getParameter("Otros_Ing_Egreg_ID").trim());
				descripcion = request.getParameter("descripcion");
				monto= Float.parseFloat(request.getParameter("monto").trim());
				montoRound = (float) (Math.round(monto * 100.0) / 100.0);
				Categoria_Ing_Egreg_ID= Integer.parseInt(request.getParameter("categoria_Ing_Egreg_ID"));
				actualizar( Otros_Ing_Egreg_ID ,descripcion,montoRound,fecha1, Categoria_Ing_Egreg_ID, response);
				break;
			
			case "eliminar":
				Otros_Ing_Egreg_ID = Integer.parseInt(request.getParameter("Otros_Ing_Egreg_ID"));
				eliminar(Otros_Ing_Egreg_ID, response);
				break;
			
			case "guardar":
				try {
					fechaForm = request.getParameter("fecha");
					fecha1 = parseador.parse(fechaForm);
					System.out.println(fecha1);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				descripcion = request.getParameter("descripcion");
				monto = Float.parseFloat(request.getParameter("monto").trim());
				montoRound = (float) (Math.round(monto * 100.0) / 100.0);
				Categoria_Ing_Egreg_ID = Integer.parseInt(request.getParameter("categoria_Ing_Egreg_ID"));
				//String descripcion,float monto, int categoria_Ing_Egreg_ID,
				guardar(descripcion,montoRound,fecha1, Categoria_Ing_Egreg_ID, response);
				break;
			default:
				response.setContentType("text/plain");
				PrintWriter out;
				out = response.getWriter();
				out.print("VACIO");
				break;
			}
		} catch (NumberFormatException e) {
			verificar_resultado(false, response);
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}
	
	private void actualizar(int otros_Ing_Egreg_ID, String descripcion, float monto,java.util.Date fecha1,
			int categoria_Ing_Egreg_ID,  HttpServletResponse response) {
		try {
			Otros_Ing_Egreg t = new Otros_Ing_Egreg();
			Categoria_Ing_Egreg  cat =  new Categoria_Ing_Egreg ();
			cat.setCategoria_Ing_Egreg_ID(categoria_Ing_Egreg_ID);
			t.setFecha(fecha1);
			t.setDescripcion(descripcion);
			t.setMonto(monto);
			t.setOtros_Ing_Egreg_ID(otros_Ing_Egreg_ID);
			t.setCategoria_Ing_Egreg(cat);
			verificar_resultado(dtOI.actualizarOI(t), response);
		}catch (Exception e) {
			System.err.println("SL ERROR: "+e.getMessage());
		}
	}

	protected void guardar(String descripcion,float monto, java.util.Date fecha1,int categoria_Ing_Egreg_ID,
			 HttpServletResponse response) {
		try{
			Otros_Ing_Egreg t = new Otros_Ing_Egreg();
			Categoria_Ing_Egreg cat =  new Categoria_Ing_Egreg();
			cat.setCategoria_Ing_Egreg_ID(categoria_Ing_Egreg_ID);
			t.setFecha(fecha1);
			t.setDescripcion(descripcion);
			t.setMonto(monto);
			t.setCategoria_Ing_Egreg(cat);
			verificar_resultado(dtOI.guardarOI(t), response);
		}catch (Exception e) {
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
		try {
			Otros_Ing_Egreg t = new Otros_Ing_Egreg();
			t.setOtros_Ing_Egreg_ID(Otros_Ing_Egreg_ID);
			verificar_resultado(dtOI.eliminarOI(t), response);
		}catch (Exception e){
			System.err.println("SL ERROR: "+e.getMessage());
		}
	}
	
	protected void traerOI (HttpServletResponse response)throws SQLException, IOException, ParseException {
		PrintWriter out;
		out = response.getWriter();
		List<Otros_Ing_Egreg>oi = new ArrayList<>();
		ResultSet rs = dtOI.cargarCOI();
		while(rs.next()){
			Otros_Ing_Egreg t = new Otros_Ing_Egreg();
			Categoria_Ing_Egreg cat = new Categoria_Ing_Egreg();
			cat.setCategoria_Ing_Egreg_ID(rs.getInt("Categoria_Ing_Egreg_ID"));
			cat.setNombreCategoria(rs.getString("nombreCategoria"));
			t.setOtros_Ing_Egreg_ID(rs.getInt("Otros_Ing_Egreg_ID"));
			String f = parseador2.format(rs.getDate("fecha"));
			t.setFecha(parseador2.parse(f));
			t.setDescripcion(rs.getString("descripcion"));
			t.setMonto(rs.getFloat("monto"));
			t.setCategoria_Ing_Egreg(cat);
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
