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
		doGet(request, response);
	}

	/**
	 * @see HttpServlet#doPut(HttpServletRequest, HttpServletResponse)
	 */
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
	
	protected void traerRoles(HttpServletResponse response) throws SQLException {
		List<Rol> roles = new ArrayList<>();
		ResultSet rs = datosRol_Opcion.cargarRol_Opcion();
		while(rs.next()) {
			Rol r = new Rol();
			r.setRol_ID(rs.getInt("Rol_ID"));
			roles.add(r);
		}
		rs = datosRol_Opcion.cargarRol_Opcion_Opciones();
		for (Rol rol : roles) {
			List<Opcion> opciones = new ArrayList<>();
			while (rs.next()) {	
				if(rol.getRol_ID() == rs.getInt("Rol_ID")) {
					Opcion o = new Opcion();
					o.setOpcion_ID(rs.getInt("Opcion_ID"));
					o.setOpcion(rs.getString("opcion"));
					opciones.add(o);
				}
			}
			rol.setOpciones(opciones);
			rs.beforeFirst();
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
