package Controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import Datos.DTContrato;
import Datos.DTFacturaMaestra;
import Datos.DataTableObject;
import Entidades.Categoria;
import Entidades.Cliente;
import Entidades.Consumo;
import Entidades.Contrato;
import Entidades.Factura_Maestra;
import Entidades.RegimenPropiedad;
import Entidades.Sector;
@WebServlet("/SL_Factura_Maestra")
public class SL_Factura_Maestra extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private PrintWriter out;
	private DTFacturaMaestra dtFactura = DTFacturaMaestra.getInstance();
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();
	
	  
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
		try {
			traerFacturas(response);
			
		}catch (SQLException e){
			e.printStackTrace();
		}
	}
    
    
    private void traerFacturas(HttpServletResponse response) throws SQLException {
    	List<Factura_Maestra> listaF = new ArrayList<>();
		ResultSet rs = dtFactura.cargarDatosTabla();
		while(rs.next()){
			Factura_Maestra fA = new Factura_Maestra();
			Consumo co = new Consumo();
			Contrato con = new Contrato();
			Cliente cl = new Cliente();
			
			fA.setNumFact(rs.getString(7));
			fA.setDeslizamiento(rs.getFloat(4));
			fA.setFechaVencimiento(rs.getDate(6));
			fA.setTotalPago(rs.getFloat(8));
			co.setConsumoTotal(rs.getFloat(3));
			co.setFecha_fin(rs.getDate(5));
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
	
}
