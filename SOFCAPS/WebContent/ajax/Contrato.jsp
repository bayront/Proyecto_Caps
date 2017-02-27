<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.html">Dashboard</a></li>
			<li><a href="#">Forms</a></li>
			<li><a href="#">Forms layouts</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-search"></i> <span>Registrar Contrato</span>
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
				<h4 class="page-header">Datos</h4>
				<form class="form-horizontal" role="form">
					<div class="form-group">
						<div class="form-group has-warning has-feedback">
							<label class="col-sm-2 control-label">Seleccione el cliente</label>
								<div class="col-sm-4">
								<select id="s2_with_tag" multiple="multiple"
									class="populate placeholder">
									<option>Linux</option>
									<option>Windows</option>
									<option>OpenSolaris</option>
									<option>FirefoxOS</option>
								</select>
								</div>
								
								<label class="col-sm-2 control-label">Numero de medidor</label>
								<div class="col-sm-4">
								<input type="text" class="form-control" placeholder="Numero de medidor"
								data-toggle="tooltip" data-placement="bottom"
								title="Tooltip for name">
							</div>
						</div>
					</div>
					
					<div class="form-group has-success has-feedback">
						<label class="col-sm-2 control-label">Monto contrato</label>
						<div class="col-sm-4">
						<input type="text" class="form-control" placeholder="Numero de medidor"
						data-toggle="tooltip" data-placement="bottom"
						title="Tooltip for name">
						</div>
						
<!-- 						<label class="col-sm-2 control-label">Cuotas</label> -->
<!-- 						<div class="col-sm-4"> -->
<!-- 								<select id="cuota" multiple="multiple" -->
<!-- 									class="populate placeholder"> -->
<!-- 									<option>1</option> -->
<!-- 									<option>2</option> -->
<!-- 									<option>3</option> -->
<!-- 									<option>4</option> -->
<!-- 									<option>5</option> -->
<!-- 									<option>6</option> -->
<!-- 									<option>7</option> -->
<!-- 									<option>8</option> -->
<!-- 									<option>9</option> -->
<!-- 									<option>10</option> -->
<!-- 								</select> -->
<!-- 						</div> -->
						
						<label for="ui-spinner" class="col-sm-2 control-label">Numero</label>
						<div class="col-sm-4">
							<input type="text" id="ui-spinner" class="form-control"
								placeholder="Spinner">
						</div>

					</div>
					
					
					<div class="form-group has-warning has-feedback">
						<label class="col-sm-2 control-label">Regimen de propiedad</label>
						<div class="col-sm-4">
								<select id="regimen" multiple="multiple"
									class="populate placeholder">
									<option>Propietario</option>
									<option>Inquilino</option>
								</select>
						</div>
						
						<label class="col-sm-2 control-label">Sector</label>
						<div class="col-sm-4">
								<select id="sector" multiple="multiple"
									class="populate placeholder">
									<option>Prueba1</option>
									<option>Prueba2</option>
									<option>Prueba3</option>
									<option>Prueba4</option>
									<option>Prueba5</option>
									<option>Prueba6</option>
									<option>Prueba7</option>
								</select>
						</div>
					</div>
					
					<div class="form-group has-success has-feedback">
						<label class="col-sm-2 control-label">Categoria</label>
						<div class="col-sm-4">
							<select id="categoria" multiple="multiple"
								class="populate placeholder">
								<option>A</option>
								<option>B</option>
								<option>C</option>
							</select>
						</div>
						<label class="col-sm-2 control-label">Estado</label>
						<div class="col-sm-4">
							<select id="estado" multiple="multiple"
								class="populate placeholder">
								<option>Activo</option>
								<option>Inactivo</option>
							</select>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
// Run Select2 plugin on elements
function DemoSelect2(){
	$('#s2_with_tag').select2({placeholder: "Seleccione cliente..."});
	$('#regimen').select2({placeholder: "Seleccione regimen..."});
	$('#sector').select2({placeholder: "Seleccione sector..."});
	$('#categoria').select2({placeholder: "Seleccione categoria..."});
	$('#estado').select2({placeholder: "Seleccione estado..."});
	$('#cuota').select2({placeholder: "Seleccione cantidad cuotas de contrato..."});
	$('#s2_country').select2();
}


// Run timepicker
function DemoTimePicker(){
	$('#input_time').timepicker({setDate: new Date()});
}
$(document).ready(function() {
	$("#ui-spinner").spinner();
	// Create Wysiwig editor for textare
	TinyMCEStart('#wysiwig_simple', null);
	TinyMCEStart('#wysiwig_full', 'extreme');
	// Add slider for change test input length
	FormLayoutExampleInputLength($( ".slider-style" ));
	// Initialize datepicker
	$('#input_date').datepicker({setDate: new Date()});
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