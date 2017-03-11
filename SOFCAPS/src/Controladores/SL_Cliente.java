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

import Datos.DTCliente;
import Datos.DataTableObject;
import Entidades.Cliente;

/**
 * Servlet implementation class SL_Usuario
 */
@WebServlet("/SL_Cliente")
public class SL_Cliente extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DTCliente datosCliente = new DTCliente();
	PrintWriter out;
       
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
		PrintWriter out = response.getWriter();
		List<Cliente> cliente = datosCliente.cliente();
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Cliente c : cliente) {
			dataTableObject.aaData.add(c);
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
//		System.out.println("hola post , este es el id : " + request.getParameter("cliente_id") + " del cliente");
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
		case "guardar":
			nombre1 = request.getParameter("nombre1").trim();
			nombre2 = request.getParameter("nombre2").trim();
			apellido1 = request.getParameter("apellido1").trim();
			apellido2= request.getParameter("apellido2").trim();
			cedula = request.getParameter("cedula").trim();
			celular = Integer.parseInt( request.getParameter("celular").trim());
			estado = Boolean.parseBoolean(request.getParameter("estado").trim());
			guardar(nombre1, nombre2, apellido1, apellido2, cedula, celular, estado, response);
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
	
	protected void guardar(String nombre1, String nombre2, String apellido1, String apellido2, String cedula, int celular, Boolean estado, HttpServletResponse response) {
		Cliente c = new Cliente();
		boolean resultado = false;
		try 
		{
			c.setNombre1(nombre1);
			c.setNombre2(nombre2);
			c.setApellido1(apellido1);
			c.setApellido2(apellido2);
			c.setCedula(cedula);
			c.setCelular(celular);
			c.setEstado(estado);
			
			 resultado = datosCliente.guardarCliente(c);
			 verificar_resultado(resultado, response);
			//response.sendRedirect("index.jsp?guardado");
		} 
		catch (Exception e) 
		{
			System.err.println("SL ERROR: "+e.getMessage());
		}
	}
	
	protected void actualizar(int cliente_id, String nombre1, String nombre2, String apellido1, String apellido2, String cedula, int celular, Boolean estado, HttpServletResponse response) {
		Cliente c = new Cliente();
		boolean resultado = false;
		try 
		{
			c.setCliente_ID(cliente_id);
			c.setNombre1(nombre1);
			c.setNombre2(nombre2);
			c.setApellido1(apellido1);
			c.setApellido2(apellido2);
			c.setCedula(cedula);
			c.setCelular(celular);
			c.setEstado(estado);
			resultado = datosCliente.actualizarCliente(c);
			verificar_resultado(resultado, response);
			//response.sendRedirect("index.jsp?guardado");
		} 
		catch (Exception e) 
		{
			System.err.println("SL ERROR: "+e.getMessage());
		}
	}
	
	protected void eliminar(int cliente_id, HttpServletResponse response) {
		Cliente c = new Cliente();
		boolean resultado = false;
		try 
		{
			c.setCliente_ID(cliente_id);
			resultado = datosCliente.eliminarCliente(c);
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
