<%@page language="java"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<div id="dialogCli" class="col-xm-offset-1 col-xm-10">
	<div class="contenido" style="margin-left: 20px;"></div>
</div>
<!--///////////////////////Directorios donde estan los jsp ///////////////////////////////777 -->
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Gestión de Clientes</a></li>
			<li><a href="#">Clientes</a></li>
		</ol>
	</div>
</div>
<!--/////////////////////////////// Formularios de Clientes/////////////////////////////// -->
<div class="row" id="cerrar">
	<div class="col-xs-12 col-sm-12">
		<div class="box" style="top: 0px; left: 0px; opacity: 1;">

			<div class="box-header">
				<div class="box-name">
					<i class="fa  fa-user"></i> <span>Registrar Nuevo Cliente</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar1" onclick="validar(colap1);"
						class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a id="expandir1" onclick="validar(expand1);" class="expand-link">
						<i class="fa fa-expand"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>

			<!-- 			Contenido del formulario -->
			<div class="box-content">
				<form data-toggle="validator" role="form" class="form-horizontal"
					action="" method="POST" id="defaultForm">
					<input type="hidden" id="opcion" name="opcion" value="guardar">
					<input type="hidden" id="estado" name="estado"> <input
						type="hidden" id="cliente_id" name="cliente_id">

					<div class="form-group">
						<label id="lnombre" for="nombre1" class="col-sm-4 control-label">Primer
							Nombre</label>
						<div class="col-sm-5">
							<input id="nombre1" name="nombre1" type="text"
								class="form-control" title="Requerido" required />
						</div>
					</div>
					<div class="form-group">
						<label for="nombre2" class="col-sm-4 control-label">Segundo
							Nombre</label>
						<div class="col-sm-5">
							<input id="nombre2" name="nombre2" type="text"
								class="form-control" title="No requerido" />
						</div>
					</div>
					<div class="form-group">
						<label for="apellido1" class="col-sm-4 control-label">Primer
							Apellido</label>
						<div class="col-sm-5">
							<input id="apellido1" name="apellido1" type="text"
								class="form-control" title="Requerido" required />
						</div>
					</div>
					<div class="form-group">
						<label for="apellido2" class="col-sm-4 control-label">Segundo
							Apellido</label>
						<div class="col-sm-5">
							<input id="apellido2" name="apellido2" type="text"
								class="form-control" title="No requerido" />
						</div>
					</div>
					<div class="form-group">
						<label for="cedula" class="col-sm-4 control-label">Cédula</label>
						<div class="col-sm-5">
							<input id="cedula" name="cedula" type="text" class="form-control"
								title="Requerido" required />
						</div>
					</div>
					<div class="form-group">
						<label for="celular" class="col-sm-4 control-label">Celular</label>
						<div class="col-sm-5">
							<input id="celular" name="celular" type="text"
								class="form-control" title="No requerido" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-3">
							<button type="submit"
								class="btn btn-primary btn-label-left btn-lg" id="guardar">
								<span><i class="fa fa-save"></i></span> Guardar
							</button>
						</div>
						<div class="col-sm-4">
							<button type="button"
								class="btn btn-default btn-label-left btn-lg"
								onclick="cancelar()">
								<span><i class="fa fa-reply txt-danger"></i></span> Cancelar
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
					<a id="colapsar_desplegar2" onclick="validar(colap2);" class="collapse-link"> 
						<i class="fa fa-chevron-up"></i>
					</a> 
					<a id="expandir2" onclick="validar(expand2);" class="expand-link">
						<i class="fa fa-expand"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding table-responsive">
				<div style="text-align: center;">
					<label Style='margin-top: 10px; margin-bottom: 10px;'> <input
						type="checkbox" id="mostrar_clientes" onclick="listar()">MOSTRAR CLIENTES INACTIVOS
					</label>
				</div>
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="dt_cliente" style="width: 100%;">
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
					<a class="close-link"> <i class="fa fa-times"></i> </a>
				</div>
			</div>
			<div class="devoops-modal-inner"></div>
			<div class="devoops-modal-bottom"></div>
		</div>
	</div>
</form>

<form id="frmActivarCliente" action="" method="POST">
	<input type="hidden" id="cliente_id" name="cliente_id" value="">
	<input type="hidden" id="opcion" name="opcion" value="activar">
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
	var expand1 = new Expand1();/////////////se crean los objetos que representan los botones de cada dialogo
	var colap1 = new Colap1();
	var expand2 = new Expand2();
	var colap2 = new Colap2();

