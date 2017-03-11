package Controladores;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponse;

import Datos.DTCategoria;
import Entidades.Categoria;


/**
 * Servlet implementation class SL_Alergia
 */
@WebServlet("/SL_Categoria")
public class SL_Categoria extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DTCategoria dta = DTCategoria.getInstance();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SL_Categoria() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		String nomCategoria;
		int categoria_ID;
		Boolean eliminado;

//		SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
		String opcion = request.getParameter("opcion").trim();

		switch (opcion) {
		/////////////////////////////////// INICIO DE ACTUALIZAR
		/////////////////////////////////// //////////////////////////////////////////////////////////////////////////////

		case "actualizar":
			
			Categoria ta = new Categoria();
			categoria_ID = Integer.parseInt(request.getParameter("categoria_ID"));
			nomCategoria = request.getParameter("nomCategoria");
			try {
				ta.setCategoria_ID(categoria_ID);
				ta.setNomCategoria(nomCategoria);

				if (dta.actualizarCategoria(ta)) {
					// refrescar(request,response);
				}

			} catch (Exception e) {
				System.err.println("SL ERROR: " + e.getMessage());
			}
			break;
		/////////////////////////////////// INICIO DE REFRESCAR
		/////////////////////////////////// //////////////////////////////////////////////////////////////////////////////

		case "refrescar":
			refrescar(request, response);
			break;
		/////////////////////////////////// INICIO DE ELIMINAR
		/////////////////////////////////// //////////////////////////////////////////////////////////////////////////////

		case "eliminar":

			ta = new Categoria();
			categoria_ID = Integer.parseInt(request.getParameter("categoria_ID"));
			eliminado = true;
			try {
				ta.setCategoria_ID(categoria_ID);
				ta.setEliminado(eliminado);
				if (dta.eliminarCategoria(ta)) {
					// refrescar(request,response);
				}

			} catch (Exception e) {
				System.err.println("SL ERROR: " + e.getMessage());
			}

			break;
		/////////////////////////////////// INICIO DE
		/////////////////////////////////// GUARDAR//////////////////////////////////////////////////////////////////////////////

		case "guardar":

			ta = new Categoria();
			nomCategoria = request.getParameter("nomCategoria");
			try {
				ta.setNomCategoria(nomCategoria);

				if (dta.guardarCategoria(ta)) {
					refrescar(request,response);
				}

			} catch (Exception e) {
				System.err.println("SL ERROR: " + e.getMessage());
			}

			break;
		/////////////////////////////////// FIN DE
		/////////////////////////////////// GUARDAR//////////////////////////////////////////////////////////////////////////////
		default:

			break;
		}
	}

	protected void refrescar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			ResultSet rs = dta.Categorias();

			response.setContentType("text/html; charset=UTF-8");
			String out = "";
			// out+="<thead>";
			// out+="<tr>";
			// out+="<th>Acciones</th>";
			// out+="<th>ID</th>";
			// out+="<th>Nombre de alergia</th>";
			//
			// out+="</tr>";
			// out+="</thead>";

			out += "<tbody>";
			while (rs.next()) {

				out += "<tr>";
				out += "<td>";
				out += "<button class='btn btn-danger ajax-link action btnID'>Eliminar</button>";
				out += "<button class='btn btn-info ajax-link action btnEdit editadarAbrir'>Editar</button>";
				out += "</td>";
				out += "<td class='categoria_ID_td'>" + rs.getInt("categoria_ID") + "</td>";
				out += "<td class='nomCategoria_td'>" + rs.getString("nomCategoria") + "</td>";

				out += "</tr>";
			}
			out += "</tbody>";

			out += "<tfoot>";
			out += "</tfoot>";

			PrintWriter pw = response.getWriter();
			pw.write(out);
			pw.flush();
			boolean error = pw.checkError();
			System.out.println("Error: " + error);

		} catch (Exception e) {
			System.out.println("SL: error en el servlet:" + e.getMessage());
			e.printStackTrace();
		}

	}

}
