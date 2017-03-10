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

import org.json.simple.JSONObject;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import Datos.DT_Opcion;
import Datos.DT_Rol;
import Datos.DT_Rol_Opcion;
import Datos.DataTableObject;
import Entidades.Opcion;
import Entidades.Rol;

/**
 * Servlet implementation class SL_Rol
 */
@WebServlet("/SL_Rol")
public class SL_Rol extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DT_Rol datosRol = DT_Rol.getInstance();
	private PrintWriter out;
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_Rol() {
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
				traerRoles(response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("hola post");
		String nomRol;
		int rol_ID;
		String metodo = request.getParameter("metodo").trim();
		System.out.println("metodo a realizar: " + metodo);
		switch (metodo) {
		case "actualizar":
			rol_ID = Integer.parseInt(request.getParameter("rol_ID").trim());
			nomRol = request.getParameter("nomRol").trim();
			actualizar(rol_ID, nomRol, response);
			break;
		case "eliminar":
			rol_ID= Integer.parseInt(request.getParameter("rol_ID"));
			eliminar(rol_ID, response);
			break;
		case "guardar":
			nomRol = request.getParameter("nomRol").trim();
			guardar(nomRol, response);
			break;
		default:
			response.setContentType("text/plain");
			out = response.getWriter();
			out.print("VACIO");
			break;
		}
	}

	private void guardar(String nomRol, HttpServletResponse response) {
		try{
			Rol r = new Rol();
			r.setNomRol(nomRol);
			verificarResultado(datosRol.guardarRol(r), response);
		}
		catch(Exception e){
			e.printStackTrace();
			System.out.println("ERROR EN EL SERVLET ROL: "+e.getMessage());
		}
	}
	private void eliminar(int rol_ID, HttpServletResponse response) {
		try {
			Rol r = new Rol();
			r.setRol_ID(rol_ID);
			verificarResultado(datosRol.eliminarRol(r), response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	private void actualizar(int rol_ID, String nomRol, HttpServletResponse response) {
		Rol r = new Rol();
		r.setRol_ID(rol_ID);
		r.setNomRol(nomRol);
		verificarResultado(datosRol.actualizarRol(r), response);
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

	/**
	 * @see HttpServlet#doPut(HttpServletRequest, HttpServletResponse)
	 */
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	protected void traerRoles(HttpServletResponse response) throws SQLException {
		List<Rol> roles = new ArrayList<>();
		ResultSet rs = datosRol.cargarRol();
		while (rs.next()) {
			Rol r = new Rol();
			r.setRol_ID(rs.getInt("Rol_ID"));
			r.setNomRol(rs.getString("nomRol"));
			roles.add(r);
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Rol rol : roles) {
			dataTableObject.aaData.add(rol);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
	}
}
