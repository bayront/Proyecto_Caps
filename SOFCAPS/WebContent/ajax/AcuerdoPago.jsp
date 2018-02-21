<%@page import="Datos.DTCliente"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page pageEncoding="UTF-8" import="Entidades.Usuario, Entidades.Rol, Datos.DT_Vw_rol_opciones;"%> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
%>
<%
	DT_Vw_rol_opciones dtvro =new DT_Vw_rol_opciones();
	Usuario us = new Usuario();
	us = (Usuario)session.getAttribute("userVerificado");
	
	Rol r = new Rol();
	r = (Rol)session.getAttribute("Rol");
	
	String direccion="";
	direccion = request.getRequestURI();
	//System.out.println("url: "+url);
	int index = request.getRequestURI().lastIndexOf("/");
	//System.out.println("index: "+index);
	String miPagina = request.getRequestURI().substring(index);
	//System.out.println("miPagina: "+miPagina);
	boolean permiso = false;
	String opcionActual = "";
	
	ResultSet resultset;
	
	if(us != null && r != null){
		resultset=dtvro.obtenerOpc(r);
		while(resultset.next()){
			opcionActual = resultset.getString("opciones");
			System.out.println("opcionActual: "+opcionActual);
			if(opcionActual.equals(miPagina)){
				permiso = true;
				break;
			}else{
				permiso = false;
			}
		}
	}else{
		System.out.println("Pagina caps");
		response.sendRedirect("../CAPS.jsp");
		return;
	}
	
	if(!permiso){	
		System.out.println("Pagina de error");
		response.sendRedirect("pag_Error.jsp");
	}
%>

<!--///////////////////////div donde se muestra un Dialogo /////////////////////////////// -->
<div id="dialog" class= "col-xm-offset-1 col-xm-10">
	<div class="contenido" style="margin-left: 20px;"></div>
</div> 
<!--///////////////////////Directorios donde estan los jsp /////////////////////////////// -->
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Reportes</a></li>
			<li><a href="#">Acuerdo de pago</a></li>
		</ol>
	</div>
</div>

<!-- inicio formulario por egresos -->

<div id="porE">
	<div class="row">
		<div class="col-xs-12 col-sm-12">
			<div class="box" style="top: 0px; left: 0px; opacity: 1;">

				<div class="box-header">
					<div class="box-name">
						<i class="fa fa-edit"></i> <span>Generación de Acuerdos de pago</span>
					</div>
				</div>

				<div class="box-content">

					<h4 class="page-header"
						Style="text-align: center; font-size: xx-large;">Informe de
						Compromiso de pago</h4>

					<div class="clearfix"></div>

					<div class="form-group has-feedback">
						<label class="col-sm-offset-2 col-sm-3 text-gpromedix control-label"
							style="width: inherit;font-size: large;">Nombre del cliente:</label>
						<%
							DTCliente dtn = new DTCliente();;
							ResultSet rs = dtn.cargarNombre();
						%>
						<div class="col-sm-5">

							<select id="tippe" name="tippe" class="populate placeholder"
								required>


								<option value="0">SELECCIONE</option>
								<%
									while (rs.next()) {
								%>
								<option value="<%=rs.getString("Cliente_ID")%>"><%=rs.getString("nombre_completo")%></option>
								<%
									}
								%>
							</select>

						</div>
						<div class="clearfix"></div>
						<div class="form-group">
							<div class="col-sm-offset-5 col-sm-3">
								<button type='button' id="imprimirr"
									class='imprimir btn btn-basic' data-toggle='tooltip'
									data-placement='top' title='Imprimir' onclick="imprimirr();">
									<i class='fa fa-print'></i> Imprimir
								</button>
							</div>

						</div>
						<div class="clearfix"></div>
						<div class="clearfix"></div>
						<div id="alerta" Style='display:none;'>
					 			<p Style='color:red; text-align:center;  font-size:medium; font-weight:600;'>¡Debe seleccionar un cliente!</p>
							 </div>

					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- inicio formulario se -->

<script type="text/javascript">

//Inicializar DatePicker
function imprimirr(){	
	
	if($('#tippe').val()!=0){
	var cat = "";
	
	cat = $('#tippe').val();
	
	if(cat==0){
		cat = "";
	}
	window.open("SLAP?tippe="+cat, '_blank');
	
	console.log("El paramtero del jsp SLAP cat"+" "+cat);
	}
	else
		$('#alerta').show();
}

function DemoSelect2() {
	$('#tippe').select2({
		placeholder : "Seleccione "
	});
}


$(document).ready(function() {
	$('#porE').show();
	LoadSelect2Script(DemoSelect2);
});

</script>