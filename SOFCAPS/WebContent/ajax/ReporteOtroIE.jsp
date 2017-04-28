<%@page import="Datos.DTOtros_Ing_Egreg"%>
<%@page import="java.sql.ResultSet"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
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
		</ol>
	</div>
</div>
<!-- ggadsssssssaaaaaaaaaaaaaa -->
<div id = "primero">
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box" style="top: 0px; left: 0px; opacity: 1;">

			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-edit"></i> <span>Reporte</span>
				</div>
<!-- 				<div class="box-icons"> -->
<!-- 					<a id="colapsar_desplegar1" class="collapse-link" onclick="validar(colap1);"> <i -->
<!-- 						class="fa fa-chevron-up"></i></a>  -->
<!-- 						<a id="expandir1" class="expand-link"  onclick="validar(expand1);">  -->
<!-- 						<i class="fa fa-expand"></i></a> -->
<!-- 				</div> -->
<!-- 				<div class="no-move"></div> -->
			</div>

			<div class="box-content">
				<div id="ow-server-footer" style="margin:-15px; margin-bottom:30px;">
					<a href="#" class="col-xs-6 col-sm-3 btn-info text-center" id="pm" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-list"></i> <span>Imprimir por mes</span> </a>
					<a href="#" class="col-xs-6 col-sm-3 btn-info text-center" id="pf" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-info-circle"></i> <span>Imprimir por periodo de fechas</span></a>
					<a href="#" class="col-xs-6 col-sm-3 btn-info text-center" id="si" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-plus-square"></i> <span>Imprimir sólo ingresos</span></a> 
					<a href="#" class="col-xs-6 col-sm-3 btn-info text-center"  id="se" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-desktop"></i> <span>Imprimir sólo egresos</span></a> 
					
				</div>
				<div id ="mes">

					
					<h4 class="page-header"
						Style="text-align: center; font-size: xx-large;">Informe ingresos y egresos</h4>

					<div class="clearfix"></div>
					<div id="s">
						<div class="form-group has-feedback">
						<label class="col-sm-4 text-gpromedix control-label">Mes:</label>
						<%
						DTOtros_Ing_Egreg dtn = DTOtros_Ing_Egreg.getInstance();
						ResultSet rs = dtn.mes();
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
						<label class="col-sm-4 text-gpromedix control-label">Año:</label>
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
					<div class="clearfix"></div>
					<div class="clearfix"></div>
					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-3">
							<button type="submit"  id="imprimir" class="fa fa-print fa-2x"
							data-toggle='tooltip' "data-placement='bottom' onclick="imprimir();">
								<span></span> Imprimir
							</button>
						</div>
						
					</div>
					
						<div class="clearfix"></div>
							<div class="clearfix"></div>
		</div>
			</div>
		</div>
	</div>
</div>
</div>
</div>

<!-- fin formulario mes y año e inicio de formulario si -->
<div id = "segundo">
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box" style="top: 0px; left: 0px; opacity: 1;">

			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-edit"></i> <span>Reporte</span>
				</div>
<!-- 				<div class="box-icons"> -->
<!-- 					<a id="colapsar_desplegar1" class="collapse-link" onclick="validar(colap1);"> <i -->
<!-- 						class="fa fa-chevron-up"></i></a>  -->
<!-- 						<a id="expandir1" class="expand-link"  onclick="validar(expand1);">  -->
<!-- 						<i class="fa fa-expand"></i></a> -->
<!-- 				</div> -->
<!-- 				<div class="no-move"></div> -->
			</div>

			<div class="box-content">
				<div id="ow-server-footer" style="margin:-15px; margin-bottom:30px;">
					<a href="#" class="col-xs-6 col-sm-3 btn-info text-center" id="pm" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-list"></i> <span>Imprimir por mes</span> </a>
						<a href="#" class="col-xs-6 col-sm-3 btn-info text-center" id="pf" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-info-circle"></i> <span>Imprimir por periodo de fechas</span></a>
					<a href="#" class="col-xs-6 col-sm-3 btn-info text-center" id="si" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-plus-square"></i> <span>Imprimir sólo ingresos</span></a> 
					<a href="#" class="col-xs-6 col-sm-3 btn-info text-center"  id="se" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-desktop"></i> <span>Imprimir sólo egresos</span></a> 
					
				</div>
			

					
					<h4 class="page-header"
						Style="text-align: center; font-size: xx-large;">Informe de ingresos</h4>

					<div class="clearfix"></div>
					
						<div class="form-group has-feedback">
						<label class="col-sm-4 text-gpromedix control-label">Categoria:</label>
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
						
						<div class= "clearfix"></div>
						<label class="col-sm-4 text-gpromedix control-label">Mes:</label>
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
						
						<div class="clearfix"></div>
						<label class="col-sm-4 text-gpromedix control-label">Año:</label>
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
					<div class="clearfix"></div>
					<div class="clearfix"></div>
					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-3">
							<button type="submit"  id="imprimir" class="fa fa-print fa-2x"
							data-toggle='tooltip' "data-placement='bottom' onclick="imprimir2();">
								<span></span> Imprimir
							</button>
						</div>
						
					</div>
					<div class="clearfix"></div>
					<div class="clearfix"></div>
		
		
		</div>
	</div>
