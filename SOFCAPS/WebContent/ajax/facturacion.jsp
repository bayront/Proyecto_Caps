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
					<a id="colapsar_desplegar1" class="collapse-link" onclick="validar(colap1);"> <i
						class="fa fa-chevron-up"></i></a> 
						<a id="expandir1" class="expand-link"  onclick="validar(expand1);"> 
						<i class="fa fa-expand"></i></a>
				</div>
				<div class="no-move"></div>
			</div>

			<div class="box-content">
				<div id="ow-server-footer" style="margin:-15px; margin-bottom:30px;">
					<a href="#" class="col-xs-6 col-sm-3 btn-info text-center" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-list"></i> <span>Ver historial de clientes</span> </a>
					<a href="#" class="col-xs-6 col-sm-3 btn-info text-center" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-plus-square"></i> <span>Crear recibo para factura</span></a> 
					<a href="#" class="col-xs-6 col-sm-3 btn-info text-center" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-desktop"></i> <span>Ver facturas sin cancelar</span></a> 
					<a href="#" class="col-xs-6 col-sm-3 btn-info text-center" style="color:#2f2481; font-weight:600;"><i
					class="fa fa-info-circle"></i> <span>Ir a consumos de clientes</span></a>
				</div>
				<form class="form-horizontal" role="form" id="defaultForm"
					method="POST" action="./SL_Factura">
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
<!--///////////////////////DataTable de los facturas/////////////////////////////// -->
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name text-center">
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
	<form id="frmEliminarFactura" action="" method="DELETE">
		<input type="hidden" id="consumo_id" name="factura_maestra_id" value="">
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

<script type="text/javascript">
// //objetos websockets
// var wsUri = "ws://"+window.location.host+"/SOFCAPS/serverendpointdemo";
// var websocket = new WebSocket(wsUri);

// //evento que notifica que la conexion esta abierta
// websocket.onopen = function(evt) { //manejamos los eventos...
//     console.log("Conectado..."); //... y aparecerá en la pantalla
// };

// //evento onmessage para resibir mensaje del serverendpoint
// websocket.onmessage = function(evt) { // cuando se recibe un mensaje
// 	console.log("Mensaje recibido de webSocket: " + evt.data);
// 	verResultado(evt.data);
// };

// //evento si hay algun error en la comunicacion con el web_socket
// websocket.onerror = function(evt) {
//     console.log("oho!.. error:" + evt.data);
// };

// 	var expand1 = new Expand1();//se crean los objetos que representan los botones de cada dialogo
// 	var colap1 =  new Colap1();
// 	var expand2 = new Expand2();
// 	var colap2 =  new Colap2();
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
	
