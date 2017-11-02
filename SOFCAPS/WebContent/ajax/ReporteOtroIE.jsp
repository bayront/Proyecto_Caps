<%@page import="Datos.DTOtros_Ing_Egreg"%>
<%@page import="Entidades.Usuario, Entidades.Rol, Datos.DT_Vw_rol_opciones,Entidades.Unidad_de_Medida"%>
<%@page import="Datos.DT_consumo_bomba"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8" import="Entidades.Usuario, Entidades.Rol, Datos.DT_Vw_rol_opciones,java.sql.ResultSet ;"%> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
%>
<%
	DT_Vw_rol_opciones dtvro = DT_Vw_rol_opciones.getInstance();
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

<!--///////////////////////div donde se muestra un Dialogo /////////////////////////////// -->
<div id="dialogCat" class= "col-xm-offset-1 col-xm-10">
	<div class="contenido" style="margin-left: 20px;"></div>
</div>  
<!--///////////////////////Directorios donde estan los jsp /////////////////////////////// -->
<div class="row">
	<div id="breadcrumb" class="col-xs-12">
		<ol class="breadcrumb">
			<!--<li><a href="index.html">Home</a></li>-->
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Reportes</a></li>
			<li><a href="#">Reporte Otros Ingresos y egresos</a></li>
		</ol>
	</div>
</div>
<!--///////////////////////Final de los directorios/////////////////////////////// -->

<!--///////////////////////MODAL PARA MOSTRAR FORMULARIOS /////////////////////////////// -->
<div id="modalbox">
	<div class="devoops-modal">
		<div class="devoops-modal-header">
			<div class="modal-header-name">
				<span>Basic table</span>
			</div>
			<div class="box-icons">
				<a class="close-link"> <i class="fa fa-times"></i>
				</a>
			</div>
		</div>
		<div class="devoops-modal-inner"></div>
		<div class="devoops-modal-bottom"></div>
	</div>
</div>
<!--Start Dashboard 1-->
<div id="dashboard-header" class="row">
	<div class="col-sm-12 col-md-12 text-center">
		<h3>Reportes de otros Ingresos y Egresos</h3>
	</div>
