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

import Datos.DTReconexion;
import Datos.DataTableObject;
import Entidades.Cliente;
import Entidades.Reconexion;
import Entidades.Factura_Maestra;


/**
 * Servlet implementation class SL_Contrato
 */
@WebServlet("/SL_Reconexion")
public class SL_Reconexion  extends HttpServlet  {
	private static final long serialVersionUID = 1L;
	private PrintWriter out;
	private DTReconexion dtReconexion = DTReconexion.getInstance();
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();
	SimpleDateFormat parseador = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH);
	
	SimpleDateFormat fecha = new SimpleDateFormat("dd/MM/yyyy");
	
	 /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_Reconexion() {
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
			traerReconexion(response);
			
		}catch (SQLException e){
			System.out.println("error sql: "+e.getMessage());
			e.printStackTrace();
		} catch (java.text.ParseException e) {
			e.printStackTrace();
			System.out.println("error de parseo : "+e.getMessage());
		}
	}
    
    private void traerReconexion(HttpServletResponse response) throws SQLException, java.text.ParseException {
		List<Reconexion> listaReconexion = new ArrayList<>();
		ResultSet rs = dtReconexion.cargarDatosTabla();
		while(rs.next()){
			Reconexion rx = new Reconexion();
			Cliente cl = new Cliente();
			Factura_Maestra fm = new Factura_Maestra();
			String f1 = parseador.format(rs.getDate("fecha_reconexion"));
			rx.setFecha_reconexion(parseador.parse(f1));
			String f2 = parseador.format(rs.getDate("f_cancel"));
			rx.setF_cancel(parseador.parse(f2));
			rx.setCancelado(rs.getBoolean("cancelado"));
			rx.setReconexion_ID(rs.getInt("Reconexion_ID"));
			cl.setCliente_ID(rs.getInt("Cliente_ID"));
			cl.setNombreCompleto(rs.getString("nombre1") + " " + rs.getString("nombre2") + " " + rs.getString("apellido1") + " " + rs.getString("apellido2"));
			fm.setFactura_Maestra_ID(rs.getInt("Factura_Maestra_ID"));
			fm.setNumFact(rs.getString("numFact"));
			rx.setCliente(cl);
			rx.setFactura_Maestra(fm);
			listaReconexion.add(rx);
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Reconexion reconexion : listaReconexion) {
			dataTableObject.aaData.add(reconexion);
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
		int reconexion_ID;
		String opcion;
		
		opcion = request.getParameter("opcion").trim();
		System.out.println("opcion a realizar: " + opcion);
		switch (opcion) {
		case "eliminar":
			reconexion_ID= Integer.parseInt(request.getParameter("reconexion_ID"));
			eliminar(reconexion_ID, response);
			break;
		default:
			response.setContentType("text/plain");
			PrintWriter out;
			out = response.getWriter();
			out.print("VACIO");
			break;
		}
	}
    
    private void eliminar(int reconexion_ID, HttpServletResponse response) {
		try {
			Reconexion rx = new Reconexion();
			rx.setReconexion_ID(reconexion_ID);
			verificar_resultado(dtReconexion.cancelarReconexion(rx), response);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ERROR EN EL SERVLET DE RECONEXION: " + e.getMessage());
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
