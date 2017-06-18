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
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import Entidades.Usuario;
import Entidades.Usuario_Rol;
import Entidades.Rol;
import Datos.DT_Usuario_Rol;
import Datos.DataTableObject;
import Datos.DTUsuario;


/**
 * Servlet implementation class SL_seguridad
 */
@WebServlet("/Autenticación")
public class SL_Usuario_Rol extends HttpServlet {		
	private PrintWriter out;
	private DT_Usuario_Rol dtUSU = DT_Usuario_Rol.getInstance();
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();
	
		private static final long serialVersionUID = 1L;
	       
	    /**
	     * @see HttpServlet#HttpServlet()
	     */
	    public SL_Usuario_Rol() {
	        super();
	    }

		/**
		 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
		 */
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			int usuario, rol;
			String opcion = request.getParameter("opcion").trim();
			System.out.println("opcion a realizar: " + opcion);
		
			switch (opcion) {
			case "guardar":
				usuario = Integer.parseInt(request.getParameter("login"));
				rol = Integer.parseInt(request.getParameter("rol"));
				guardar(usuario, rol, response);
				break;
			case "cargar":
				try {
					traerRU(response);
				}catch (SQLException e){
					e.printStackTrace();
				}
				break;
			default:
				response.setContentType("text/plain");
				PrintWriter out;
				out = response.getWriter();
				out.print("VACIO");
				break;
			}
		}
		
		protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			Usuario_Rol ru = new Usuario_Rol();
			try {
				ru.setUsuario_id(Integer.parseInt(req.getHeader("Usuario_ID")));
				ru.setRol_id(Integer.parseInt(req.getHeader("Rol_ID")));
				verificar_resultado(dtUSU.eliminarRU(ru), resp);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("ERROR EN EL SERVLET ROL_USUARIO: " + e.getMessage());
			}
		}

		/**
		 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
		 */
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			try {
				Usuario us = new Usuario();
				Usuario userVerificado = new Usuario();
				Rol r = new Rol();
				DTUsuario dtu = DTUsuario.getInstance();
				DT_Usuario_Rol dtru = DT_Usuario_Rol.getInstance();

				String  user, pwd = "";
				int rol = 0;
				user = request.getParameter("username");
				pwd = request.getParameter("password");
				rol = Integer.parseInt(request.getParameter("rol"));
				
				us.setLogin(user);
				us.setPass(pwd);
				r.setRol_ID(rol);
				userVerificado = dtu.verificarUser(us);
				if (dtru.verificarRol(userVerificado, r)) {
					System.out.println("El Usuario y rol son correcto!!!");
					HttpSession hts = request.getSession(true);
					hts.setAttribute("nombre_usuario", userVerificado.getNombre_usuario());
					hts.setAttribute("userVerificado", userVerificado);
					hts.setAttribute("Rol", r);
					response.sendRedirect("index.jsp?msj=1");
				} 
				else{
					System.out.println("ERROR AL AUTENTICAR, El Usuario y/o Rol no son correctos!");
					String msg = "¡ERROR AL AUTENTICAR, El Usuario y/o Rol no son correctos!";
					request.setAttribute("msg", msg);
					request.getRequestDispatcher("CAPS.jsp").forward(request, response);
					
					System.out.println(user);
					System.out.println(pwd);
					System.out.println(rol);
				}
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("ERROR EN SL_seguridad: " + e.getMessage());
			}
		}
		
		protected void guardar(int usuario_ID, int rol_ID, HttpServletResponse response) {
			Usuario_Rol ru = new Usuario_Rol();
			try {
				ru.setUsuario_id(usuario_ID);
				ru.setRol_id(rol_ID);
				verificar_resultado(dtUSU.guardarRU(ru), response);
			}catch (Exception e) {
				System.err.println("ERROR EN EL SERVLET CONTRATO: "+e.getMessage());
			}
		}
	
		private void traerRU(HttpServletResponse response) throws SQLException, IOException {
			response.setContentType("application/json");
			out = response.getWriter();
			List<Usuario_Rol> listaRU = new ArrayList<>();
			ResultSet rs = dtUSU.cargarDatosTabla();
			while(rs.next()){
				Usuario_Rol ru= new Usuario_Rol();
				ru.setUsuario_id(rs.getInt("Usuario_ID"));
				ru.setRol_id(rs.getInt("Rol_ID"));
				Usuario usu = new Usuario();
				Rol rol = new Rol();
				usu.setLogin(rs.getString("login"));
				rol.setNomRol(rs.getString("nomRol"));
				
				ru.setUsuario(usu);
				ru.setRol(rol);		
				listaRU.add(ru);
			}
			DataTableObject dataTableObject = new DataTableObject();
			dataTableObject.aaData = new ArrayList<>();
			for (Usuario_Rol rolusuario : listaRU) {
				dataTableObject.aaData.add(rolusuario);
			}
			String json = gson.toJson(dataTableObject);
			System.out.println(json.toString());
			out.print(json);
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
}
