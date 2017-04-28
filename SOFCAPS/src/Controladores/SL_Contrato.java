package Controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.sun.xml.xsom.impl.scd.ParseException;

import Datos.DTContrato;
import Datos.DataTableObject;
import Entidades.Categoria;
import Entidades.Categoria_Ing_Egreg;
import Entidades.Cliente;
import Entidades.Contrato;
import Entidades.RegimenPropiedad;
import Entidades.Sector;

/**
 * Servlet implementation class SL_Contrato
 */
@WebServlet("/SL_Contrato")
public class SL_Contrato extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PrintWriter out;
	private DTContrato dtContrato = DTContrato.getInstance();
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();
	SimpleDateFormat parseador = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH);
	
	SimpleDateFormat fecha = new SimpleDateFormat("dd/MM/yyyy");
	  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_Contrato() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("application/json");
		out = response.getWriter();
		try {
			traerContrato(response);
			
		}catch (SQLException e){
			System.out.println("error sql: "+e.getMessage());
			e.printStackTrace();
		} catch (java.text.ParseException e) {
			e.printStackTrace();
			System.out.println("error de parseo : "+e.getMessage());
		}
	}
    
    
    private void traerContrato(HttpServletResponse response) throws SQLException, java.text.ParseException {
		List<Contrato> listaC = new ArrayList<>();
		ResultSet rs = dtContrato.cargarDatosTabla();
		while(rs.next()){
			Contrato co = new Contrato();
			Cliente cl = new Cliente();
			RegimenPropiedad rp =new RegimenPropiedad();
			Sector se = new Sector();
			Categoria ca = new Categoria();
			co.setContrato_ID(rs.getInt("contrato_ID"));
			String f = parseador.format(rs.getDate("fechaContrato"));
			co.setFechaContrato(parseador.parse(f));
			co.setNumContrato(rs.getInt("numContrato"));
			co.setNumMedidor(rs.getString("numMedidor"));
			co.setDireccionCliente(rs.getString("direccionCliente"));
			co.setCuotas(rs.getInt("cuotas"));
			co.setCantidadPersonas(rs.getInt("cantidadPersonas"));
			co.setMontoContrato(rs.getFloat("montoContrato"));
			cl.setCliente_ID(rs.getInt("Cliente_ID"));
			cl.setNombreCompleto(rs.getString("nombre1") + " " + rs.getString("nombre2") + " " + rs.getString("apellido1") + " " + rs.getString("apellido2"));
			rp.setRegimenPropiedad_ID(rs.getInt("RegimenPropiedad_ID"));
			rp.setRegimenPro(rs.getString("regimenPro"));
			se.setSector_ID(rs.getInt("Sector_ID"));
			se.setNombreSector(rs.getString("nombreSector"));
			ca.setCategoria_ID(rs.getInt("Categoria_ID"));
			ca.setNomCategoria(rs.getString("nomCategoria"));
			co.setCliente(cl);
			co.setCategoria(ca);
			co.setRegimenPropiedad(rp);
			co.setSector(se);
			
			listaC.add(co);
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Contrato contrato : listaC) {
			dataTableObject.aaData.add(contrato);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String numMedidor, opcion, direccionCliente;
		Date fechaContrato = null;
		int contrato_ID, cuotas, cantidadPersonas, cliente, regimenPropiedad, sector, categoria;
		int numContrato = 1; 
		float montoContrato, montoRound;
		
		opcion = request.getParameter("opcion").trim();
		System.out.println("opcion a realizar: " + opcion);
	
		switch (opcion) {
		case "actualizar":
			System.out.println("opcion a realizar: " + request.getParameter("opcion"));
			contrato_ID = Integer.parseInt(request.getParameter("contrato_ID"));
			numMedidor = request.getParameter("numMedidor").trim();
			direccionCliente = request.getParameter("direccionCliente").trim();
			cuotas = Integer.parseInt(request.getParameter("cuotas"));
			cantidadPersonas = Integer.parseInt(request.getParameter("cantidadPersonas"));
			montoContrato = Float.parseFloat(request.getParameter("montoContrato"));
			montoRound = (float) (Math.round(montoContrato * 100.0) / 100.0);
			cliente = Integer.parseInt(request.getParameter("nombreCliente"));
			regimenPropiedad = Integer.parseInt(request.getParameter("regimenPropiedad"));
			sector = Integer.parseInt(request.getParameter("sector"));
			categoria = Integer.parseInt(request.getParameter("categoria"));
			actualizar(contrato_ID, numMedidor, direccionCliente, cuotas, cantidadPersonas, montoRound, cliente, regimenPropiedad, sector, categoria, response);
			break;
		case "eliminar":
			contrato_ID= Integer.parseInt(request.getParameter("contrato_ID"));
			eliminar(contrato_ID, response);
			break;
		case "guardar":
			numMedidor = request.getParameter("numMedidor").trim();
			direccionCliente = request.getParameter("direccionCliente").trim();
			System.out.println("opcion a realizar: " + request.getParameter("opcion"));
			try {
				System.out.println("la fecha es: " + request.getParameter("fechaContrato"));
				fechaContrato = fecha.parse(request.getParameter("fechaContrato"));
				System.out.println("la fecha es: " + fechaContrato);
			} catch (java.text.ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			cuotas = Integer.parseInt(request.getParameter("cuotas"));
			cantidadPersonas = Integer.parseInt(request.getParameter("cantidadPersonas"));
			montoContrato = Float.parseFloat(request.getParameter("montoContrato"));
			montoRound = (float) (Math.round(montoContrato * 100.0) / 100.0);
			cliente = Integer.parseInt(request.getParameter("nombreCliente"));
			regimenPropiedad = Integer.parseInt(request.getParameter("regimenPropiedad"));
			sector = Integer.parseInt(request.getParameter("sector"));
			categoria = Integer.parseInt(request.getParameter("categoria"));
			guardar(numMedidor,direccionCliente, fechaContrato, numContrato, cuotas, cantidadPersonas, montoRound, cliente, regimenPropiedad, sector, categoria, response);
			break;
		case "calcular":
			contrato_ID= Integer.parseInt(request.getParameter("contrato_ID"));
			montoContrato = Float.parseFloat(request.getParameter("montoContrato"));
			traerMontoRestante(contrato_ID, montoContrato, response);
			break;
		case "cancelar":
			int id = Integer.parseInt(request.getParameter("id"));
			boolean cancelado = dtContrato.cancelarContrato(id);
			if(cancelado == true) {
				response.setContentType("text/plain");
				PrintWriter out;
				out = response.getWriter();
				out.print("CANCELADO");
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
    
    private void traerMontoRestante(int contrato_ID, float montoContrato, HttpServletResponse response) throws IOException {
		System.out.println("contrato_ID: "+contrato_ID+", monto: "+montoContrato);
		try {
			montoContrato = montoContrato - dtContrato.calcularMontoRestante(contrato_ID);
			int cuotas = dtContrato.calcularCuotasRestantes(contrato_ID) + 1;
			Contrato contrato = new Contrato();
			contrato.setCuotas(cuotas);
			contrato.setMontoContrato(montoContrato);
			String json = gson.toJson(contrato);
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			out.print(json);
		} catch (SQLException e) {
			e.printStackTrace();
			response.setContentType("text/plain");
			PrintWriter out = response.getWriter();
			out.print("ERROR");
		}
	}

	private void eliminar(int contrato_ID, HttpServletResponse response) {
		try {
			Contrato contrato = new Contrato();
			contrato.setContrato_ID(contrato_ID);
			verificar_resultado(dtContrato.eliminarContratro(contrato), response);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ERROR EN EL SERVLET CONTRATO: " + e.getMessage());
		}
		
	}
    
    protected void guardar(String numMedidor, String direccionCliente,  Date fechaContrato, int numContrato, int cuotas, int cantidadPersonas, float montoContrato, int clienteId, int regimenPropiedadId, int sectorId, int categoriaId, HttpServletResponse response) {
		Contrato c = new Contrato();
		Cliente cl = new Cliente();
		RegimenPropiedad r = new RegimenPropiedad();
		Sector s = new Sector();
		Categoria ca = new Categoria();
		try 
		{
			c.setEstado(true);
			c.setNumMedidor(numMedidor);
			c.setDireccionCliente(direccionCliente);
			c.setFechaContrato(fechaContrato);
			c.setNumContrato(numContrato);
			c.setCuotas(cuotas);
			c.setCantidadPersonas(cantidadPersonas);
			c.setMontoContrato(montoContrato);
			c.setFechaCrea(fechaContrato);
			cl.setCliente_ID(clienteId);
			r.setRegimenPropiedad_ID(regimenPropiedadId);
			s.setSector_ID(sectorId);
			ca.setCategoria_ID(categoriaId);
			c.setCliente(cl);
			c.setRegimenPropiedad(r);
			c.setSector(s);
			c.setCategoria(ca);
			verificar_resultado(dtContrato.guardarContrato(c), response);
		} 
		catch (Exception e) 
		{
			System.err.println("ERROR EN EL SERVLET CONTRATO: "+e.getMessage());
		}
	}
	protected void actualizar(int contrato_ID, String numMedidor, String direccionCliente, int cuotas, int cantidadPersonas, float montoContrato, int clienteId, int regimenPropiedadId, int sectorId, int categoriaId, HttpServletResponse response) {
		Contrato c = new Contrato();
		Cliente cl = new Cliente();
		RegimenPropiedad r = new RegimenPropiedad();
		Sector s = new Sector();
		Categoria ca = new Categoria();
		System.out.println("opcion a realizar: " + "Actualizar dentro de funcion actualizar");
		try 
		{
			c.setContrato_ID(contrato_ID);
			c.setNumMedidor(numMedidor);
			c.setDireccionCliente(direccionCliente);
			c.setCuotas(cuotas);
			c.setCantidadPersonas(cantidadPersonas);
			c.setMontoContrato(montoContrato);
			cl.setCliente_ID(clienteId);
			r.setRegimenPropiedad_ID(regimenPropiedadId);
			s.setSector_ID(sectorId);
			ca.setCategoria_ID(categoriaId);
			c.setCliente(cl);
			c.setRegimenPropiedad(r);
			c.setSector(s);
			c.setCategoria(ca);
			verificar_resultado(dtContrato.actualizarContrato(c), response);
		} 
		catch (Exception e) 
		{
			System.err.println("ERROR EN EL SERVLET CONTRATO: "+e.getMessage());
		}
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