// //////////////////////////funsión que muestra el resultado mediant un dialogo//////////////////////////////////////
// 	var verResultado = function(r) {//parametro(resultado-String)
// 		if(r == "BIEN"){
// 			mostrarMensaje("#dialog", "CORRECTO", 
// 					"¡Se realizó la acción correctamente, todo bien!", "#d7f9ec", "btn-info");
// 			limpiar_texto();
// 			$('#tabla_consumo').DataTable().ajax.reload();
// 			websocket.send("ACTUALIZADO");
// 		}
// 		if(r == "ERROR"){
// 			mostrarMensaje("#dialog", "ERROR", 
// 					"¡Ha ocurrido un error, no se pudó realizar la acción!", "#E97D7D", "btn-danger");
// 		}
// 		if(r =="VACIO"){
// 			mostrarMensaje("#dialog", "VACIO", 
// 					"¡No se especificó la acción a realizar!", "#FFF8A7", "btn-warning");
// 		}
// 		if(r =="ACTUALIZADO"){
// 			mostrarMensaje("#dialog", "ACTUALIZADO", 
// 					"¡Otro usuario a realizado un cambio, se actualizaron los datos!", "#86b6dd", "btn-primary");
// 			$('#tabla_consumo').DataTable().ajax.reload();
// 		}
// 		if(r == "LECTURAMENOR"){
// 			mostrarMensaje("#dialog", "ERROR", 
// 					"¡La lectura que ha digitado debe ser mayor que la lectura anterior!", "#E97D7D", "btn-danger");
// 		}
// 		if(r == "FECHAMENOR"){
// 			mostrarMensaje("#dialog", "ERROR", 
// 					"¡La fecha debe ser mayor que el registro anterior de este cliente!", "#E97D7D", "btn-danger");
// 		}
// 	}
// /////////////////////////////funsión que abre un dialogo y mostrara un contenido//////////////////////////////////
// 	function abrirDialogo(callback) {//parametro(funsion_js[eliminar])
// 		OpenModalBox(
// 				"<div><h3>Borrar Consumo</h3></div>",
// 				"<p Style='text-align:center; color:salmon; font-size:x-large;'>Esta seguro de borrar este consumo?</p>",
// 				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-2 col-md-3'>"+
// 				"<button style='margin-left:-10px; color:#ece1e1;' type='button' id='eliminar_consumo' "+
// 				"class='btn btn-danger btn-label-left'>"+
// 				"<span style='margin-right:-6px;'><i class='fa fa-trash-o'></i></span>Borrar consumo</button>"+
// 				"<div style='margin-top: 5px;'></div> </div>"+
// 				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-1 col-md-4 text-center'>"+
// 				"<button type='button' class='btn btn-default btn-label-left' Style='margin-left:10px;' onclick='CloseModalBox()'>"+
// 				"<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
// 		callback();
// 	}
// ///////////////////funsión que crea un dataTable para traer en cliente y el contrato mediante un dialogo////////////
// 	function filtrarTabla(){
// 		    $('#datatable-filter thead th label input').each( function () {
// 		        var title = $(this).attr("name");
// 		        $(this).attr("placeholder", "Buscar por " + title);
// 		    } );
// 		    var table = $('#datatable-filter').DataTable({
// 		    	"destroy": true,
// 		    	"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
// 		    	"bJQueryUI": true,
// 				"language":idioma_esp,
// 				ajax: {
// 					"method":"GET",
// 					"url":"./SL_consumo",
// 					"data": {
// 				        "carga": 2//para decirle al servlet que cargue solo clinte + consumos
// 				    },
// 					"dataSrc":"aaData"
// 				},
// 				"columns": [
// 		            { "data": "nombreCompleto"},
// 		            { "data": "contratos[0].numContrato" },
// 		            { "data": "contratos[0].numMedidor" },
// 		            {"defaultContent":"<button type='button' style='margin-left:15px;' class='activar btn btn-primary'"
// 		            +"title='Seleccionar cliente' id='seleccionarCl' >"
// 					+ "<i class='fa fa-upload'></i> </button>"}
// 		            ]
// 		    });
		 
// 		    // Aplicar la busqueda por columna
// 		    table.columns().every( function () {
// 		        var that = this;
// 		        $( 'input', this.header() ).on( 'keyup change', function () {
// 		            if ( that.search() !== this.value ) {
// 		                that.search( this.value) .draw();
// 		            }
// 		        } );
// 		    } );
// 		    cambiarCliente('#datatable-filter tbody', table);
// 	}
// /////////////////////////////funsión que setea el cliente y contrato en los input del formulario////////////////////
// 	function cambiarCliente(tbody, table) {//parametro(id_tabla, objeto dataTable)
// 		$(tbody).on("click","button#seleccionarCl",function(){
// 			console.log("cambiar cliente");
// 			var datos = table.row($(this).parents("tr")).data();
// 			console.log(datos);
// 			$("#nombreClienteCompleto").val(datos.nombreCompleto);
// 			$("#numContrato").val(datos.contratos[0].numContrato);
// 			$("#numMedidor").val(datos.contratos[0].numMedidor);
// 			$("#cliente_ID").val(datos.cliente_ID);
// 			$("#contrato_ID").val(datos.contratos[0].contrato_ID);
			
