<%@page language="java"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%> 
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
			<li><a href="#">Facturación</a></li>
		</ol>
	</div>
</div>
<!--///////////////////////Gestión de facturas/////////////////////////////// -->
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box" style="top: 0px; left: 0px; opacity: 1;">

			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-edit"></i> <span>Facturación</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar1" class="collapse-link"> <i
						class="fa fa-chevron-up"></i></a> 
						<a id="expandir1" class="expand-link"> 
						<i class="fa fa-expand"></i></a>
				</div>
				<div class="no-move"></div>
			</div>

			<div class="box-content">
				<div id="ow-server-footer" style="margin:-15px; margin-bottom:30px;">
					<a href="#" id="historialFacturas" class="col-xs-6 col-sm-3 btn-info text-center" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-list"></i> <span>Historial de facturas</span> </a>
					<a href="#" class="col-xs-6 col-sm-3 btn-info text-center" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-plus-square"></i> <span>Crear recibo para factura</span></a> 
					<a href="#" id="facturasSinCancelar" class="col-xs-6 col-sm-3 btn-info text-center" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-desktop"></i> <span>Ver facturas sin cancelar</span></a> 
					<a href="#" class="col-xs-6 col-sm-3 btn-info text-center" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-info-circle"></i> <span>Ir a consumos de clientes</span></a>
				</div>
				<form class="form-horizontal" role="form" id="defaultForm"
					method="POST" action="./SL_Factura">
					<input type="hidden" id="numFact" name="numFact">
					<input type="hidden" id="opcion" name="opcion" value="generar">
					
					<h4 class="page-header"
						Style="text-align: center; font-size: xx-large;">Generación de facturas</h4>

					<div class="clearfix"></div>
					<div class="form-group has-success has-feedback">
						<label class="col-sm-4 control-label">Fecha de corte</label>
						<div class="col-sm-5">
							<input type="text" id="fecha_corte" class="form-control" name="fecha_corte" 
							placeholder="Fecha de corte" title="Fecha de corte de facturas"><span
								class="fa fa-calendar txt-success form-control-feedback"></span>
						</div>
					</div>
					
					<div class="clearfix"></div>
					<div class="form-group has-success has-feedback">
						<label class="col-sm-4 control-label">Fecha de vencimiento</label>
						<div class="col-sm-5">
							<input type="text" id="fecha_vence" class="form-control" name="fecha_vence" 
							placeholder="Fecha de vencimiento" title="Fecha de vencimiento de facturas"><span
								class="fa fa-calendar txt-success form-control-feedback"></span>
						</div>
					</div>
					
					<div class="clearfix"></div>
					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-3">
							<button type="submit" class="btn btn-primary btn-label-left btn-lg"
							data-toggle='tooltip' "data-placement='bottom' title='Generar facturas' >
								<span><i class="fa fa-save"></i></span> Generar
							</button>
						</div>
						<div class="col-sm-4">
							<button type="button"
								class="btn btn-default btn-label-left btn-lg"
								onclick="cancelar();">
								<span><i class="fa fa-reply txt-danger"></i></span> Cancelar
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!--///////////////////////////////////DataTable de los facturas////////////////////////////////////////////// -->
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-th"></i> <span>Lista de facturas recientes</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar2" onclick="validar(colap2);" class="collapse-link"> 
						<i class="fa fa-chevron-up"></i> </a> 
					<a id="expandir2" onclick="validar(expand2);" class="expand-link"> 
						<i class="fa fa-expand"></i> </a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding table-responsive">
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="tabla_factura" style="width:100%;">
					<thead>
						<tr>
							<th>Cliente</th>
							<th>Medidor</th>
							<th>Consumo</th>
							<th>Total pago</th>
							<th>Deslizamiento</th>
							<th>Fecha de corte</th>
							<th>Vencimiento</th>
							<th>Num_factura</th>
							<th>Acción</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!--///////////////////////Formulario y dialogo de eliminción /////////////////////////////// -->
<div>
	<form id="frmAnularFactura" action="" method="POST">
		<input type="hidden" id="numFact" name="numFact" value="">
		<input type="hidden" id="opcion" name="opcion" value="eliminar">

		<!-- 	Modal 	-->
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

