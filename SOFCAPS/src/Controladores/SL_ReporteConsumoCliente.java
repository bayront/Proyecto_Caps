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
import Datos.DTContrato;
import Datos.DataTableObject;
import Entidades.Cliente;
import Entidades.Consumo;
import Entidades.Contrato;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.Exporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;

/**
 * Servlet implementation class SL_ReporteConsumoCliente
 */
@WebServlet("/SL_ReporteConsumoCliente")
public class SL_ReporteConsumoCliente extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PrintWriter out;
	private DTConsumo datosConsumo = DTConsumo.getInstance();
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();
	SimpleDateFormat parseador = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH);
	
	SimpleDateFormat fecha = new SimpleDateFormat("dd/MM/yyyy", new Locale("es_ES"));
	SimpleDateFormat parseador2 = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH);
	
	
	  
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_ReporteConsumoCliente() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opcion = request.getParameter("opcion");
    	System.out.println("opcion del get: "+opcion);
 
    	
    	switch (opcion) {
    	case "cargar":
	    	response.setContentType("application/json");
			out = response.getWriter();
			try {
				traerConsumos(response);
				
			}catch (SQLException e){
				System.out.println("error sql: "+e.getMessage());
				e.printStackTrace();
			} catch (java.text.ParseException e) {
				e.printStackTrace();
				System.out.println("error de parseo : "+e.getMessage());
			}
		
			break;
    	
		case "imprimir":
			System.out.println("imprimir");
			Connection con = null;
    		con = Conexion.getConnection();
    		String userC= request.getParameter("userC");
			
    		int consumo= Integer.parseInt(request.getParameter("consumo_id"));
			System.out.println(consumo);
			HashMap<String, Object>hm = new HashMap<>();
			hm.put("Parameter1", consumo);
			hm.put("userC", userC);
			System.out.println(hm);
			OutputStream otps = response.getOutputStream();
			ServletContext context = getServletContext();
			String path = context.getRealPath("/");
			String template = "reporte\\consumoCFiltro.jasper";
			Exporter exporter = new JRPdfExporter();
			System.out.println(path+template);
			System.out.println(con);
			JasperPrint jasperPrint;
			System.out.println("Imprimir Contrato");
			try {
				jasperPrint = JasperFillManager.fillReport(path+template, hm, con);
				response.setContentType("application/pdf");
				response.setHeader("Content-Disposition", "inline; filename=\"Informe.pdf\"");
				exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
				exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(otps));
			} catch (JRException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		
			try {
				exporter.exportReport();
			} catch (JRException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			break;
		default:
			break;		}
		
	}

	
	protected void traerConsumos(HttpServletResponse response) throws SQLException, IOException, ParseException {
		List<Consumo> consumos = new ArrayList<>();
		ResultSet rs = datosConsumo.cargarConsumos();
		while (rs.next()) {
			String f = parseador2.format(rs.getDate("fecha_fin"));
			Consumo c = new Consumo(parseador2.parse(f), rs.getFloat("consumoTotal"),
					rs.getFloat("lectura_Actual"), 
					rs.getInt("Consumo_ID"),
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

	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
