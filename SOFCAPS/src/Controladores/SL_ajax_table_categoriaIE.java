package Controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Datos.DT_categoria_Ing_Engre;
import Entidades.Categoria_Ing_Egreg;


/**
 * Servlet implementation class SL_ajax_table_categoriaIE
 */
@WebServlet("/SL_ajax_table_categoriaIE")
public class SL_ajax_table_categoriaIE extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
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
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try
		{
			DT_categoria_Ing_Engre dtcatIE = DT_categoria_Ing_Engre.getInstance();
			Categoria_Ing_Egreg categIE = new Categoria_Ing_Egreg();
			
			String nombreCategoria ="";
			int tipoCategoria =0;
			
			nombreCategoria = request.getParameter("nombreCategoria");
			tipoCategoria = Integer.parseInt(request.getParameter("tipoCategoria"));
			
			System.out.println("fName " + nombreCategoria);
			System.out.println("sName " + tipoCategoria);
			
			categIE.setNombreCategoria(nombreCategoria);
			categIE.setTipoCategoria(tipoCategoria);
			
			if(dtcatIE.guardarcarIE(categIE))
			{
				ResultSet rs = dtcatIE.cargarDatosTabla();
				response.setContentType("text/html; charset=UTF-8");
				String out = "";
				
				out+="<thead>";
				out+="<tr>";
				out+="<th>Id</th>";
				out+="<th>Nombre categoria</th>";
				out+="<th>tipo de categoria</th>";
				out+="<th>Acciones</th>";
				out+="</tr>";
				out+="</thead>";
				
				out+="<tbody>";
				while(rs.next())
				{
					out+="<tr>";
					out+="<td>"+rs.getInt("Categoria_Ing_Egreg_ID")+"</td>";
					out+="<td>"+rs.getString("nombreCategoria")+"</td>";
					out+="<td>"+rs.getString("descripcion")+"</td>";
					out+="";
					out+="</tr>";
				}
				out+="</tbody>";
				
				out+="<tfoot>";
				out+="<tr>";
				out+="<th>ID</th>";
				out+="<th>Nombre categoria</th>";
				out+="<th>tipo de categoria</th>";
				out+="<th>Acciones</th>";
				out+="</tr>";
				out+="</tfoot>";
				
				PrintWriter pw = response.getWriter();
				pw.write(out);
				pw.flush();
				boolean error = pw.checkError();
				System.out.println("Error? "+ error);
			}
			else
			{
				//Msj de Error
			}
			
		
			
		}
		catch(Exception e)
		{
			System.out.println("SL: error en el servlet:" +e.getMessage());
			e.printStackTrace();
		}
	}

}
