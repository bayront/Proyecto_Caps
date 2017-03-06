<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="#">Dashboard</a></li>
			<li><a href="#">Tarifa</a></li>
			<li><a href="#">Ver tarifas</a></li>
		</ol>
	</div>
</div>
<!-- <div class="row"> -->
<!-- 	<div class="col-xs-12 col-sm-12"> -->
<!-- 		<div class="box" style="top: 0px; left: 0px; opacity: 1;"> -->

<!-- 			<div class="box-header"> -->
<!-- 				<div class="box-name"> -->
<!-- 					<i class="fa fa-plus-square-o"></i> <span>Registro de -->
<!-- 						Consumos</span> -->
<!-- 				</div> -->
<!-- 				<div class="box-icons"> -->
<!-- 					<a id="colapsar_desplegar1" class="collapse-link"> <i -->
<!-- 						class="fa fa-chevron-up"></i></a> <a id="expandir1" -->
<!-- 						class="expand-link"> <i class="fa fa-expand"></i></a> -->
<!-- 				</div> -->
<!-- 				<div class="no-move"></div> -->
<!-- 			</div> -->

<!-- 			<div class="box-content"> -->
<!-- 				<form class="form-horizontal" role="form" id="defaultForm" -->
<!-- 					method="post" action="validators.html"> -->
<!-- 					<input type="hidden" id="opcion" name="opcion" value="guardar"> -->
<!-- 					<input type="hidden" id="actual" name="actual">  -->
<!-- 					<input type="hidden" id="consumo_ID" name="consumo_ID">  -->
<!-- 					<input type="hidden" id="cliente_ID" name="cliente_ID">  -->
<!-- 					<input type="hidden" id="contrato_ID" name="contrato_ID"> -->
					
<!-- 					<div class="form-group"> -->
<!-- 						<label class="col-sm-4 control-label">Lectura Actual</label> -->
<!-- 						<div class="col-sm-5"> -->
<!-- 							<input type="number" class="form-control" name="lecture" -->
<!-- 								id="lectura_Actual" data-toggle="tooltip" data-placement="top"title="lectura de consumo"> -->
<!-- 						</div> -->
<!-- 					</div> -->

<!-- 					<div class="clearfix"></div> -->

<!-- 					<div class="form-group has-success has-feedback"> -->
<!-- 						<label class="col-sm-4 control-label">Fecha de corte</label> -->
<!-- 						<div class="col-sm-5"> -->
<!-- 							<input type="text" id="fecha_fin" class="form-control" -->
<!-- 								name="date_send" placeholder="Fecha de corte"> <span -->
<!-- 								class="fa fa-calendar txt-success form-control-feedback"></span> -->
<!-- 						</div> -->
<!-- 					</div> -->

<!-- 					<div class="clearfix"></div> -->

<!-- 					<div class="form-group has-success"> -->
<!-- 						<label class="col-sm-4 control-label">Consumo</label> -->
<!-- 						<div class="col-sm-5"> -->
<!-- 							PARA DEJAR SIN USO A INPUT AGREGAR ATRIBUTO *disabled* -->
<!-- 							<input type="text" class="form-control" -->
<!-- 								placeholder="el consumo es un campo calculado" -->
<!-- 								readonly="readonly" id="consumoTotal"> -->
<!-- 						</div> -->
<!-- 					</div> -->

<!-- 					<h4 class="page-header" -->
<!-- 						Style="text-align: center; font-size: xx-large;">Cliente</h4> -->

<!-- 					<div class="form-group"> -->

