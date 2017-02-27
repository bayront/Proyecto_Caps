<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="#">Dashboard</a></li>
			<li><a href="#">Consumos</a></li>
			<li><a href="#">Ver consumos</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box"
			style="top: 0px; left: 0px; opacity: 1;">
			
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-plus-square-o"></i> <span>Registro de Consumos</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i></a> 
					<a class="expand-link"> <i class="fa fa-expand"></i></a>
				</div>
				<div class="no-move"></div>
			</div>
			
			<div class="box-content" >
				<form class="form-horizontal" role="form" id="defaultForm" method="post" action="validators.html">
					<!-- Fecha de corte -->
					<div class="form-group has-success has-feedback">
						<label class="col-sm-4 control-label">Fecha de corte</label>
						<div class="col-sm-5">
							<input type="text" id="input_date" class="form-control" name="date_send" placeholder="Fecha de corte">
							<span class="fa fa-calendar txt-success form-control-feedback"></span>
						</div>
					</div>
					
					<div class="clearfix"></div>

					<div class="form-group">
							<label class="col-sm-4 control-label">Lectura Actual</label>
							<div class="col-sm-5">
								<input type="number" class="form-control" name="lecture"
								data-toggle="tooltip" data-placement="top" title="lectura de consumo">
							</div>
					</div>
					
					<div class="clearfix"></div>
					
					<div class="form-group has-success">
						<label class="col-sm-4 control-label">Consumo</label>
						<div class="col-sm-5">
							<!-- PARA DEJAR SIN USO A INPUT AGREGAR ATRIBUTO *disabled* -->
							<input type="text" class="form-control" placeholder="el consumo es un campo calculado"
							disabled>
						</div>
					</div>
					
					<h4 class="page-header" Style=" text-align: center; font-size: xx-large;">Cliente</h4>
					
					<div class="form-group">

						<label class="col-sm-4 control-label">Nombres</label>
						<div class="col-sm-5">
							<input type="text" class="form-control"
								placeholder="Nombres" data-toggle="tooltip"
								data-placement="bottom" title="Nombre completo">
						</div>
						<div class="col-sm-2">
							<button type="button" class="blue" id="abrir_modal" Style=" position: absolute;">
								<span><i class="fa fa-search"></i></span>  Buscar Cliente
							</button>
						</div>
					</div>
					<div class="form-group has-success">
						<label for="ui-spinner" class="col-sm-4 control-label">N&uacutemero del contrato</label>
						<div class="col-sm-4">
							<input type="text" id="ui-spinner" class="form-control"
								placeholder="contrato">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label">Medidor</label>
						<div class="col-sm-5">
							<input type="text" class="form-control"
								placeholder="medidor" data-toggle="tooltip"
								data-placement="top" title="numero de medidor">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-3">
							<button type="button" class="btn btn-default btn-label-left btn-lg">
								<span><i class="fa fa-clock-o txt-danger"></i></span> Cancelar
							</button>
						</div>
						<div class="col-sm-4">
							<button type="submit" class="btn btn-primary btn-label-left btn-lg">
								<span><i class="fa fa-clock-o"></i></span> Enviar
							</button>
						</div>
					</div>

				</form>
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name text-center">
					<i class="fa fa-th"></i> <span>Lista de consumos</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding">
				<div style="display: block; text-align: center;">
					<button type="button" class="btn btn-default btn-app-sm btn-circle" id="center_button">
						<i class=" fa fa-plus"></i>
					</button>
				</div>
					
				<table
					class="table table-bordered table-striped table-hover table-heading table-datatable"
					id="datatable-3">
					<thead>
						<tr>
							<th>Fecha_Corte</th>
							<th>Lectura</th>
							<th>Consumo</th>
							<th>Nombre_Cliente</th>
							<th>Num_Contrato</th>
							<th>Num_medidor</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>1</td>
							<td>Ubuntu</td>
							<td>16%</td>
							<td><i class="fa fa-home"></i><a href="http://ubuntu.com"
								target="_blank">http://ubuntu.com</a></td>
							<td>13.10</td>
							<td><i class="fa fa-linux"></i></td>
							<td></td>
						</tr>
						<tr>
							<td>2</td>
							<td>Debian</td>
							<td>14.1%</td>
							<td><i class="fa fa-home"></i><a href="http://debian.org"
								target="_blank">http://debian.org</a></td>
							<td>7.4</td>
							<td><i class="fa fa-linux"></i></td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<div>
	<form id="frmEliminarUsuario" action="" method="POST">
		<input type="hidden" id="usuario_id" name="idusuario" value="">
		<input type="hidden" id="opcion" name="opcion" value="eliminar">
	</form>
	<!-- Modal -->
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
</div>

<script type="text/javascript">
	// Run Datables plugin and create 3 variants of settings
	function AllTables() {

		TestTable3();
		LoadSelect2Script(MakeSelect2);
	}
	function MakeSelect2() {
		$('select').select2();
		$('.dataTables_filter').each(
				function() {
					$(this).find('label input[type=text]').attr('placeholder',
							'Buscar');
				});
	}
	function DemoSelect2() {
		$('#s2_with_tag').select2({
			placeholder : "Select OS"
		});
		$('#s2_country').select2();
	}
	function DemoTimePicker() {
		$('#input_time').timepicker({
			setDate : new Date()
		});
	}
	$(document)
			.ready(
					function() {
						// Load Datatables and run plugin on tables 
						LoadDataTablesScripts(AllTables);

						//Load pickers
						LoadTimePickerScript(AllTimePickers);

						// Create UI spinner
						$("#ui-spinner").spinner();

						// Initialize datepicker
						$('#input_date').datepicker({
							setDate : new Date()
						});

						LoadTimePickerScript(DemoTimePicker);

						// Add tooltip to form-controls
						$('.form-control').tooltip();

						LoadSelect2Script(DemoSelect2);

						// Load example of form validation
						LoadBootstrapValidatorScript(DemoFormValidator);

						//MODALS
						$('#abrir_modal')
								.on('click',
										function(e) {
											OpenModalBox(
													"<div><h3>Buscar Cliente</h3></div>",
													"<div class='table-responsive'>"+
													"<table class='table table-bordered table-striped table-hover table-heading table-datatable'"+
													"id='datatable-2'>"+
														"<thead>"+
															"<tr>"+
																"<th><label><input type='text' name='buscar_Nombre'"+
																		"value='Buscar nombre' class='search_init' /></label></th>"+
																"<th><label><input type='text' name='buscar_Apellido'"+
																		"value='Buscar apellido' class='search_init' /></label></th>"+
																"<th><label><input type='text' name='buscar_Num_Med'"+
																		"value='Buscar medidor' class='search_init' /></label></th>"+
																"<th></th>"+
															"</tr>"+
														"</thead>"+
														"<tbody>"+
															"<tr><td>1</td><td>Ubuntu</td><td>16%</td><td>13.10</td></tr>"+
															"<tr><td>2</td><td>Debian</td><td>14.1%</td><td>7.4</td></tr>"+
															"<tr><td>3</td><td>Arch Linux</td><td>10.8%</td><td>2014.02.01</td></tr>"+
														"</tbody>"+
														"<tfoot>"+
															"<tr><th>Primer Nombre</th><th>Primer Apellido</th><th>Medidor</th><th></th></tr>"+
														"</tfoot>"+
													"</table>"+
												"</div>",
													"<div Style='text-align: center; margin-bottom: -10px;'><button type='button' class='btn btn-secondary' onclick='CloseModalBox()'>Cancelar</button></div>");
											
											TestTable2();
										});

						// Add Drag-n-Drop feature
						WinMove();
					});
</script>