</div>
<!--End Dashboard 1-->
<!--Start Dashboard 2-->
<div class="row-fluid">
	<div id="dashboard_links" class="col-xs-12 col-sm-2 pull-right">
		<ul class="nav nav-pills nav-stacked"
		style="background: #4C9480 url(./img/devoops_pattern_b10.png) 0 0 repeat;">
			<li class="active"><a href="#" class="tab-link" id="IM">Imprimir por mes</a></li>
			<li><a href="#" class="tab-link" id="II">Imprimir ingresos</a></li>
			<li><a href="#" class="tab-link" id="IE">Imprimir Egresos</a></li>
			<li><a href="#" class="tab-link" id="IF">Imprimir por períodos</a></li>
		</ul>
	</div>
	<div id="dashboard_tabs" class="col-xs-12 col-sm-10">
	
		<!--Start Dashboard Tab 1-->
		<div id="dashboard-IM" class="row"
		style="visibility: visible; position: relative;">
			<div class="col-xs-12" style="margin-top: 20px;">
				<h4 class="page-header">Informe de otros ingresos y egresos por mes</h4>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-12  col-md-offset-1 col-md-10">
					<div class="box" style="top: 0px; left: 0px; opacity: 1;">
						<div class="box-header">
							<div class="box-name">
								<i class="fa fa-sitemap"></i> <span>Reporte por mes</span>
							</div>
							<div class="box-icons">
								<a id="colapsar_desplegar2" class="collapse-link"> 
									<i class="fa fa-chevron-up"></i></a> 
								<a id="expandir2" class="expand-link" onclick="validar(expand2);" >
									<i class="fa fa-expand"></i></a>
								<a class="cerrar" title="Inhabilitado"> 
									<i class="fa fa-times"></i></a>
							</div>
							<div class="no-move"></div>
						</div>
						<div class="box-content">
						<div class="form-group has-feedback">
						<label class="col-sm-offset-3 col-sm-1 control-label text-gpromedix">Mes:</label>
						<%
						DTOtros_Ing_Egreg dtn = DTOtros_Ing_Egreg.getInstance();
						rs = dtn.mes();
						%>
						<div class="col-sm-5">
							<select id="parameter1" name="parameter1" class="populate placeholder" required>
								<option value="0">SELECCIONE</option>
									<%
									while(rs.next())
									{
									%>
									<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
									<%
									} 
									%>
							</select>
						</div>
						<div class="clearfix"></div>
							<div class="form-group">
								<label class="col-sm-offset-3 col-sm-1 control-label text-gpromedix">Año:</label>
								<%
								rs = dtn.anio();
								%>
									<div class="col-sm-5 ">
									<select id="a" name="a" class="populate placeholder" required>
										<option value="0">SELECCIONE</option>
										<%
										while(rs.next())
										{
										%>
										<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
										<%
										} 
										%>
									</select>
								</div>
							</div>
					</div>
					<div class="clearfix"></div>
					<div class="form-group">
						<div class="col-sm-offset-5 col-sm-3">
							<button type='button' class='imprimir btn btn-basic' data-toggle='tooltip' 
							data-placement='top' title='Imprimir' onclick="imprimir();" >
							<i class='fa fa-print'></i> Imprimir</button>
						</div>
					</div>
					<div class="clearfix"></div>
					<div id="alerta" Style='display:none;'>
					 <p Style='color:red; text-align:center;  font-size:medium; font-weight:600;'>¡No se ha seleccionado el mes o el año!</p>
					</div>
					</div>
				</div>
			</div>
		</div>
		<div class="clearfix"></div>
		<div style="height: 15px;"></div>
	</div>
		<!--End Dashboard Tab 1-->
		
		
		
		<!--Start Dashboard Tab 2-->
	<div id="dashboard-II" class="row"
		style="visibility: hidden; position: absolute;">
		<div class="col-xs-12" style="margin-top: 20px;">
			<h4 class="page-header">Informe de ingresos</h4>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12  col-md-offset-1 col-md-10">
				<div class="box" style="top: 0px; left: 0px; opacity: 1;">
					<div class="box-header">
						<div class="box-name">
							<i class="fa fa-sitemap"></i> <span>Reporte de ingresos</span>
						</div>
						<div class="box-icons">
							<a id="colapsar_desplegar2" class="collapse-link"> 
								<i class="fa fa-chevron-up"></i></a> 
							<a id="expandir2" class="expand-link" onclick="validar(expand2);" >
								<i class="fa fa-expand"></i></a>
							<a class="cerrar" title="Inhabilitado"> 
								<i class="fa fa-times"></i></a>
						</div>
						<div class="no-move"></div>
					</div>
					<div class="box-content">
					<div class="form-group has-feedback">
						<label class="col-sm-offset-2 col-sm-2 control-label text-right">Categoría:</label>
						<%
						rs = dtn.ing();
						%>
						<div class="col-sm-5">	
							<select id="tipp" name="tipp" class="populate placeholder" required>			
								<option value="0">SELECCIONE</option>
									<%
									while(rs.next())
									{
									%>
								<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
								<%
								} 
								%>
							</select>
						</div>
						<div class="clearfix"></div>
					<div class="form-group">
						<div class= "clearfix"></div>
						<label class="col-sm-offset-3 col-sm-1 control-label text-gpromedix">Mes:</label>
						<%
						rs = dtn.mes();
						%>
						<div class="col-sm-5">
							<select id="rox" name="rox" class="populate placeholder" required>
								<option value="0">SELECCIONE</option>
								<%
								while(rs.next())
								{
								%>
								<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
								<%
								} 
								%>
							</select>
						</div>
					</div>
					<div class="clearfix"></div>
					<div class="form-group">
						<div class="clearfix"></div>
						<label class="col-sm-offset-3 col-sm-1 control-label text-gpromedix">Año:</label>
						<%
						rs = dtn.anio();
						%>
						<div class="col-sm-5 ">
							<select id="anios" name="anios" class="populate placeholder" required>
								<option value="0">SELECCIONE</option>
								<%
								while(rs.next())
								{
								%>
								<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
								<%
								} 
								%>
							</select>
						</div>
					</div>
					</div>
					<div class="clearfix"></div>
					<div class="form-group">
						<div class="col-sm-offset-5 col-sm-3">
