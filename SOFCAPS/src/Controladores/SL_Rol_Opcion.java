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

import Datos.DTConsumo;
import Datos.DT_Rol_Opcion;
import Datos.DataTableObject;
import Entidades.Cliente;
import Entidades.Contrato;
import Entidades.Opcion;
import Entidades.Rol;

/**
 * Servlet implementation class SL_Rol_Opcion
 */
@WebServlet("/SL_Rol_Opcion")
public class SL_Rol_Opcion extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DT_Rol_Opcion datosRol_Opcion = DT_Rol_Opcion.getInstance();
	private PrintWriter out;
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_Rol_Opcion() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json");
		out = response.getWriter();
			try {
				int rol_ID = Integer.parseInt(request.getParameter("rol_ID"));
				traerRO(rol_ID, response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out;
		System.out.println("hola post");
		int rol_ID, opcion_ID;
		String metodo = request.getParameter("metodo").trim();
		System.out.println("metodo a realizar: " + metodo);
		switch (metodo) {
		case "eliminar":
			rol_ID= Integer.parseInt(request.getParameter("rol_ID"));
			opcion_ID= Integer.parseInt(request.getParameter("opcion_ID"));
			eliminar(rol_ID, opcion_ID, response);
			break;
		case "guardar":
			rol_ID= Integer.parseInt(request.getParameter("rol_ID"));
			opcion_ID= Integer.parseInt(request.getParameter("opcion_ID"));
			guardar(rol_ID, opcion_ID, response);
			break;
		default:
			response.setContentType("text/plain");
			out = response.getWriter();
			out.print("VACIO");
			break;
		}
	}

	private void guardar(int rol_ID, int opcion_ID, HttpServletResponse response) {
		// TODO Auto-generated method stub
		try{
			Rol r = new Rol();
			r.setRol_ID(rol_ID);
			Opcion o = new Opcion();
			o.setOpcion_ID(opcion_ID);
			verificarResultado(datosRol_Opcion.guardarRol_Opcion(r, o), response);
		}
		catch(Exception e){
			e.printStackTrace();
			System.out.println("ERROR EN EL SERVLET ROL_OPCION: "+e.getMessage());
		}
	}

	private void eliminar(int rol_ID, int opcion_ID, HttpServletResponse response) {
		// TODO Auto-generated method stub
		try{
			Rol r = new Rol();
			r.setRol_ID(rol_ID);
			Opcion o = new Opcion();
			o.setOpcion_ID(opcion_ID);
			verificarResultado(datosRol_Opcion.eliminarRol_Opcion(r, o), response);
		}
		catch(Exception e){
			e.printStackTrace();
			System.out.println("ERROR EN EL SERVLET ROL_OPCION: "+e.getMessage());
		}
	}
	
	private void verificarResultado(boolean r, HttpServletResponse response) {
		// TODO Auto-generated method stub
		PrintWriter out;
		response.setContentType("text/plain");
		try {
			if(r) {
				out = response.getWriter();
				out.print("BIEN");
			}else {
				out = response.getWriter();
				out.print("ERROR");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	protected void traerRO(int rol_ID, HttpServletResponse response) throws SQLException {
		List<Opcion> opciones = new ArrayList<>();
		ResultSet rs = datosRol_Opcion.cargarRol_Opcion_Opciones();
		rs.beforeFirst();
		while (rs.next()) {
			if (rol_ID == rs.getInt("Rol_ID")) {
				Opcion o = new Opcion();
				o.setOpcion_ID(rs.getInt("Opcion_ID"));
				o.setOpcion(rs.getString("opcion"));
				opciones.add(o);
			}
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
