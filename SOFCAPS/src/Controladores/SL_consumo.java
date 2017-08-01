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
import java.util.Locale.Category;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.eclipse.persistence.internal.jpa.parsing.FetchJoinNode;

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
	SimpleDateFormat fecha = new SimpleDateFormat("dd/MM/yyyy", new Locale("es_ES"));
	SimpleDateFormat parseador2 = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_consumo() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		out = response.getWriter();
		int contrato_ID = 0;
		if(Integer.parseInt(request.getParameter("carga")) == 1) {
			try {
				try {
					traerConsumos(contrato_ID, response);
				} catch (ParseException e) {
					e.printStackTrace();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else if(Integer.parseInt(request.getParameter("carga")) == 2) {
			try {
				traerClienteContratos(response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else if(Integer.parseInt(request.getParameter("carga")) == 3) {
			try {
				contrato_ID = Integer.parseInt(request.getParameter("contrato_ID"));
				traerConsumos(contrato_ID, response);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opcion = request.getParameter("opcion");
		float lectura, consumoTotal;
		int contrato_ID, cliente_ID, consumo_ID;
		Date fecha_fin;
		try {
			switch (opcion) {
			case "guardar":
				lectura = Float.parseFloat(request.getParameter("lectura"));
				consumoTotal = Float.parseFloat(request.getParameter("consumoTotal"));
				float lecturaRound= (float) (Math.round(lectura * 100.0) / 100.0);
				float consumoRound= (float) (Math.round(consumoTotal * 100.0) / 100.0);
				cliente_ID = Integer.parseInt(request.getParameter("cliente_ID"));
				contrato_ID = Integer.parseInt(request.getParameter("contrato_ID"));
				fecha_fin = fecha.parse(request.getParameter("fecha"));
				guardar(fecha_fin,consumoRound, lecturaRound, cliente_ID, contrato_ID, response);
				break;
			case "actualizar":
				consumo_ID = Integer.parseInt(request.getParameter("consumo_ID"));
				contrato_ID = Integer.parseInt(request.getParameter("contrato_ID"));
				consumoTotal = Float.parseFloat(request.getParameter("consumoTotal"));
				lectura = Float.parseFloat(request.getParameter("lectura"));
				float lecturaRound2= (float) (Math.round(lectura * 100.0) / 100.0);
				float consumoRound2= (float) (Math.round(consumoTotal * 100.0) / 100.0);
				fecha_fin = fecha.parse(request.getParameter("fecha"));
				cliente_ID = Integer.parseInt(request.getParameter("cliente_ID"));
				contrato_ID = Integer.parseInt(request.getParameter("contrato_ID"));
				actualizar(consumo_ID, contrato_ID, fecha_fin, consumoRound2, lecturaRound2, response);
				break;
			default:
				response.setContentType("text/plain");
				out = response.getWriter();
				out.print("VACIO");
				break;
			}
		} catch (java.text.ParseException e) {
			e.printStackTrace();
			verificar_resultado(false, response);
		}
	}
	
	private void guardar(Date fecha_fin,float consumoTotal, float lectura, int cliente_ID, int contrato_ID, HttpServletResponse response) throws IOException {
		Contrato c = new Contrato();
		Cliente cl = new Cliente();
		Consumo consumo =  new Consumo();
//		boolean lecturaMenor = false;
		boolean fechaMenor = false;
		try {
			ResultSet r = datosConsumo.cargarTodosConsumos();
			while(r.next()) {
//				if(lectura <= r.getFloat("lectura_Actual") && contrato_ID == r.getInt("Contrato_ID")) {
//					lecturaMenor = true;
//				}
				if(fecha_fin.compareTo(r.getDate("fecha_fin")) <= 0 && contrato_ID == r.getInt("Contrato_ID")) {
					fechaMenor = true;
				}
			}
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
//		if(lecturaMenor) {
//			response.setContentType("text/plain");
//			out = response.getWriter();
//			out.print("LECTURAMENOR");
//		}else 
		if(fechaMenor) {
			response.setContentType("text/plain");
			out = response.getWriter();
			out.print("FECHAMENOR");
		}else {
			try {
				consumo.setFecha_fin(fecha_fin);
				consumo.setConsumoTotal(consumoTotal);
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
	}
	
	private void actualizar(int consumo_ID, int contrato_ID, Date fecha_fin, float consumoTotal, float lectura, HttpServletResponse response) throws IOException {
		Consumo consumo =  new Consumo();
//		boolean lecturaMenor = false;
		boolean fechaMenor = false;
//		int primerRegistro = 0;
		try {
			ResultSet r = datosConsumo.cargarTodosConsumos();
			while(r.next()) {
//				if(r.getFloat("lectura_Actual") == 0) {
//					primerRegistro = r.getInt("Consumo_ID");
//				}
				if(consumo_ID > r.getInt("Consumo_ID") && contrato_ID == r.getInt("Contrato_ID") && r.getFloat("lectura_Actual") > 0) {
//					if(lectura <= r.getFloat("lectura_Actual") && contrato_ID == r.getInt("Contrato_ID")) {
//						lecturaMenor = true;
//					}
					if(fecha_fin.compareTo(r.getDate("fecha_fin")) <= 0 && contrato_ID == r.getInt("Contrato_ID")) {
						fechaMenor = true;
					}
				}
//				if(consumo_ID == r.getInt("Consumo_ID") && r.getFloat("consumoTotal") == r.getFloat("lectura_Actual")){
//					Consumo c = new Consumo();
//					c.setConsumo_ID(primerRegistro);
//					c.setFecha_fin(fecha_fin);
//					c.setActual(false);
//					c.setEliminado(false);
//					c.setConsumoTotal(0.0f);
//					c.setLectura_Actual(0.0f);
//					datosConsumo.actualizarConsumo(c);
//				}
			}
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
//		if(lecturaMenor) {
//			response.setContentType("text/plain");
//			out = response.getWriter();
//			out.print("LECTURAMENOR");
//		}else 
		if(fechaMenor) {
			response.setContentType("text/plain");
			out = response.getWriter();
			out.print("FECHAMENOR");
		}else {
			try {
			consumo.setConsumo_ID(consumo_ID);
			consumo.setFecha_fin(fecha_fin);
			consumo.setConsumoTotal(consumoTotal);
			consumo.setLectura_Actual(lectura);
			consumo.setActual(true);
			consumo.setEliminado(false);
			verificar_resultado(datosConsumo.actualizarConsumo(consumo), response);
			}catch (Exception e) {
				System.err.println("ERROR EN EL SERVLET CONTRATO: "+e.getMessage());
			}
		}

	}

	/**
	 * @see HttpServlet#doDelete(HttpServletRequest, HttpServletResponse)
	 */
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Consumo consumo =  new Consumo();
		consumo.setConsumo_ID(Integer.parseInt(req.getHeader("consumo_ID")));
		consumo.setEliminado(true);
		verificar_resultado(datosConsumo.eliminarConsumo(consumo), resp);
	}
	
	protected void traerConsumos(int contrato_ID, HttpServletResponse response) throws SQLException, IOException, ParseException {
		List<Consumo> consumos = new ArrayList<>();
		ResultSet rs;
		if(contrato_ID == 0)
			rs = datosConsumo.cargarConsumos();
		else
			rs = datosConsumo.cargarHistorial(contrato_ID);
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
