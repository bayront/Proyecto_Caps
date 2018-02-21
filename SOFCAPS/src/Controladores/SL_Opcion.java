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
	private DT_Opcion datosOpcion = new DT_Opcion();
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
		response.setContentType("application/json");
		out = response.getWriter();
		try {
			traerOpciones(response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private void traerOpciones(HttpServletResponse response) throws SQLException {
		// TODO Auto-generated method stub
		List<Opcion> opciones = new ArrayList<>();
		ResultSet rs = datosOpcion.cargarDatos();
		while (rs.next()) {
			Opcion o = new Opcion();
			o.setOpcion_ID(rs.getInt("Opcion_ID"));
			o.setOpcion(rs.getString("opcion"));
			o.setDescripcion(rs.getString("descripcion"));
			o.setUrl(rs.getString("url"));
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