<!--///////////////////////DataTable del historial de Facturas cliente/////////////////////////////// -->
<div id="historial" class="row" style="display:none;">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name text-center">
					<i class="fa fa-th"></i> <span>Historial de Facturas Cliente</span>
				</div>
				<div class="box-icons">
					<a id="abrir_historial" class="expand-link"> 
						<i class="fa fa-expand"></i></a>
					<a class="cerrar_historial" onclick="cerrarHistorial();"> 
						<i class="fa fa-times"></i></a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding table-responsive">
				<div style="width:100%; padding-top:15px;"></div>
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="tabla_facturas_historial" style="width:100%;">
					<thead>
						<tr>
							<th>Cliente</th>
							<th>Medidor</th>
							<th>Consumo</th>
							<th>Total pago</th>
							<th>Deslizamiento</th>
							<th>Fecha de corte</th>
							<th>Vencimiento</th>
							<th>Num_factura</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
// /////////////////////////////////////Iniciar dataTables y cargar los plugins//////////////////////////////////////
	function AllTables() {
		//cargar PDF Y EXCEL
		$.getScript('plugins/datatables/nuevo/jszip.min.js', function(){
			$.getScript('plugins/datatables/nuevo/pdfmake.min.js',function(){
				$.getScript('plugins/datatables/nuevo/vfs_fonts.js',function(){
					console.log("PDF Y EXCEL cargado");
					iniciarTabla();
					LoadSelect2Script(MakeSelect2);
				});
			});
		});
	}
	
//////////////////////////funsión que muestra el resultado mediante un dialogo//////////////////////////////////////
	var verResultado = function(r) {//parametro(resultado-String)
		if(r == "BIEN"){
			mostrarMensaje("#dialog", "CORRECTO", 
					"¡Se ha anulado correctamente la factura!", "#d7f9ec", "btn-info");
			limpiar_texto();
			$('#tabla_factura').DataTable().ajax.reload();
		}
		if(r == "ERROR"){
			mostrarMensaje("#dialog", "ERROR", 
					"¡No se puedo anular esta factura!", "#E97D7D", "btn-danger");
		}
	}
