<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="#">Dashboard</a></li>
			<li><a href="#">Crear Usuario</a></li>
			<li><a href="#">Ver Usuario</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name text-center">
					<i class="fa fa-th"></i> <span>Lista de Usuario</span>
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
				<input type="hidden" id="usuario_id" name="usuario_id">
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="tabla_usuario">
					<thead>
						<tr>
							<th>Login</th>
							<th>Password</th>
							<th></th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>


<div>
	<form id="frmEliminarUsuario" action="" method="POST">
		<input type="hidden" id="usuario_id" name="usuario_id" value="">
		<input type="hidden" id="opcion" name="opcion" value="eliminar">

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
	
	function abrirDialogo() {
		OpenModalBox(
				"<div><h3>Borrar Usuario</h3></div>",
				"<p Style='text-align: center;'>Esta seguro de borrar este usuario?</p>",
				"<div Style='text-align: center; margin-bottom: -10px;'>"+
				"<button type='button' id='eliminar_usuario' class='btn btn-primary' onclick='CloseModalBox()'>Borrar </button>"
				+ "<button type='button' class='btn btn-secondary' Style='margin-left: 10px;' onclick='CloseModalBox()'> Cancelar</button>"
				+ "</div>");
		eliminar();
		
	}
	
	var eliminar = function(){
		$("#eliminar_usuario").on("click", function(){
			frmElim= $("#frmEliminarUsuario").serialize();
			console.log("datos a eliminar: " + frmElim);
			$.ajax({
				method:"POST",
				url:"SL_Usuario",
				data: frmElim
			}).done(function(info){
				iniciarTabla();
				console.log(info);
			});
			
			CloseModalBox();
			
		});
		
	}

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
			"<div><h3>Buscar Cliente</h3></div>",
			"<div class='table-responsive'>"
			+ "<table class='table table-bordered table-striped table-hover table-heading table-datatable'"+
			"id='datatable-filter'>"
			+ "<thead>"
			+ "<tr>"
			+ "<th><label><input type='text' name='login'/></label></th>"
			+ "<th><label><input type='text' name='pass'/></label></th>"
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
		            { "data": "login" },
		            { "data": "pass" },
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
		var tablaUsuario = $('#tabla_usuario').DataTable( {
			"destroy": true,
			'bProcessing': false,
			'bServerSide': false,
// 			"aaSorting": [[ 0, "asc" ]],
 	//		"sDom": "T<'box-contents'<'col-sm-4'f><'col-sm-4'B><'col-sm-4 text-right'l><'clearfix'>>rt<'box-content'<'col-sm-6'i><'col-sm-6 text-right'p><'clearfix'>>",
			ajax: {
				"method":"GET",
				"url":"./SL_Usuario",
// 				"dataSrc":"aaData"
			},
			"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
// 			"sAjaxSource": "./SL_consumo",
        	"bJQueryUI": true,
//         	pagingType: 'full_numbers',	
			"language":idioma_esp,
// 			"oLanguage":idioma_esp,
			"columns": [
	            { "data": "login" },
	            { "data": "pass" },
	            {"defaultContent":"<button type='button' class='editarConsumo btn btn-primary' data-toggle='tooltip' "+
					"data-placement='bottom' title='Editar'>"+
					"<i class='fa fa-pencil-square-o'></i> </button>  "+
					"<button type='button' class='eliminar btn btn-danger' data-toggle='tooltip' "+
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
 		seleccionarEliminarUsuario('#tabla_usuario tbody', tablaUsuario);
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
	
	var limpiar_texto = function() {//limpiar texto del formulario
		$("#login").val("guardar");
		$("#pass").val("");
	}
	
	var seleccionarEditarConsumo = function(tbody, table) {
		console.log("seleccinar editar consumo");
		
		table.rows().every(function(index	) {
			console.log(table.row(index).data());
		});
	}
	
	var seleccionarEliminarUsuario = function(tbody, table) {
		//console.log("seleccionar eliminar consumo");
		$(tbody).on("click", "button.eliminar", function() {
			var datos = table.row($(this).parents("tr")).data();//mismo evento para el boton eliminar
			console.log(datos);
			var usuario_id = $("#frmEliminarUsuario #usuario_id").val(datos.usuario_ID);//solo se obtiene el id que es oculto
			abrirDialogo();
		});
		
		table.rows().every(function(index	) {
			console.log(table.row(index).data());
		});
	}
	
	
</script>
