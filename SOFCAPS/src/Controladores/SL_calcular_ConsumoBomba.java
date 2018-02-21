package Controladores;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Datos.DT_consumo_bomba;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SL_calcular_ConsumoBomba
 */
@WebServlet("/SL_calcular_ConsumoBomba")
public class SL_calcular_ConsumoBomba extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DT_consumo_bomba dTconsB = new DT_consumo_bomba();
	private PrintWriter out;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SL_calcular_ConsumoBomba() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String lecturaActual = "";
		float consumo = 0;
		String opc = "";
		opc = request.getParameter("opcion");
		int bombaID;
		
		
		switch(opc){
		case "guardar" : 
			lecturaActual = request.getParameter("lecturaActual");
			consumo = dTconsB.calcularConsumo(Float.parseFloat(lecturaActual));
			System.out.println(consumo);
		
			PrintWriter pw = response.getWriter();
			pw.write(String.valueOf(consumo));
			pw.flush();
			//doGet(request, response);
			break;
		
		case "actualizar": 
			bombaID = Integer.parseInt(request.getParameter("bombaID"));
			lecturaActual = request.getParameter("lecturaActual");
			consumo = dTconsB.calcularConsumoBActualizar(Float.parseFloat(lecturaActual), bombaID);
			System.out.println(consumo);
			PrintWriter pw1 = response.getWriter();
			pw1.write(String.valueOf(consumo));
			pw1.flush();
			break;
			
		default :
			response.setContentType("text/plain");
			out = response.getWriter();
			out.print("VACIO");
			break;
		}
		

	}

}
