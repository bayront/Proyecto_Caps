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
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();
	PrintWriter out;
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
		try {
			traerCategorias(response);
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
		
		String opcion,nomCategoria, descripcion;
	
		
		opcion = request.getParameter("opcion").trim();
		System.out.println("opcion a realizar: " + opcion);
		
		try {
			switch (opcion) {
			case "actualizar":
				categoria_ID = Integer.parseInt(request.getParameter("categoria_ID").trim());
				nomCategoria = request.getParameter("nomCategoria");
				descripcion = request.getParameter("descripcion");
				actualizar( categoria_ID, nomCategoria, descripcion, response);
				break;
			
			case "eliminar":
				categoria_ID= Integer.parseInt(request.getParameter("categoria_ID"));
				System.out.println("cat_id: "+categoria_ID);
				eliminar(categoria_ID, response);
				break;
			
			case "guardar":
				nomCategoria = request.getParameter("nomCategoria");
				descripcion = request.getParameter("descripcion");
				guardar(nomCategoria, descripcion, response);
				break;
			default:
				response.setContentType("text/plain");
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
	private void actualizar(int categoria_ID, String nomCategoria, String descripcion, HttpServletResponse response) {
		try{
			Categoria cat =  new Categoria();
			cat.setCategoria_ID(categoria_ID);
			cat.setNomCategoria(nomCategoria);
			cat.setDescripcion(descripcion);
			verificar_resultado(datosCategoria.actualizarCategoria(cat), response);
		}catch (Exception e){
			System.err.println("SL ERROR: "+e.getMessage());
			e.printStackTrace();
		}
	}

	protected void guardar(String nomCategoria, String descripcion, HttpServletResponse response) {
		try {
			Categoria cat =  new Categoria();
			cat.setNomCategoria(nomCategoria);
			cat.setDescripcion(descripcion);
			verificar_resultado(datosCategoria.guardarCategoria(cat), response);
		}catch (Exception e){
			System.err.println("SL ERROR: "+e.getMessage());
		}
	}
	
	protected void verificar_resultado(boolean r, HttpServletResponse response) throws IOException {
		response.setContentType("text/plain");
		if(r) {
			out = response.getWriter();
			out.print("BIEN");
		}else {
			out = response.getWriter();
			out.print("ERROR");
		}
	}

	protected void eliminar(int categoria_ID, HttpServletResponse response) {
		try{
			Categoria c = new Categoria();
			c.setCategoria_ID(categoria_ID);
			System.out.println("cat_ID_ "+categoria_ID);
			verificar_resultado(datosCategoria.eliminarCategoria(c), response);
		}catch (Exception e){
			e.printStackTrace();
			System.out.println("ERROR EN EL SERVLET CATEGORIA INGRESOS Y EGRESOS: " + e.getMessage());
		}
	}

	private void traerCategorias(HttpServletResponse response) throws SQLException, IOException {
		response.setContentType("application/json");
		out = response.getWriter();
		List<Categoria> categorias = new ArrayList<>();
		ResultSet rs = datosCategoria.Categorias();
		while(rs.next()){
			Categoria cat = new Categoria();
			cat.setNomCategoria(rs.getString("nomCategoria"));
			cat.setCategoria_ID(rs.getInt("Categoria_ID"));
			String desc = rs.getString("descripcion");
			if(desc == "" || desc == null) {
				cat.setDescripcion("");
			}else {
				cat.setDescripcion(rs.getString("descripcion"));
			}
			categorias.add(cat);
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Categoria categoria : categorias) {
			dataTableObject.aaData.add(categoria);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println("DATOS: " + json.toString());
		out.print(json);
	}
}