<!-- 							<button type="submit"  id="imprimir" class="fa fa-print fa-2x" -->
<!-- 							data-toggle='tooltip' data-placement='bottom' onclick="imprimir2();"> -->
<!-- 								<span></span> Imprimir -->
<!-- 							</button> -->
							<button type='button' id="imprimir" class='btn btn-basic' data-toggle='tooltip' 
								data-placement='top' title='Imprimir' onclick="imprimir2();" >
								<i class='fa fa-print'></i> Imprimir</button>
						</div>	
					</div>
					<div class="clearfix"></div>
					<div id="alertaII" Style='display:none;'>
					 <p Style='color:red; text-align:center;  font-size:medium; font-weight:600;'>¡Debe seleccionar la categoria, el mes y el año!</p>
					</div>
					</div>
				</div>
			</div>
			</div>
		<div class="clearfix"></div>
		<div style="height: 15px;"></div>
		</div>
		<!--End Dashboard Tab 3-->
		
		<div id="dashboard-IE" class="row"
		style="visibility: hidden; position: absolute;">
			<div class="col-xs-12" style="margin-top: 20px;">
				<h4 class="page-header">Informe de egresos</h4>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-12  col-md-offset-1 col-md-10">
					<div class="box" style="top: 0px; left: 0px; opacity: 1;">
						<div class="box-header">
							<div class="box-name">
								<i class="fa fa-sitemap"></i> <span>Reporte de egresos</span>
							</div>
							<div class="box-icons">
								<a id="colapsar_desplegar2" class="collapse-link"> 
									<i class="fa fa-chevron-up"></i></a> 
								<a id="expandir2" class="expand-link" onclick="validar(expand2);" >
									<i class="fa fa-expand"></i></a>
								<a class="cerrar" title="Inhabilitado"> 
									<i class="fa fa-times"></i></a>
							</div>
							<div class="no-move"></div>
						</div>
						<div class="box-content">
				<div class="form-group has-feedback">
				<input type="hidden" id="userC" name="userC" value="<%=nombre_usuario %>">
						<label class="col-sm-offset-2 col-sm-2 control-label text-right">Categoría:</label>
						<%
						rs = dtn.egre();
						%>
						<div class="col-sm-5">
							
								<select id="tippe" name="tippe" class="populate placeholder" required>
								
									
									<option value="0">SELECCIONE</option>
										<%
										while(rs.next())
										{
										%>
										<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
										<%
										} 
										%>
								</select>
							
						</div>
						<div class="clearfix"></div>
					<div class="form-group">
						<label class="col-sm-offset-3 col-sm-1 control-label text-gpromedix">Mes:</label>
						<%
						rs = dtn.mes();
						%>
						<div class="col-sm-5">
							
								<select id="roxa" name="roxa" class="populate placeholder" required>
									<option value="0">SELECCIONE</option>
										<%
										while(rs.next())
										{
										%>
										<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
										<%
										} 
										%>
								</select>
							
						</div>
						</div>
						
						<div class="clearfix"></div>
					<div class="form-group">
						<label class="col-sm-offset-3 col-sm-1 control-label text-gpromedix">Año:</label>
						<%
						rs = dtn.anio();
						
						%>
						<div class="col-sm-5 ">
							
								<select id="aniosd" name="aniosd" class="populate placeholder" required>
									<option value="0">SELECCIONE</option>
										<%
										while(rs.next())
										{
										%>
										<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
										<%
										} 
										%>
								</select>
							
						</div>
					</div>
					</div>
					
					<div class="clearfix"></div>
					<div class="form-group">
						<div class="col-sm-offset-5 col-sm-3">
