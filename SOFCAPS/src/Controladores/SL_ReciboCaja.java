package Controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

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
import Entidades.Reconexion;
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
			traerReconexiones(idCliente , response);
		}
	}
	
	private void traerReconexiones(int idCliente, HttpServletResponse response) {
		System.out.println("traer reconexiones del cliente");
		List<Reconexion> reconexiones = dtReconexion.listaReconexiones(idCliente);
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Reconexion r : reconexiones) {
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
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
