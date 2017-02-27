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
					<i class="fa fa-search"></i> <span>Recibo caja</span>
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
						<label class="col-sm-2 control-label">Descripcion</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Digite la descripcion"
								data-toggle="tooltip" data-placement="bottom"
								title="Tooltip for name">
						</div>
						<label class="col-sm-2 control-label">Monto</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Ingrese el monto"
								data-toggle="tooltip" data-placement="bottom"
								title="Tooltip for last name">
						</div>
					</div>
					<div class="form-group has-success has-feedback">
						<label class="col-sm-2 control-label">Contrato</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Numero de contrato">
						</div>
						<label class="col-sm-2 control-label">Factura</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Numero de factura">
							<span
								class="fa fa-check-square-o txt-success form-control-feedback"></span>
						</div>
					</div>
					<div class="form-group has-warning has-feedback">
						<label class="col-sm-2 control-label">Categoria recibo</label>
						<div class="col-sm-4">
							<select id="s2_with_tag" multiple="multiple"
								class="populate placeholder">
								<option>Ingreso</option>
								<option>Egreso</option> 
							</select>
						</div>
					</div>
					<div class="form-group has-error has-feedback">
						<label class="col-sm-2 control-label">Date</label>
						<div class="col-sm-2">
							<input type="text" id="input_date" class="form-control"
								placeholder="Date"> <span
								class="fa fa-calendar txt-danger form-control-feedback"></span>
						</div>
						<div class="col-sm-2">
							<input type="text" id="input_time" class="form-control"
								placeholder="Time"> <span
								class="fa fa-clock-o txt-danger form-control-feedback"></span>
						</div>
					<div class="clearfix"></div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-2">
							<button type="cancel" class="btn btn-default btn-label-left">
								<span><i class="fa fa-clock-o txt-danger"></i></span> Cancel
							</button>
						</div>
						<div class="col-sm-2">
							<button type="submit" class="btn btn-warning btn-label-left">
								<span><i class="fa fa-clock-o"></i></span> Send later
							</button>
						</div>
						<div class="col-sm-2">
							<button type="submit" class="btn btn-primary btn-label-left">
								<span><i class="fa fa-clock-o"></i></span> Submit
							</button>
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
	$('#s2_with_tag').select2({placeholder: "Seleccione categaria..."});
	$('#s2_country').select2();
}
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
