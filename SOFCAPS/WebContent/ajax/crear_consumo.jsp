<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.html">Dashboard</a></li>
			<li><a href="#">Consumos</a></li>
			<li><a href="#">Crear Consumo</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-search"></i> <span>Registros de consumos</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content">
				<form class="form-horizontal" role="form" id="defaultForm" method="post" action="validators.html">

					<div class="form-group">

						<!-- PARA COLOR NEGRO DEJAR CON CLASE *control-label* -->
						<label class="col-sm-2 control-label">Primer nombre</label>
						<div class="col-sm-4">

							<!-- PARA COLOR NEGRO DEJAR CON CLASE *form-control* -->
							<input type="text" class="form-control"
								placeholder="primer nombre" data-toggle="tooltip"
								data-placement="bottom" title="Tooltip para nombre">
						</div>

						<label class="col-sm-2 control-label">Apellido</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Apellido"
								data-toggle="tooltip" data-placement="bottom"
								title="Tooltip para apellido">
						</div>
					</div>

					<!-- PARA COLOR AZUL DEJAR CON DIV CON *.has-success*
						DEJAR LABEL CON CLASE  *.control-label*-->
					<div class="form-group has-success has-feedback">
						<label class="col-sm-2 control-label">Empresa</label>
						<div class="col-sm-4">

							<!-- PARA INPUT COLOR AZUL DEJAR DIV CON CLASE *.has-success*
							DEJAR INPUT CON CLASE *.form-control*-->
							<input type="text" class="form-control" placeholder="Empresa">
						</div>
						<label class="col-sm-2 control-label">Lugar</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Lugar">
							<span
								class="fa fa-check-square-o txt-success form-control-feedback"></span>
						</div>
					</div>

					<!-- PARA COLOR AMARILLO DEJAR DIV CON CLASE *.has-warning*
						DEJAR LABEL CON CLASE * .control-label*-->
					<div class="form-group has-warning has-feedback">
						<label class="col-sm-2 control-label">Residencia</label>
						<div class="col-sm-2">
							<!-- PARA DEJAR INPUT CON COLOR AMARILLO DEJAR DIV CON CLASE *.has-warning*
						 	DEJAR INPUT CON CALSE  *.form-control*-->
							<input type="text" class="form-control" placeholder="Ciudad">

							<!-- PARA AGREGAR UN ICONO ESCRIBIR SPAN CON CLASE DE FONT-AWESOME
							 	BUSCAR CLASE DE ICONO EN http://fontawesome.io/icons/
							 	Y DEJAR CLASE *.form-control-feedback*-->
							<span class="fa fa-key txt-warning form-control-feedback"></span>
						</div>
						<div class="col-sm-2">
							<input type="text" class="form-control" placeholder="Pais">
							<span class="fa fa-frown-o txt-danger form-control-feedback"></span>
						</div>
						<label class="col-sm-1 control-label">CODIGO</label>
						<div class="col-sm-2">
							<input type="text" class="form-control"
								placeholder="Another info" data-toggle="tooltip"
								data-placement="top" title="Hello world!">
						</div>
						<div class="col-sm-2">
							<div class="checkbox">
								<label> <input type="checkbox" checked> No exist
									<i class="fa fa-square-o small"></i>
								</label>
							</div>
						</div>
					</div>
					<div class="form-group has-error has-feedback">
					<!-- PARA DEJAR LABEL CON COLOR ROJO ESCRIBIR CLASE EN DIV *.has-error*
						DEJAR LABEL CON CLASE *.control-label*-->
						<label class="col-sm-2 control-label">Fecha Nacimiento</label>
						<div class="col-sm-2">
						<!-- PARA DEJAR INPUT CON COLOR ROJO DEJAR ESCRITO EN DIV LA CLASE *.has-error*
							DEJAR INPUT CON CLASE *.form-control*-->
							<!-- PARA APARECER EL DATE-TIME-PICKER DEJAR A INPUT LA CLASE *.input_date* -->
							<input type="text" id="input_date" class="form-control"
								placeholder="Fecha Nacimiento"> <span
								class="fa fa-calendar txt-danger form-control-feedback"></span>
						</div>
						<div class="col-sm-2">
						<!-- PARA APARECER DATE_TIME_HOUR DEJAR A INPUT CON LA CLASE *.input_time* -->
							<input type="text" id="input_time" class="form-control"
								placeholder="Hora"> <span
								class="fa fa-clock-o txt-danger form-control-feedback"></span>
						</div>

						<label class="col-sm-2 control-label">input Deshabilitado</label>
						<div class="col-sm-2">
						<!-- PARA DEJAR SIN USO A INPUT AGREGAR ATRIBUTO *disabled* -->
							<input type="text" class="form-control" placeholder="No info"
								data-toggle="tooltip" data-placement="top" title="Hello world!"
								disabled>
						</div>
					</div>

					<div class="form-group">
					<!-- FORMA PARA CREAR PERIODOS DE TIEMPO CON JQUERY UI -->
						<label class="col-sm-4 control-label">Periodo de fechas</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="date3_example"
								placeholder="fecha de inicio">
						</div>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="date3-1_example"
								placeholder="fecha de fin">
						</div>
					</div>

					<div class="form-group">

						<label class="col-sm-2 control-label">Grupo de inputs</label>
						<div class="col-sm-2">
						<!-- PARA DEJAR UN GRUPO DE INPUT, POR EJEMPLO AGREGAR UN ICONO DEJAR CLASE *.input-group* -->
							<div class="input-group">
								<span class="input-group-addon">
								<i class="fa fa-github-square"></i>
								</span>
								<input type="text" class="form-control" placeholder="GitHub">
							</div>
						</div>

						<div class="col-sm-2">
							<div class="input-group">
								<input type="text" class="form-control" placeholder="Group" id="insert">
								<span class="input-group-addon"><i class="fa fa-group"></i></span>
							</div>
						</div>

						<div class="col-sm-2">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-money"></i></span>
								<input type="text" class="form-control" placeholder="Money">
								<span class="input-group-addon"><i class="fa fa-usd"></i></span>
							</div>
						</div>

					</div>

					<div class="form-group">
					<!-- FORMA PARA CREAR UN SPINNER CON JQUERY UI -->
						<label for="ui-spinner" class="col-sm-4 control-label">Numero</label>
						<div class="col-sm-8">
							<input type="text" id="ui-spinner" class="form-control"
								placeholder="Spinner">
						</div>
					</div>

					<!-- Agregar espacio con clase *.clearfix* -->
					<div class="clearfix"></div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Nombre de Usuario</label>
						<!-- PARA AGREGAR VALIDACION DE NOMBRE DE USUARIO AGREGAR NAME=*username* -->
						<div class="col-sm-5">
							<input type="text" class="form-control" name="username" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Pais</label>
						<div class="col-sm-5">
							<select class="populate placeholder" name="country"
								id="s2_country">
								<option value="">-- Select a country --</option>
								<option value="fr">France</option>
								<option value="de">Germany</option>
								<option value="it">Italy</option>
								<option value="jp">Japan</option>
								<option value="ru">Russia</option>
								<option value="gb">United Kingdom</option>
								<option value="us">United State</option>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label">Edad</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="ages" />
						</div>
					</div>

					<div class="form-group">
							<label class="col-sm-3 control-label">Costo</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" name="cost"/>
							</div>
					</div>

					<div class="clearfix"></div>

					<div class="form-group">
					<!-- Tipos de botones para enviar -->
						<div class="col-sm-offset-2 col-sm-2">
							<button type="cancel" class="btn btn-default btn-label-left">
								<span><i class="fa fa-clock-o txt-danger"></i></span> Cancelar
							</button>
						</div>
						<div class="col-sm-2">
							<button type="submit" class="btn btn-warning btn-label-left">
								<span><i class="fa fa-clock-o"></i></span> Enviar luego
							</button>
						</div>
						<div class="col-sm-2">
							<button type="submit" class="btn btn-primary btn-label-left">
								<span><i class="fa fa-clock-o"></i></span> Enviar
							</button>
						</div>
						<div class="col-sm-2">
							<button type="submit" class="blue">
								<span><i class="fa fa-clock-o"></i></span> Enviar
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
		//crear los datepickers
		LoadTimePickerScript(AllTimePickers);
		// Create UI spinner
		$("#ui-spinner").spinner();

		// Create Wysiwig editor for textare
		TinyMCEStart('#wysiwig_simple', null);
		TinyMCEStart('#wysiwig_full', 'extreme');
		// Add slider for change test input length
		FormLayoutExampleInputLength($(".slider-style"));
		// Initialize datepicker
		$('#input_date').datepicker({
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
		// Add drag-n-drop feature to boxes
		WinMove();
	});
</script>