// 			CloseModalBox();
// 		});
// 	}
// ///////////////////////////funsión que activa el evento click del boton editar del dataTable///////////////////////
// 	var seleccionarEditarConsumo = function(tbody, table) {//parametro(id_tabla, objeto dataTable)
// 		$(tbody).on("click", "button.editarConsumo", function() {
// 			var datos = table.row($(this).parents("tr")).data();
// 			var f = new Date(datos.fecha_fin);
// 			var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
// 			$("#lectura_Actual").val(datos.lectura_Actual);
// 			$("#fecha_fin").val(fecha);
// 			$("#consumoTotal").val(datos.consumoTotal);
// 			$("#nombreClienteCompleto").val(datos.cliente.nombreCompleto);
// 			$("#numContrato").val(datos.contrato.numContrato);
// 			$("#numMedidor").val(datos.contrato.numMedidor);
// 			$("#opcion").val("actualizar");
// 			$("#consumo_ID").val(datos.consumo_ID);
// 			$("#nombreClienteCompleto").prop('readonly', true);
// 			$("#numContrato").prop('readonly', true);
// 			$("#numMedidor").prop('readonly', true);
// 			$("#abrir_modal").prop('disabled', true);
// 			$("#abrir_modal").attr('title', 'No puede editar el cliente');
// 			$("#cliente_ID").val(datos.cliente.cliente_ID);
// 			$("#contrato_ID").val(datos.contrato.contrato_ID);
			
