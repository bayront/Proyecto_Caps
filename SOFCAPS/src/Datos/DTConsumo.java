package Datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import Entidades.Cliente;
import Entidades.Consumo;
import Entidades.Contrato;

public class DTConsumo {
	Connection cn = null;
	PreparedStatement ps =null;
	ResultSet rs =null;
	public ArrayList<Consumo> listarConsumos()
	{
		ArrayList<Consumo> listaConsumo = new ArrayList<>();
		String sql = ("SELECT * from consumo");
		try 
		{
			cn = Conexion.getConnection();
			ps = cn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = ps.executeQuery();
			
			while (rs.next()) 
			{
				Consumo c = new Consumo();
				c.setFecha_fin(rs.getDate("fecha_fin"));
				c.setConsumoTotal(rs.getFloat("consumoTotal"));
				c.setLectura_Actual(rs.getFloat("lectura_Actual"));
				c.setActual(rs.getBoolean("actual"));
				c.setConsumo_ID(rs.getInt("Consumo_ID"));
				listaConsumo.add(c);
				
			}
			ps.close();
			cn.close();
			System.out.println("datos cargados de consumos");
		} 
		catch (Exception e) 
		{
			System.err.println("METODO CARGAR: "+e.getMessage());
		}
		
		return listaConsumo;
	}
	public ArrayList<Consumo> listarConsumosConCliente()
	{
		ArrayList<Consumo> listaConsumo = new ArrayList<>();
		String sql = ("SELECT * from consumo");
		String sql2 = ("SELECT * from cliente_contrato");
		try 
		{
			cn = Conexion.getConnection();
			ps = cn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = ps.executeQuery();
			
			while (rs.next()) 
			{
				Consumo c = new Consumo();
				Contrato contrato = new Contrato();
				Cliente cli = new Cliente();
				c.setFecha_fin(rs.getDate("fecha_fin"));
				c.setConsumoTotal(rs.getFloat("consumoTotal"));
				c.setLectura_Actual(rs.getFloat("lectura_Actual"));
				c.setActual(rs.getBoolean("actual"));
				c.setConsumo_ID(rs.getInt("Consumo_ID"));
				contrato.setContrato_ID(rs.getInt("Contrato_ID"));
				cli.setCliente_ID(rs.getInt("Cliente_ID"));
				c.setCliente(cli);
				c.setContrato(contrato);
				listaConsumo.add(c);
				
			}
			System.out.println("datos cargados de consumos");
		} 
		catch (Exception e) 
		{
			System.err.println("METODO CARGAR: "+e.getMessage());
		}
		
		try {
			ps = cn.prepareStatement(sql2, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = ps.executeQuery();
			while (rs.next()) 
			{
				for (Consumo consumo : listaConsumo) {
					if(rs.getInt("Cliente_ID") == consumo.getCliente().getCliente_ID() && 
							rs.getInt("Contrato_ID") == consumo.getContrato().getContrato_ID()) {
						consumo.getCliente().setNombre1(rs.getString("nombres"));
						consumo.getCliente().setApellido1(rs.getString("apellidos"));
						consumo.getContrato().setNumContrato(rs.getInt("numContrato"));
						consumo.getContrato().setNumMedidor(rs.getString("numMedidor"));
					}else{
						System.out.println("este no es el cliente: " + consumo.getCliente().getCliente_ID() + 
								"y no es el contrato: " + consumo.getContrato().getContrato_ID());
					}
				}
				
			}
			ps.close();
			cn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return listaConsumo;
	}
}