<!-- 						<label class="col-sm-4 control-label">Nombres</label> -->
<!-- 						<div class="col-sm-5"> -->
<!-- 							<input type="text" class="form-control" -->
<!-- 								id="nombreClienteCompleto" placeholder="Nombres" -->
<!-- 								data-toggle="tooltip" data-placement="bottom" -->
<!-- 								title="Nombre completo"> -->
<!-- 						</div> -->
<!-- 						<div class="col-sm-5 col-md-3"> -->
<!-- 							<button type="button" class="blue" id="abrir_modal"> -->
<!-- 								<span><i class="fa fa-search"></i></span> Buscar Cliente -->
<!-- 							</button> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="form-group has-success"> -->
<!-- 						<label for="ui-spinner" class="col-sm-4 control-label">N&uacutemero -->
<!-- 							del contrato</label> -->
<!-- 						<div class="col-sm-4"> -->
<!-- 							<input type="text" id="ui-spinner" class="form-control" -->
<!-- 								placeholder="contrato" id="numContrato"> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="clearfix"></div> -->
<!-- 					<div class="form-group"> -->
<!-- 						<label class="col-sm-4 control-label">Medidor</label> -->
<!-- 						<div class="col-sm-5"> -->
<!-- 							<input type="text" class="form-control" id="numMedidor" -->
<!-- 								placeholder="medidor" data-toggle="tooltip" data-placement="top" -->
<!-- 								title="numero de medidor"> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="form-group"> -->
<!-- 						<div class="col-sm-offset-4 col-sm-3"> -->
<!-- 							<button type="button" -->
<!-- 								class="btn btn-default btn-label-left btn-lg" -->
<!-- 								onclick="cancelar()"> -->
<!-- 								<span><i class="fa fa-clock-o txt-danger"></i></span> Cancelar -->
<!-- 							</button> -->
<!-- 						</div> -->
<!-- 						<div class="col-sm-4"> -->
<!-- 							<button type="submit" -->
<!-- 								class="btn btn-primary btn-label-left btn-lg"> -->
<!-- 								<span><i class="fa fa-clock-o"></i></span> Enviar -->
<!-- 							</button> -->
<!-- 						</div> -->
<!-- 					</div> -->

<!-- 				</form> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->

<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name text-center">
					<i class="fa fa-th"></i> <span>Lista de Tarifas</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar2" class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a id="expandir2" class="expand-link"> <i class="fa fa-expand"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding table-responsive">
<!-- 				<div style="display: block; text-align: center;"> -->
<!-- 					<button type="button" class="btn btn-default btn-app-sm btn-circle" id="center_button"> -->
<!-- 						<i class=" fa fa-plus"></i> -->
<!-- 					</button> -->
<!-- 				</div> -->
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="tabla_tarifa">
					<thead>
						<tr>
							<th>Limite Inferior</th>
							<th>Limite Superior</th>
							<th>Monto</th>
							<th></th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- <div class="container"> -->
<!-- 	<div class="table-responsive"> -->
<!-- 		<table class="table" id="tablaNormal"> -->
<!-- 			<thead> -->
<!-- 				<tr> -->
<!-- 					<th>Fecha_Corte</th> -->
<!-- 					<th>Lectura</th> -->
<!-- 					<th>Consumo</th> -->
<!-- 				</tr> -->
<!-- 			</thead> -->
<!-- 			<tbody> -->
<!-- 				<tr class="active"> -->
<!-- 					<td>1</td> -->
<!-- 					<td>Anna</td> -->
<!-- 					<td>3939.3</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td>2</td> -->
<!-- 					<td>Debbie</td> -->
<!-- 					<td>32.34</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td>3</td> -->
<!-- 					<td>como noo se</td> -->
<!-- 					<td>2324.1</td> -->
<!-- 				</tr> -->
<!-- 			</tbody> -->
<!-- 		</table> -->
<!-- 	</div> -->
<!-- </div> -->
<div>
<!-- 	<form id="frmEliminarUsuario" action="" method="POST"> -->
<!-- 		<input type="hidden" id="usuario_id" name="idusuario" value=""> -->
<!-- 		<input type="hidden" id="opcion" name="opcion" value="eliminar"> -->

<!-- 		Modal -->
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
	</form>
</div>


