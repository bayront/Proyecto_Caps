package Controladores;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Datos.Conexion;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.Exporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;

/**
 * Servlet implementation class SL_ReporteFilm
 */
@WebServlet("/SL_ReporteOtros")

public class SL_ReporteOtros extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_ReporteOtros() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try 
		{
			Connection con = null;
			
			con = Conexion.getConnection();
			String descripcion ="";
			
			String monto ="";
			String fecha ="";
			
			descripcion = request.getParameter("descripcion");
			monto = request.getParameter("monto");
			fecha = request.getParameter("fecha");
			//Aquí se ponen los parámetros a como se llaman en el reporte
			HashMap<String, Object>hm = new HashMap<>();
			
			hm.put("descripcion", descripcion);
			hm.put("monto", monto);
			hm.put("fecha", fecha);
			
			System.out.println(hm);
			OutputStream otps = response.getOutputStream();
			ServletContext context = getServletContext();
			String path = context.getRealPath("/");
			String template = "reporte\\InformeF.jasper";
			Exporter exporter = new JRPdfExporter();
			System.out.println(path+template);
			System.out.println(con);
			JasperPrint jasperPrint = JasperFillManager.fillReport(path+template, hm, con);
			response.setContentType("application/pdf");
			response.setHeader("Content-Disposition", "inline; filename=\"Informe.pdf\"");
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