// 			validarExpand(expand1, "#expandir1");
// 			if(colap1.valor==false)
// 				validarColap(colap1, "#colapsar_desplegar1");
// 			validarColap(colap2, "#colapsar_desplegar2");
// 			if(expand2.valor == true)
// 				validarExpand(expand2, "#expandir2");
// 		});
// 	}
///////////////////////////////Ejecutar el metodo DataTable para llenar la Tabla///////////////////////////////////
	function iniciarTabla(){
// 		validarColap(colap1, "#colapsar_desplegar1");
		var tablaConsumo = $('#tabla_factura').DataTable( {
			responsive: true,
			"destroy": true,
			'bProcessing': false,
			'bServerSide': false,
// 			ajax: {
// 				"method":"GET",
// 				"url":"./SL_consumo",
// 				"data": {
// 			        "carga": 1//para decirle al servlet que cargue consumos + cliente + contrato
// 			    },
// 				"dataSrc":"aaData"
// 			},
			"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
        	"bJQueryUI": true,
			"language":idioma_esp,
			drawCallback: function(settings){
	            var api = this.api();
	            $('td', api.table().container()).find("button").tooltip({container : 'body'});
	            $("a.btn").tooltip({container: 'body'});
	        },
// 			"columns": [
// 	            { "data": null,
// 	                render: function ( data, type, row ) {
// 	                	var f = new Date(data.fecha_fin);
// 	        			var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
// 	                	return fecha;
// 	                }},
// 	            { "data": "lectura_Actual" },
// 	            { "data": "consumoTotal" },
// 	            { "data": "cliente.nombreCompleto" },
// 	            { "data": "contrato.numContrato" },
// 	            { "data": "contrato.numMedidor" },
// 	            {"defaultContent":"<button type='button' class='editarConsumo btn btn-primary' title='Editar consumo'>"+
// 					"<i class='fa fa-pencil-square-o'></i> </button>  "+
// 					"<button type='button' class='eliminarConsumo btn btn-danger' title='Eliminar consumo'>"+
// 					"<i class='fa fa-trash-o'></i> </button>"}
// 	            ],
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
// 		seleccionarEditarConsumo('#tabla_consumo tbody', tablaConsumo);
// 		seleccionarEliminarConsumo('#tabla_consumo tbody', tablaConsumo);
	}
	
// 	var agregar_nuevo_consumo = function() {//////////////agregar nuevo registro limpiando texto y abriendo el form
// 		limpiar_texto();
// 		validarExpand(expand1, "#expandir1");
// 		if(colap1.valor==false)
// 			validarColap(colap1, "#colapsar_desplegar1");
		
// 		validarColap(colap2, "#colapsar_desplegar2");
// 		if(expand2.valor == true)
// 			validarExpand(expand2, "#expandir2");
		
// 		$("button#abrir_modal").focus();
// 	}
	
// 	var cancelar = function() {////////////////cancela la acción limpiando el texto y colapsando el formulario
// 		limpiar_texto();
// 		if(expand1.valor == true)
// 			validarExpand(expand1, "#expandir1");
		
// 		if(expand2.valor == true)
// 			validarExpand(expand2, "#expandir2");
		
// 		validarColap(colap1, "#colapsar_desplegar1");
// 		if (colap2.valor ==true){}else{
// 			validarColap(colap2, "#colapsar_desplegar2");
// 		}
// 	}
	
// 	var limpiar_texto = function() {////////////////////////limpiar texto del formulario
// 		$("#opcion").val("guardar");
// 		$("#consumo_ID").val("");
// 		$("#cliente_ID").val("");
// 		$("#contrato_ID").val("");
// 		$("#lectura_Actual").val("");
// 		$("#fecha_fin").val("");
// 		$("#consumoTotal").val("");
// 		$("#nombreClienteCompleto").val("");
// 		$("#numContrato").val("");
// 		$("#numMedidor").val("");
// 		$("#nombreClienteCompleto").prop('readonly', false);
// 		$("#numContrato").prop('readonly', false);
// 		$("#numMedidor").prop('readonly', false);
// 		$("#abrir_modal").prop('disabled', false);
// 		$("#abrir_modal").attr('title', '');
// 		$("form#defaultForm").data('bootstrapValidator').resetForm();////////////////resetear las validaciones
// 	}
// /////////////////////////funsión que activa el evento click para eliminar un registro del dataTable////////////////
// 	var seleccionarEliminarConsumo = function(tbody, table) {//parametro(id_tabla, objeto dataTable)
// 		$(tbody).on("click", "button.eliminarConsumo", function() {
// 			var datos = table.row($(this).parents("tr")).data();
// 			$("form#frmEliminarConsumo #consumo_id").val(datos.consumo_ID);
// 			abrirDialogo(eliminarConsumo);
// 		});
// 	}
// //////////////////////////////////eliminar los datos seteados en el formulario/////////////////////////////////////
// 	var eliminarConsumo = function() {
// 		$("#eliminar_consumo").on("click", function() {
// 			var consumo_ID = $("#frmEliminarConsumo #consumo_id").val();//se obtiene el id del usuario que esta oculto
// 			console.log("consumo_ID:"+consumo_ID);
// 			$.ajax({
// 				type:"DELETE",
// 				url:"./SL_consumo",
// 				headers: {"consumo_ID": consumo_ID}
// 			}).done(function(info) {
// 				verResultado(info);
// 				CloseModalBox();
// 			});
// 		});
// 	}
/////////////////////////////////////////////////FUNSIÓN PRINCIPAL/////////////////////////////////////////////////
	$(document).ready(function() {

		//cargar scripts dataTables
		LoadDataTablesScripts2(AllTables);

		// Inicializar DatePicker
		$('#fecha_corte').datepicker({
			setDate : new Date(),
			dateFormat: 'dd/mm/yy',
			onSelect: function(dateText, inst) {
				$("#fecha_corte").val(dateText.toString());
				$("#fecha_corte").change();
// 				$('form#defaultForm').bootstrapValidator('revalidateField', 'fecha');
			}
		});
		$('#fecha_vence').datepicker({
			setDate : new Date(),
			dateFormat: 'dd/mm/yy',
			onSelect: function(dateText, inst) {
				$("#fecha_vence").val(dateText.toString());
				$("#fecha_vence").change();
// 				$('form#defaultForm').bootstrapValidator('revalidateField', 'fecha');
			}
		});
		
	
		// Añadir Tooltip para formularios
		$('.form-control').tooltip();
		$('[data-toggle=tooltip]').tooltip();

// 		//Cargar plugins para validaciones
// 		LoadBootstrapValidatorScript(FormValidConsumo);

// 		//MODAL para mostrar una tabla con el cliente y en contrato
// 		$('#abrir_modal').on('click',function(e) {
// 			OpenModalBox(
// 			"<div><h3>Buscar Cliente</h3></div>",
// 			"<div class='table-responsive'>"
// 			+ "<table class='table table-bordered table-striped table-hover table-heading table-datatable'"+
// 			"id='datatable-filter'>"
// 			+ "<thead>"
// 			+ "<tr>"
// 			+ "<th><label><input type='text' name='Nombres'/></label></th>"
// 			+ "<th><label><input type='text' name='Num_Contrato'/></label></th>"
// 			+ "<th><label><input type='text' name='Medidor'/></label></th>"
// 			+ "<th></th>"
// 			+ "</tr>"														
// 			+ "</thead>"														
// 			+ "<tfoot>"														
// 			+ "<tr><th Style='color: #5d96c3;'>Nombre Completo</th>"+
// 			"<th Style='color: #5d96c3;'>Numero Contrato</th>"+
// 			"<th Style='color: #5d96c3;'>Medidor</th><th></th></tr>"														
// 			+ "</tfoot>"														
// 			+ "</table>"														
// 			+ "</div>",
// 			"<div Style='text-align: center; margin-bottom: -5px;'><button type='button' class='btn-default btn-label-left btn-lg' "
// 			+"onclick='CloseModalBox()'><span><i class='fa fa-reply txt-danger'></i></span>Cancelar</button></div>");
			
// 			filtrarTabla();		
		});
		
// 		// Add Drag-n-Drop feature				
// 		WinMove();	
		
// 		//añadir tooltip
// 		$('[data-toggle="tooltip"]').tooltip();
// 	});
// ///////////////////////////Funsión que valida el formulario de consumos de clientes////////////////////////////////
// 	function FormValidConsumo() {
// 		$('form#defaultForm').bootstrapValidator({
// 			message: '¡Este valor no es valido!',
// 			fields: {
// 				lectura:{
// 					validators: {
// 						notEmpty:{
// 			                message: "¡Este campo es requerido y no debe estar vacio!"
// 			            },
// 			            greaterThan: {
// 	                        value: 0,
// 	                        inclusive: false,
// 	                        message: '¡El valor debe ser mayor o igual a 0!'
// 	                    },
// 						callback: {
//            					message: '¡Seleccione un cliente antes de digitar la lectura!',
//             				callback: function (value, validator, $field) {
//             					if($("form#defaultForm #contrato_ID").val()=="" && $("form#defaultForm #cliente_ID").val()==""){
//             						return false;
//                                 }else{
//                                 	return true;
//                                 }
//             				}
//         				}
// 			        }
// 				},
// 				fecha:{
// 					validators: {
// 						notEmpty:{
// 			                message: "¡Este campo es requerido y no debe estar vacio!"
// 			            }
// 			        }
// 				},
// 				consumoActual:{
// 					validators: {
// 						notEmpty:{
// 			                message: "¡Este campo es requerido y no debe estar vacio!"
// 			            }
// 			        }
// 				}
// 			}
// 		}).on('success.form.bv', function(e) {//evento que se activa cuando los datos son correctos
//             // Prevenir el evento submit
//             e.preventDefault();

//             //obtener datos del formulario
//             var $form = $(e.target);
//             var frm=$form.serialize();
//             console.log(frm);
//             $.ajax({//enviar datos por ajax
// 	 			type:"POST",
// 	 			url:"./SL_consumo",
// 	 			data: frm//datos a enviar
// 	 			}).done(function(info) {//informacion que el servlet le reenvia al jsp
// 	 			console.log(info);
// 	 			if(expand1.valor == true)
// 					validarExpand(expand1, "#expandir1");
			
// 				if(expand2.valor == true)
// 					validarExpand(expand2, "#expandir2");
				
// 				validarColap(colap1, "#colapsar_desplegar1");
// 				if (colap2.valor ==true){}else{
// 					validarColap(colap2, "#colapsar_desplegar2");
// 				}
// 				verResultado(info);//se envia a verificar que mensaje respondio el servlet	
// 	 			});
//         });
// 	}
	
</script>