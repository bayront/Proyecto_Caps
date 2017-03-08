package Controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import Datos.DTConsumo;
import Datos.DataTableObject;
import Entidades.Cliente;
import Entidades.Consumo;
import Entidades.Contrato;

/**
 * Servlet implementation class SL_consumo
 */
@WebServlet("/SL_consumo")
public class SL_consumo extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DTConsumo datosConsumo = DTConsumo.getInstance();
	private PrintWriter out;
	private Gson gson = new GsonBuilder().setPrettyPrinting().create();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_consumo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		response.setContentType("application/json");
		out = response.getWriter();
		if(Integer.parseInt(request.getParameter("carga")) == 1) {
			try {
				traerConsumos(response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(Integer.parseInt(request.getParameter("carga")) == 2) {
			try {
				traerClienteContratos(response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
	}

	/**
	 * @see HttpServlet#doPut(HttpServletRequest, HttpServletResponse)
	 */
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
	
	protected void traerConsumos(HttpServletResponse response) throws SQLException, IOException {
		List<Consumo> consumos = new ArrayList<>();
		ResultSet rs = datosConsumo.cargarConsumos();
		while (rs.next()) {
			Consumo c = new Consumo(rs.getDate("fecha_fin"), rs.getFloat("consumoTotal"), 
					rs.getFloat("lectura_Actual"), rs.getInt("Consumo_ID"),
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
//		System.out.println(json.toString());
		out.print(json);
	}

	protected void traerClienteContratos(HttpServletResponse response) throws SQLException {
		List<Cliente> clientes = new ArrayList<>();
		ResultSet rs = datosConsumo.cargarClienteContrato();
		while (rs.next()) {
			Cliente cl = new Cliente(rs.getInt("Cliente_ID"));
			Contrato ct = new Contrato(rs.getInt("Contrato_ID"));
			cl.setNombreCompleto(rs.getString("nombre_completo"));
			ct.setNumContrato(rs.getInt("numContrato"));
			ct.setNumMedidor(rs.getString("numMedidor"));
			List<Contrato> contratos = new ArrayList<>();
			contratos.add(ct);
			cl.setContratos(contratos);
			clientes.add(cl);
		}
		DataTableObject dataTableObject = new DataTableObject();
		dataTableObject.aaData = new ArrayList<>();
		for (Cliente cliente : clientes) {
			dataTableObject.aaData.add(cliente);
		}
		String json = gson.toJson(dataTableObject);
		System.out.println(json.toString());
		out.print(json);
	}
}
