<%@page language="java"%>
<%@page contentType="text/html"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.ResultSet"%>
 <%@page pageEncoding="UTF-8" import="Datos.DTConsumo,Entidades.Usuario, Entidades.Rol, Datos.DT_Vw_rol_opciones,java.sql.ResultSet ;"%> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%
response.setHeader("Pragma", "No-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setDateHeader("Expires", -1);
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
			<li><a href="#">Reporte Consumo de clientes</a></li>
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
		<h3>Opciones para generar reporte de consumos de los clientes</h3>
	</div>
</div>
<!--End Dashboard 1-->
<!--Start Dashboard 2-->
<div class="row-fluid">
	<div id="dashboard_links" class="col-xs-12 col-sm-2 pull-right">
		<ul class="nav nav-pills nav-stacked"
		style="background: #4C9480 url(./img/devoops_pattern_b10.png) 0 0 repeat;">
			<li class="active"><a href="#" class="tab-link" id="IMC">Imprimir por meses</a></li>
			<li><a href="#" class="tab-link" id="IIC">Imprimir por sector</a></li>
		</ul>
	</div>
	<div id="dashboard_tabs" class="col-xs-12 col-sm-10">
	
		<!--Start Dashboard Tab 1-->
		<div id="dashboard-IMC" class="row"
		style="visibility: visible; position: relative;">
			<div class="col-xs-12" style="margin-top: 20px;">
				<h4 class="page-header">Informe período de fechas</h4>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-12  col-md-offset-1 col-md-10">
					<div class="box" style="top: 0px; left: 0px; opacity: 1;">
						<div class="box-header">
							<div class="box-name">
								<i class="fa fa-plus-square-o"></i> <span>Generar consumos por meses</span>
							</div>
							<div class="box-icons">
								<a id="colapsar_desplegar1" class="collapse-link"> 
									<i class="fa fa-chevron-up"></i></a> 
								<a id="expandir1" class="expand-link"> 
									<i class="fa fa-expand"></i></a>
								<a class="cerrar" title="Inhabilitado"> 
									<i class="fa fa-times"></i></a>
							</div>
							<div class="no-move"></div>
						</div>
						<div class="box-content">
								<div class="form-group">
								
									<label class="col-sm-2 control-label">Periodo de fechas</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="FECHITAM"
										placeholder="fecha de inicio">
									</div>
									
									<div class="col-sm-4">
										<input type="text" class="form-control" id="FECHITAMM"
										placeholder="fecha de fin">
									</div>
									
								</div>
									<div class="clearfix"></div>
									<input type="hidden" id="userC" name="userC" value="<%=nombre_usuario %>">
								
								<div class="form-group">
									<div class="col-sm-offset-4 col-sm-3">
										<button type='button' class='imprimir btn btn-basic' data-toggle='tooltip' 
											data-placement='top' title='Imprimir' onclick="imprimir();" >
											<i class='fa fa-print'></i> Imprimir
										</button>
									</div>
								</div>
								
									<div class= "clearfix"></div>
									<div class= "clearfix"></div>
									<div class= "clearfix"></div>
									<div class="clearfix"></div>
									<div class="clearfix"></div>
					
							</div>
						</div>
					</div>
				</div>
			</div>
			
		
		<!--End Dashboard Tab 1-->
		
		<!--Start Dashboard Tab 2-->
		<div id="dashboard-IIC" class="row"
		style="visibility: hidden; position: absolute;">
			<div class="col-xs-12" style="margin-top: 20px;">
				<h4 class="page-header">Informe por Sector</h4>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-12  col-md-offset-1 col-md-10">
					<div class="box" style="top: 0px; left: 0px; opacity: 1;">
						<div class="box-header">
							<div class="box-name">
								<i class="fa fa-sitemap"></i> <span>Informe para generar consumos por sector</span>
							</div>
							<div class="box-icons">
								<a id="colapsar_desplegar2" class="collapse-link"> 
									<i class="fa fa-chevron-up"></i></a> 
								<a id="expandir2" class="expand-link" onclick="validar(expand2);" >
									<i class="fa fa-expand"></i></a>
							</div>
							<div class="no-move"></div>
						</div>
						<div class="box-content">
								<div class="form-group">
							
									<label class="col-sm-2 control-label">Periodo de Fechas</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="FECHITA"
										placeholder="fecha de inicio">
									</div>
									
									<div class="col-sm-4">
										<input type="text" class="form-control" id="FECHITAA"
										placeholder="fecha de fin">
									</div>
								</div>
								
								<div class="clearfix"></div>
								<div class="clearfix"></div>
								
								<div class="form-group">
										<label class="col-sm-2 text-gpromedix control-label">Sector:</label>
											<%
											DTConsumo dtn = DTConsumo.getInstance();
											 rs = dtn.sector();
											
											%>
										<div class="col-sm-5">
										
											<select id="sec" name="sec" class="populate placeholder" required>
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
								<div class="clearfix"></div>
					
								<div class="form-group">
									<div class="col-sm-offset-4 col-sm-3">
										<button type='button' class='imprimir btn btn-basic' data-toggle='tooltip' 
											data-placement='top' title='Imprimir' onclick="imprimirFS();" >
											<i class='fa fa-print'></i>Imprimir 
										</button>
									</div>
								</div>
								<div class= "clearfix"></div>
								<div class= "clearfix"></div>
								<div class= "clearfix"></div>
								<div class="clearfix"></div>
								<div class="clearfix"></div>
		
						</div>
					</div>
				</div>
			</div>
			<div class="clearfix"></div>
			<div style="height: 15px;"></div>
		</div>
		<!--End Dashboard Tab 2-->
		
	</div>
	<div class="clearfix"></div>
</div>

<!--End Dashboard 2 -->

<div style="height: 40px;"></div>

<script type="text/javascript">


function imprimir()

{	
	
	var valor = "";
	var v = "";
	userC = $('#userC').val();
	
	
	cat = $('#FECHITAM').val();
	valor = $('#FECHITAMM').val();
		
	window.open("SL_ConsumoClientesPorMeses?FECHITAM="+cat+"&FECHITAMM="+valor+"&userC="+userC, '_blank');
	console.log("El paramtero del jsp otro FECHITAM"+" "+valor);
	console.log("El paramtero del jspFECHITA MM "+" "+cat);
	

}
function imprimirFS()

{	
	
	var valor = "";
	var v = "";
	var s = "";
	userC = $('#userC').val();
	
	cat = $('#FECHITA').val();
	valor = $('#FECHITAA').val();
	s = $('#sec').val();
		
	window.open("SL_CCMS?FECHITA="+cat+"&FECHITAA="+valor+"&sec="+s+"&userC="+userC, '_blank');
	console.log("El paramtero del jsp otro"+" "+valor);
	console.log("El paramtero del jsp cat"+" "+cat);
	

}



function DemoSelect2() {
	
	$('#sec').select2();
	
}
///////////////////////////////////FUNSIÓN PRINCIPAL////////////////////////////////////////////////////////
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
	$('#FECHITAM').datepicker({
		setDate : new Date(),
		dateFormat: 'dd/mm/yy',
		changeMonth: true,
  		changeYear: true,
		onSelect: function(dateText, inst) {
			$("#insert").val(dateText);
	}
	});
	
	$('#FECHITAMM').datepicker({
		setDate : new Date(),
		dateFormat: 'dd/mm/yy',
		changeMonth: true,
  		changeYear: true,
		onSelect: function(dateText, inst) {
			$("#insert").val(dateText);
	}
	});
	
	$('#FECHITA').datepicker({
		setDate : new Date(),
		dateFormat: 'dd/mm/yy',
		changeMonth: true,
  		changeYear: true,
		onSelect: function(dateText, inst) {
			$("#insert").val(dateText);
	}
	});
	
	$('#FECHITAA').datepicker({
		setDate : new Date(),
		dateFormat: 'dd/mm/yy',
		changeMonth: true,
  		changeYear: true,
		onSelect: function(dateText, inst) {
			$("#insert").val(dateText);
	}
	});
	// Load Timepicker plugin
	
	// Add tooltip to form-controls
	$('.form-control').tooltip();
	LoadSelect2Script(DemoSelect2);
	// Load example of form validation
	LoadBootstrapValidatorScript(DemoFormValidator);
		
			
});


</script>