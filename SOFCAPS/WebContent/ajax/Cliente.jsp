	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<div class="row fondo">
		<div class="col-sm-12 col-md-12 col-lg-12">
			<h1 class="text-center text-uppercase">Clientes</h1>
		</div>
	</div>
	
	<div class="row">
		<div id="cuadro2" class="col-sm-12 col-md-12 col-lg-12">
			<form class="form-horizontal" action="" method="POST">
				<div class="form-group">
					<h3 class="col-sm-offset-2 col-sm-8 text-center">					
					Formulario de Registro de Clientes</h3>
				</div>
				<input type="hidden" id="opcion" name="opcion" value="guardar">
				<input type="hidden" id="estado" name="estado">
				<input type="hidden" id="cliente_id" name="cliente_id">
				<div class="form-group">
					<label for="nombre1" class="col-sm-2 control-label">Primer Nombre</label>
					<div class="col-sm-8"><input id="nombre1" name="nombre1" type="text" class="form-control"  autofocus></div>				
				</div>
				<div class="form-group">
					<label for="nombre2" class="col-sm-2 control-label">Segundo Nombre</label>
					<div class="col-sm-8"><input id="nombre2" name="nombre2" type="text" class="form-control" ></div>
				</div>
				<div class="form-group">
					<label for="apellido1" class="col-sm-2 control-label">Primer Apellido</label>
					<div class="col-sm-8"><input id="apellido1" name="apellido1" type="text" class="form-control" ></div>
				</div>
				<div class="form-group">
					<label for="apellido2" class="col-sm-2 control-label">Segundo Apellido</label>
					<div class="col-sm-8"><input id="apellido2" name="apellido2" type="text" class="form-control" ></div>
				</div>
				<div class="form-group">
					<label for="cedula" class="col-sm-2 control-label">Cédula</label>
					<div class="col-sm-8"><input id="cedula" name="cedula" type="text" class="form-control" ></div>
				</div>
				<div class="form-group">
					<label for="celular" class="col-sm-2 control-label">Celular</label>
					<div class="col-sm-8"><input id="celular" name="celular" type="text" class="form-control" ></div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-8">
						<input id="" type="submit" class="btn btn-primary" value="Guardar">
						<input id="btn_listar" type="button" class="btn btn-primary" value="Listar">
					</div>
				</div>
			</form>
			<div class="col-sm-offset-2 col-sm-8">
				<p class="mensaje"></p>
			</div>
			
		</div>
	</div>
	<div class="row">
		<div id="cuadro1" class="col-sm-12 col-md-12 col-lg-12">
			<div class="col-sm-offset-2 col-sm-8">
				<h3 class="text-center"> <small class="mensaje"></small></h3>
			</div>
			<div class="table-responsive col-sm-12">		
				<table id="dt_cliente" class="table table-bordered table-hover table-striped table-heading table-datatable" cellspacing="0" width="100%">
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
	<div>
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
</div>
	
	<script type="text/javascript">	
	
	//al hacer click al boton listar volver a llenar los datos en el dataTable
		$("#btn_listar").on("click", function() {
			listar();//listar al presionar boton del formulario de registro
		});
	
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
	}
	
	//revise los mensaje que envian el guardar y eliminar (metodos)
	var mostrar_mensaje = function(info) {
		var text ="", color="";
		console.log("info: " + info.respuesta);
		if (info.respuesta =="BIEN"){//si la respuesta fue BIEN pasa el if y luego
			texto="<strong>Bien!</strong>, se guardaron los cambios correctamente";
			color = "#379911";
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
			var table = $("#dt_cliente").DataTable({
				"destroy":true,//para que se puede destruir los datos y recargarlos
				'bProcessing': false,
				'bServerSide': false,
				ajax: {
					"method":"GET",
					"url":"./SL_Cliente"
				},
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
				"language":idioma_esp,//cambiar el lenguaje a español
				"dom": "Bfrtip",//boton para agregar
				"buttons":[{
					"text": "<i class='fa fa-user-plus'></i>",
					"titleAttr": "Agregar cliente",
					"action": function() {
						agregar_nuevo_usuario();//llamar el metodo agregar que muestra el formulario
					}
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
