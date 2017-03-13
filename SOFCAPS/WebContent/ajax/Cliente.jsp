<%@page language="java"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="#">Inicio</a></li>
			<li><a href="#">Clientes</a></li>
			<li><a href="#">Todos los clientes</a></li>
		</ol>
	</div>
</div>

<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box" style="top: 0px; left: 0px; opacity: 1;">

			<div class="box-header">
				<div class="box-name">
					<i class="fa  fa-user"></i> <span>Registrar Nuevo Cliente</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar1" class="collapse-link"> <i
						class="fa fa-chevron-up"></i></a> <a id="expandir1"
						class="expand-link"  onclick="validarExpand();"> <i class="fa fa-expand"></i></a>
				</div>
				<div class="no-move"></div>
			</div>

			<div class="box-content">
			
				<form class="form-horizontal" action="" method="POST">
				<input type="hidden" id="opcion" name="opcion" value="guardar">
				<input type="hidden" id="estado" name="estado">
				<input type="hidden" id="cliente_id" name="cliente_id">
		
				<div class="form-group">
					<label id="lnombre" for="nombre1" class="col-sm-4 control-label">Primer Nombre</label>
					<div class="col-sm-5"><input  id="nombre1" name="nombre1" type="text" class="form-control" title="Requerido" required/></div>				
				</div>
				<div class="form-group">
					<label for="nombre2" class="col-sm-4 control-label">Segundo Nombre</label>
					<div class="col-sm-5"><input id="nombre2" name="nombre2" type="text" class="form-control"/></div>
				</div>
				<div class="form-group">
					<label for="apellido1" class="col-sm-4 control-label">Primer Apellido</label>
					<div class="col-sm-5"><input id="apellido1" name="apellido1" type="text" class="form-control" title="Requerido" required/></div>
				</div>
				<div class="form-group">
					<label for="apellido2" class="col-sm-4 control-label">Segundo Apellido</label>
					<div class="col-sm-5"><input id="apellido2" name="apellido2" type="text" class="form-control" /></div>
				</div>
				<div class="form-group">
					<label for="cedula" class="col-sm-4 control-label">Cédula</label>
					<div class="col-sm-5"><input id="cedula" name="cedula" type="text" class="form-control" title="Requerido" required/></div>
				</div>
				<div class="form-group">
					<label for="celular" class="col-sm-4 control-label">Celular</label>
					<div class="col-sm-5"><input id="celular" name="celular" type="text" class="form-control" onkeypress="return valida(event)"/></div>
				</div>
				
				<div class="form-group">
						<div class="col-sm-offset-4 col-sm-3">
							<button type="button"
								class="btn btn-default btn-label-left btn-lg"
								onclick="cancelar()">
								<span><i class="fa fa-reply txt-danger"></i></span> Cancelar
							</button>
						</div>
						<div class="col-sm-4">
							<button type="submit" 
								class="btn btn-primary btn-label-left btn-lg" id="guardar">
								<span><i class="fa fa-save"></i></span> Guardar
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
		<div class="box" id="cuadro1">
			<div class="box-header">
				<div class="box-name text-center">
					<i class="fa fa-th"></i> <span>Lista de Clientes</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar2" class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a id="expandir2" class="expand-link"> <i class="fa fa-expand"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding table-responsive">
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="dt_cliente">
					<thead>
						<tr>
							<th>Nombre1</th>
							<th>Nombre2</th>
							<th>Apellido1</th>
							<th>Apellido2</th>
							<th>Cédula</th>
							<th>Celular</th>
							<th></th>	
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
	
	<form id="frmEliminarCliente" action="" method="POST">
		<input type="hidden" id="cliente_id" name="cliente_id" value="">
		<input type="hidden" id="opcion" name="opcion" value="eliminar">

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

	
	<script type="text/javascript">	
	
	//al hacer click al boton listar volver a llenar los datos en el dataTable
		//$("#btn_listar").on("click", function() {
	//		listar();//listar al presionar boton del formulario de registro
	//	});
	
	//verificar menu expandido
	//var expand = false;
	// Iniciar dataTables
	
	//funcion que permite solo numeros
	function valida(e){
    tecla = (document.all) ? e.keyCode : e.which;

    //Tecla de retroceso para borrar, siempre la permite
    if (tecla==8){
        return true;
    }    
    // Patron de entrada, en este caso solo acepta numeros
    patron =/[0-9]/;
    tecla_final = String.fromCharCode(tecla);
    return patron.test(tecla_final);
	}
	
	
		function abrirDialogo() {
			OpenModalBox(
					"<div><h3>Borrar Cliente</h3></div>",
					"<p Style='text-align: center;'>Esta seguro de borrar este cliente?</p>",
					"<div Style='text-align: center; margin-bottom: -10px;'>"+
					"<button type='button' id='eliminar_cliente' class='btn btn-primary'>Borrar </button>"
					+ "<button type='button' class='btn btn-secondary' Style='margin-left: 10px;' onclick='CloseModalBox()'> Cancelar</button>"
					+ "</div>");
			eliminar();//activar evento de eliminar
		}
		
	
	//metodo guardar donde activa el evento submit del formulario de registro
	var guardar = function() {
		$("form").on("submit", function(e) {
			e.preventDefault();//detiene el evento
			var frm = $(this).serialize();//parsea los datos del formulario
			console.log(frm);
			$.ajax({//enviar datos por ajax
			method:"POST",
			url:"./SL_Cliente",
			data: frm//datos a enviar
			}).done(function(info) {//informacion que el servlet le reenvia al jsp
			console.log(info);
			//var json_info = JSON.parse(info);
			//console.log(json_info);
			mostrar_mensaje(info);//se envia a verificar que mensaje respondioel servlet
			limpiar_texto();
			listar();//volver a listar datos
			
			});
		});
	}
	var limpiar_texto = function() {//limpiar texto del formulario
		$("#opcion").val("guardar");
		$("#nombre1").val("");
		$("#nombre2").val("");
		$("#apellido1").val("");
		$("#apellido2").val("");
		$("#cedula").val("");
		$("#celular").val("");
		//$("#estado").val("");
	}
	
	//activa evento para eliminar con el boton que esta oculto al usuario, este se activa en el evento onReady
	var eliminar = function() {
		$("#eliminar_cliente").on("click", function() {
			var cliente_id= $("#frmEliminarCliente #cliente_id").val();//se obtiene el id del usuario que esta oculto
			var opcion = $("#frmEliminarCliente #opcion").val();//se obtiene la opcion que esta oculta
			$.ajax({
				method:"POST",
				url:"./SL_Cliente",
				data: {"cliente_id":cliente_id, "opcion": opcion}//se envian los datos al servlet
			}).done(function(info) {
				mostrar_mensaje(info);
				listar();
			});
			console.log(opcion + ": " + cliente_id);
			CloseModalBox();
		});
		limpiar_texto();
	}
	
	var agregar_nuevo_usuario = function() {
		limpiar_texto();
// 		colapsar_desplegar($("#colapsar_desplegar2"));
// 		colapsar_desplegar($("#colapsar_desplegar1"));
// 		if(expand == false){
// 			expandir($("#expandir1"));
// 			expand = true;
// 		}
	}
	
	var cancelar = function() {
		limpiar_texto();
// 		if(expand == true){
// 			expandir($("#expandir1"));
// 			expand = false;
// 		}
// 		colapsar_desplegar($("#colapsar_desplegar1"));
// 		colapsar_desplegar($("#colapsar_desplegar2"));
	}
	
	//revise los mensaje que envian el guardar y eliminar (metodos)
	var mostrar_mensaje = function(info) {
		var text ="", color="";
		console.log("info: " + info.respuesta);
		if (info.respuesta =="BIEN"){//si la respuesta fue BIEN pasa el if y luego
			texto="<strong>Bien!</strong>, se guardaron los cambios correctamente";
			color = "#379911";
// 			console.log("cambiar esto en verResultado");
			alert("Se realizo la operación correctamente");
// 			location.reload();
// 			console.log("cambiar esto ahi mismo");
			
			limpiar_texto();
		}
		else if(info.respuesta =="ERROR"){
			texto="<strong>ERROR</strong>, no se ejecuto la consulta correctamente";
			color = "#C9302C";
		}else if(info.respuesta =="ACTUALIZADO"){//aqui se resive la respuesta del serverendpoint y todos las sesiones se actualizan
			texto="<strong>DATO ACTUALIZADOS</strong>, otro usuario ha actualizado la base de datos";
			color = "#ea8f1a";
			listar();//actulizar datos del datatable
		}else{
			texto="<strong>Opcion vacia!</strong>, opcion no solicitada";
			color = "#ddblld";
		}
		$(".mensaje").html(texto).css({"color":color});
		$(".mensaje").fadeOut(7000, function() {//se muestra el mensaje por un tiempo y luego se oculta
			$(this).fadeIn(5000);
			$(this).html("");
		});
	}

	//ejecutar el metodo DataTable para llenar el dataTable
		var listar = function() {
			console.log("cargando dataTable");
			var table = $("#dt_cliente").DataTable({
				"destroy":true,//para que se puede destruir los datos y recargarlos
				'bProcessing': false,
				'bServerSide': false,
				ajax: {
					"method":"GET",
					"url":"./SL_Cliente",
					"data": {
				        "carga": 1//para decirle al servlet que cargue consumos + cliente + contrato
				    },
				    "dataSrc":"aaData"
				},
				"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
				"language":idioma_esp,
				'bJQueryUI': true,
				'aoColumns': [
				    { 'mData': 'nombre1' },
				    { 'mData': 'nombre2' },
				    { 'mData': 'apellido1' },
				    { 'mData': 'apellido2' },
				    { 'mData': 'cedula' },
				    { 'mData': 'celular' },
				    {"defaultContent":"<button type='button' class='editar btn btn-primary'>"+//poner botones en cada fila
						"<i class='fa fa-pencil-square-o'></i>"+
						"</button>  "+
						"<button type='button' class='eliminar btn btn-danger' data-toggle='modal' data-target='#modalEliminar' >"+
						"<i class='fa fa-trash-o'></i>"+
						"</button>"}
				],
				"dom":"<rt><'row'<'form-inline' <'col-sm-12 text-center'B>>>"
					 +"<'row' <'form-inline' <'col-sm-6'l><'col-sm-6'f>>>"
					 +"<rt>"
					 +"<'row'<'form-inline'"
					 +"<'col-sm-6 col-md-6 col-lg-6'i><'col-sm-6 col-md-6 col-lg-6'p>>>",
	            "buttons":[{
					"text": "<i class='fa fa-user-plus'></i>",
					"titleAttr": "Agregar usuario",
					"className": "btn btn-success",
					"action": function() {
						agregar_nuevo_usuario();
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
			obtener_datos_editar("#dt_cliente tbody", table);//despues de llenar se manda a activar el evento clickde obtener
			obtener_id_eliminar("#dt_cliente tbody", table)//igual para el boton eliminar
		}	
	
	//activar el evento del boton actualizar que esta el las filas del dataTable
	var obtener_datos_editar = function(tbody, table) {
			$(tbody).on("click", "button.editar", function() {//activar evento click en boton actualizar que esta en el dataTable
				var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
				table.rows().every(function(index, loop, rowloop) {
					if(index == datos){
						console.log(table.row(index).data().cliente_id);
						var nombre1 = $("#nombre1").val(table.row(index).data().nombre1);
						var nombre2 = $("#nombre2").val(table.row(index).data().nombre2);
						var apellido1 = $("#apellido1").val(table.row(index).data().apellido1);
						var apellido2 = $("#apellido2").val(table.row(index).data().apellido2);
						var cedula = $("#cedula").val(table.row(index).data().cedula);
						var celular = $("#celular").val(table.row(index).data().celular)
						var estado = $("#estado").val(table.row(index).data().estado);;
						var cliente_id = $("#cliente_id").val(table.row(index).data().cliente_ID);
						var opcion = $("#opcion").val("actualizar");//settear datos en el formulario de edicion
					
					}
				});
			});
		}
		
	//activar evento del boton eliminar que esta en la fila seleccionada del dataTable
		var obtener_id_eliminar = function(tbody, table) {
			$(tbody).on("click", "button.eliminar", function() {
				var datos = table.row($(this).parents("tr")).data();//mismo evento para el boton eliminar
				console.log(datos);
				var cliente_id = $("#frmEliminarCliente #cliente_id").val(datos.cliente_ID);//solo se obtiene el id que es oculto
				abrirDialogo();
			});
		}
	
		function MakeSelect2() {
			$('select').select2();
		}
		function AllTables() {
			$.getScript('plugins/datatables/nuevo/jszip.min.js', function(){
				$.getScript('plugins/datatables/nuevo/pdfmake.min.js',function(){
					$.getScript('plugins/datatables/nuevo/vfs_fonts.js',function(){
						console.log("PDF Y EXCEL cargado");
						listar();
					});
				});
			});
			LoadSelect2Script(MakeSelect2);
		}
		//llamar a la funcio listar para que llene el dataTable
		$(document).ready(function(){
			LoadDataTablesScripts2(AllTables);
			guardar();//activar evento de guardar
		});
		
		function validarExpand() {
			if(expand == true)
				expand = false;
			else
				expand = true;
		}
		
	//cambiar idioma al dataTable
		var idioma_esp = {
			    "sProcessing":     "Procesando...",
			    "sLengthMenu":     "Mostrar _MENU_ registros",
			    "sZeroRecords":    "No se encontraron resultados",
			    "sEmptyTable":     "Ningún dato disponible en esta tabla",
			    "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
			    "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
			    "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
			    "sInfoPostFix":    "",
			    "sSearch":         "Buscar:",
			    "sUrl":            "",
			    "sInfoThousands":  ",",
			    "sLoadingRecords": "Cargando...",
			    "oPaginate": {
			        "sFirst":    "Primero",
			        "sLast":     "Último",
			        "sNext":     "Siguiente",
			        "sPrevious": "Anterior"
			    },
			    "oAria": {
			        "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
			        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
			    }
			}

	</script>
