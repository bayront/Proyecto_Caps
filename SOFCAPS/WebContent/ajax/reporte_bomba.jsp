<%@page import="Entidades.Mes"%>
<%@page import="Datos.DT_consumo_bomba, java.util.* ,java.sql.ResultSet"%>
<%@page language="java"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8" import="Entidades.Usuario, Entidades.Rol, Datos.DT_Vw_rol_opciones;"%> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
%>
<%
	DT_Vw_rol_opciones dtvro = 	new DT_Vw_rol_opciones();
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
<%
	String nombre_usuario = "";
	nombre_usuario = (String) session.getAttribute("nombre_usuario");
	nombre_usuario = nombre_usuario==null?"":nombre_usuario;
	
	String url="";	
	ResultSet rs;
%>


<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Reportes</a></li>
			<li><a href="#">Informe de la bomba</a></li>
		</ol>
	</div>
</div>

<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-search"></i> <span>Reporte de consumos de agua de la bomba</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a> <a class="close-link"> <i class="fa fa-times"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content">
<!-- 						FORMA PARA CREAR PERIODOS DE TIEMPO CON JQUERY UI <label -->
				<form class="form-horizontal" role="form" id="formReporteBomba">
					<div class="form-group">
						<label	class="col-sm-3 control-label">período de fechas</label>
						<div class="col-sm-4">
						<input type="hidden" id="userC" name="userC" value="<%=nombre_usuario %>">
							<input type="text" class="form-control" id="FECHITA1"
								placeholder="fecha de inicio">
						</div>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="FECHITA2"
								placeholder="fecha de fin">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-5 col-sm-3">
							<button type='button' id="imprimir3" class='imprimir btn btn-basic' 
							data-toggle='tooltip' data-placement='top' title='Imprimir' onclick="imprimir();">
								<i class='fa fa-print'></i> Imprimir
							</button>
						</div>
					</div>
					<div class="clearfix"></div>
					<div class="clearfix"></div>
					<div id="alerta" Style='display:none;'>
					 			<p Style='color:red; text-align:center;  font-size:medium; font-weight:600;'>¡No se ha seleccionado ningún rango de fechas o la fecha inicio es mayor a la fecha fin!</p>
							 </div>
				</form>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">

function imprimir()

{	
	var f = $("#FECHITA1").val().split("/");
	var fecha1 = new Date(f[2], f[1]-1, f[0]);
	f = $("#FECHITA2").val().split("/");
	var fecha2 = new Date(f[2], f[1]-1, f[0]);
	if($('#FECHITA1').val()!="" && $('#FECHITA2').val()!="" && fecha1<=fecha2){
	var valor = "";
	var v = "";
	userC = $('#userC').val();

		
	valor = $('#FECHITA1').val();
	v = $('#FECHITA2').val();
	

	
	window.open("SL_reporte_bomba?FECHITA1="+valor+"&FECHITA2="+v+"&userC="+userC, '_blank');
	
	console.log("El mes jsp"+" "+valor);
	console.log("El mes jsp"+" "+v);
	}
	else
		$('#alerta').show();
	
}





// Run Select2 plugin on elements
function DemoSelect2(){
	$('#meses').select2();
}



$(document).ready(function() {
	
	$('#FECHITA1').datepicker({
		setDate : new Date(),
		dateFormat: 'dd/mm/yy',
		changeMonth: true,
  changeYear: true,
		onSelect: function(dateText, inst) {
			$("#insert").val(dateText);
	}
	});
	
	$('#FECHITA2').datepicker({
		setDate : new Date(),
		dateFormat: 'dd/mm/yy',
		changeMonth: true,
  changeYear: true,
		onSelect: function(dateText, inst) {
			$("#insert").val(dateText);
	}
	});

	
	// Add slider for change test input length
	FormLayoutExampleInputLength($( ".slider-style" ));
	// Initialize datepicker
	//$('#input_date').datepicker({setDate: new Date()});
	// Load Timepicker plugin

	// Add tooltip to form-controls
	LoadSelect2Script(DemoSelect2);
	// Load example of form validation
	LoadBootstrapValidatorScript(DemoFormValidator);
	// Add drag-n-drop feature to boxes
	WinMove();

})
</script>