<%@page language="java"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8" import="Entidades.Usuario, Entidades.Rol, Datos.DT_Vw_rol_opciones, java.sql.ResultSet ;"%>
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
	
	
	ResultSet resultset;
	
	if(us != null && r != null)
	{
		resultset=dtvro.obtenerOpc(r);
		while(resultset.next())
		{
			opcionActual = resultset.getString("opciones");
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
<!--///////////////////////Directorios donde estan los jsp ///////////////////////////////777 -->
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Usuarios</a></li>
			<li><a href="#">Gestión de usuarios</a></li>
		</ol>
	</div>
</div>
<!--/////////////////////////////// DataTable de los usuarios/////////////////////////////// -->
<div class="row">
	<div class="col-xs-12">
		<div class="box" id="cuadro1">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-th"></i> <span>Lista de Usuarios</span>
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
						type="checkbox" id="mostrar_usuarios">MOSTRAR USUARIOS INACTIVOS
					</label>
				</div>
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="dt_usuario" style="width: 100%;">
					<thead>
						<tr>
							<th>Nombre</th>
							<th>Login</th>
							<th>Password</th>
							<th>Acción</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!--/////////////////////////////// Formularios de Clientes/////////////////////////////// -->
<div class="row" id="formularioUsuario" style="display:none;">
	<div class="col-xs-12 col-sm-12">
		<div class="box" style="top: 0px; left: 0px; opacity: 1;">

			<div class="box-header">
				<div class="box-name">
					<i class="fa  fa-user"></i> <span>Formulario de usuarios</span>
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
					<input type="hidden" id="usuario_id" name="usuario_id">
					
					<div class="form-group">
						<label id="1login" for="nombre_usuario" class="col-sm-4 control-label">Nombre del usuario</label>
						<div class="col-sm-5">
							<input id="nombre_usuario" name="nombre_usuario" type="text"
								class="form-control" title="Requerido" required />
						</div>
					</div>
					<div class="form-group">
						<label id="1login" for="login" class="col-sm-4 control-label">Login</label>
						<div class="col-sm-5">
							<input id="login" name="login" type="text"
								class="form-control" title="Requerido" required />
						</div>
					</div>
					<div class="form-group">
						<label for="pass" class="col-sm-4 control-label">Contraseña</label>
						<div class="col-sm-5">
							<input id="pass" name="pass" type="password"
								class="form-control" title="Requerido" required/>
						</div>
					</div>
					<div class="form-group">
						<label for="confirmPass" class="col-sm-4 control-label">Repetir contraseña</label>
						<div class="col-sm-5">
							<input id="confirmPass" name="confirmPass" type="password"
								class="form-control" title="Requerido" required/>
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
<!--/////////////////////////////// Formalario y dialogo de eliminación/////////////////////////////// -->
<form id="frmEliminarUsuario" action="" method="POST">
	<input type="hidden" id="usuario_id" name="usuario_id" value="">
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
<!--///////////////////////////// Formalario y dialogo de activación de usuarios/////////////////////////////// -->
<form id="frmActivarUsuario" action="" method="POST">
	<input type="hidden" id="usuario_id" name="usuario_id" value="">
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
	var loginValid = ""; ///////////variable para validar si el usuario esta editando un registro 
	var expand1 = new Expand1();/////////////se crean los objetos que representan los botones de cada dialogo
	var colap1 = new Colap1();
	var expand2 = new Expand2();
	var colap2 = new Colap2();

/////////////////////////////////Abrir dialogo para eliminar usuario////////////////////////////////////////////
	function abrirDialogo() {
		OpenModalBox(//modal(tutilo, contenido, foot)
				"<div><h3>Borrar Usuario</h3></div>",
				"<p Style='text-align:center; color:salmon; font-size:x-large;'>¿Esta seguro de borrar este Usuario?</p>",
				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-2 col-md-3'> "
						+ "<button type='button' id='eliminar_usuario' class='btn btn-danger btn-label-left'"
						+" style='color:#ece1e1;' >"
						+ "<span><i class='fa fa-trash-o'></i></span>Eliminar usuario </button>"
						+ "<div style='margin-top: 5px;'></div>"
						+ "</div> <div class='col-sm-12 col-md-offset-1 col-md-3 text-center' Style='margin-bottom: -10px;'>"
						+ "<button type='button' class='btn btn-default btn-label-left' Style='margin-left: 10px;' onclick='CloseModalBox()'>"
						+ "<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
		eliminar();//activar evento de eliminar
	}
///////////////////Modal para Reactivar el Cliente eliminado o dado de baja///////////////////////////////
	function abrirDialogo2() {
		OpenModalBox(
				"<div><h3>Reactivar Usuario</h3></div>",
				"<p Style='text-align:center; color:blue; font-size:x-large;'>¿Esta seguro de volver a reactivar este usuario?</p>",
				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-2 col-md-3'> "
						+ "<button type='button' id='activar_usuario' class='btn btn-primary btn-label-left'"
						+" style='color:#ece1e1;' >"
						+ "<span><i class='fa fa-user'></i></span>Activar usuario </button>"
						+ "<div style='margin-top: 5px;'></div>"
						+ "</div> <div class='col-sm-12 col-md-offset-1 col-md-3 text-center' Style='margin-bottom: -10px;'>"
						+ "<button type='button' class='btn btn-default btn-label-left' Style='margin-left: 10px;' onclick='CloseModalBox()'>"
						+ "<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
		activar();//activar evento para que el cliente sea activo otra vez
	}
	
/////////////Metodo para limpiar el texto del formulario de clientes//////////////////////////////////77
	var limpiar_texto = function() {//limpiar texto del formulario
		$("#opcion").val("guardar");
		$("#login").val("");
		$("#pass").val("");
		$("#defaultForm").data('bootstrapValidator').resetForm();////////////////resetear las validaciones
	}

/////////////Metdoo que activa evento para eliminar con el boton que esta oculto al usuario,/////////////////////// 
//////////////////////este metodo se activa al abrir el dialogo con metodo abrirDialogo() para eliminar al cliente//////////////////////////////
	var eliminar = function() {
		$("#eliminar_usuario").on("click", function() {
			var usuario_id = $("#frmEliminarUsuario #usuario_id").val();//se obtiene el id del usuario que esta oculto
			var opcion = $("#frmEliminarUsuario #opcion").val();//se obtiene la opcion que esta oculta
			$.ajax({
				method : "POST",
				url : "./SL_Usuario",
				data : {
					"usuario_ID" : usuario_id,
					"opcion" : opcion
				}
			//se envian los datos al servlet
			}).done(function(info) {
				verResultado(info);
			});
			console.log(opcion + ": " + usuario_id);
			CloseModalBox();
		});
		limpiar_texto();
	}
	
//////////////////metodo para activar el cliente a la base de datos///////////////////////////////////////////
	var activar = function() {
		$("#activar_usuario").on("click", function() {
			var usuario_id = $("#frmActivarUsuario #usuario_id").val();//se obtiene el id del usuario que esta oculto
			var opcion = $("#frmActivarUsuario #opcion").val();//se obtiene la opcion que esta oculta
			$.ajax({
				method : "POST",
				url : "./SL_Usuario",
				data : {
					"usuario_ID" : usuario_id,
					"opcion" : opcion
				}
			//se envian los datos al servlet
			}).done(function(info) {
				verResultado(info);
			});
			console.log(opcion + ": " + usuario_id);
			CloseModalBox();
		});
	}
////////////////////////////////limpia el texto y valida los botones de control de dialogo/////////////////////////
	var agregar_nuevo_usuario = function() {
		document.getElementById('formularioUsuario').style.display = 'block';
		//$("#expandir1").prop('disabled', true);
		limpiar_texto();
		validarExpand(expand1, "#expandir1");
		if (colap1.valor == false)
			validarColap(colap1, "#colapsar_desplegar1");
		validarColap(colap2, "#colapsar_desplegar2");
		if (expand2.valor == true)
			validarExpand(expand2, "#expandir2");
		
		$("#nombre_usuario").focus();
	}
///////////////////////////////cancelar la accion sobre el cliente/////////////////////////////////////////////777
	var cancelar = function() {
		limpiar_texto();	
		document.getElementById('formularioUsuario').style.display = 'none';
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
			cargar_usuarios();
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
	var boton= 1;//varaible para validar si el check de activar clientes esta checkeado
/////////////////////////////////funsion que devuelve los botones dependiendo del check///////////////////////////
function botones() {
	if(boton ==1){
	return "<button type='button' class='editarUsu btn btn-primary' title='Editar Usuario'>" //poner botones en cada fila
	+"<i class='fa fa-pencil-square-o'></i>"
	+ "</button>  "
	+ "<button type='button' title='Eliminar Usuario' class='eliminarUsu btn btn-danger' >"
	+ "<i class='fa fa-trash-o'></i>"
	+ "</button>";
	}else if(boton ==2){
	return "<button type='button' style='margin-left:15px;' class='activarUsu btn btn-primary' title='activar cliente'>"
		+ "<i class='fa fa-upload'></i>"
		+ "</button>";
	}
}
////////////////////////////Ejecutar el metodo DataTable para llenar el dataTable con ajax///////////////////////////7
	var listar = function() {
		console.log("cargando dataTable");
		boton= 1;
		var table = $("#dt_usuario").DataTable({
			"destroy" : true,//para que se puede destruir los datos y recargarlos
			responsive : true,
			'bProcessing' : false,
			'bServerSide' : false,
			ajax : {
				"method" : "GET",
				"url" : "./SL_Usuario",
				"data" : {
				"carga" : boton
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
				{'mData' : 'nombre_usuario'},
				{'mData' : 'login'},
				{'mData' : 'pass'},
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
						"titleAttr" : "Agregar Usuario",
						"className" : "btn btn-success",
						"action" : function() {
										agregar_nuevo_usuario();
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
		obtener_datos_editar("#dt_usuario tbody", table);//despues de llenar se manda a activar el evento clickde obtener
		obtener_id_eliminar("#dt_usuario tbody", table)//igual para el boton eliminar
		obtener_id_activar("#dt_usuario tbody", table);//igual para el boton activar
		LoadSelect2Script(MakeSelect2);
		$("#mostrar_usuarios").change(function(){//evento que carga diferentes datos si el checkbox esta activo o no
	        if($(this).is(':checked')){
	        	boton= 2;
				document.getElementById('formularioUsuario').style.display = 'none';
				cargar_usuarios();
	        }else{
	        	boton= 1;
	        	//document.getElementById('formularioUsuario').style.display = 'block';
	        	$('#dt_usuario').DataTable().ajax.reload();
	        }
		});
	}
//////////////////////////////////////metodo para llenar al dataTable con los clientes anulado////////////////////////
	var cargar_usuarios = function() {
		console.log("Cargando DataTable para activación");
		$('#dt_usuario').DataTable().state.clear();
		$('#dt_usuario').DataTable().clear().draw();
		$.ajax({
	        type: "GET",
	        url: "./SL_Usuario",
	        data: {
		        "carga": boton//para decirle al servlet que cargue datos
		    },
	        success: function(response){
	        	$('#dt_usuario').DataTable().rows.add(response.aaData).draw();
	        }
		});
	}
/////////////////////////activar el evento del boton actualizar que esta el las filas del dataTable/////////////////
	var obtener_datos_editar = function(tbody, table) {
		$(tbody).on("click","button.editarUsu",function() {//activar evento click en boton actualizar que esta en el dataTable
			var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
			table.rows().every(function(index, loop, rowloop) {
				if (index == datos) {
					var nombre_usuario = $("#nombre_usuario").val(table.row(index).data().nombre_usuario);
					var login = $("#login").val(table.row(index).data().login);
					loginValid = table.row(index).data().login;
					var pass = $("#pass").val(table.row(index).data().pass);
					var eliminado = $("#eliminado").val(table.row(index).data().eliminado);
					var usuario_id = $("#usuario_id").val(table.row(index).data().usuario_ID);
					var opcion = $("#opcion").val("actualizar");//settear datos en el formulario de edicion
				}
			});
			document.getElementById('formularioUsuario').style.display = 'block';
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
		$(tbody).on("click","button.eliminarUsu",function() {
			var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
			table.rows().every(function(index, loop, rowloop) {
				if (index == datos) {console.log(table.row(index).data().usuario_ID);
					var usuario_id = $("#frmEliminarUsuario #usuario_id").val(table.row(index).data().usuario_ID);
				}
			});
			abrirDialogo();
		});
	}
///////////////////////////////Activa el evento cuando de click al boton activar cliente del dataTable////////////////7
	var obtener_id_activar = function(tbody, table) {
		$(tbody).on("click","button.activarUsu",function() {var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
			table.rows().every(function(index, loop, rowloop) {
				if (index == datos) {console.log(table.row(index).data().usuario_ID);
					var usuario_id = $("#frmActivarUsuario #usuario_id").val(table.row(index).data().usuario_ID);
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
					console.log("PDF Y EXCEL cargado");
					listar();
					LoadSelect2Script(MakeSelect2);
				});
			});
		});
	}

////////////////////////////llamar a la funcio listar para que llene el dataTable//////////////////////////////
	$(document).ready(function() {
		
		LoadBootstrapValidatorScript(formValidUsu);
		
		LoadDataTablesScripts2(AllTables);
		
		validarColap(colap1, "#colapsar_desplegar1");
		
		$('.form-control').tooltip();
	});
///////////////////////////////////////valida el formulario de los usuarios////////////////////////////////////////
function formValidUsu() {
	$('#defaultForm').bootstrapValidator({
		message : 'Este valor no es valido',
		fields : {
			nombre_usuario:{
				validators:{
					notEmpty : {
						message : "¡Este campo es requerido y no debe estar vacio!"
					}
				}
			},
			pass:{
				validators:{
					notEmpty : {
						message : "¡Este campo es requerido y no debe estar vacio!"
					},
					identical: {
                        field: 'confirmPass',
                        message: "¡La contreseña y su confirmación no son iguales!"
                    }
				}
			},
			confirmPass:{
				validators:{
					notEmpty : {
						message : "¡Este campo es requerido y no debe estar vacio!"	
					},
					identical: {
                        field: 'pass',
                        message: "¡La contreseña y su confirmación no son iguales!"
                    }
				}
			},
			login : {
				validators : {
					callback : {
						message : '¡Este campo no debe ser igual a los otros registros!',
						callback : function(value,validator, $field) {
							
							var tabla = $('#dt_usuario').DataTable();
							var filas = tabla.rows();
							var noigual = true;
							filas.every(function(index,loop, rowloop) {
								if (value == tabla.row(index).data().login) {
									noigual = false;
								}
								if(loginValid == value){
									noigual = true;
								}
							});
							return noigual;
						}
					},
					notEmpty : {
						message : "¡Este campo es requerido y no debe estar vacio!"
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
			method:"POST",
			url:"./SL_Usuario",
			data: frm//datos a enviar
			}).done(function(info) {//informacion que el servlet le reenvia al jsp
			console.log(info);
			if(expand1.valor == true)
				validarExpand(expand1, "#expandir1");
				
			if(expand2.valor == true)
				validarExpand(expand2, "#expandir2");
				
			validarColap(colap1, "#colapsar_desplegar1");
			if (colap2.valor ==true){}else{
				validarColap(colap2, "#colapsar_desplegar2");
			}
			verResultado(info);
			});
		});
}
</script>
