package Controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
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

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import Datos.DTConsumo;
import Datos.DTFacturaMaestra;
import Datos.DT_consumo_bomba;
import Datos.DataTableObject;
import Entidades.Cliente;
import Entidades.Consumo;
import Entidades.Contrato;
import Entidades.Factura_Maestra;
@WebServlet("/SL_Factura_Maestra")
public class SL_Factura_Maestra extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private PrintWriter out;
	private DTFacturaMaestra dtFactura = DTFacturaMaestra.getInstance();
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();
	SimpleDateFormat parseador = new SimpleDateFormat("dd/MM/yyyy");
	SimpleDateFormat parseador2 = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH);
	
	  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_Factura_Maestra() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("application/json");
		out = response.getWriter();
		String numMedidor;
		if(Integer.parseInt(request.getParameter("carga")) == 1) {
			try {
				try {
					traerFacturas(response);
				} catch (ParseException e) {
					e.printStackTrace();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else if(Integer.parseInt(request.getParameter("carga")) == 2) {
			try {
				numMedidor = request.getParameter("numMedidor");
				historialFacturaCliente(numMedidor, response);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}else if(Integer.parseInt(request.getParameter("carga")) == 3) {
			try {
				facturasSinCancelar(response);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}else if(Integer.parseInt(request.getParameter("carga")) == 4) {
			try {
				historialFacturas(response);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
	}
    
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String opcion = req.getParameter("opcion");
		switch (opcion) {
		case "generar":
			try {
				Date fechaCorte, fechaVence;
				String fechaForm;
				fechaForm = req.getParameter("fecha_corte");
				fechaCorte = parseador.parse(fechaForm);
				fechaForm = req.getParameter("fecha_vence");
				fechaVence = parseador.parse(fechaForm);
				generarFacturas(fechaCorte, fechaVence, resp);
			} catch (ParseException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			break;
		case "eliminar":
			String numFact = req.getParameter("numFact");
			anularFactura(numFact, resp);
			break;
		default:
			resp.setContentType("text/plain");
			PrintWriter out;
			out = resp.getWriter();
			out.print("VACIO");
			break;
		}
    }
	
	private void generarFacturas(Date fechaCorte, Date fechaVence, HttpServletResponse resp) throws IOException, SQLException {
		DTConsumo dtConsumo = DTConsumo.getInstance();
		ResultSet r = dtConsumo.cargarTodosConsumos();
		boolean hayFechaCorte = false;
		while(r.next()){
			if(r.getDate("fecha_fin").equals(fechaCorte)) {
				hayFechaCorte = true;
				break;
			}
		}
		if (hayFechaCorte) {
			if (dtFactura.generarFacturas(fechaCorte, fechaVence) == 0) {
				resp.setContentType("text/plain");
				PrintWriter out;
				out = resp.getWriter();
				out.print("NOFACTURAS");
			}else
				verificar_resultado(true, resp);
		}else
			verificar_resultado(false, resp);
			
	}
	
	private void anularFactura(String numFact, HttpServletResponse response) {
		try {
			Factura_Maestra factura = new Factura_Maestra();
			factura.setNumFact(numFact);
			verificar_resultado(dtFactura.anularFacturaMaestra(factura), response);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ERROR EN EL SERVLET FACTURA_MAESTRA: " + e.getMessage());
		}
		
	}
	
	private void traerFacturas(HttpServletResponse response) throws SQLException, ParseException {
    	List<Factura_Maestra> listaF = new ArrayList<>();
		ResultSet rs = dtFactura.cargarDatosTabla();
		while(rs.next()){
			Factura_Maestra fA = new Factura_Maestra();
			Consumo co = new Consumo();
			Contrato con = new Contrato();
			Cliente cl = new Cliente();
			
			fA.setNumFact(rs.getString(7));
			fA.setDeslizamiento(rs.getFloat(4));
			String f = parseador2.format(rs.getDate(6));
			fA.setFechaVencimiento(parseador2.parse(f));
			fA.setTotalPago(rs.getFloat(8));
			co.setConsumoTotal(rs.getFloat(3));
			f = parseador2.format(rs.getDate(5));
			co.setFecha_fin(parseador2.parse(f));
			cl.setNombreCompleto(rs.getString(1));
			con.setNumMedidor(rs.getString(2));
			
			fA.setConsumo(co);
			fA.setCliente(cl);
			fA.setContrato(con);
			
			listaF.add(fA);
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Factura_Maestra factura : listaF) {
			dataTableObject.aaData.add(factura);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
	}
	
	private void historialFacturaCliente (String numMedidor, HttpServletResponse response) throws SQLException, IOException, ParseException {
		List<Factura_Maestra> listaF = new ArrayList<>();
		ResultSet rs = dtFactura.historialFacturasCliente(numMedidor);
		while(rs.next()){
			Factura_Maestra fA = new Factura_Maestra();
			Consumo co = new Consumo();
			Contrato con = new Contrato();
			Cliente cl = new Cliente();
			
			fA.setNumFact(rs.getString(7));
			fA.setDeslizamiento(rs.getFloat(4));
			String f = parseador2.format(rs.getDate(6));
			fA.setFechaVencimiento(parseador2.parse(f));
			fA.setTotalPago(rs.getFloat(8));
			co.setConsumoTotal(rs.getFloat(3));
			f = parseador2.format(rs.getDate(5));
			co.setFecha_fin(parseador2.parse(f));
			cl.setNombreCompleto(rs.getString(1));
			con.setNumMedidor(rs.getString(2));
			
			fA.setConsumo(co);
			fA.setCliente(cl);
			fA.setContrato(con);
			
			listaF.add(fA);
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Factura_Maestra fA : listaF) {
			dataTableObject.aaData.add(fA);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);	
	}
	
	private void historialFacturas (HttpServletResponse response) throws SQLException, IOException, ParseException {
		List<Factura_Maestra> listaF = new ArrayList<>();
		ResultSet rs = dtFactura.historialFacturas();
		while(rs.next()){
			Factura_Maestra fA = new Factura_Maestra();
			Consumo co = new Consumo();
			Contrato con = new Contrato();
			Cliente cl = new Cliente();
			
			fA.setNumFact(rs.getString(7));
			fA.setDeslizamiento(rs.getFloat(4));
			String f = parseador2.format(rs.getDate(6));
			fA.setFechaVencimiento(parseador2.parse(f));
			fA.setTotalPago(rs.getFloat(8));
			co.setConsumoTotal(rs.getFloat(3));
			f = parseador2.format(rs.getDate(5));
			co.setFecha_fin(parseador2.parse(f));
			cl.setNombreCompleto(rs.getString(1));
			con.setNumMedidor(rs.getString(2));
			
			fA.setConsumo(co);
			fA.setCliente(cl);
			fA.setContrato(con);
			
			listaF.add(fA);
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Factura_Maestra fA : listaF) {
			dataTableObject.aaData.add(fA);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
		
	}
	
	private void facturasSinCancelar (HttpServletResponse response) throws SQLException, IOException, ParseException {
		List<Factura_Maestra> listaF = new ArrayList<>();
		ResultSet rs = dtFactura.facturasSinCancelar();
		while(rs.next()){
			Factura_Maestra fA = new Factura_Maestra();
			Consumo co = new Consumo();
			Contrato con = new Contrato();
			Cliente cl = new Cliente();
			
			fA.setNumFact(rs.getString(7));
			fA.setDeslizamiento(rs.getFloat(4));
			String f = parseador2.format(rs.getDate(6));
			fA.setFechaVencimiento(parseador2.parse(f));
			fA.setTotalPago(rs.getFloat(8));
			co.setConsumoTotal(rs.getFloat(3));
			f = parseador2.format(rs.getDate(5));
			co.setFecha_fin(parseador2.parse(f));
			cl.setNombreCompleto(rs.getString(1));
			con.setNumMedidor(rs.getString(2));
			
			fA.setConsumo(co);
			fA.setCliente(cl);
			fA.setContrato(con);
			
			listaF.add(fA);
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Factura_Maestra fA : listaF) {
			dataTableObject.aaData.add(fA);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
		
	}
	
    protected void verificar_resultado(boolean r, HttpServletResponse response) throws IOException {
		response.setContentType("text/plain");
		PrintWriter out;
		if(r) {
			out = response.getWriter();
			out.print("BIEN");
		}else {
			out = response.getWriter();
			out.print("ERROR");
		}
	}
}
