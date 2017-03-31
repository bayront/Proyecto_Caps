package Controladores;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Entidades.Usuario;
import Entidades.Rol;
import Datos.DT_Usuario_Rol;
import Datos.DTUsuario;


/**
 * Servlet implementation class SL_seguridad
 */
@WebServlet("/Autenticación")
public class SL_Usuario_Rol extends HttpServlet {
	
		private static final long serialVersionUID = 1L;
	       
	    /**
	     * @see HttpServlet#HttpServlet()
	     */
	    public SL_Usuario_Rol() {
	        super();
	        // TODO Auto-generated constructor stub
	    }

		/**
		 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
		 */
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
			// TODO Auto-generated method stub
			//response.getWriter().append("Served at: ").append(request.getContextPath());
			response.sendRedirect("CAPS.jsp");
		}

		/**
		 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
		 */
		
		protected void doPost(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
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
			
					response.sendRedirect("index.jsp?msj=1");
				} 
				else
				{
					System.out.println("ERROR AL AUTENTICAR, El Usuario y Rol no son correctos!");
					String msg = "¡ERROR AL AUTENTICAR, El Usuario y Rol no son correctos!";
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


}