</div>
</div>

</div>

<!-- fin formulario si -->

<!-- inicio formulario pf -->
<!-- inicio formulario pf -->
<div id = "porF">
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box" style="top: 0px; left: 0px; opacity: 1;">

			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-edit"></i> <span>Reporte</span>
				</div>
<!-- 				<div class="box-icons"> -->
<!-- 					<a id="colapsar_desplegar1" class="collapse-link" onclick="validar(colap1);"> <i -->
<!-- 						class="fa fa-chevron-up"></i></a>  -->
<!-- 						<a id="expandir1" class="expand-link"  onclick="validar(expand1);">  -->
<!-- 						<i class="fa fa-expand"></i></a> -->
<!-- 				</div> -->
<!-- 				<div class="no-move"></div> -->
			</div>

			<div class="box-content">
				<div id="ow-server-footer" style="margin:-15px; margin-bottom:30px;">
					<a href="#" class="col-xs-6 col-sm-3 btn-info text-center" id="pmf" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-list"></i> <span>Imprimir por mes</span> </a>
						<a href="#" class="col-xs-6 col-sm-3 btn-info text-center" id="pff" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-info-circle"></i> <span>Imprimir por periodo de fechas</span></a>
					<a href="#" class="col-xs-6 col-sm-3 btn-info text-center" id="sif" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-plus-square"></i> <span>Imprimir sÃ³lo ingresos</span></a> 
					<a href="#" class="col-xs-6 col-sm-3 btn-info text-center"  id="sef" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-desktop"></i> <span>Imprimir sÃ³lo egresos</span></a> 
					
				</div>
				<div class="form-group">
					<!-- FORMA PARA CREAR PERIODOS DE TIEMPO CON JQUERY UI -->
						<label class="col-sm-4 control-label">Periodo de fechas</label>
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
						<div class="col-sm-offset-4 col-sm-3">
							<button type="submit"  id="imprimir3" class="fa fa-print fa-2x"
							data-toggle='tooltip' "data-placement='bottom' onclick="imprimir4();">
								<span></span> Imprimir
							</button>
						</div>
						
					</div>
						<div class= "clearfix"></div>
							<div class= "clearfix"></div>
								<div class= "clearfix"></div>
		</div>
	</div>
</div>
</div>

</div>


<!-- fin formulario pf -->
<!-- inicio formulario por egresos -->

<div id = "porE">
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box" style="top: 0px; left: 0px; opacity: 1;">

			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-edit"></i> <span>Reporte</span>
				</div>
