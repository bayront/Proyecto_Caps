package Controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import Datos.DTConsumo;
import Datos.DataTableObject;
import Entidades.Categoria;
import Entidades.Cliente;
import Entidades.Consumo;
import Entidades.Contrato;
import Entidades.RegimenPropiedad;
import Entidades.Sector;

/**
 * Servlet implementation class SL_consumo
 */
@WebServlet("/SL_consumo")
public class SL_consumo extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DTConsumo datosConsumo = DTConsumo.getInstance();
	private PrintWriter out;
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();
	SimpleDateFormat fecha = new SimpleDateFormat("dd/MM/yyyy");
	SimpleDateFormat parseador2 = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_consumo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		response.setContentType("application/json");
		out = response.getWriter();
		if(Integer.parseInt(request.getParameter("carga")) == 1) {
			try {
				try {
					traerConsumos(response);
				} catch (ParseException e) {
					e.printStackTrace();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(Integer.parseInt(request.getParameter("carga")) == 2) {
			try {
				traerClienteContratos(response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opcion = request.getParameter("opcion");
		float lectura;
		int contrato_ID, cliente_ID, consumo_ID;
		Date fecha_fin;
		try {
			switch (opcion) {
			case "guardar":
					lectura = Float.parseFloat(request.getParameter("lectura"));
					cliente_ID = Integer.parseInt(request.getParameter("cliente_ID"));
					contrato_ID = Integer.parseInt(request.getParameter("contrato_ID"));
					fecha_fin = fecha.parse(request.getParameter("fecha"));
					System.out.println("la fecha es: " + fecha_fin);
//					guardar(fecha_fin, lectura, cliente_ID, contrato_ID, response);
				break;
			case "actualizar":
				
				break;
			default:
				break;
			}
		} catch (java.text.ParseException e) {
			e.printStackTrace();
			verificar_resultado(false, response);
		}
	}

	/**
	 * @see HttpServlet#doPut(HttpServletRequest, HttpServletResponse)
	 */
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("hola PUT");
	}
	
	private void guardar(Date fecha_fin, float lectura, int cliente_ID, int contrato_ID, HttpServletResponse response) {
		Contrato c = new Contrato();
		Cliente cl = new Cliente();
		Consumo consumo =  new Consumo();
		try {
			consumo.setFecha_fin(fecha_fin);
			consumo.setLectura_Actual(lectura);
			consumo.setActual(true);
			consumo.setEliminado(false);
			c.setContrato_ID(contrato_ID);
			cl.setCliente_ID(cliente_ID);
			consumo.setCliente(cl);
			consumo.setContrato(c);
			verificar_resultado(datosConsumo.guardarConsumo(consumo), response);
		}catch (Exception e) {
			System.err.println("ERROR EN EL SERVLET CONTRATO: "+e.getMessage());
		}
	}

	/**
	 * @see HttpServlet#doDelete(HttpServletRequest, HttpServletResponse)
	 */
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("hola DELETE");
	}
	
	protected void traerConsumos(HttpServletResponse response) throws SQLException, IOException, ParseException {
		List<Consumo> consumos = new ArrayList<>();
		ResultSet rs = datosConsumo.cargarConsumos();
		while (rs.next()) {
			String f = parseador2.format(rs.getDate("fecha_fin"));
			Consumo c = new Consumo(parseador2.parse(f), rs.getFloat("consumoTotal"), 
					rs.getFloat("lectura_Actual"), rs.getInt("Consumo_ID"),
					new Cliente(rs.getInt("Cliente_ID")), new Contrato(rs.getInt("Contrato_ID")));
			consumos.add(c);
		}
		rs = datosConsumo.cargarClienteContrato();
		while (rs.next()) {
			for (Consumo consumo : consumos) {
				if(rs.getInt("Cliente_ID") == consumo.getCliente().getCliente_ID() &&
						rs.getInt("Contrato_ID") ==consumo.getContrato().getContrato_ID()) {
					consumo.getCliente().setNombreCompleto(rs.getString("nombre_completo"));
					consumo.getContrato().setNumContrato(rs.getInt("numContrato"));
					consumo.getContrato().setNumMedidor(rs.getString("numMedidor"));
				}
			}
			
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Consumo c : consumos) {
			dataTableObject.aaData.add(c);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
	}

	protected void traerClienteContratos(HttpServletResponse response) throws SQLException {
		List<Cliente> clientes = new ArrayList<>();
		ResultSet rs = datosConsumo.cargarClienteContrato();
		while (rs.next()) {
			Cliente cl = new Cliente(rs.getInt("Cliente_ID"));
			Contrato ct = new Contrato(rs.getInt("Contrato_ID"));
			cl.setNombreCompleto(rs.getString("nombre_completo"));
			ct.setNumContrato(rs.getInt("numContrato"));
			ct.setNumMedidor(rs.getString("numMedidor"));
			List<Contrato> contratos = new ArrayList<>();
			contratos.add(ct);
			cl.setContratos(contratos);
			clientes.add(cl);
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