<script type="text/javascript">
	// Iniciar dataTables
	function AllTables() {
		//cargar PDF Y EXCEL
		$.getScript('plugins/datatables/nuevo/jszip.min.js', function(){
			$.getScript('plugins/datatables/nuevo/pdfmake.min.js',function(){
				$.getScript('plugins/datatables/nuevo/vfs_fonts.js',function(){
					console.log("PDF Y EXCEL cargado");
					iniciarTabla();
				});
			});
		});
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
	
// 	function abrirDialogo() {
// 		OpenModalBox(
// 				"<div><h3>Borrar Consumo</h3></div>",
// 				"<p Style='text-align: center;'>Esta seguro de borrar este consumo?</p>",
// 				"<div Style='text-align: center; margin-bottom: -10px;'>"+
// 				"<button type='button' id='eliminar_consumo' class='btn btn-primary' onclick='CloseModalBox()'>Borrar </button>"
// 				+ "<button type='button' class='btn btn-secondary' Style='margin-left: 10px;' onclick='CloseModalBox()'> Cancelar</button>"
// 				+ "</div>");
// 	}

	$(document).ready(function() {

		//cargar scripts dataTables
		LoadDataTablesScripts2(AllTables);
		
		// Crear UI spinner
		$("#ui-spinner").spinner();

		// Inicializar DatePicker
		$('#fecha_fin').datepicker({
		setDate : new Date()
		});
	
		// Añadir Tooltip para formularios
		$('.form-control').tooltip();

		//Cargar ejemplo para validaciones
		LoadBootstrapValidatorScript(DemoFormValidator);

		//MODALS
		$('#abrir_modal').on('click',function(e) {
			OpenModalBox(
			"<div><h3>Buscar Tarifa</h3></div>",
			"<div class='table-responsive'>"
			+ "<table class='table table-bordered table-striped table-hover table-heading table-datatable'"+
			"id='datatable-filter'>"
			+ "<thead>"
			+ "<tr>"
			+ "<th><label><input type='text' name='lim_Inf'/></label></th>"
			+ "<th><label><input type='text' name='lim_Sup'/></label></th>"
			+ "<th><label><input type='text' name='monto'/></label></th>"
			+ "<th></th>"
			+ "</tr>"														
			+ "</thead>"														
			+ "<tbody>"														
			+ "<tr><td>1</td><td>Ubuntu</td><td>16%</td><td></td></tr>"														
			+ "<tr><td>2</td><td>Debian</td><td>14.1%</td><td></td></tr>"														
			+ "<tr><td>3</td><td>Arch Linux</td><td>10.8%</td><td></td></tr>"														
			+ "</tbody>"														
			+ "<tfoot>"														
			+ "<tr><th Style='color: #5d96c3;'>Primer Nombre</th>"+
			"<th Style='color: #5d96c3;'>Primer Apellido</th>"+
			"<th Style='color: #5d96c3;'>Medidor</th><th></th></tr>"														
			+ "</tfoot>"														
			+ "</table>"														
			+ "</div>",
			"<div Style='text-align: center; margin-bottom: -10px;'><button type='button' class='btn btn-secondary' onclick='CloseModalBox()'>Cancelar</button></div>");
			filtrarTabla();		
		});
	
		// Add Drag-n-Drop feature				
		WinMove();	
		
		//add tooltip
		$('[data-toggle="tooltip"]').tooltip();
	});
	
	function filtrarTabla(){
		    // Setup - add a text input to each footer cell
		    $('#datatable-filter thead th label input').each( function () {
		        var title = $(this).attr("name");
		        $(this).attr("placeholder", "Buscar por " + title);
		    } );
		 
		    // DataTable
		    var table = $('#datatable-filter').DataTable({
		    	"destroy": true,
		    	"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
		    	"bJQueryUI": true,
				"language":idioma_esp,
				"columns": [
		            { "data": "lim_Inf" },
		            { "data": "lim_Sup" },
		            { "data": "monto" },
		            {"defaultContent":"<button type='button' class='seleccionar btn btn-primary'>"+
						"Seleccionar</button>"}
		            ],
		    });
		 
		    // Apply the search
		    table.columns().every( function () {
		        var that = this;
		        $( 'input', this.header() ).on( 'keyup change', function () {
		            if ( that.search() !== this.value ) {
		                that.search( this.value) .draw();
		            }
		        } );
		    } );
	}
	
	function iniciarTabla(){
		colapsar_desplegar($("#colapsar_desplegar1"));
		console.log("cargando dataTable");
		var tablaConsumo = $('#tabla_tarifa').dataTable( {
			"destroy": true,
			'bProcessing': false,
			'bServerSide': false,
// 			"aaSorting": [[ 0, "asc" ]],
 	//		"sDom": "T<'box-contents'<'col-sm-4'f><'col-sm-4'B><'col-sm-4 text-right'l><'clearfix'>>rt<'box-content'<'col-sm-6'i><'col-sm-6 text-right'p><'clearfix'>>",
			"ajax": {
				"method":"GET",
				"url":"./SL_tarifa",
 				"dataSrc":"aaData"
			},
			"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
// 			"sAjaxSource": "./SL_consumo",
        	"bJQueryUI": true,
//         	pagingType: 'full_numbers',	
			"language":idioma_esp,
// 			"oLanguage":idioma_esp,
			"columns": [
	            { "data": "lim_Inf" },
	            { "data": "lim_Sup" },
	            { "data": "monto" },
	            {"defaultContent":"<button type='button' class='editarConsumo btn btn-primary' data-toggle='tooltip' "+
					"data-placement='bottom' title='Editar'>"+
					"<i class='fa fa-pencil-square-o'></i> </button>  "+
					"<button type='button' class='eliminarConsumo btn btn-danger' data-toggle='tooltip' "+
					"data-placement='bottom' title='Eliminar'>"+
					"<i class='fa fa-trash-o'></i> </button>"}
	            ],
	            "dom":"<rt><'row'<'form-inline' <'col-sm-12 text-center'B>>>"
					 +"<'row' <'form-inline' <'col-sm-6'l><'col-sm-6'f>>>"
					 +"<rt>"
					 +"<'row'<'form-inline'"
					 +"<'col-sm-6 col-md-6 col-lg-6'i><'col-sm-6 col-md-6 col-lg-6'p>>>",//'Bfrtip',
// 				"dom": 'Bfrtip',
	            "buttons":[{
					"text": "<i class='fa fa-user-plus'></i>",
					"titleAttr": "Agregar usuario",
					"className": "btn btn-success",
					"action": function() {
						agregar_nuevo_consumo();
					}
				},
				{
	                extend:    'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o"></i>',
	                titleAttr: 'excel'
	            },
	            {
	                extend:    'csvHtml5',
	                text:      '<i class="fa fa-file-text-o"></i>',
	                titleAttr: 'csv'
	            },
	            {
	                extend:    'pdfHtml5',
	                text:      '<i class="fa fa-file-pdf-o"></i>',
	                titleAttr: 'pdf'
	            }]
		});
//
// 		seleccionarEditarConsumo('#tabla_consumo tbody', tablaConsumo);
// 		seleccionarEliminarConsumo('#tabla_consumo tbody', tablaConsumo);
//--------------------QUEDE AQUI-------------------------------
//
//
//
	}
	
	var agregar_nuevo_consumo = function() {
		limpiar_texto();
		colapsar_desplegar($("#colapsar_desplegar2"));
		colapsar_desplegar($("#colapsar_desplegar1"));
		expandir($("#expandir1"));
	}
	
	var cancelar = function() {
		limpiar_texto();
		expandir($("#expandir1"));
		colapsar_desplegar($("#colapsar_desplegar1"));
		colapsar_desplegar($("#colapsar_desplegar2"));
	}
	
// 	var limpiar_texto = function() {//limpiar texto del formulario
// 		$("#opcion").val("guardar");
// 		$("#consumo_ID").val("");
// 		$("#cliente_ID").val("");
// 		$("#contrato_ID").val("");
// 		$("#lectura_Actual").val("").focus();
// 		$("#fecha_fin").val("");
// 		$("#consumoTotal").val("");
// 		$("#nombreClienteCompleto").val("");
// 		$("#numContrato").val("");
// 		$("#numMedidor").val("");
// 	}
	
// 	var seleccionarEditarConsumo = function(tbody, table) {
// 		console.log("seleccinar editar consumo");
		
// 		table.rows().every(function(index	) {
// 			console.log(table.row(index).data());
// 		});
// 	}
// 	var seleccionarEliminarConsumo = function(tbody, table) {
// 		console.log("seleccionar eliminar consumo");
		
// 		table.rows().every(function(index	) {
// 			console.log(table.row(index).data());
// 		});
// 	}
	
	
</script>