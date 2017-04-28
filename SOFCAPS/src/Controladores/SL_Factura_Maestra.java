package Controladores;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import Datos.Conexion;
import Datos.DTConsumo;
import Datos.DTFacturaMaestra;
import Datos.DT_consumo_bomba;
import Datos.DataTableObject;
import Entidades.Cliente;
import Entidades.Consumo;
import Entidades.Contrato;
import Entidades.Factura_Maestra;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.Exporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
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
		String numMedidor, numFact;
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
		}else if(Integer.parseInt(request.getParameter("carga")) == 5) {
			Float montoTotal = Float.parseFloat(request.getParameter("montoTotal"));
			int factura_Maestra_ID = Integer.parseInt(request.getParameter("factura_Maestra_ID"));
			traerMontoRestante(montoTotal, factura_Maestra_ID, response);
		}else if(Integer.parseInt(request.getParameter("carga")) == 6) {
			numFact = request.getParameter("numFact");
			System.out.println("numero de factura: "+numFact);
			try {
				imprimirFactura(numFact, response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(Integer.parseInt(request.getParameter("carga")) == 7) {
			try {
				imprimirFacturaMasivo(response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
    
    private void traerMontoRestante(Float montoTotal, int factura_Maestra_ID, HttpServletResponse response) throws IOException {
    	System.out.println("factura_maestra_ID: "+ factura_Maestra_ID+", monto: "+montoTotal);
    	try {
			montoTotal = montoTotal - dtFactura.calcularMontoRestante(factura_Maestra_ID);
			System.out.println("monto factura: "+montoTotal);
			response.setContentType("text/plain");
			PrintWriter out = response.getWriter();
			out.print(montoTotal);
		} catch (Exception e) {
			e.printStackTrace();
			response.setContentType("text/plain");
			PrintWriter out = response.getWriter();
			out.print("ERROR");
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
		case "cancelar":
			int id = Integer.parseInt(req.getParameter("id"));
			boolean cancelado = Boolean.parseBoolean(req.getParameter("cancelado"));
			System.out.println("factura cancelada: "+cancelado);
			boolean pagado = dtFactura.cancelarFactura(id, cancelado);
			if(pagado == true) {
				resp.setContentType("text/plain");
				PrintWriter out;
				out = resp.getWriter();
				out.print("CANCELADO");
			}
			break;
		default:
			resp.setContentType("text/plain");
			PrintWriter out;
			out = resp.getWriter();
			out.print("VACIO");
			break;
		}
    }
	
	private void imprimirFactura (String numFact, HttpServletResponse resp) throws SQLException, ParseException {
		try {
			Connection con = null;
			
			con = Conexion.getConnection();			
			
			//Aquí se ponen los parámetros a como se llaman en el reporte
			HashMap<String, Object>hm = new HashMap<>();
			hm.put("numFact", numFact);
			
			System.out.println("segundo numero de factura: "+numFact);
			System.out.println(hm);
			resp.reset();
			OutputStream otps = resp.getOutputStream();
			ServletContext context = getServletContext();
			String path = context.getRealPath("/");
			String template = "reporte\\Facturas.jasper";
			Exporter exporter = new JRPdfExporter();
			System.out.println(path+template);
			System.out.println(con);
			JasperPrint jasperPrint = JasperFillManager.fillReport(path+template, hm, con);
			resp.setContentType("application/pdf");
			resp.setHeader("Content-Disposition", "inline; filename=\"Informe.pdf\"");
			exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
			exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(otps));
			exporter.exportReport();
			System.out.println("SL_Factura_Maestra numFact"+" "+numFact);
		}catch (Exception e) {
		 e.printStackTrace();
		 System.out.println("REPORTE: ERROR AL GENERAR REPORTE " + e.getMessage());
		}
	}
	
	private void imprimirFacturaMasivo (HttpServletResponse resp) throws SQLException, ParseException {
		try 
		{
			 
			Connection con = null;
			
			con = Conexion.getConnection();			
			
			//Aquí se ponen los parámetros a como se llaman en el reporte
			HashMap<String, Object>hm = new HashMap<>();
//			hm.put("numFact", numFact);
			
//			System.out.println(hm);
			resp.reset();
			OutputStream otps = resp.getOutputStream();
			ServletContext context = getServletContext();
			String path = context.getRealPath("/");
			String template = "reporte\\FacturaMasiva.jasper";
			Exporter exporter = new JRPdfExporter();
			System.out.println(path+template);
			System.out.println(con);
			JasperPrint jasperPrint = JasperFillManager.fillReport(path+template, hm, con);
			resp.setContentType("application/pdf");
			resp.setHeader("Content-Disposition", "inline; filename=\"Informe.pdf\"");
			exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
			exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(otps));
			exporter.exportReport();
			
		}
		catch (Exception e) 
		{
		 e.printStackTrace();
		 System.out.println("REPORTE: ERROR AL GENERAR REPORTE " + e.getMessage());
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
				PrintWriter out = resp.getWriter();
				out.print("NOFACTURAS");
			}else
				verificar_resultado(true, resp);
		}else {
			resp.setContentType("text/plain");
			PrintWriter out = resp.getWriter();
			out.print("NOFECHA");
		}
			
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
