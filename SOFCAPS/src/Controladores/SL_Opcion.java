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

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import Datos.DT_Opcion;
import Datos.DataTableObject;
import Entidades.Opcion;
import Entidades.Rol;

/**
 * Servlet implementation class SL_Opcion
 */
@WebServlet("/SL_Opcion")
public class SL_Opcion extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DT_Opcion datosOpcion = DT_Opcion.getInstance();
	private PrintWriter out;
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_Opcion() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			response.setContentType("application/json");
			out = response.getWriter();
			switch (Integer.parseInt(request.getParameter("carga"))) {
			case 1:
				int rol_ID = Integer.parseInt(request.getParameter("rol_ID"));
				try {
					traerOpciones(rol_ID, response);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				break;
			case 2:
				try {
					traerOpciones2(response);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				break;
			default:
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
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("hola POST opcion");
		String opcion, descripcion;
		int opcion_ID;
		String metodo = request.getParameter("metodo").trim();
		System.out.println("metodo a realizar: " + metodo);
		switch (metodo) {
		case "actualizar":
			opcion_ID = Integer.parseInt(request.getParameter("opcion_ID").trim());
			opcion = request.getParameter("opcion").trim();
			descripcion = request.getParameter("descripcion").trim();
			actualizar(opcion_ID, opcion, descripcion, response);
			break;
		case "eliminar":
			opcion_ID= Integer.parseInt(request.getParameter("opcion_ID"));
			eliminar(opcion_ID, response);
			break;
		case "guardar":
			opcion = request.getParameter("opcion").trim();
			descripcion = request.getParameter("descripcion").trim();
			guardar(opcion, descripcion, response);
			break;
		default:
			response.setContentType("text/plain");
			out = response.getWriter();
			out.print("VACIO");
			break;
		}
	}
	
	private void guardar(String opcion, String descripcion, HttpServletResponse response) {
		// TODO Auto-generated method stub
		try{
			Opcion o = new Opcion();
			DT_Opcion dta = new DT_Opcion();
			o.setDescripcion(descripcion);
			o.setOpcion(opcion);
			verificarResultado(datosOpcion.guardarOpcion(o), response);
		}
		catch(Exception e){
			e.printStackTrace();
			System.out.println("ERROR EN EL SERVLET: "+e.getMessage());
		}
	}

	private void eliminar(int opcion_ID, HttpServletResponse response) {
		try {
			Opcion o = new Opcion();
			o.setOpcion_ID(opcion_ID);
			verificarResultado(datosOpcion.eliminarOpcion(o), response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void actualizar(int opcion_ID, String opcion, String descripcion, HttpServletResponse response) {
		// TODO Auto-generated method stub
		try {
			Opcion o =  new Opcion();
			o.setOpcion(opcion);
			o.setOpcion_ID(opcion_ID);
			o.setDescripcion(descripcion);
			verificarResultado(datosOpcion.actualizarOpcion(o), response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private void verificarResultado(boolean r, HttpServletResponse response) {
		try {
			if(r) {
				response.setContentType("text/plain");
				out = response.getWriter();
				out.print("BIEN");
			}else {
				response.setContentType("text/plain");
				out = response.getWriter();
				out.print("ERROR");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	protected void traerOpciones(int rol_ID, HttpServletResponse response) throws SQLException {
		List<Opcion> opciones = new ArrayList<>();
		ResultSet rs = datosOpcion.cargarDatos(rol_ID);
		while (rs.next()) {
			Opcion o = new Opcion();
			o.setOpcion_ID(rs.getInt("Opcion_ID"));
			o.setOpcion(rs.getString("opcion"));
//			o.setDescripcion(rs.getString("descripcion"));
			opciones.add(o);
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Opcion opcion : opciones) {
			dataTableObject.aaData.add(opcion);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
	}
	private void traerOpciones2(HttpServletResponse response) throws SQLException {
		// TODO Auto-generated method stub
		List<Opcion> opciones = new ArrayList<>();
		ResultSet rs = datosOpcion.cargarDatos2();
		while (rs.next()) {
			Opcion o = new Opcion();
			o.setOpcion_ID(rs.getInt("Opcion_ID"));
			o.setOpcion(rs.getString("opcion"));
//			o.setDescripcion(rs.getString("descripcion"));
			opciones.add(o);
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Opcion opcion : opciones) {
			dataTableObject.aaData.add(opcion);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
	}
}


