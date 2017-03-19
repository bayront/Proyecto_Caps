package Controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.ForEach;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import Datos.DT_categoria_Ing_Engre;
import Datos.DataTableObject;
import Entidades.Categoria_Ing_Egreg;
import Entidades.TipoCategoria;


/**
 * Servlet implementation class SL_ajax_table_categoriaIE
 */
@WebServlet("/SL_ajax_table_categoriaIE")
public class SL_ajax_table_categoriaIE extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PrintWriter out;
	private DT_categoria_Ing_Engre dTcatIE = DT_categoria_Ing_Engre.getInstance();
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_ajax_table_categoriaIE() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		out = response.getWriter();
		try {
			traerCategoriaIE(response);
			
		}catch (SQLException e){
			e.printStackTrace();
		}
		
	}

	private void traerCategoriaIE(HttpServletResponse response) throws SQLException {
		List<Categoria_Ing_Egreg> listaC = new ArrayList<>();
		ResultSet rs = dTcatIE.cargarDatosTabla();
		while(rs.next()){
			Categoria_Ing_Egreg catIE =new Categoria_Ing_Egreg();
			TipoCategoria tCat = new TipoCategoria();
			catIE.setCategoria_Ing_Egreg_ID(rs.getInt("Categoria_Ing_Egreg_ID"));
			catIE.setNombreCategoria(rs.getString("nombreCategoria"));
			tCat.setTipoCategoria_ID(rs.getInt("TipoCategoria_ID"));
			tCat.setDescripcion(rs.getString("descripcion"));
			catIE.setTipoCategoria(tCat);
			listaC.add(catIE);
			
		}
		
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Categoria_Ing_Egreg categoria_Ing_Egreg : listaC) {
			dataTableObject.aaData.add(categoria_Ing_Egreg);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Hola verga!!");
		String nombreCat, opcion;
		int catID, tcID;
		
		opcion = request.getParameter("opcion");
		System.out.println("opcion a realizar: " + opcion);
		try {
			switch (opcion) {
			case "guardar":
				System.out.println("nombreCat: "+request.getParameter("nombreCategoria"));
				if(request.getParameter("nombreCategoria") != "" || !(request.getParameter("nombreCategoria").isEmpty())) {
					nombreCat = request.getParameter("nombreCategoria");
				}else {
					nombreCat = null;
					response.setContentType("text/plain");
					out = response.getWriter();
					out.print("ERROR");
					break;
				}
				tcID = Integer.parseInt(request.getParameter("tipoCategoria"));
				guardar(nombreCat, tcID, response);
				break;
			
			case "actualizar":
				System.out.println(request.getParameter("nombreCategoria"));
				if(request.getParameter("nombreCategoria") != "" || !(request.getParameter("nombreCategoria").isEmpty())) {
					nombreCat = request.getParameter("nombreCategoria");
				}else {
					nombreCat = null;
					response.setContentType("text/plain");
					out = response.getWriter();
					out.print("ERROR");
					break;
				}
				tcID = Integer.parseInt(request.getParameter("tipoCategoria"));
				catID = Integer.parseInt(request.getParameter("catIE_ID"));
				actualizar(nombreCat, tcID, catID, response);
				break;
			
			case "eliminar":
				catID = Integer.parseInt(request.getParameter("catIE_ID"));
				eliminar(catID, response);	
				break;

			default:
				response.setContentType("text/plain");
				out = response.getWriter();
				out.print("VACIO");
				break;
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			response.setContentType("text/plain");
			out = response.getWriter();
			out.print("ERROR");
		}
		
	}

	private void eliminar(int catID, HttpServletResponse response) {
		try {
			Categoria_Ing_Egreg catIE = new Categoria_Ing_Egreg();
			catIE.setCategoria_Ing_Egreg_ID(catID);
			verificarResultado(dTcatIE.eliminarCatIE(catIE), response);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ERROR EN EL SERVLET CATEGORIA INGRESOS Y EGRESOS: " + e.getMessage());
		}
		
	}

	private void actualizar(String nombreCat, int tcID, int catID, HttpServletResponse response) {
		try {
			Categoria_Ing_Egreg catIE = new Categoria_Ing_Egreg();
			TipoCategoria tCat = new TipoCategoria();
			catIE.setNombreCategoria(nombreCat);
			catIE.setCategoria_Ing_Egreg_ID(catID);
			tCat.setTipoCategoria_ID(tcID);
			catIE.setTipoCategoria(tCat);
			verificarResultado(dTcatIE.actualizarCatIE(catIE), response);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ERROR EN EL SERVLET CATEGORIA INGRESOS Y EGRESOS: " + e.getMessage());
		}
		
	}

	private void guardar(String nombreCat, int tcID, HttpServletResponse response) {
		try {
			Categoria_Ing_Egreg catIE = new Categoria_Ing_Egreg();
			TipoCategoria tCat = new TipoCategoria();
			catIE.setNombreCategoria(nombreCat);
			tCat.setTipoCategoria_ID(tcID);
			catIE.setTipoCategoria(tCat);
			verificarResultado(dTcatIE.guardarcarIE(catIE), response);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ERROR EN EL SERVLET CATEGORIA INGRESOS Y EGRESOS: " + e.getMessage());
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
