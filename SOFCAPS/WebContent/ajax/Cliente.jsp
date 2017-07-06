<%@page language="java"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8" import="Entidades.*, Datos.*, java.sql.ResultSet;"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%
response.setHeader("Pragma", "No-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setDateHeader("Expires", -1);
%>
<%
	DT_Vw_rol_opciones dtvro = DT_Vw_rol_opciones.getInstance();

	Usuario us = new Usuario();
	us = (Usuario)session.getAttribute("userVerificado");
	
	Rol r = new Rol();
	r = (Rol)session.getAttribute("Rol");
	
	String url="";
	url = request.getRequestURI();
	//System.out.println("url: "+url);
	int index = request.getRequestURI().lastIndexOf("/");
	//System.out.println("index: "+index);
	String miPagina = request.getRequestURI().substring(index);
	//System.out.println("miPagina: "+miPagina);
	boolean permiso = false;
	String opcionActual = "";
	
	
	ResultSet rs;
	
	if(us != null && r != null)
	{
		rs=dtvro.obtenerOpc(r);
		while(rs.next())
		{
			opcionActual = rs.getString("opciones");
			System.out.println("opcionActual: "+opcionActual);
			if(opcionActual.equals(miPagina))
			{
				permiso = true;
				break;
			}
			else
			{
				permiso = false;
			}
		}
	}
	else
	{
		System.out.println("Pagina caps");
		response.sendRedirect("../CAPS.jsp");
		return;
	}
	
	if(!permiso)
	{	
		System.out.println("Pagina de error");
		response.sendRedirect("pag_Error.jsp");
	}
%>
<!--///////////////////////div donde se muestra un Dialogo /////////////////////////////// -->
<div id="dialogCli" class="col-xm-offset-1 col-xm-10">
	<div class="contenido" style="margin-left: 20px;"></div>
</div>
<!--///////////////////////Directorios donde estan los jsp /////////////////////////////// -->
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Gestión de Clientes</a></li>
			<li><a href="#">Clientes</a></li>
		</ol>
	</div>
</div>
<!--/////////////////////////////// DataTable de los clientes/////////////////////////////// -->
<div class="row">
	<div class="col-xs-12">
		<div class="box" id="cuadro1">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-th"></i> <span>Lista de Clientes</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar2" onclick="validar(colap2);" class="collapse-link"> 
						<i class="fa fa-chevron-up"></i></a> 
					<a id="expandir2" onclick="validar(expand2);" class="expand-link">
						<i class="fa fa-expand"></i></a>
					<a class="cerrar" title="Inhabilitado"> 
						<i class="fa fa-times"></i></a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding table-responsive">
				<div style="text-align: center;">
					<label Style='margin-top: 10px; margin-bottom: 10px;'> <input
						type="checkbox" id="mostrar_clientes" onclick="">MOSTRAR CLIENTES INACTIVOS
					</label>
				</div>
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="dt_cliente" style="width: 100%;">
					<thead>
						<tr>
							<th>Primer Nombre</th>
							<th>primer Apellido</th>
							<th>Cédula</th>
							<th>Acción</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!--/////////////////////////////// Formularios de Clientes/////////////////////////////// -->
<div class="row" id="formularioCliente" ><!-- style="display:none;" -->
	<div class="col-xs-12 col-sm-12">
		<div class="box" style="top: 0px; left: 0px; opacity: 1;">

			<div class="box-header">
				<div class="box-name">
					<i class="fa  fa-user"></i> <span>Formulario de Clientes</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar1" onclick="validar(colap1);" class="collapse-link"> 
						<i class="fa fa-chevron-up"></i></a> 
					<a id="expandir1" class="expand-link" onclick="validar(expand1);">
						<i class="fa fa-expand"></i></a>
					<a class="cerrar_formulario_cliente" onclick="cancelar();"> 
						<i class="fa fa-times"></i></a>
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
							<input id="celular" name="celular" type="text" max="99999999999"
								class="form-control" title="No requerido" data-bv-lessthan-message="Inválido"/>
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
<!--/////////////////////////////// Formalario y dialogo de eliminaciÃ³n/////////////////////////////// -->
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
<!--///////////////////////////// Formalario y dialogo de activaciÃ³n de clientes/////////////////////////////// -->
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
	var cedulaValid = "";///////////variable para validar si el usuario esta editando un registro 
	var expand1 = new Expand1();/////////////se crean los objetos que representan los botones de cada dialogo
	var colap1 = new Colap1();
	var expand2 = new Expand2();
	var colap2 = new Colap2();
////////////////////////////////Abrir dialogo para eliminar Cliente/////////////////////////////////////////////
	function abrirDialogo() {
		OpenModalBox(//modal(tutilo, contenido, foot)
				"<div><h3>Borrar Cliente</h3></div>",
				"<p Style='text-align:center; color:salmon; font-size:x-large;'>¿Esta seguro de borrar este cliente? <br />"+
						"Se borraran los contratos, consumos y facturas a nombre de este cliente</p>",
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
/////////////Metodo para limpiar el texto del formulario de clientes//////////////////////////////////77
	var limpiar_texto = function() {//limpiar texto del formulario
		$( "form #info" ).remove();
		$("#opcion").val("guardar");
		$("#nombre1").val("").prop('readonly', false);
		$("#nombre2").val("").prop('readonly', false);
		$("#apellido1").val("").prop('readonly', false);
		$("#apellido2").val("").prop('readonly', false);
		$("#cedula").val("").prop('readonly', false);
		$("#celular").val("").prop('readonly', false);
		$("form button#guardar").removeAttr('disabled');
		$("#defaultForm").data('bootstrapValidator').resetForm();////////////////resetear las validaciones
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
////////////////////////////////limpia el texto y valida los botones de control de dialogo/////////////////////////
	var agregar_nuevo_cliente = function() {
		document.getElementById('formularioCliente').style.display = 'block';
		//$("#expandir1").prop('disabled', true);
		limpiar_texto();
		validarExpand(expand1, "#expandir1");
		if (colap1.valor == false)
			validarColap(colap1, "#colapsar_desplegar1");
		validarColap(colap2, "#colapsar_desplegar2");
		if (expand2.valor == true)
			validarExpand(expand2, "#expandir2");
		
		$("#nombre1").focus();
	}
///////////////////////////////cancelar la accion sobre el cliente////////////////////////////////////////////////
	var cancelar = function() {
		limpiar_texto();
		document.getElementById('formularioCliente').style.display = 'none';
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
	var verResultado = function(r) {//parametro(resultado-String)
		if (r == "BIEN") {
			mostrarMensaje("#dialogCli", "CORRECTO",
					"¡Se realizó la acción correctamente, todo bien!","#d7f9ec", "btn-info");
			limpiar_texto();
			cargar_cliente();
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
var boton= 1;//varaible para validar si el check de activar clientes esta checkeado
/////////////////////////////////funsion que devuelve los botones dependiendo del check///////////////////////////
function botones() {
	if(boton ==1){
		return "<button type='button' class='visualizar btn btn-info' data-toggle='tooltip' "+
		"data-placement='top' title='Visualizar Registro'>"
		+"<i class='fa fa-info-circle'></i> </button>  "
		+"<button type='button' class='editar btn btn-primary' title='Editar Cliente'>"
		+"<i class='fa fa-pencil-square-o'></i>"
		+ "</button>  "
		+ "<button type='button' title='Eliminar Cliente' class='eliminar btn btn-danger' >"
		+ "<i class='fa fa-trash-o'></i>"
		+ "</button>";
	}else if(boton ==2){
		return "<button type='button' style='margin-left:15px;' class='activar btn btn-primary' title='activar cliente'>"
		+ "<i class='fa fa-upload'></i>"
		+ "</button>";
	}
}
////////////////////////////Ejecutar el metodo DataTable para llenar el dataTable con ajax///////////////////////////7
	var listar = function() {
		boton= 1;
		var table = $("#dt_cliente").DataTable({
			"destroy" : true,//para que se puede destruir los datos y recargarlos
			responsive : true,
			'bProcessing' : false,
			'bServerSide' : false,
			ajax : {
				"method" : "GET",
				"url" : "./SL_Cliente",
				"data" : {
					"carga" : boton//para decirle al servlet que cargue consumos + cliente + contrato
				},
				"dataSrc" : "aaData"
			},
			"lengthMenu" : [ [ 10, 25, 50, -1 ],[ 10, 25, 50, "Todo" ] ],
			"pageLength": 0,
			"language" : idioma_esp,
			drawCallback : function(settings) {
				var api = this.api();
				$('td', api.table().container()).find("button").tooltip({container : 'body'});
				$("a.btn").tooltip({container : 'body'});
			},
			'bJQueryUI' : true,
			'aoColumns' : [
				{'mData' : 'nombre1'},
				{'mData' : 'apellido1'},
				{'mData' : 'cedula'},
				{"mData" : null,
					render: function ( data, type, row ) {
	                	return botones;
	                }
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
							agregar_nuevo_cliente(); }
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
		table.page.len(0).draw();
		$('#dt_cliente_length').each( function() {
			$(this).find('label select').attr('disabled', 'disabled');
		});	
		$('#dt_cliente_filter').each( function() {
			$(this).find('label input[type=search]').on( 'keyup change', function () {
		    	if($(this).val() == ""){
		    		table.page.len(0).draw();
		    		$('#dt_cliente_length').each( function() {
		    			$(this).find('label select').attr('disabled', 'disabled');
		    		});
		    	}else{
		    		table.page.len(10).draw();
		    		$('#dt_cliente_length').each( function() {
		    			$(this).find('label select').removeAttr('disabled');
		    		});
		    	}
		    });	
		});
		obtener_datos_editar("#dt_cliente tbody", table);//despues de llenar se manda a activar el evento clickde obtener
		obtener_id_eliminar("#dt_cliente tbody", table)//igual para el boton eliminar
		obtener_datos_visualizar("#dt_cliente tbody", table)//igual para el boton visualizar
		obtener_id_activar("#dt_cliente tbody", $('#dt_cliente').DataTable());//igual para el boton activar
		$('.dataTables_filter').each(
			function() {
				$(this).find('label input[type=search]').attr('placeholder', 'Buscar registro');
		});
		$("#mostrar_clientes").change(function(){//evento que carga diferentes datos si el checkbox esta activo o no
	        if($(this).is(':checked')){
	        	boton= 2;
				document.getElementById('formularioCliente').style.display = 'none';
				cargar_cliente();
	        }else{
	        	boton= 1;
	        	//document.getElementById('cerrar').style.display = 'block';
	        	$('#dt_cliente').DataTable().ajax.reload();
	        }
		});
	}
//////////////////////////////////////metodo para llenar al dataTable con los clientes anulado////////////////////////
	var cargar_cliente = function() {
		console.log("Cargando DataTable para activaciÃ³n");
		$('#dt_cliente').DataTable().state.clear();
		$('#dt_cliente').DataTable().clear().draw();
		$.ajax({
	        type: "GET",
	        url: "./SL_Cliente",
	        data: {
		        "carga": boton//para decirle al servlet que cargue datos
		    },
	        success: function(response){
	        	$('#dt_cliente').DataTable().rows.add(response.aaData).draw();
	        }
		});
	}
/////////////////////////activar el evento del boton visualizar que esta el las filas del dataTable/////////////////
	var obtener_datos_visualizar = function(tbody, table) {defaultForm
		$(tbody).on("click","button.visualizar",function() {//activar evento click en boton actualizar que esta en el dataTable
			$( "form#defaultForm #info" ).remove();
			$("form#defaultForm").prepend("<h2 id='info' Style='color:#3276D7; text-align:center;'>Visualización del Registro</h2>");
			var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
			table.rows().every(function(index, loop, rowloop) {
				if (index == datos) {
					$("#nombre1").val(table.row(index).data().nombre1).prop('readonly', true);
					$("#nombre2").val(table.row(index).data().nombre2).prop('readonly', true);
					$("#apellido1").val(table.row(index).data().apellido1).prop('readonly', true);
					$("#apellido2").val(table.row(index).data().apellido2).prop('readonly', true);
					$("#cedula").val(table.row(index).data().cedula).prop('readonly', true);
					$("#celular").val(table.row(index).data().celular).prop('readonly', true);
					var estado = $("#estado").val(table.row(index).data().estado).prop('readonly', true);
					$("#cliente_id").val(table.row(index).data().cliente_ID);
					$("#opcion").val("visualizar");//settear datos en el formulario de visualizaciÃ³n
					$("form button#guardar").attr('disabled', 'disabled');
				}
			});
			document.getElementById('formularioCliente').style.display = 'block';
			validarExpand(expand1, "#expandir1");
			if (colap1.valor == false)
				validarColap(colap1, "#colapsar_desplegar1");
			validarColap(colap2, "#colapsar_desplegar2");
			if (expand2.valor == true)
				validarExpand(expand2, "#expandir2");
		});
	}
/////////////////////////activar el evento del boton actualizar que esta el las filas del dataTable/////////////////
	var obtener_datos_editar = function(tbody, table) {
		$(tbody).on("click","button.editar",function() {//activar evento click en boton actualizar que esta en el dataTable
			var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
			table.rows().every(function(index, loop, rowloop) {
				if (index == datos) {
					var nombre1 = $("#nombre1").val(table.row(index).data().nombre1);
					var nombre2 = $("#nombre2").val(table.row(index).data().nombre2);
					var apellido1 = $("#apellido1").val(table.row(index).data().apellido1);
					var apellido2 = $("#apellido2").val(table.row(index).data().apellido2);
					var cedula = $("#cedula").val(table.row(index).data().cedula);
					cedulaValid = cedula.val();
					
					var celular = $("#celular").val(table.row(index).data().celular);
					var estado = $("#estado").val(table.row(index).data().estado);
					var cliente_id = $("#cliente_id").val(table.row(index).data().cliente_ID);
					var opcion = $("#opcion").val("actualizar");//settear datos en el formulario de edicion
				}
			});
			document.getElementById('formularioCliente').style.display = 'block';
			validarExpand(expand1, "#expandir1");
			if (colap1.valor == false)
				validarColap(colap1, "#colapsar_desplegar1");
			validarColap(colap2, "#colapsar_desplegar2");
			if (expand2.valor == true)
				validarExpand(expand2, "#expandir2");
		});
	}
/////////////////////////activar evento del boton eliminar que esta en la fila seleccionada del dataTable///////////
	var obtener_id_eliminar = function(tbody, table) {//parametros(id_tabla, objeto dataTable)
		$(tbody).on("click","button.eliminar",function() {
			var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
			table.rows().every(function(index, loop, rowloop) {
				if (index == datos) {
					var cliente_id = $("#frmEliminarCliente #cliente_id").val(table.row(index).data().cliente_ID);
				}
			});
			abrirDialogo();
		});
	}
///////////////////////////////Activa el evento cuando de click al boton activar cliente del dataTable////////////////7
	var obtener_id_activar = function(tbody, table) { //parametros(id_tabla, objeto dataTable)
		$(tbody).on("click","button.activar",function() {
			var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
			table.rows().every(function(index, loop, rowloop) {
				if (index == datos) {
					var cliente_id = $("#frmActivarCliente #cliente_id").val(table.row(index).data().cliente_ID);
				}
			});
			abrirDialogo2();
		});
	}
/////////////////////cargar plugin de dataTables y llamar a la funcion listar()//////////////////////////////////7
	function AllTables() {
		$.getScript('plugins/datatables/nuevo/jszip.min.js', function() {
			$.getScript('plugins/datatables/nuevo/pdfmake.min.js', function() {
				$.getScript('plugins/datatables/nuevo/vfs_fonts.js',function() {
					listar();
					LoadSelect2Script(MakeSelect2);
				});
			});
		});
	}

/////////////////////////////////////////FUNSIÃ“N PRINCIPAL/////////////////////////////////////////////
	$(document).ready(function() {
		/////////cargar plugin para validaciones de bootstrap
		LoadBootstrapValidatorScript(formValidCli);
		
		///////cargar plugin para DataTable
		LoadDataTablesScripts2(AllTables);
		
		//validarColap(colap1, "#colapsar_desplegar1");
		
		// Add drag-n-drop feature to boxes
		WinMove();
		
		$('.form-control').tooltip();
	});
/////////////////////////////////////////valida el formulario de los clientes////////////////////////////////////////
	function formValidCli() {
		$('#defaultForm').bootstrapValidator({
			message : '¡Este valor no es valido!',
			fields : {
				cedula : {
					validators : {
						stringLength: {
							max: 18,
							message: '¡Este campo solo permite 18 caracteres!'
						},
						notEmpty : {
							message : "¡Este campo es requerido y no debe estar vacio!"
						},
						regexp: {
							regexp: /^[0-9]{3}(-)[0-9]{6}(-)[0-9]{4}[a-zA-Z]$/,
							message: '¡Este campo solo acepta el formato de la Cédula!'
		                },
						callback : {
							message : '¡Este campo no debe ser igual a los otros registros!',
							callback : function(value,validator, $field) {
								if(cedulaValid == value){
									return true;
								}
								var tabla = $('#dt_cliente').DataTable();
								var filas = tabla.rows();
								var noigual = true;
								filas.every(function(index,loop, rowloop) {
									if (value == tabla.row(index).data().cedula) {
										noigual = false;
									}
								});
								return noigual;
							}
						}
					}
				},
				nombre1 : {
					validators : {
						stringLength: {
							max: 50,
							message: '¡Este campo solo permite 50 caracteres!'
						},
						notEmpty : {
							message : "¡Este campo es requerido y no debe estar vacio!"
						},
						regexp: {
							regexp: /^[a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/,
							message: '¡Este campo no acepta espacios en blanco ni caracteres especiales!'
	                    }
					}
				},
				nombre2 : {
					validators : {
						stringLength: {
							max: 50,
							message: '¡Este campo solo permite 50 caracteres!'
						},
						regexp: {
							regexp: /^[a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/,
							message: '¡Este campo no acepta espacios en blanco ni caracteres especiales!'
	                    }
					}
				},
				apellido1 : {
					validators : {
						stringLength: {
							max: 50,
							message: '¡Este campo solo permite 50 caracteres!'
						},
						notEmpty : {
							message : "¡Este campo es requerido y no debe estar vacio!"
						},
						regexp: {
							regexp: /^[a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/,
							message: '¡Este campo no acepta espacios en blanco ni caracteres especiales!'
	                    }
					}
				},
				apellido2 : {
					validators : {
						stringLength: {
							max: 50,
							message: '¡Este campo solo permite 50 caracteres!'
						},
						regexp: {
							regexp: /^[a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/,
							message: '¡Este campo no acepta espacios en blanco ni caracteres especiales!'
	                    }
					}
				},
				celular:{
					validators : {
						digits:{
							message : "¡Este campo solo acepta números!"
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
				method : "POST",
				url : "./SL_Cliente",
				data : frm//datos a enviar
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
            
        });
	}
	
</script>

