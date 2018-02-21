package Controladores;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	private PrintWriter out;
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_Usuario() {
        super();
        // TODO Auto-generated constructor stub
    }
	public ServletConfig getServletConfig() {
		// TODO Auto-generated method stub
		return null;
	}
	public String getServletInfo() {
		// TODO Auto-generated method stub
		return null; 
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		out = response.getWriter();
		if(Integer.parseInt(request.getParameter("carga")) == 1){
		try {
			traerUsuarios(response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		else if(Integer.parseInt(request.getParameter("carga")) == 2) {
			try {
				traerUsuariosInactivos(response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
		
	private void traerUsuarios(HttpServletResponse response) throws SQLException {
		List<Usuario> usuarios = new ArrayList<>();
		ResultSet rs = datosUsuario.cargarUsuarios();
		while (rs.next()) {
			Usuario u = new Usuario();
			u.setUsuario_ID(rs.getInt("usuario_ID"));
			u.setLogin(rs.getString("login"));
			u.setPass(rs.getString("pass"));
			u.setNombre_usuario(rs.getString("nombre_usuario"));
			u.setEliminado(rs.getBoolean("eliminado"));
			usuarios.add(u);
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Usuario usuario : usuarios) {
			dataTableObject.aaData.add(usuario);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
	}
	
	private void traerUsuariosInactivos(HttpServletResponse response) throws SQLException {
		List<Usuario> usuarios = new ArrayList<>();
		ResultSet rs = datosUsuario.cargarUsuariosInactivos();
		while (rs.next()) {
			Usuario u = new Usuario();
			u.setUsuario_ID(rs.getInt("usuario_ID"));
			u.setLogin(rs.getString("login"));
			u.setPass(rs.getString("pass"));
			u.setNombre_usuario(rs.getString("nombre_usuario"));
			u.setEliminado(rs.getBoolean("eliminado"));
			usuarios.add(u);
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Usuario usuario : usuarios) {
			dataTableObject.aaData.add(usuario);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String login, pass, opcion, nombre_usuario;
		int usuario_ID;
		opcion = request.getParameter("opcion").trim();
		System.out.println("opcion a realizar: " + opcion);
		switch (opcion) {
			case "actualizar":
				nombre_usuario = request.getParameter("nombre_usuario").trim();
				login = request.getParameter("login").trim();
				pass = request.getParameter("pass").trim();
				usuario_ID= Integer.parseInt(request.getParameter("usuario_id"));
				System.out.println("actualizar SL_Usuario");
				actualizar(usuario_ID, nombre_usuario, login, pass, response);
				break;
			case "eliminar":
				usuario_ID= Integer.parseInt(request.getParameter("usuario_ID"));
				eliminar(usuario_ID, response);
				break;					
			case "guardar":
				nombre_usuario = request.getParameter("nombre_usuario").trim();
				login = request.getParameter("login").trim();
				pass = request.getParameter("pass").trim();
				guardar(nombre_usuario, login, pass, response);
				break;
			case "activar":
				usuario_ID= Integer.parseInt(request.getParameter("usuario_ID"));
				activar(usuario_ID, response);
				break;
			default:
				response.setContentType("text/plain");
				out = response.getWriter();
				out.print("VACIO");
				break;
		}
	}

	/**
	 * @see HttpServlet#doPut(HttpServletRequest, HttpServletResponse)
	 */
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
	
	protected void guardar(String nombre_usuario, String login, String pass, HttpServletResponse response) {
		try {
			Usuario u = new Usuario();
			u.setNombre_usuario(nombre_usuario);
			u.setLogin(login);
			u.setPass(pass);
			 verificar_resultado(datosUsuario.guardarUsuario(u), response);	
		} catch (Exception e) {
			System.err.println("SL_Usuario ERROR: "+e.getMessage());
		}
	}
	
	
	protected void actualizar(int usuario_id, String nombre_usuario, String login, String pass, HttpServletResponse response) {
		try {
			Usuario u = new Usuario();
			u.setUsuario_ID(usuario_id);
			u.setNombre_usuario(nombre_usuario);
			u.setLogin(login);
			u.setPass(pass);
			u.setEliminado(false);
			verificar_resultado(datosUsuario.actualizarUsuario(u), response);
		} catch (Exception e) {
			System.err.println("SL ERROR: "+e.getMessage());
		}
	}
	
    protected void eliminar(int usuario_id,  HttpServletResponse response) {
    	try {
			Usuario u = new Usuario();
			u.setUsuario_ID(usuario_id);
			verificar_resultado(datosUsuario.eliminarUsuario(u), response);
		} catch (Exception e) {
			System.err.println("SL ERROR: "+e.getMessage());
		}
	}
    protected void activar(int usuario_ID, HttpServletResponse response) {
		try {
			Usuario u = new Usuario();
			u.setUsuario_ID(usuario_ID);
			verificar_resultado(datosUsuario.activarUsuario(u), response);
		} catch (Exception e) {
			System.err.println("SL ERROR: "+e.getMessage());
		}
	}  
      
	protected void verificar_resultado(boolean r, HttpServletResponse response) throws IOException {
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
}
