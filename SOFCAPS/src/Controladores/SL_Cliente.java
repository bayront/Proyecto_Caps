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

import org.json.simple.JSONObject;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import Datos.DTCliente;
import Datos.DTUsuario;
import Datos.DataTableObject;
import Entidades.Cliente;
import Entidades.Usuario;

/**
 * Servlet implementation class SL_Usuario
 */
@WebServlet("/SL_Cliente")
public class SL_Cliente extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DTCliente datosCliente = DTCliente.getInstance();
	private PrintWriter out;
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();
	   
    /**
     * @see HttpServlet#HttpServlet()
     */

 public SL_Cliente() {
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
		out = response.getWriter();
		if(Integer.parseInt(request.getParameter("carga")) == 1) {
			try {
				traerClientes(response);
			} catch (SQLException e) {
			// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else if(Integer.parseInt(request.getParameter("carga")) == 2) {
			try {
				traerClientesInactivos(response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	  }
	
	private void traerClientes(HttpServletResponse response) throws SQLException {
		List<Cliente> clientes = new ArrayList<>();
		ResultSet rs = datosCliente.cargarClientes();
		while (rs.next()) {
			Cliente c = new Cliente();
			c.setCliente_ID(rs.getInt("cliente_id"));
			c.setNombre1(rs.getString("nombre1"));
			c.setNombre2(rs.getString("nombre2"));
			c.setApellido1(rs.getString("Apellido1"));
			c.setApellido2(rs.getString("Apellido2"));
			c.setCedula(rs.getString("cedula"));
			c.setCelular(rs.getInt("celular"));
			c.setEstado(rs.getBoolean("estado"));
			clientes.add(c);
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Cliente cliente : clientes) {
			dataTableObject.aaData.add(cliente);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
		}
	
	private void traerClientesInactivos(HttpServletResponse response) throws SQLException {
		List<Cliente> clientes = new ArrayList<>();
		ResultSet rs = datosCliente.cargarClientesInactivos();
		while (rs.next()) {
			Cliente c = new Cliente();
			c.setCliente_ID(rs.getInt("cliente_id"));
			c.setNombre1(rs.getString("nombre1"));
			c.setNombre2(rs.getString("nombre2"));
			c.setApellido1(rs.getString("Apellido1"));
			c.setApellido2(rs.getString("Apellido2"));
			c.setCedula(rs.getString("cedula"));
			c.setCelular(rs.getInt("celular"));
			c.setEstado(rs.getBoolean("estado"));
			clientes.add(c);
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Cliente cliente : clientes) {
			dataTableObject.aaData.add(cliente);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
		}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nombre1, nombre2, apellido1, apellido2, cedula, opcion;
		int celular, cliente_id;
		Boolean estado;
		
		opcion = request.getParameter("opcion").trim();
		System.out.println("opcion a realizar: " + opcion);
	
		switch (opcion) {
		case "actualizar":
			nombre1 = request.getParameter("nombre1").trim();
			nombre2 = request.getParameter("nombre2").trim();
			apellido1 = request.getParameter("apellido1").trim();
			apellido2= request.getParameter("apellido2").trim();
			cedula = request.getParameter("cedula").trim();
			celular = Integer.parseInt( request.getParameter("celular").trim());
			estado = Boolean.parseBoolean(request.getParameter("estado").trim());
			cliente_id= Integer.parseInt(request.getParameter("cliente_id"));
			actualizar(cliente_id, nombre1, nombre2, apellido1, apellido2, cedula, celular, estado,  response);
			break;
		case "eliminar":
			cliente_id= Integer.parseInt(request.getParameter("cliente_id"));
			eliminar(cliente_id, response);
			break;
		case "activar":
			cliente_id= Integer.parseInt(request.getParameter("cliente_id"));
			activar(cliente_id, response);
			break;
		case "guardar":
			nombre1 = request.getParameter("nombre1").trim();
			nombre2 = request.getParameter("nombre2").trim();
			apellido1 = request.getParameter("apellido1").trim();
			apellido2= request.getParameter("apellido2").trim();
			cedula = request.getParameter("cedula").trim();
			celular = Integer.parseInt( request.getParameter("celular").trim());
			guardar(nombre1, nombre2, apellido1, apellido2, cedula, celular, response);
			break;
		default:
			response.setContentType("text/plain");
			out = response.getWriter();
			out.print("VACIO");
			break;
		}
	 }
	
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	protected void guardar(String nombre1, String nombre2, String apellido1, String apellido2, String cedula, int celular,  HttpServletResponse response) {
		
		try {
			Cliente c = new Cliente();
			c.setNombre1(nombre1);
			c.setNombre2(nombre2);
			c.setApellido1(apellido1);
			c.setApellido2(apellido2);
			c.setCedula(cedula);
			c.setCelular(celular);

			 verificar_resultado(datosCliente.guardarCliente(c), response);	
		} catch (Exception e) {
			System.err.println("SL_Cliente ERROR: "+e.getMessage());
		}
	}
	
	protected void actualizar(int cliente_id, String nombre1, String nombre2, String apellido1, String apellido2, String cedula, int celular, Boolean estado, HttpServletResponse response) {
		try {
			Cliente c = new Cliente();
			c.setCliente_ID(cliente_id);
			c.setNombre1(nombre1);
			c.setNombre2(nombre2);
			c.setApellido1(apellido1);
			c.setApellido2(apellido2);
			c.setCedula(cedula);
			c.setCelular(celular);
			c.setEstado(estado);
			verificar_resultado(datosCliente.actualizarCliente(c), response);
			} catch (Exception e) {
			System.err.println("SL ERROR: "+e.getMessage());
		}
	}
	
	  protected void eliminar(int cliente_id, HttpServletResponse response) {
			try {
				Cliente c = new Cliente();
				c.setCliente_ID(cliente_id);
				verificar_resultado(datosCliente.eliminarCliente(c), response);
			} catch (Exception e) {
				System.err.println("SL ERROR: "+e.getMessage());
			}
		}
	  
	  protected void activar(int cliente_id, HttpServletResponse response) {
			try {
				Cliente c = new Cliente();
				c.setCliente_ID(cliente_id);
				verificar_resultado(datosCliente.activarCliente(c), response);
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


