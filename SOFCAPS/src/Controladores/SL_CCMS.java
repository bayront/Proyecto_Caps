package Controladores;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.io.*;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.javafx.collections.MappingChange.Map;

import Datos.Conexion;
import Datos.DTCategoria;
import Datos.DTConsumo;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.Exporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;

/**
 * Servlet implementation class SL_ReporteFilm
 */
@WebServlet("/SL_CCMS")

public class SL_CCMS extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	DateFormat fecha = new SimpleDateFormat("yyyy-MM-dd");
	DateFormat parseador = new SimpleDateFormat("dd/MM/yyyy");
       
    /**	
     * @see HttpServlet#HttpServlet()
     */
    public SL_CCMS() {
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
			String valor ="";
			String v="";
			String sectorC="";
			String userC= request.getParameter("userC");
			
			
			valor= request.getParameter("FECHITA");
			v=request.getParameter("FECHITAA");
			sectorC= request.getParameter("sec");
			
			
			Date fecha1 = parseador.parse(valor);
			String f1 = fecha.format(fecha1);
			
			Date fecha2 = parseador.parse(v);
			String f2 = fecha.format(fecha2);
			
			System.out.println("fecha1: "+f1+"fecha2: "+f2);
			
			//Aqu� se ponen los par�metros a como se llaman en el reporte
			HashMap<String, Object>hm = new HashMap<>();
			
			
			hm.put("mini", f1);
			hm.put("aini",f2);
			hm.put("nomini",sectorC);
			hm.put("userC", userC);
			
			
			//$P{mesConsumoClienteSectorjasper}, $P{anioConsumoClienteSectorjasper},  $P{nombreSectorConsumoClientejasper}
			System.out.println(hm);
			OutputStream otps = response.getOutputStream();
			ServletContext context = getServletContext();
			String path = context.getRealPath("/");
			String template = "reporte\\ConsumoClientesMS.jasper";
			Exporter exporter = new JRPdfExporter();
			System.out.println(path+template);
			System.out.println(con);
			JasperPrint jasperPrint = JasperFillManager.fillReport(path+template, hm, con);
			response.setContentType("application/pdf");
			response.setHeader("Content-Disposition", "inline; filename=\"Informe.pdf\"");
			exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
			exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(otps));
			exporter.exportReport();
			System.out.println("SlReporte parametro"+" "+valor);
			
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