// /////////////////////////////funsión que abre un dialogo y mostrara un contenido//////////////////////////////////
	function abrirDialogo() {//parametro(funsion_js[eliminar])
		OpenModalBox(
				"<div><h3>Anular Factura</h3></div>",
				"<p Style='text-align:center; color:salmon; font-size:x-large;'>Esta seguro que desea anular esta factura?</p>",
				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-2 col-md-3'>"+
				"<button style='margin-left:-10px; color:#ece1e1;' type='button' id='anular_factura' "+
				"class='btn btn-danger btn-label-left'>"+
				"<span style='margin-right:-6px;'><i class='fa fa-trash-o'></i></span>Anular Factura</button>"+
				"<div style='margin-top: 5px;'></div> </div>"+
				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-1 col-md-4 text-center'>"+
				"<button type='button' class='btn btn-default btn-label-left' Style='margin-left:10px;' onclick='CloseModalBox()'>"+
				"<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
		anularFacturaMaestra();
	}
	
//////////////////////////////////eliminar los datos seteados en el formulario/////////////////////////////////////
	var anularFacturaMaestra = function() {
		$("#anular_factura").on("click", function() {
			frmElim = $("#frmAnularFactura").serialize();
			console.log("datos a eliminar: " + frmElim);
			$.ajax({
				method:"POST",
				url:"./SL_Factura_Maestra",
				data: frmElim
			}).done(function(info) {
				 	limpiar_texto();
				 	verResultado(info);
			});
			CloseModalBox();
		});
	}

function cerrarHistorial() {
		document.getElementById('historial').style.display = 'none';
		expandir($("#abrir_historial"));
		$('#tabla_facturas_historial').DataTable().state.clear();
		$('#tabla_facturas_historial').DataTable().clear().draw();
	}
	
function cerrasFacturasSinCancelar() {
	document.getElementById('facturasSinCancelar').style.display = 'none';
	expandir($("#abrir_facturas_sin_cancelar"));
	$('#tabla_facturas_sin_cancelar').DataTable().state.clear();
	$('#tabla_facturas_sin_cancelar').DataTable().clear().draw();
}
// ///////////////////funsión que crea un dataTable para traer el historial de facturas de un cliente mediante un dialogo////////////
	function historialFacturasCliente(numMedidor){
		if($.fn.DataTable.isDataTable('#tabla_facturas_historial')){
			$('#tabla_facturas_historial').DataTable().state.clear();
			$('#tabla_facturas_historial').DataTable().clear().draw();
			$.ajax({
		        type: "GET",
		        url:"./SL_Factura_Maestra",
				data: {
			        "carga": 2,
			        "numMedidor" : numMedidor
			    },
		        success: function(response){
		        	$('#tabla_facturas_historial').DataTable().rows.add(response.aaData).draw();
		        }
			});
		}else{
			var table = $('#tabla_facturas_historial').DataTable({
				responsive: true,
				"destroy": true,
		    	"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
		    	"bJQueryUI": true,
				"language":idioma_esp,
				ajax: {
					"method":"GET",
					"url":"./SL_Factura_Maestra",
					"data": {
				        "carga": 2,
				        "numMedidor" : numMedidor
				    },
					"dataSrc":"aaData"
				},
				"columns": [
					{ "data": "cliente.nombreCompleto" },
		             { "data": "contrato.numMedidor" },
		            { "data": "consumo.consumoTotal" },
		            { "data": "totalPago" },
		            { "data": "deslizamiento" },
		            { "data": null,
		                render: function ( data, type, row ) {
		                	var f = new Date(data.consumo.fecha_fin);
		        			var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
		                	return fecha;
		                }},
		             { "data": null,
			         	render: function ( data, type, row ) {
			             	var f = new Date(data.fechaVencimiento);
			        		var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
			               	return fecha;
			       	}},
		            { "data": "numFact" }
		     	]
		    });
		}
	}

///////////////////////////funcion que activa el evento click del boton ver historial del dataTable///////////////////////
	var visualizarHistorial = function(tbody, table) {//parametro(id_tabla, objeto dataTable)
		$(tbody).on("click", "button.verHistorial", function() {
			var datos = table.row($(this).parents("tr")).data();
			var numMedidor = datos.contrato.numMedidor;
			document.getElementById('historial').style.display = 'block';
			expandir($("#abrir_historial"));
			$("#abrir_historial").prop('disabled', true);
			historialFacturasCliente(numMedidor);
			
		});
	}
	
///////////////////////////funcion que activa el evento click del boton ver historial del dataTable///////////////////////
	var facturassinCancelar = function(tbody, table) {//parametro(id_tabla, objeto dataTable)
		$(tbody).on("click", "button.verHistorial", function() {
			var datos = table.row($(this).parents("tr")).data();
			var numMedidor = datos.contrato.numMedidor;
			document.getElementById('facturasSinCancelar').style.display = 'block';
			expandir($("#abrir_facturas_sin_cancelar"));
			$("#abrir_facturas_sin_cancelar").prop('disabled', true);
			historialFacturasCliente(numMedidor);
			
		});
	}
	
///////////////////funcion que crea un dataTable para traer facturas sin cancelar////////////
	function facturasSinCancelar(){
		    $('#datatable-filter thead th label input').each( function () {
		        var title = $(this).attr("name");
		        $(this).attr("placeholder", "Buscar por " + title);
		    } );
		    var table = $('#datatable-filter').DataTable({
				responsive: true,
				"destroy": true,
		    	"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
		    	"bJQueryUI": true,
				"language":idioma_esp,
				ajax: {
					"method":"GET",
					"url":"./SL_Factura_Maestra",
					"data": {
				        "carga": 3
				    },
					"dataSrc":"aaData"
				},
				"columns": [
					{ "data": "cliente.nombreCompleto" },
		             { "data": "contrato.numMedidor" },
		            { "data": "consumo.consumoTotal" },
		            { "data": "totalPago" },
		            { "data": "deslizamiento" },
		            { "data": null,
		                render: function ( data, type, row ) {
		                	var f = new Date(data.consumo.fecha_fin);
		        			var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
		                	return fecha;
		                }},
		             { "data": null,
			         	render: function ( data, type, row ) {
			             	var f = new Date(data.fechaVencimiento);
			        		var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
			               	return fecha;
			       	}},
		            { "data": "numFact" },
		            {"defaultContent":"<button type='button' style='margin-left:15px;' class='anularFactura btn btn-danger'"
		          	+"title='Anular Factura' id='anularFactura' >"
					+ "<i class='fa fa-upload'></i> </button>"}
		     		]
		    });
		 
		    // Aplicar la busqueda por columna
		    table.columns().every( function () {
		        var that = this;
		        $( 'input', this.header() ).on( 'keyup change', function () {
		            if ( that.search() !== this.value ) {
		                that.search( this.value) .draw();
		            }
		        } );
		    } );
		    anularFacturas('#datatable-filter tbody', table);
	}
	
/////////////////////////////funcion que anula la factura////////////////////
	function anularFacturas(tbody, table) {//parametro(id_tabla, objeto dataTable)
		$(tbody).on("click","button.anularFactura",function(){
			var datos = table.row($(this).parents("tr")).index();;
			var numFact;
			
			table.rows().every(function(index, loop, rowloop) {
				console.log("indices: "+ index +" : "+datos);
				if(index == datos){
					numFact = table.row(index).data().numFact;
					$("#frmAnularFactura #numFact").val(numFact);
				}
			});
			abrirDialogo();
		});
	}
	
///////////////////funcion que crea un dataTable para traer historial de todas las facturas////////////
	function historialFacturas(){
		    $('#datatable-facturas-sin-cancelar thead th label input').each( function () {
		        var title = $(this).attr("name");
		        $(this).attr("placeholder", "Buscar por " + title);
		    } );
		    var table = $('#datatable-facturas-sin-cancelar').DataTable({
				responsive: true,
				"destroy": true,
		    	"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
		    	"bJQueryUI": true,
				"language":idioma_esp,
				ajax: {
					"method":"GET",
					"url":"./SL_Factura_Maestra",
					"data": {
				        "carga": 4
				    },
					"dataSrc":"aaData"
				},
				"columns": [
					{ "data": "cliente.nombreCompleto" },
		             { "data": "contrato.numMedidor" },
		            { "data": "consumo.consumoTotal" },
		            { "data": "totalPago" },
		            { "data": "deslizamiento" },
		            { "data": null,
		                render: function ( data, type, row ) {
		                	var f = new Date(data.consumo.fecha_fin);
		        			var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
		                	return fecha;
		                }},
		             { "data": null,
			         	render: function ( data, type, row ) {
			             	var f = new Date(data.fechaVencimiento);
			        		var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
			               	return fecha;
			       	}},
		            { "data": "numFact" }
		     	]
		    });
		 
		    // Aplicar la busqueda por columna
		    table.columns().every( function () {
		        var that = this;
		        $( 'input', this.header() ).on( 'keyup change', function () {
		            if ( that.search() !== this.value ) {
		                that.search( this.value) .draw();
		            }
		        } );
		    } );
	}

///////////////////////////////Ejecutar el metodo DataTable para llenar la Tabla///////////////////////////////////
	function iniciarTabla(){
		validarColap(colap1, "#colapsar_desplegar1");
		var tablaFactura = $('#tabla_factura').DataTable( {
			responsive: true,
			"destroy": true,
			'bProcessing': false,
			'bServerSide': false,
			ajax: {
				"method":"GET",
				"url":"./SL_Factura_Maestra",
				"data": {
			        "carga": 1//para decirle al servlet que cargue la vista factura_actual
			    },
				"dataSrc":"aaData"
			},
			"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
        	"bJQueryUI": true,
			"language":idioma_esp,
			drawCallback: function(settings){
	            var api = this.api();
	            $('td', api.table().container()).find("button").tooltip({container : 'body'});
	            $("a.btn").tooltip({container: 'body'});
	        },
			"columns": [
				{ "data": "cliente.nombreCompleto" },
	             { "data": "contrato.numMedidor" },
	            { "data": "consumo.consumoTotal" },
	            { "data": "totalPago" },
	            { "data": "deslizamiento" },
	            { "data": null,
	                render: function ( data, type, row ) {
	                	var f = new Date(data.consumo.fecha_fin);
	        			var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
	                	return fecha;
	                }},
	             { "data": null,
		         	render: function ( data, type, row ) {
		             	var f = new Date(data.fechaVencimiento);
		        		var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
		               	return fecha;
		       	}},
	            { "data": "numFact" },
	            {"defaultContent":"<button type='button' class='editarConsumo btn btn-primary' title='Editar consumo'>"+
					"<i class='fa fa-pencil-square-o'></i> </button>  "+
					"<button type='button' class='eliminarConsumo btn btn-danger' title='Eliminar consumo'>"+
					"<i class='fa fa-trash-o'></i> </button> "+
					"<button type='button' class='verHistorial btn btn-warning' data-toggle='tooltip' "+
					"data-placement='top' title='ver historial facturas'>"+
					"<i class='fa fa-sitemap'></i> </button>"}
	            ],
	            "dom":"<rt><'row'<'form-inline' <'col-sm-12 text-center'B>>>"
					 +"<'row' <'form-inline' <'col-sm-6'l><'col-sm-6'f>>>"
					 +"<rt>"
					 +"<'row'<'form-inline'"
					 +"<'col-sm-6 col-md-6 col-lg-6'i><'col-sm-6 col-md-6 col-lg-6'p>>>",
	            "buttons":[{
					"text": "<i class='fa fa-archive'></i>",
					"titleAttr": "Imprimir facturas",
					"className": "btn btn-success",
					"action": function() {
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
		visualizarHistorial('#tabla_factura tbody', tablaFactura);
	}
	
	
	var cancelar = function() {////////////////cancela la acción limpiando el texto y colapsando el formulario
		limpiar_texto();
		colapsar_desplegar($("#colapsar_desplegar1"));	
	}
	
	var limpiar_texto = function() {////////////////////////limpiar texto del formulario
		$("#opcion").val("generar");
		$("#fecha_corte").val("");
		$("#fecha_vence").val("");
		$("form#defaultForm").data('bootstrapValidator').resetForm();////////////////resetear las validaciones
	}
/////////////////////////////////////////////////FUNSIÓN PRINCIPAL/////////////////////////////////////////////////
	$(document).ready(function() {

		//cargar scripts dataTables
		LoadDataTablesScripts2(AllTables);

		LoadBootstrapValidatorScript(FormValidFactura);
		
		// Inicializar DatePicker
		$('#fecha_corte').datepicker({
			setDate : new Date(),
			dateFormat: 'dd/mm/yy',
			onSelect: function(dateText, inst) {
				$("#fecha_corte").val(dateText.toString());
				$("#fecha_corte").change();
				$('#defaultForm').bootstrapValidator('revalidateField', 'fecha_corte');
			}
		});
		$('#fecha_vence').datepicker({
			setDate : new Date(),
			dateFormat: 'dd/mm/yy',
			onSelect: function(dateText, inst) {
				$("#fecha_vence").val(dateText.toString());
				$("#fecha_vence").change();
				$('#defaultForm').bootstrapValidator('revalidateField', 'fecha_vence');
			}
		});
		
		//MODAL para mostrar una tabla con facturas sin cancelar
		$('#facturasSinCancelar').on('click',function(e) {
			OpenModalBox(
			"<div><h3>Facturas sin cancelar</h3></div>",
			"<div class='table-responsive'>"
			+ "<table class='table table-bordered table-striped table-hover table-heading table-datatable'"+
			"id='datatable-filter'>"
			+ "<thead>"
			+ "<tr>"
			+ "<th><label><input type='text' name='Cliente'/></label></th>"
			+ "<th><label><input type='text' name='Medidor'/></label></th>"
			+ "<th><label><input type='text' name='Consumo'/></label></th>"
			+ "<th><label><input type='text' name='Total pago'/></label></th>"
			+ "<th><label><input type='text' name='Deslizamiento'/></label></th>"
			+ "<th><label><input type='text' name='Fecha de corte'/></label></th>"
			+ "<th><label><input type='text' name='Vencimiento'/></label></th>"
			+ "<th><label><input type='text' name='Num_factura'/></label></th>"
			+ "<th></th>"
			+ "</tr>"														
			+ "</thead>"														
			+ "<tfoot>"														
			+ "<tr><th Style='color: #5d96c3;'>Cliente</th>"+
			"<th Style='color: #5d96c3;'>Medidor</th>"+
			"<th Style='color: #5d96c3;'>Fecha de corte</th>"+
			"<th Style='color: #5d96c3;'>Total pago</th>"+
			"<th Style='color: #5d96c3;'>Deslizamiento</th>"+
			"<th Style='color: #5d96c3;'>Fecha de corte</th>"+
			"<th Style='color: #5d96c3;'>Vencimiento</th>"+
			"<th Style='color: #5d96c3;'>Num_factura</th><th></th></tr>"														
			+ "</tfoot>"														
			+ "</table>"														
			+ "</div>",
			"<div Style='text-align: center; margin-bottom: -5px;'><button type='button' class='btn-default btn-label-left btn-lg' "
			+"onclick='CloseModalBox()'><span><i class='fa fa-reply txt-danger'></i></span>Cancelar</button></div>");
			
			facturasSinCancelar();
		});
		
		//MODAL para mostrar una tabla del historial de todas las facturas
		$('#historialFacturas').on('click',function(e) {
			OpenModalBox(
			"<div><h3>Facturas sin cancelar</h3></div>",
			"<div class='table-responsive'>"
			+ "<table class='table table-bordered table-striped table-hover table-heading table-datatable'"+
			"id='datatable-facturas-sin-cancelar'>"
			+ "<thead>"
			+ "<tr>"
			+ "<th><label><input type='text' name='Cliente'/></label></th>"
			+ "<th><label><input type='text' name='Medidor'/></label></th>"
			+ "<th><label><input type='text' name='Consumo'/></label></th>"
			+ "<th><label><input type='text' name='Total pago'/></label></th>"
			+ "<th><label><input type='text' name='Deslizamiento'/></label></th>"
			+ "<th><label><input type='text' name='Fecha de corte'/></label></th>"
			+ "<th><label><input type='text' name='Vencimiento'/></label></th>"
			+ "<th><label><input type='text' name='Num_factura'/></label></th>"
			+ "<th></th>"
			+ "</tr>"														
			+ "</thead>"														
			+ "<tfoot>"														
			+ "<tr><th Style='color: #5d96c3;'>Cliente</th>"+
			"<th Style='color: #5d96c3;'>Medidor</th>"+
			"<th Style='color: #5d96c3;'>Fecha de corte</th>"+
			"<th Style='color: #5d96c3;'>Total pago</th>"+
			"<th Style='color: #5d96c3;'>Deslizamiento</th>"+
			"<th Style='color: #5d96c3;'>Fecha de corte</th>"+
			"<th Style='color: #5d96c3;'>Vencimiento</th>"+
			"<th Style='color: #5d96c3;'>Num_factura</th></tr>"														
			+ "</tfoot>"														
			+ "</table>"														
			+ "</div>",
			"<div Style='text-align: center; margin-bottom: -5px;'><button type='button' class='btn-default btn-label-left btn-lg' "
			+"onclick='CloseModalBox()'><span><i class='fa fa-reply txt-danger'></i></span>Cancelar</button></div>");
			
			historialFacturas();
		});
		
// 		Add Drag-n-Drop feature				
		WinMove();
	
		// Añadir Tooltip para formularios
		$('.form-control').tooltip();
		$('[data-toggle=tooltip]').tooltip();
	});
/////////////////////////////////////funsión que valida los campos del formulario////////////////////////////////
	function FormValidFactura() {
		$('form#defaultForm').bootstrapValidator({
			message: '¡Este valor no es valido!',
			fields: {
				fecha_corte:{
					validators:{
	                    notEmpty:{
			                message: "¡Este campo es requerido y no debe estar vacio!"
			            }
					}
				},
				fecha_vence:{
					validators:{
	                    notEmpty:{
			                message: "¡Este campo es requerido y no debe estar vacio!"
			            },
			            callback: {
	       					message: '¡La fecha de vencimiento debe ser mayor que la fecha actual!',
	        				callback: function (value, validator, $field) {
		            				var f1 = $("form#defaultForm #fecha_vence").val().split("/");
// 		            				var f2 = $("form#defaultForm #fecha_corte").val().split("/");
		            				var fecha1 = new Date(f1[2], f1[1]-1, f1[0]);
		            				var fecha2 = new Date();
		            				if(fecha1 <=  fecha2)
	        							return false;
		            				else
		            					return true;
	        				}
	    				}
					}
				}
			}
		}).on('success.form.bv', function(e) {//evento que se activa cuando los datos son correctos
            // Prevenir el evento submit
            e.preventDefault();

            //obtener datos del formulario
            var $form = $(e.target);
            var frm=$form.serialize();
            console.log(frm);
  			$.ajax({//enviar datos por ajax
	  			method:"post",
	  			url:"./SL_Factura_Maestra",
	  			data: frm//datos a enviar
	  		}).done(function(info) {//informacion que el servlet le reenvia al jsp
	  			console.log(info);
 				verResultado(info);
	  		});
        });
	}
</script>