<!-- 							<button type="submit"  id="imprimir3" class="fa fa-print fa-2x" -->
<!-- 							data-toggle='tooltip' "data-placement='bottom' onclick="imprimir3();"> -->
<!-- 								<span></span> Imprimir -->
<!-- 							</button> -->
							<button type='button' id="imprimir3" class='btn btn-basic' data-toggle='tooltip' 
								data-placement='top' title='Imprimir' onclick="imprimir3();" >
								<i class='fa fa-print'></i> Imprimir</button>
						</div>
					<div class="clearfix"></div>
					<div id="alertaIE" Style='display:none;'>
					 <p Style='color:red; text-align:center;  font-size:medium; font-weight:600;'>¡Debe seleccionar la categoria, el mes y el año!</p>
					</div>
					</div>
		<div class="clearfix"></div>
					
						</div>
					</div>
				</div>
			</div>
			<div class="clearfix"></div>
			<div style="height: 15px;"></div>
		</div>
		<!--End Dashboard Tab 3-->
		<!-- Inicio dashbord tab 4 -->
		<div id="dashboard-IF" class="row"
		style="visibility: hidden; position: absolute;">
			<div class="col-xs-12" style="margin-top: 20px;">
				<h4 class="page-header">Informe por período de fechas</h4>
			</div>

			</form>
			<div class="row">
				<div class="col-xs-12 col-sm-12  col-md-offset-1 col-md-10">
					<div class="box" style="top: 0px; left: 0px; opacity: 1;">
						<div class="box-header">
							<div class="box-name">
								<i class="fa fa-sitemap"></i> <span>Reporte por fechas</span>
							</div>
							<div class="box-icons">
								<a id="colapsar_desplegar2" class="collapse-link"> 
									<i class="fa fa-chevron-up"></i></a> 
								<a id="expandir2" class="expand-link" onclick="validar(expand2);" >
									<i class="fa fa-expand"></i></a>
								<a class="cerrar" title="Inhabilitado"> 
									<i class="fa fa-times"></i></a>
							</div>
							<div class="no-move"></div>
						</div>
						<div class="box-content">
								<div class="form-group">
					<!-- FORMA PARA CREAR períodos DE TIEMPO CON JQUERY UI -->
						<label class="col-sm-3 control-label text-center">Período de fechas</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="FECHITA1"
								placeholder="fecha de inicio">
						</div>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="FECHITA2"
								placeholder="fecha de fin">
						</div>
					</div>
					<div class="clearfix"></div>
					
					<div class="form-group">
						<div class="col-sm-offset-5 col-sm-3">
<!-- 							<button type="submit"  id="imprimir3" class="fa fa-print fa-2x" -->
<!-- 							data-toggle='tooltip' "data-placement='bottom' onclick="imprimir4();"> -->
<!-- 								<span></span> Imprimir -->
<!-- 							</button> -->
							<button type='button' id="imprimir4" class='btn btn-basic' data-toggle='tooltip' 
								data-placement='top' title='Imprimir' onclick="imprimir4();" >
								<i class='fa fa-print'></i> Imprimir</button>
						</div>
						
					</div>
						<div class= "clearfix"></div>
						<div id="alertaIF" Style='display:none;'>
					 <p Style='color:red; text-align:center;  font-size:medium; font-weight:600;'>¡No se ha seleccionado ningún rango de fechas o la fecha inicio es mayor a la fecha fin!</p>
					</div>
					</div>
				</div>
			</div>
			</div>
			<div class="clearfix"></div>
			<div style="height: 15px;"></div>
		</div>
		<!--End Dashboard Tab 4-->
		
		
		
		
		
		
	</div>
	<div class="clearfix"></div>
</div>
<!--End Dashboard 2 -->
		
		
		
		
		
	
	<div class="clearfix"></div>
</div>
<!--End Dashboard 2 -->
		
		





<div style="height: 40px;"></div>

<script type="text/javascript">
// function Select2Test(){
// 	$("#el2").select2();
// 	$("#parameter1").select2();
// 	$('#rox').select2();
// 	$('#a').select2();
// 	$('#tipp').select2();
// 	$('#anios').select2();
// 	$('#tippe').select2();
// 	$('#roxa').select2();
// 	$('#aniosd').select2();
// }


function imprimir()

{	
	if($('#parameter1').val()!=0 && $('#a').val()!=0 ){
	var valor = "";
	var v = "";	
	valor = $('#parameter1').val();
	v =  $('#a').val();
	userC = $('#userC').val();

	if(valor == 0)
	{
		valor = "";
	}if(v==0){
		v = "";
	}

	
	window.open("SL_ReporteOtros?parameter1="+valor+"&a="+v+"&userC="+userC, '_blank');
	System.out.println("La fecha del jsp"+" "+parameter1);
	console.log("La fecha del jsp"+" "+parameter1);
	console.log("El paramtero del jsp"+" "+valor);
	console.log("El paramtero del jsp anio"+" "+v);
	}
	else
		$('#alerta').show();

}