///////////////////7//Abrir dialogo para eliminar Cliente/////////////////////////////////////////////
	function abrirDialogo() {
		OpenModalBox(//modal(tutilo, contenido, foot)
				"<div><h3>Borrar Cliente</h3></div>",
				"<p Style='text-align:center; color:salmon; font-size:x-large;'>¿Esta seguro de borrar este cliente?</p>",
				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-2 col-md-3'> "
						+ "<button type='button' id='eliminar_cliente' class='btn btn-danger btn-label-left'"
						+" style='color:#ece1e1;' >"
						+ "<span><i class='fa fa-trash-o'></i></span>Eliminar cliente </button>"
						+ "<div style='margin-top: 5px;'></div>"
						+ "</div> <div class='col-sm-12 col-md-offset-1 col-md-3 text-center' Style='margin-bottom: -10px;'>"
						+ "<button type='button' class='btn btn-default btn-label-left' Style='margin-left: 10px;' onclick='CloseModalBox()'>"
						+ "<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
		eliminar();//activar evento de eliminar
	}
///////////////////Modal para Reactivar el Cliente eliminado o dado de baja///////////////////////////////
	function abrirDialogo2() {
		OpenModalBox(
				"<div><h3>Reactivar Cliente</h3></div>",
				"<p Style='text-align:center; color:blue; font-size:x-large;'>¿Esta seguro de volver a reactivar este cliente?</p>",
				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-2 col-md-3'> "
						+ "<button type='button' id='activar_cliente' class='btn btn-primary btn-label-left'"
						+" style='color:#ece1e1;' >"
						+ "<span><i class='fa fa-user'></i></span>Activar cliente </button>"
						+ "<div style='margin-top: 5px;'></div>"
						+ "</div> <div class='col-sm-12 col-md-offset-1 col-md-3 text-center' Style='margin-bottom: -10px;'>"
						+ "<button type='button' class='btn btn-default btn-label-left' Style='margin-left: 10px;' onclick='CloseModalBox()'>"
						+ "<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
		activar();//activar evento para que el cliente sea activo otra vez
	}

////////////metodo guardar donde activa el evento submit del formulario de registro////////////////////////
	var guardar = function() {
		$("#defaultForm").on("submit", function(e) {
			e.preventDefault();//detiene el evento
			var frm = $(this).serialize();//parsea los datos del formulario
			console.log(frm);
			if($(this).find("#nombre1").val()!="" && $(this).find("#apellido1").val()!="" 
					&& $(this).find("#cedula").val() !=""){
				$.ajax({//enviar datos por ajax
					method : "POST",
					url : "./SL_Cliente",
					data : frm
				//datos a enviar
				}).done(function(info) {//informacion que el servlet le reenvia al jsp
					console.log(info);
					if (expand1.valor == true)
						validarExpand(expand1, "#expandir1");

					if (expand2.valor == true)
						validarExpand(expand2, "#expandir2");

					validarColap(colap1, "#colapsar_desplegar1");
					if (colap2.valor == true) {
					} else {
						validarColap(colap2, "#colapsar_desplegar2");
					}
					verResultado(info);//se envia a verificar que mensaje respondioel servlet
				});
			}
		});
	}
/////////////Metodo para limpiar el texto del formulario de clientes//////////////////////////////////77
	var limpiar_texto = function() {//limpiar texto del formulario
		$("#opcion").val("guardar");
		$("#nombre1").val("");
		$("#nombre2").val("");
		$("#apellido1").val("");
		$("#apellido2").val("");
		$("#cedula").val("");
		$("#celular").val("");

	}

/////////////Metdoo que activa evento para eliminar con el boton que esta oculto al usuario,/////////////////////// 
//////////////////////este metodo se activa al abrir el dialogo con metodo abrirDialogo() para eliminar al cliente//////////////////////////////
	var eliminar = function() {
		$("#eliminar_cliente").on("click", function() {
			var cliente_id = $("#frmEliminarCliente #cliente_id").val();//se obtiene el id del usuario que esta oculto
			var opcion = $("#frmEliminarCliente #opcion").val();//se obtiene la opcion que esta oculta
			$.ajax({
				method : "POST",
				url : "./SL_Cliente",
				data : {
					"cliente_id" : cliente_id,
					"opcion" : opcion
				}
			//se envian los datos al servlet
			}).done(function(info) {
				verResultado(info);
			});
			console.log(opcion + ": " + cliente_id);
			CloseModalBox();
		});
		limpiar_texto();
	}
	
//////////////////metodo para activar el cliente a la base de datos///////////////////////////////////////////
	var activar = function() {
		$("#activar_cliente").on("click", function() {
			var cliente_id = $("#frmActivarCliente #cliente_id").val();//se obtiene el id del usuario que esta oculto
			var opcion = $("#frmActivarCliente #opcion").val();//se obtiene la opcion que esta oculta
			$.ajax({
				method : "POST",
				url : "./SL_Cliente",
				data : {
					"cliente_id" : cliente_id,
					"opcion" : opcion
				}
			//se envian los datos al servlet
			}).done(function(info) {
				verResultado(info);
			});
			console.log(opcion + ": " + cliente_id);
			CloseModalBox();
		});
	}
////////////////////////////////limpia el texto y valida los botones de control de dialogo/////////////////////////
	var agregar_nuevo_cliente = function() {
		limpiar_texto();
		validarExpand(expand1, "#expandir1");
		if (colap1.valor == false)
			validarColap(colap1, "#colapsar_desplegar1");
		validarColap(colap2, "#colapsar_desplegar2");
		if (expand2.valor == true)
			validarExpand(expand2, "#expandir2");

	}
///////////////////////////////cancelar la accion sobre el cliente/////////////////////////////////////////////777
	var cancelar = function() {
		limpiar_texto();
		if (expand1.valor == true)
			validarExpand(expand1, "#expandir1");

		if (expand2.valor == true)
			validarExpand(expand2, "#expandir2");

		validarColap(colap1, "#colapsar_desplegar1");
		if (colap2.valor == true) {
		} else {
			validarColap(colap2, "#colapsar_desplegar2");
		}
	}
////////////////////////metodo que muestra un dialogo del resultado de la operacion/////////////////////////////////
	var verResultado = function(r) {
		if (r == "BIEN") {
			mostrarMensaje("#dialogCli", "CORRECTO",
					"¡Se realizó la acción correctamente, todo bien!","#d7f9ec", "btn-info");
			limpiar_texto();
			$('#dt_cliente').DataTable().ajax.reload();
		}
		if (r == "ERROR") {
			mostrarMensaje("#dialogCli", "ERROR",
					"¡Ha ocurrido un error, no se pudo realizar la acción!","#E97D7D", "btn-danger");
		}
		if (r == "VACIO") {
			mostrarMensaje("#dialogCli", "VACIO",
					"¡No se especificó la acción a realizar!", "#FFF8A7","btn-warning");
		}
	}

////////////////////////////Ejecutar el metodo DataTable para llenar el dataTable con ajax///////////////////////////7
	var listar = function() {
		console.log("cargando dataTable");
		if (document.getElementById("mostrar_clientes").checked == false) {//valida si el usuario no ha tocado el checxbox
			document.getElementById('cerrar').style.display = 'inline';
			var table = $("#dt_cliente").DataTable({
				"destroy" : true,//para que se puede destruir los datos y recargarlos
				responsive : true,
				'bProcessing' : false,
				'bServerSide' : false,
				ajax : {
					"method" : "GET",
					"url" : "./SL_Cliente",
					"data" : {
						"carga" : 1
						//para decirle al servlet que cargue consumos + cliente + contrato
					},
					"dataSrc" : "aaData"
				},
				"lengthMenu" : [ [ 10, 25, 50, -1 ],[ 10, 25, 50, "Todo" ] ],
				"language" : idioma_esp,
				drawCallback : function(settings) {
					var api = this.api();
					$('td', api.table().container()).find("button").tooltip({container : 'body'});
						$("a.btn").tooltip({container : 'body'});
				},
				'bJQueryUI' : true,
				'aoColumns' : [
					{'mData' : 'nombre1'},
					{'mData' : 'nombre2'},
					{'mData' : 'apellido1'},
					{'mData' : 'apellido2'},
					{'mData' : 'cedula'},
					{'mData' : 'celular'},
					{"defaultContent" : "<button type='button' class='editar btn btn-primary' title='editar Cliente'>" //poner botones en cada fila
						+"<i class='fa fa-pencil-square-o'></i>"
						+ "</button>  "
						+ "<button type='button' title='eliminar Cliente' class='eliminar btn btn-danger' >"
						+ "<i class='fa fa-trash-o'></i>"
						+ "</button>"
					}],
					"dom" : "<rt><'row'<'form-inline' <'col-sm-12 text-center'B>>>"
							+ "<'row' <'form-inline' <'col-sm-6'l><'col-sm-6'f>>>"
							+ "<rt>"
							+ "<'row'<'form-inline'"
							+ "<'col-sm-6 col-md-6 col-lg-6'i><'col-sm-6 col-md-6 col-lg-6'p>>>",
					"buttons" : [
						{
							"text" : "<i class='fa fa-user-plus'></i>",
							"titleAttr" : "Agregar Cliente",
							"className" : "btn btn-success",
							"action" : function() {
											agregar_nuevo_cliente();
										}
						},
						{
							extend : 'excelHtml5',
							text : '<i class="fa fa-file-excel-o"></i>',
							titleAttr : 'excel'
						},
						{
							extend : 'csvHtml5',
							text : '<i class="fa fa-file-text-o"></i>',
							titleAttr : 'csv'
						},
						{
							extend : 'pdfHtml5',
							text : '<i class="fa fa-file-pdf-o"></i>',
							titleAttr : 'pdf'
						} ]
			});
			obtener_datos_editar("#dt_cliente tbody", table);//despues de llenar se manda a activar el evento clickde obtener
			obtener_id_eliminar("#dt_cliente tbody", table)//igual para el boton eliminar
			$('.dataTables_filter').each(
				function() {
					$(this).find('label input[type=search]').attr('placeholder', 'Buscar');
			});
		}else {
			document.getElementById('cerrar').style.display = 'none';
			cargar_activar_cliente();
		}
	}
//////////////////////////////////////metodo para llenar al dataTable con los clientes anulado////////////////////////
	var cargar_activar_cliente = function() {
		console.log("cargando dataTable");
		var table = $("#dt_cliente").DataTable({
			"destroy" : true,//para que se puede destruir los datos y recargarlos
			responsive : true,
			'bProcessing' : false,
			'bServerSide' : false,
			ajax : {
				"method" : "GET",
				"url" : "./SL_Cliente",
				"data" : {
					"carga" : 2
				//para decirle al servlet que cargue consumos + cliente + contrato
				},
				"dataSrc" : "aaData"
			},
			"lengthMenu" : [ [ 10, 25, 50, -1 ],[ 10, 25, 50, "Todo" ] ],
			"language" : idioma_esp,
			drawCallback : function(settings) {
				var api = this.api();
				$('td', api.table().container()).find("button").tooltip({container : 'body'	});
				$("a.btn").tooltip({container : 'body'});
			},
			'bJQueryUI' : true,
			'aoColumns' : [
				{'mData' : 'nombre1'},
				{'mData' : 'nombre2'},
				{'mData' : 'apellido1'},
				{'mData' : 'apellido2'},
				{'mData' : 'cedula'},
				{'mData' : 'celular'},
				{'defaultContent' : "<button type='button' style='margin-left:15px;' class='activar btn btn-primary' title='activar cliente'>"
					+ "<i class='fa fa-upload'></i>"
					+ "</button>"}
			],
			"dom" : "<rt><'row'<'form-inline' <'col-sm-12 text-center'B>>>"
				+ "<'row' <'form-inline' <'col-sm-6'l><'col-sm-6'f>>>"
				+ "<rt>"
				+ "<'row'<'form-inline'"
				+ "<'col-sm-6 col-md-6 col-lg-6'i><'col-sm-6 col-md-6 col-lg-6'p>>>",
			"buttons" : [
					{
						extend : 'excelHtml5',
						text : '<i class="fa fa-file-excel-o"></i>',
						titleAttr : 'excel'
					}, 
					{
						extend : 'csvHtml5',
						text : '<i class="fa fa-file-text-o"></i>',
						titleAttr : 'csv'
					}, 
					{
						extend : 'pdfHtml5',
						text : '<i class="fa fa-file-pdf-o"></i>',
						titleAttr : 'pdf'
					}]
		});
		obtener_id_activar("#dt_cliente tbody", table);
		$('.dataTables_filter').each(
			function() {
				$(this).find('label input[type=search]').attr('placeholder', 'Buscar');
		});
	}
/////////////////////////activar el evento del boton actualizar que esta el las filas del dataTable/////////////////
	var obtener_datos_editar = function(tbody, table) {
		$(tbody).on("click","button.editar",function() {//activar evento click en boton actualizar que esta en el dataTable
			var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
			table.rows().every(function(index, loop, rowloop) {
				if (index == datos) {
					console.log(table.row(index).data().cliente_ID);
					var nombre1 = $("#nombre1").val(table.row(index).data().nombre1);
					var nombre2 = $("#nombre2").val(table.row(index).data().nombre2);
					var apellido1 = $("#apellido1").val(table.row(index).data().apellido1);
					var apellido2 = $("#apellido2").val(table.row(index).data().apellido2);
					var cedula = $("#cedula").val(table.row(index).data().cedula);
					var celular = $("#celular").val(table.row(index).data().celular);
					var estado = $("#estado").val(table.row(index).data().estado);
					var cliente_id = $("#cliente_id").val(table.row(index).data().cliente_ID);
					var opcion = $("#opcion").val("actualizar");//settear datos en el formulario de edicion
				}
			});
			validarExpand(expand1, "#expandir1");
			if (colap1.valor == false)
				validarColap(colap1, "#colapsar_desplegar1");
			validarColap(colap2, "#colapsar_desplegar2");
			if (expand2.valor == true)
				validarExpand(expand2, "#expandir2");

		});
	}

/////////////////////////activar evento del boton eliminar que esta en la fila seleccionada del dataTable///////////
	var obtener_id_eliminar = function(tbody, table) {
		$(tbody).on("click","button.eliminar",function() {
			var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
			table.rows().every(function(index, loop, rowloop) {
				if (index == datos) {console.log(table.row(index).data().cliente_id);
					var cliente_id = $("#frmEliminarCliente #cliente_id").val(table.row(index).data().cliente_ID);
				}
			});
			abrirDialogo();
		});
	}
///////////////////////////////Activa el evento cuando de click al boton activar cliente del dataTable////////////////7
	var obtener_id_activar = function(tbody, table) {
		$(tbody).on("click","button.activar",function() {var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
			table.rows().every(function(index, loop, rowloop) {
				if (index == datos) {console.log(table.row(index).data().cliente_id);
					var cliente_id = $("#frmActivarCliente #cliente_id").val(table.row(index).data().cliente_ID);
				}
			});
			abrirDialogo2();
		});
	}

	function MakeSelect2() {
		$('select').select2();
	}
/////////////////////cargar plugin de dataTables y llamar a la funcion listar()//////////////////////////////////7
	function AllTables() {
		$.getScript('plugins/datatables/nuevo/jszip.min.js', function() {
			$.getScript('plugins/datatables/nuevo/pdfmake.min.js', function() {
				$.getScript('plugins/datatables/nuevo/vfs_fonts.js',function() {
					console.log("PDF Y EXCEL cargado");
					listar();
				});
			});
		});
		LoadSelect2Script(MakeSelect2);
	}

////////////////////////////llamar a la funcio listar para que llene el dataTable//////////////////////////////
	$(document).ready(function() {
		$('#mensaje_info').hide();
		LoadBootstrapValidatorScript(formValidCli);
		LoadDataTablesScripts2(AllTables);
		validarColap(colap1, "#colapsar_desplegar1");
		$('.form-control').tooltip();
		guardar();
	});
/////////////////////////////////////////valida el formulario de los clientes////////////////////////////////////////
	function formValidCli() {
		$('#defaultForm').bootstrapValidator({
			message : 'Este valor no es valido',
			fields : {
				cedula : {
					validators : {
						notEmpty : {
							message : "Este campo es requerido y no debe estar vacio"
							},
							regexp: {
								regexp: /^[0-9]{3}(-)[0-9]{6}(-)[0-9]{4}[a-zA-Z]$/,
								message: 'Este campo solo acepta el formato de la Cédula'
		                    },
						callback : {
							message : 'Este campo no debe ser igual a los otros registros',
							callback : function(value,validator, $field) {
								if($('#defaultForm #opcion').val()!="actualizar"){
									var tabla = $('#dt_cliente').DataTable();
									var filas = tabla.rows();
									var noigual = true;
									filas.every(function(index,loop, rowloop) {
										if (value == tabla.row(index).data().cedula) {
											noigual = false;
										}
									});
									return noigual;
								}else{
									return true;
								}
							}
						}
					}
				},
				nombre1 : {
					validators : {
						notEmpty : {
							message : "Este campo es requerido y no debe estar vacio"
						},
						regexp: {
							regexp: /^[a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/,
							message: 'Este campo no acepta espacios en blanco'
	                    }
					}
				},
				nombre2 : {
					validators : {
						regexp: {
							regexp: /^[a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/,
							message: 'Este campo no acepta espacios en blanco'
	                    }
					}
				},
				apellido1 : {
					validators : {
						notEmpty : {
							message : "Este campo es requerido y no debe estar vacio"
						},
						regexp: {
							regexp: /^[a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/,
							message: 'Este campo no acepta espacios en blanco'
	                    }
					}
				},
				apellido2 : {
					validators : {
						regexp: {
							regexp: /^[a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/,
							message: 'Este campo no acepta espacios en blanco'
	                    }
					}
				},
				celular:{
					validators : {
						digits:{
							message : "Este campo solo acepta números"
						}
					}
				}
			}
		});
	}
	
</script>
