package Controladores;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import Datos.DTUsuario;
import Datos.DataTableObject;
import Entidades.Usuario;

/**
 * Servlet implementation class SL_Usuario
 */
@WebServlet("/SL_Usuario")
public class SL_Usuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DTUsuario datosUsuario = new DTUsuario();
	PrintWriter out;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_Usuario() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#getServletConfig()
	 */
	public ServletConfig getServletConfig() {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * @see Servlet#getServletInfo()
	 */
	public String getServletInfo() {
		// TODO Auto-generated method stub
		return null; 
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		List<Usuario> usuarios = datosUsuario.usuarios();
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Usuario u : usuarios) {
			dataTableObject.aaData.add(u);
		}
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("hola post , este es el id : " + request.getParameter("usuario_id") + " del usuario");
		String login, pass, opcion;
		int usuario_id;
		opcion = request.getParameter("opcion").trim();
		System.out.println("opcion a realizar: " + opcion);
	
		switch (opcion) {
		case "actualizar":
			login = request.getParameter("login").trim();
			pass = request.getParameter("pass").trim();
			usuario_id= Integer.parseInt(request.getParameter("usuario_id"));
			actualizar(usuario_id, login, pass, response);
			break;
		case "eliminar":
			usuario_id= Integer.parseInt(request.getParameter("usuario_id"));
			eliminar(usuario_id, response);
			break;
		case "guardar":
			login = request.getParameter("login").trim();
			pass = request.getParameter("pass").trim();
			guardar(login, pass, response);
			break;
		default:
			final JSONObject json = new JSONObject();
			response.setContentType("application/json");
			out = response.getWriter();
			json.put("respuesta", "OPCION_VACIA");
			System.out.println(json.toJSONString());
			out.print(json.toJSONString());
			break;
		}
		
		//doGet(request, response);
	}

	/**
	 * @see HttpServlet#doPut(HttpServletRequest, HttpServletResponse)
	 */
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
	
	protected void guardar(String login, String pass, HttpServletResponse response) {
		Usuario u = new Usuario();
		boolean resultado = false;
		try 
		{
			u.setLogin(login);
			u.setPass(pass);
			 resultado = datosUsuario.guardarUsuario(u);
			 verificar_resultado(resultado, response);
			//response.sendRedirect("index.jsp?guardado");
		} 
		catch (Exception e) 
		{
			System.err.println("SL ERROR: "+e.getMessage());
		}
	}
	protected void actualizar(int usuario_id, String login, String pass, HttpServletResponse response) {
		Usuario u = new Usuario();
		boolean resultado = false;
		try 
		{
			u.setUsuario_ID(usuario_id);
			u.setLogin(login);
			u.setPass(pass);
			resultado = datosUsuario.actualizarUsuario(u);
			verificar_resultado(resultado, response);
			//response.sendRedirect("index.jsp?guardado");
		} 
		catch (Exception e) 
		{
			System.err.println("SL ERROR: "+e.getMessage());
		}
	}
	protected void eliminar(int usuario_id, HttpServletResponse response) {
		Usuario u = new Usuario();
		boolean resultado = false;
		try 
		{
			u.setUsuario_ID(usuario_id);
			resultado = datosUsuario.eliminarUsuario(u);
			verificar_resultado(resultado, response);
			//response.sendRedirect("index.jsp?guardado");
		} 
		catch (Exception e) 
		{
			System.err.println("SL ERROR: "+e.getMessage());
		}
	}
	protected void verificar_resultado(boolean r, HttpServletResponse response) throws IOException {
		final JSONObject json = new JSONObject();
		if(r) {
			response.setContentType("application/json");
			out = response.getWriter();
			json.put("respuesta", "BIEN");
			System.out.println(json.toJSONString());
			out.print(json.toJSONString());
		}else {
			response.setContentType("application/json");
			out = response.getWriter();
			json.put("respuesta", "ERROR");
			System.out.println(json.toJSONString());
			out.print(json.toJSONString());
		}
	}

}
