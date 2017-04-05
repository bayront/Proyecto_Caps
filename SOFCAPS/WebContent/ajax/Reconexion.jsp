<%@page language="java"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<div id="dialog" class="col-xm-offset-1 col-xm-10">
	<div class="contenido" style="margin-left: 20px;"></div>
</div>
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Reconexion</a></li>
		</ol>
	</div>
</div>

<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-search"></i> <span>Registro de Otros Ingresos y Egresos</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"  id="colapsar_desplegar1" onclick="validar(colap1);" > 
						<i class="fa fa-chevron-up"></i> </a> 
					<a class="expand-link" id="expandir1" onclick="validar(expand1);"> 
						<i class="fa fa-expand"></i></a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content">
				<form class="form-horizontal" role="form" id="formOI" method="post" action="">
					<input type="hidden" id="opcion" name="opcion" value="guardar">
					<input type="hidden" id="Otros_Ing_Egreg_ID" name="Otros_Ing_Egreg_ID">
					
			<div class="form-group has-success">
			<label class="col-sm-4 control-label text-info">Nombre del Cliente </label>
				<div class="col-sm-4">
					<input id="monto" name="NombreCliente" data-bv-numeric="true" class="form-control"
					 title="Requerido">
				</div>
			</div>


<div class="form-group">
	<label class="col-sm-4 text-right control-label">Factura</label>
			<div class="col-sm-4">
				<select class="populate placeholder" name="FacturaMaestra" 
					id="FacturaMaestra">
						<option value="">--Seleccione la Factura--</option>
				</select>
			</div>
	</div>
	<div class="form-group has-success has-feedback">
	<!-- FORMA PARA CREAR PERIODOS DE TIEMPO CON JQUERY UI -->
	<label  class="col-sm-4 control-label text-info">Fecha de Reconexion</label>
		<div class="col-sm-4">
			<input id="fecha" name="fecha" type="text" class="form-control"
				placeholder="fecha de Reconexion" title="Requerido">
			<span class="fa fa-calendar txt-success form-control-feedback"></span>
		</div>
	</div>
	
	<div class="form-group has-success has-feedback">
	<!-- FORMA PARA CREAR PERIODOS DE TIEMPO CON JQUERY UI -->
	<label  class="col-sm-4 control-label text-info">Fecha de Cancelado</label>
		<div class="col-sm-4">
			<input id="fecha_cancelado" name="fecha" type="text" class="form-control"
				placeholder="fecha de Cancelado" title="Requerido">
			<span class="fa fa-calendar txt-success form-control-feedback"></span>
		</div>
	</div>	
				</form>
			</div>
		</div>
	</div>
</div>	

<script type="text/javascript">
// Run timepicker
function DemoTimePicker(){
	$('#input_time').timepicker({setDate: new Date()});
}
$(document).ready(function() {
	// Create Wysiwig editor for textare
	TinyMCEStart('#wysiwig_simple', null);
	TinyMCEStart('#wysiwig_full', 'extreme');
	// Add slider for change test input length
	FormLayoutExampleInputLength($( ".slider-style" ));
	// Initialize datepicker
	$('#fecha').datepicker({setDate: new Date()});
	$('#fecha_cancelado').datepicker({setDate: new Date()});
	// Load Timepicker plugin
	LoadTimePickerScript(DemoTimePicker);
	// Add tooltip to form-controls
	$('.form-control').tooltip();
	LoadSelect2Script(DemoSelect2);
	// Load example of form validation
	LoadBootstrapValidatorScript(DemoFormValidator);
	// Add drag-n-drop feature to boxes
	WinMove();
});
	
</script>



	
	
	