<!-- 				<div class="box-icons"> -->
<!-- 					<a id="colapsar_desplegar1" class="collapse-link" onclick="validar(colap1);"> <i -->
<!-- 						class="fa fa-chevron-up"></i></a>  -->
<!-- 						<a id="expandir1" class="expand-link"  onclick="validar(expand1);">  -->
<!-- 						<i class="fa fa-expand"></i></a> -->
<!-- 				</div> -->
<!-- 				<div class="no-move"></div> -->
			</div>

			<div class="box-content">
				<div id="ow-server-footer" style="margin:-15px; margin-bottom:30px;">
					<a href="#" class="col-xs-6 col-sm-3 btn-info text-center" id="pm" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-list"></i> <span>Imprimir por mes</span> </a>
						<a href="#" class="col-xs-6 col-sm-3 btn-info text-center" id="pf" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-info-circle"></i> <span>Imprimir por periodo de fechas</span></a>
					<a href="#" class="col-xs-6 col-sm-3 btn-info text-center" id="si" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-plus-square"></i> <span>Imprimir sólo ingresos</span></a> 
					<a href="#" class="col-xs-6 col-sm-3 btn-info text-center"  id="se" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-desktop"></i> <span>Imprimir sólo egresos</span></a> 
					
				</div>
			

					
					<h4 class="page-header"
						Style="text-align: center; font-size: xx-large;">Informe de Egresos</h4>

					<div class="clearfix"></div>
					
						<div class="form-group has-feedback">
						<label class="col-sm-4 text-gpromedix control-label">Categoria:</label>
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
						<div class= "clearfix"></div>
						<label class="col-sm-4 text-gpromedix control-label">Mes:</label>
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
						
						<div class="clearfix"></div>
						<label class="col-sm-4 text-gpromedix control-label">Año:</label>
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
					<div class="clearfix"></div>
					<div class="clearfix"></div>
					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-3">
							<button type="submit"  id="imprimir3" class="fa fa-print fa-2x"
							data-toggle='tooltip' "data-placement='bottom' onclick="imprimir3();">
								<span></span> Imprimir
							</button>
						</div>
						
					</div>
					<div class="clearfix"></div>
					<div class="clearfix"></div>
		
		
		</div>
	</div>
</div>
</div>

</div>


<!-- inicio formulario se -->





<!-- fin formulario se -->


<script type="text/javascript">

//Inicializar DatePicker

function imprimir()

{	
	var valor = "";
	var v = "";

		
	valor = $('#parameter1').val();
	v =  $('#a').val();

	
	
	if(valor == 0)
	{
		valor = "";
	}if(v==0){
		v = "";
	}

	
	window.open("SL_ReporteOtros?parameter1="+valor+"&a="+v, '_blank');
	System.out.println("La fecha del jsp"+" "+parameter1);
	console.log("La fecha del jsp"+" "+parameter1);
	console.log("El paramtero del jsp"+" "+valor);
	console.log("El paramtero del jsp anio"+" "+v);

}


function imprimir4()

{	
	
	var valor = "";
	var v = "";
	
	
	cat = $('#FECHITA1').val();
	valor = $('#FECHITA2').val();
	
	
	
	
// 	if(cat==0){
// 		cat = "";
// 	}

// 	if(valor == 0)
// 	{
// 		valor = "";
// 	}if(v==0){
// 		v = "";
// 	}
	

	
	window.open("SLF?FECHITA1="+cat+"&FECHITA2="+valor, '_blank');
	console.log("El paramtero del jsp otro"+" "+valor);
	console.log("El paramtero del jsp cat"+" "+cat);
	

}




function imprimir2()

{	
	
	var valor = "";
	var v = "";
	var cat = "";
	
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
	

	
	window.open("SLP?tipp="+cat+"&rox="+valor+"&anios="+v, '_blank');
	console.log("El paramtero del jsp otro"+" "+valor);
	console.log("El paramtero del jsp cat"+" "+cat);
	console.log("El paramtero del jsp ansodias anio"+" "+v);

}

function imprimir3()

{	
	

	var valor = "";
	var v = "";
	var cat = "";
	
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
	

	
	window.open("SE?tippe="+cat+"&roxa="+valor+"&aniosd="+v, '_blank');
	console.log("El paramtero del jsp otro"+" "+valor);
	console.log("El paramtero del jsp cat"+" "+cat);
	console.log("El paramtero del jsp ansodias anio"+" "+v);

}


function DemoSelect2() {
	$('#s2_with_tag').select2({
		placeholder : "Select OS"
	});
	$('#s2_country').select2();
}
// Run timepicker
function DemoTimePicker() {
	$('#input_time').timepicker({
		setDate : new Date()
	});
}

$(document).ready(function() {
	LoadTimePickerScript(AllTimePickers);
	$('#segundo').hide();
	$('#porF').hide();
	$('#porE').hide();
	
	
	
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
		
	$('#si').click(function() {

// 		var body = $('body');
// 		body.toggleClass('body-expanded');
		$('#segundo').show();
		
	});
	
	$('#pm').click(function() {

// 		var body = $('body');
// 		body.toggleClass('body-expanded');
		
		$('#primero').show();
	});

	$('#se').click(function() {

// 		var body = $('body');
// 		body.toggleClass('body-expanded');
		
		$('#porE').show();
	});
	
	$('#pf').click(function() {

// 		var body = $('body');
// 		body.toggleClass('body-expanded');
		
		$('#porF').show();
	});
		
});


	
</script>