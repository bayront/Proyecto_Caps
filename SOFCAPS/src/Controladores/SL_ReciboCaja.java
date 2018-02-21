package Controladores;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
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

import Datos.DT_reciboCaja;
import Datos.DataTableObject;

import Entidades.Contrato;
import Entidades.Factura_Maestra;
import Entidades.ReciboCaja;
import Entidades.Reconexion;
import Entidades.Serie;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.Exporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import Entidades.Cliente;
import Datos.Conexion;
import Datos.DTContrato;
import Datos.DTFacturaMaestra;
import Datos.DTReconexion;
/**
 * Servlet implementation class SL_ReciboCaja
 */
@WebServlet("/SL_ReciboCaja")
public class SL_ReciboCaja extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PrintWriter out;
	private DT_reciboCaja dt_reciboCaja = new DT_reciboCaja();
	private DTContrato dTcontrato= new DTContrato();
	private DTFacturaMaestra dtFacturaMaestra = new DTFacturaMaestra();
	private DTReconexion dtReconexion = new DTReconexion();
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();
	
	SimpleDateFormat fecha = new SimpleDateFormat("dd/MM/yyyy", new Locale("es_ES"));
	SimpleDateFormat parseador2 = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH);
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_ReciboCaja() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		out = response.getWriter();
		int idRecibo;
		int idCliente = Integer.parseInt(request.getParameter("cliente_ID"));
		if(Integer.parseInt(request.getParameter("idserie")) == 1){
			try {
				traerNumeroFactura(idCliente , response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else if(Integer.parseInt(request.getParameter("idserie")) == 2) {
			try {	
				traerVistaClienteContrato(idCliente , response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else if(Integer.parseInt(request.getParameter("idserie")) == 3) {
			try {
				traerReconexiones(idCliente , response);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}else if(Integer.parseInt(request.getParameter("idserie")) == 4) {
			try {
				int anioB= Integer.parseInt(request.getParameter("anioB"));
				int periodoB= Integer.parseInt(request.getParameter("periodoB"));
				cargarRecibosDetalles(anioB, periodoB);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else if(Integer.parseInt(request.getParameter("idserie")) == 5) {
			idRecibo = Integer.parseInt(request.getParameter("idRecibo"));
			try {
				imprimirRecibo(idRecibo, response);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(Integer.parseInt(request.getParameter("idserie")) == 6) {
			String fecha_inicio = request.getParameter("fecha_inicio");
			String fecha_fin = request.getParameter("fecha_fin");
			String user = request.getParameter("userC");
			
			try {
				DateFormat fechaParse = new SimpleDateFormat("yyyy-MM-dd");
				Date fecha_inicioD;
				fecha_inicioD = fecha.parse(fecha_inicio);
				fecha_inicio = fechaParse.format(fecha_inicioD);
				Date fecha_finD = fecha.parse(fecha_fin);
				fecha_fin = fechaParse.format(fecha_finD);
				imprimirInforme(fecha_inicio, fecha_fin, user, response);
			} catch (ParseException e) {
				e.printStackTrace();
				response.setContentType("text/plain");
				out = response.getWriter();
				out.print("ERROR AL GENERAR INFORME");
			}
		}
	}

	private void cargarRecibosDetalles(int anioB, int periodoB) throws SQLException {
		int mesI=0, mesF=0;
		if(periodoB == 1) {
			mesI= 1;
			mesF= 6;
		}else if(periodoB == 2) {
			mesI= 7;
			mesF= 12;
		}
		List<ReciboCaja> listaRecibo = new ArrayList<>();
		ResultSet rs = dt_reciboCaja.cargarRecibos(anioB, mesI, mesF);
		while(rs.next()){
			ReciboCaja reciboCaja = new ReciboCaja();
			Cliente cliente = new Cliente();
			Serie serie = new Serie();
			serie.setSerie_ID(rs.getInt("Serie_ID"));
			serie.setDescripcion(rs.getString("descripcionSerie"));
			cliente.setNombreCompleto(rs.getString("nombreCompleto"));
			cliente.setCliente_ID(rs.getInt("Cliente_ID"));
			reciboCaja.setCliente(cliente);
			reciboCaja.setSerie(serie);
			reciboCaja.setReciboCaja_ID(rs.getInt("ReciboCaja_ID"));
			reciboCaja.setDescripcion(rs.getString("descripcionRecibo"));
			reciboCaja.setNumDocumento(rs.getInt("numDocumento"));
			reciboCaja.setNumReciboCaja(rs.getString("numReciboCaja"));
			reciboCaja.setMontoTotal(rs.getFloat("montoTotal"));
			try {
				String fecha1 = parseador2.format(rs.getDate("fecha"));
				reciboCaja.setFecha(parseador2.parse(fecha1));
			} catch (ParseException e1) {
				e1.printStackTrace();
			}
			if(serie.getSerie_ID() == 1) {
				ResultSet resultSet = dtFacturaMaestra.cargarFacturaUnica(reciboCaja.getNumDocumento());
				resultSet.next();
				Factura_Maestra f = new Factura_Maestra();
				f.setFactura_Maestra_ID(resultSet.getInt("Factura_Maestra_ID"));
				f.setNumFact(resultSet.getString("numFact"));
				reciboCaja.factura_Maestra = f;
			}else if(serie.getSerie_ID() == 2) {
				ResultSet resultSet = dTcontrato.cargarContratoUnico(reciboCaja.getNumDocumento());
				resultSet.next();
				Contrato c = new Contrato();
				c.setContrato_ID(resultSet.getInt("Contrato_ID"));
				c.setNumContrato(resultSet.getInt("numContrato"));
				c.setNumMedidor(resultSet.getString("numMedidor"));
				reciboCaja.contrato = c;
			}else if(serie.getSerie_ID() == 3){
				ResultSet resultSet = dtReconexion.cargarReconexionUnica(reciboCaja.getNumDocumento());
				resultSet.next();
				Reconexion r = new Reconexion();
				r.setReconexion_ID(resultSet.getInt("Reconexion_ID"));
				try {
					String fecha2 = parseador2.format(resultSet.getDate("fecha_reconexion"));
					r.setFecha_reconexion(parseador2.parse(fecha2));
				} catch (ParseException e) {
					e.printStackTrace();
				}
				reciboCaja.reconexion = r;
			}
			listaRecibo.add(reciboCaja);
		}
		
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (ReciboCaja reciboCaja : listaRecibo) {
			dataTableObject.aaData.add(reciboCaja);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
	}
	
	private void imprimirRecibo (int idRecibo, HttpServletResponse resp) throws SQLException, ParseException {
		try {
			Connection con = null;
			
			con = Conexion.getConnection();			
			
			//Aqu� se ponen los par�metros a como se llaman en el reporte
			HashMap<String, Object>hm = new HashMap<>();
			hm.put("idRecibo", idRecibo);
			
			System.out.println(hm);
			resp.reset();
			OutputStream otps = resp.getOutputStream();
			ServletContext context = getServletContext();
			String path = context.getRealPath("/");
			String template = "reporte\\reciboCaja.jasper";
			Exporter exporter = new JRPdfExporter();
			System.out.println(path+template);
			System.out.println(con);
			JasperPrint jasperPrint = JasperFillManager.fillReport(path+template, hm, con);
			resp.setContentType("application/pdf");
			resp.setHeader("Content-Disposition", "inline; filename=\"Informe.pdf\"");
			exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
			exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(otps));
			exporter.exportReport();
		}catch (Exception e) {
		 e.printStackTrace();
		 System.out.println("REPORTE: ERROR AL GENERAR REPORTE " + e.getMessage());
		}
	}
	
	private void imprimirInforme(String fecha_inicio, String fecha_fin, String user, 
			HttpServletResponse resp) throws IOException {
		try {
			//Aqu� se ponen los par�metros a como se llaman en el reporte
			HashMap<String, Object>hm = new HashMap<>();
			
			hm.put("Parameter1", fecha_inicio);
			hm.put("Parameter2", fecha_fin);
			hm.put("userC", user);
			
			resp.reset();
			OutputStream otps = resp.getOutputStream();
			ServletContext context = getServletContext();
			String path = context.getRealPath("/");
			String template = "reporte\\informeReciboCaja.jasper";
			Exporter exporter = new JRPdfExporter();
			
			Connection con = Conexion.getConnection();
			JasperPrint jasperPrint;
			jasperPrint = JasperFillManager.fillReport(path+template, hm, con);
			resp.setContentType("application/pdf");
			resp.setHeader("Content-Disposition", "inline; filename=\"Informe_Recibos.pdf\"");
			exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
			exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(otps));
			exporter.exportReport();
		} catch (JRException e) {
			e.printStackTrace();
			resp.setContentType("text/plain");
			out = resp.getWriter();
			out.print("ERROR AL GENERAR INFORME");
		}	
	}

	private void traerReconexiones(int idCliente, HttpServletResponse response) throws ParseException {
		System.out.println("traer reconexiones del cliente");
		List<Reconexion> reconexiones = dtReconexion.listaReconexiones(idCliente);
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Reconexion r : reconexiones) {
			String f = parseador2.format(r.getFecha_reconexion());
			r.setFecha_reconexion(parseador2.parse(f));
			dataTableObject.aaData.add(r);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
	}

	private void traerVistaClienteContrato(int cliente_ID, HttpServletResponse response) throws SQLException {
		List<Contrato> listaC = new ArrayList<>();
		ResultSet rs = dTcontrato.cargarVistaClienteContrato(cliente_ID);	
		  
		while(rs.next()){
			float montoPagado = dTcontrato.calcularMontoRestante(rs.getInt("Contrato_ID"));
			System.out.println("monto pagado: "+montoPagado+", monto del contrato: "+rs.getFloat("montoContrato"));
			if(rs.getFloat("montoContrato") > montoPagado){
				Contrato contrato = new Contrato();
				Cliente cliente = new Cliente();
				cliente.setCliente_ID(rs.getInt("Cliente_ID"));
				contrato.setNumMedidor(rs.getString("numMedidor"));
				contrato.setContrato_ID(rs.getInt("Contrato_ID"));
				contrato.setNumContrato(rs.getInt("numContrato"));
				float montoRound = (float) (Math.round(rs.getFloat("montoContrato") * 100.0) / 100.0);
				contrato.setMontoContrato(montoRound);
				contrato.setCuotas(rs.getInt("cuotas"));
				contrato.setCliente(cliente);
				listaC.add(contrato);
			}
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
	
	private void traerNumeroFactura(int cliente_ID, HttpServletResponse response) throws SQLException {
		List<Factura_Maestra> listaFC = new ArrayList<>();
		System.out.println("cliente a ver facturas: "+cliente_ID);
		ResultSet rs = dtFacturaMaestra.cargarNumeroDeFactura(cliente_ID);	
		  
		while(rs.next()){
			Factura_Maestra factura_maestra = new Factura_Maestra();
			factura_maestra.setNumFact(rs.getString("numFact"));
			factura_maestra.setTotalPago(rs.getFloat("totalPago") + rs.getFloat("deslizamiento"));
			factura_maestra.setFactura_Maestra_ID(rs.getInt("Factura_Maestra_ID"));
			listaFC.add(factura_maestra);
		}
		
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Factura_Maestra factura_maestra : listaFC) {
			dataTableObject.aaData.add(factura_maestra);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opcion = request.getParameter("opcion");
		String fechaForm;
		float monto, montoRound;
		int serie_ID, numDocumento, cliente_ID, reciboCaja_ID;
		Date fechaRecibo;
		switch (opcion) {
		case "guardar":
			float totalPagar = Float.parseFloat(request.getParameter("totalPagar"));
			monto = Float.parseFloat(request.getParameter("monto"));
			montoRound = (float) (Math.round(monto * 100.0) / 100.0);
			cliente_ID = Integer.parseInt(request.getParameter("cliente_ID"));
			try {
				System.out.println("fecha recibo: "+request.getParameter("fechaRecibo"));
				fechaForm = request.getParameter("fechaRecibo");
				fechaRecibo = fecha.parse(fechaForm);
				System.out.println(fechaRecibo);
				
				serie_ID = Integer.parseInt(request.getParameter("serie"));
				numDocumento = Integer.parseInt(request.getParameter("dato"));
				System.out.println("cliente: "+cliente_ID+", monto: "+monto+", serie: "+serie_ID+", totalPagar: "+totalPagar);
				guardar(serie_ID, numDocumento, montoRound, fechaRecibo, cliente_ID, totalPagar, response);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			break;
			case "eliminar":
				reciboCaja_ID = Integer.parseInt(request.getParameter("reciboCaja_ID"));
				eliminar(reciboCaja_ID, response);
				break;
		default:
			response.setContentType("text/plain");
			out = response.getWriter();
			out.print("VACIO");
			break;
		}
	}

	private void eliminar(int reciboCaja_ID, HttpServletResponse response) {
		try {
			ReciboCaja r = new ReciboCaja();
			r.setReciboCaja_ID(reciboCaja_ID);
			r.setEstado(false);
			System.out.println("reciboCaja a eliminar en el servlet: "+r.getReciboCaja_ID());
			verificar_resultado(dt_reciboCaja.eliminarRecibo(r), response);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void guardar(int serie_ID, int numDocumento, float monto, Date fechaRecibo, int cliente_ID, float totalPagar, HttpServletResponse response) throws IOException {
		Serie serie = new Serie();
		serie.setSerie_ID(serie_ID);
		Cliente cliente = new Cliente();
		cliente.setCliente_ID(cliente_ID);
		ReciboCaja r = new ReciboCaja();
		r.setNumDocumento(numDocumento);
		r.setMontoTotal(monto);
		r.setSerie(serie);
		r.setFecha(fechaRecibo);
		r.setDescripcion(null);
		r.setCliente(cliente);
		verificar_resultado(dt_reciboCaja.guardarRecibo(r, totalPagar), response);
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