function imprimir4()

{	
	var f = $("#FECHITA1").val().split("/");
	var fecha1 = new Date(f[2], f[1]-1, f[0]);
	f = $("#FECHITA2").val().split("/");
	var fecha2 = new Date(f[2], f[1]-1, f[0]);
	if($('#FECHITA1').val()!="" && $('#FECHITA2').val()!="" && fecha1<=fecha2){
	var valor = "";
	var v = "";
	userC = $('#userC').val();
	
	
	cat = $('#FECHITA1').val();
	valor = $('#FECHITA2').val();
		
	window.open("SLF?FECHITA1="+cat+"&FECHITA2="+valor+"&userC="+userC, '_blank');
	console.log("El paramtero del jsp otro"+" "+valor);
	console.log("El paramtero del jsp cat"+" "+cat);
	}
	else
		$('#alertaIF').show();
	

}

function imprimir2()

{	
	if($('#rox').val()!=0 && $('#anios').val()!=0 && $('#tipp').val()!=0){
	var valor = "";
	var v = "";
	var cat = "";
	userC = $('#userC').val();
	
	cat = $('#tipp').val();
	valor = $('#rox').val();
	v =  $('#anios').val();
	
	
	
	if(cat==0){
		cat = "";
	}

	if(valor == 0)
	{
		valor = "";
	}if(v==0){
		v = "";
	}
	

	
	window.open("SLP?tipp="+cat+"&rox="+valor+"&anios="+v+"&userC="+userC, '_blank');
	console.log("El paramtero del jsp otro"+" "+valor);
	console.log("El paramtero del jsp cat"+" "+cat);
	console.log("El paramtero del jsp ansodias anio"+" "+v);
	}
	else
		$('#alertaII').show();

}

function imprimir3()

{	
	
	if($('#roxa').val()!=0 && $('#aniosd').val()!=0 && $('#tippe').val()!=0){
	var valor = "";
	var v = "";
	var cat = "";
	userC = $('#userC').val();
	
	cat = $('#tippe').val();
	valor = $('#roxa').val();
	v =  $('#aniosd').val();
	
	
	
	if(cat==0){
		cat = "";
	}

	if(valor == 0)
	{
		valor = "";
	}if(v==0){
		v = "";
	}
	

	
	window.open("SE?tippe="+cat+"&roxa="+valor+"&aniosd="+v+"&userC="+userC, '_blank');
	console.log("El paramtero del jsp otro"+" "+valor);
	console.log("El paramtero del jsp cat"+" "+cat);
	console.log("El paramtero del jsp ansodias anio"+" "+v);
	}
	else
		$('#alertaIE').show();

}



function DemoSelect2() {
	$('#parameter1').select2({
		placeholder : "Select "
	});
	$('#rox').select2();
	$('#a').select2();
	$('#tipp').select2();
	$('#anios').select2();
	$('#tippe').select2();
	$('#roxa').select2();
	$('#aniosd').select2();
}
// Run timepicker
function DemoTimePicker() {
	$('#input_time').timepicker({
		setDate : new Date()
	});
}

$(document).ready(function() {
	LoadTimePickerScript(AllTimePickers);
	// Make all JS-activity for dashboard
	DashboardTabChecker();
	LoadBootstrapValidatorScript(DemoFormValidator);//validaciones
	LoadSelect2Script(DemoSelect2);
	 $('[data-toggle="tooltip"]').tooltip();
	// Create UI spinner
	$("#ui-spinner").spinner();

	// Create Wysiwig editor for textare
	TinyMCEStart('#wysiwig_simple', null);
	TinyMCEStart('#wysiwig_full', 'extreme');
	// Add slider for change test input length
	FormLayoutExampleInputLength($(".slider-style"));
	// Initialize datepicker
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
	// Load Timepicker plugin
	LoadTimePickerScript(DemoTimePicker);
	// Add tooltip to form-controls
	$('.form-control').tooltip();
	LoadSelect2Script(DemoSelect2);
	// Load example of form validation
	LoadBootstrapValidatorScript(DemoFormValidator);
		
			
});

</script>