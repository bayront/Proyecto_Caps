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

import Datos.DT_reciboCaja;
import Datos.DataTableObject;

import Entidades.Contrato;
import Entidades.Factura_Maestra;
import Entidades.ReciboCaja;
import Entidades.Reconexion;
import Entidades.Serie;
import Entidades.Cliente;
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
	private DT_reciboCaja dt_reciboCaja = DT_reciboCaja.getInstance();
	private DTContrato dTcontrato= DTContrato.getInstance();
	private DTFacturaMaestra dtFacturaMaestra = DTFacturaMaestra.getInstance();
	private DTReconexion dtReconexion = DTReconexion.getInstance();
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
				cargarRecibosDetalles();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	private void cargarRecibosDetalles() throws SQLException {
		List<ReciboCaja> listaRecibo = new ArrayList<>();
		ResultSet rs = dt_reciboCaja.cargarRecibos();
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
			reciboCaja.setDescripcion(rs.getString("descripcionRecibo"));
			reciboCaja.setNumDocumento(rs.getInt("numDocumento"));
			reciboCaja.setMontoTotal(rs.getFloat("montoTotal"));
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
			Contrato contrato = new Contrato();
			Cliente cliente = new Cliente();
			cliente.setCliente_ID(rs.getInt("Cliente_ID"));
			contrato.setNumMedidor(rs.getString("numMedidor"));
			contrato.setContrato_ID(rs.getInt("Contrato_ID"));
			contrato.setNumContrato(rs.getInt("numContrato"));
			contrato.setMontoContrato(rs.getFloat("montoContrato"));
			contrato.setCuotas(rs.getInt("cuotas"));
			contrato.setCliente(cliente);
			listaC.add(contrato);
			
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
		float monto;
		int serie_ID, numDocumento, cliente_ID;
		Date fechaRecibo;
		switch (opcion) {
		case "guardar":
			monto = Float.parseFloat(request.getParameter("monto"));
			cliente_ID = Integer.parseInt(request.getParameter("cliente_ID"));
			try {
				fechaForm = request.getParameter("fechaRecibo");
				fechaRecibo = fecha.parse(fechaForm);
				System.out.println(fechaRecibo);
				
				serie_ID = Integer.parseInt(request.getParameter("serie"));
				if(serie_ID == 1)
					numDocumento = Integer.parseInt(request.getParameter("factura"));
				else if(serie_ID == 2)
					numDocumento = Integer.parseInt(request.getParameter("contrato"));
				else
					numDocumento = Integer.parseInt(request.getParameter("reconexion"));
				System.out.println("cliente: "+cliente_ID+", monto: "+monto+", serie: "+serie_ID);
				guardar(serie_ID, numDocumento, monto, fechaRecibo, cliente_ID, response);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			break;
			case "eliminar":
				System.out.println("eliminado");
//				lectura = Float.parseFloat(request.getParameter("lectura"));
//				float lecturaRound= (float) (Math.round(lectura * 100.0) / 100.0);
//				cliente_ID = Integer.parseInt(request.getParameter("cliente_ID"));
//				contrato_ID = Integer.parseInt(request.getParameter("contrato_ID"));
//				fecha_fin = fecha.parse(request.getParameter("fecha"));
//				guardar(fecha_fin, lecturaRound, cliente_ID, contrato_ID, response);
				break;
		default:
			response.setContentType("text/plain");
			out = response.getWriter();
			out.print("VACIO");
			break;
		}
	}

	private void guardar(int serie_ID, int numDocumento, float monto, Date fechaRecibo, int cliente_ID, HttpServletResponse response) throws IOException {
		Serie serie = new Serie();
		serie.setSerie_ID(serie_ID);
		Cliente cliente = new Cliente();
		cliente.setCliente_ID(cliente_ID);
		ReciboCaja r = new ReciboCaja();
		r.setNumDocumento(numDocumento);
		r.setMontoTotal(monto);
		r.setSerie(serie);
		r.setFecha(fechaRecibo);
		r.setCliente(cliente);
		//verificar_resultado(dt_reciboCaja.guardarRecibo(r), response);
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
