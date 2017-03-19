<%@page language="java"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<div id="dialogUsu" class= "col-xm-offset-1 col-xm-10">
	<div class="contenido" style="margin-left: 20px;"></div>
</div>
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Usuario</a></li>
			<li><a href="#">Gestión de usuarios</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
				<div class="box-header">
						<div class="box-name">
							<i class="fa fa-search"></i> <span>Formulario de Usuarios</span>
						</div>
						<div class="box-icons">
							<a id="colapsar_desplegar1" onclick="validar(colap1);" class="collapse-link"> <i class="fa fa-chevron-up"></i></a> 
							<a id="expandir1" onclick="validar(expand1);"  class="expand-link"> <i class="fa fa-expand"></i></a>
						</div>
						<div class="no-move"></div>
				</div>
				<div class="box-content">
				
				<form class="form-horizontal formUsuario" role="form" id="defaultForm" method="POST" action="">
				
					<input type="hidden" id="opcion" name="opcion" value="guardar">
					<input type="hidden" id="Usuario_ID" name="Usuario_ID">
					<div class="form-group">
						<label class="col-sm-4 control-label text-info">Nombre de usuario</label>
						<div class="col-sm-4"><input id="nombreUsu" name="nombreUsu" type="text" 
						class="form-control"  autofocus title="No requerido" ></div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label text-info">Login</label>
						<div class="col-sm-4"><input id="login" name="login" type="text" 
						class="form-control"  autofocus title="Requerido" ></div>
					</div> 
					<div class="form-group">
						<label class="col-sm-4 control-label text-info">Password</label>
							<div class="col-sm-4"><input id="pass" name="pass" type="text" 
							class="form-control" title="Requerido" ></div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-3">
							<button  id="btnEnviar" type="submit" class="btn btn-primary btn-label-left btn-lg">
								<span><i class="fa fa-save"></i></span>Guardar
							</button>
						</div>
						<div class="col-sm-4">
							<button type="button" class="btn btn-default btn-label-left btn-lg" onclick="cancelar();">
								<span><i class="fa fa-reply txt-danger"></i></span>Cancelar
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
					<i class="fa fa-th"></i> <span>Lista de Usuarios</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar2" onclick="validar(colap2);" class="collapse-link"> <i class="fa fa-chevron-up"></i></a> 
					<a id="expandir2" onclick="validar(expand2);" class="expand-link"> <i class="fa fa-expand"></i></a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding table-responsive">
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="tabla_usuario" style="width: 100%;">
					<thead>
						<tr>
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
<div>
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
var expand1 = new Expand1();//se crean los objetos que representan los botones de cada dialogo
var colap1 =  new Colap1();
var expand2 = new Expand2();
var colap2 =  new Colap2();
//////////////////////////////llama a funsión que carga el dataTables de usuarios////////////////////////////////// 
	function AllTables() {
		LoadSelect2Script(MakeSelect2);
		iniciarTabla();
	}
/////////////////////////////////////////cargar los select con plugin select2//////////////////////////////////////
	function MakeSelect2() {
		$('select').select2();
		$('.dataTables_filter').each(
			function() {
				$(this).find('label input[type=search]').attr('placeholder', 'Buscar');
			});
	}
//////////////////////////funsión que abre un dialogo para eliminar a un usuario////////////////////////////////////
	function abrirDialogo() {
		OpenModalBox(
				"<div><h3>Borrar Usuario</h3></div>",
				"<p Style='text-align:center; color:salmon; font-size:x-large;'>Esta seguro de borrar este usuario?</p>",
				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-3 col-md-3'>"+
				"<button type='button' id='eliminar_usuario' class='btn btn-danger btn-label-left' onclick='CloseModalBox()'"+
				" style=' color: #ece1e1;'>"+
				"<span><i class='fa fa-trash-o'></i></span>Borrar usuario</button>"+
				"<div style='margin-top: 5px;'></div> </div>"+
				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-3 text-center'>"+
				"<button type='button' class='btn btn-default btn-label-left' onclick='CloseModalBox()'>"+
				"<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
		eliminar();
		
	}
	
	var limpiar_texto = function() {//limpiar texto del formulario
		$("#opcion").val("guardar");
		$("#usuario_id").val("");
		$("#login").val("").focus();
		$("#login").removeAttr("readonly");
		$("#pass").val("");
		$("#Usuario_id").val("");
	}
//////////////////////////////////funsión que carga el dataTable con ajax/////////////////////////////////////////
	function iniciarTabla(){
		console.log("cargando DataTable Usuario");
		var tablaUsuario = $('#tabla_usuario').DataTable( {
			"destroy": true,
			'bProcessing': false,
			'bServerSide': false,
			ajax: {
				"method":"GET",
				"url":"./SL_Usuario",
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
	            { "data": "login" },
	            { "data": "pass" },
	            {"defaultContent":"<button type='button' class='editarUsuario btn btn-primary' data-toggle='tooltip' "+
					"data-placement='bottom' title='Editar Usuario'>"+
					"<i class='fa fa-pencil-square-o'></i> </button>  "+
					"<button type='button' class='eliminarUsuario btn btn-danger' data-toggle='tooltip' "+
					"data-placement='bottom' title='Eliminar Usuario'>"+
					"<i class='fa fa-trash-o'></i> </button>"}
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
				},{
	                extend:    'csvHtml5',
	                text:      '<i class="fa fa-file-text-o"></i>',
	                titleAttr: 'csv'
	            }]
		});
		
 		seleccionarEliminarUsuario('#tabla_usuario tbody', tablaUsuario);
 		seleccionarEditarUsuario('#tabla_usuario tbody', tablaUsuario);
	}
////////////////////funsión que abre un dialogo donde muestra la respuesta de la operación sobre el usuario/////////////////////
	var verResultado = function(r) {
		if(r == "BIEN"){
			mostrarMensaje("#dialogUsu", "CORRECTO", 
					"¡Se realizó la acción correctamente, todo bien!", "#d7f9ec", "btn-info");
			limpiar_texto();
			$('#tabla_usuario').DataTable().ajax.reload();/////////////////recargar dataTable
		}
		if(r == "Error"){
			mostrarMensaje("#dialog", "ERROR", 
					"¡Ha ocurrido un error, no se pudo realizar la acción!", "#E97D7D", "btn-danger");
		}
		if(r =="VACIO"){
			mostrarMensaje("#dialog", "VACIO", 
					"¡No se especificó la acción a realizar!", "#FFF8A7", "btn-warning");
		}
	}
/////////////////////////funsión que activa el evento click del boton eliminar usuario/////////////////////////////
	var eliminar = function(){
		$("#eliminar_usuario").on("click", function(){
			frmElim= $("#frmEliminarUsuario").serialize();
			console.log("datos a eliminar: " + frmElim);
			$.ajax({
				method:"POST",
				url:"SL_Usuario",
				data: frmElim
			}).done(function(info){
				verResultado(info);
			});
			CloseModalBox();
		});
	}
//////////////////////////////funsión que activa el evento click del boton eliminar que esta en cada fila del dataTable/////////////////////
	var seleccionarEliminarUsuario = function(tbody, table) {
		$(tbody).on("click", "button.eliminarUsuario", function() {
			var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
			var usuario_ID;
			table.rows().every(function(index, loop, rowloop) {
				if(index == datos){
					usuario_ID = table.row(index).data().usuario_ID;
					$("#frmEliminarUsuario #usuario_id").val(usuario_ID);
				}
			});
			abrirDialogo();
		});
	}
//////////////////////Funsión que activa el evento click del boton editar del DataTable//////////////////////////////
	var seleccionarEditarUsuario = function(tbody, table) {
		$(tbody).on("click", "button.editarUsuario", function() {
			var datos = table.row($(this).parents("tr")).index();
			var usuario_ID, login, pass;
			table.rows().every(function(index, loop, rowloop) {
				if(index == datos){
					usuario_ID = table.row(index).data().usuario_ID;
					login = table.row(index).data().login;
					pass = table.row(index).data().pass;
					$("#Usuario_ID").val(usuario_ID);
					$("#login").val(login);
					$("#login").attr("readonly","readonly");
					$("#pass").val(pass);
					$("#opcion").val("actualizar");
				}
			});
			validarExpand(expand1, "#expandir1");
			if(colap1.valor==false)
				validarColap(colap1, "#colapsar_desplegar1");
			validarColap(colap2, "#colapsar_desplegar2");
			if(expand2.valor == true)
				validarExpand(expand2, "#expandir2");
		});
	}
	
	var agregar_nuevo_usuario = function() {
		limpiar_texto();
		validarExpand(expand1, "#expandir1");
		if(colap1.valor==false)
			validarColap(colap1, "#colapsar_desplegar1");
		validarColap(colap2, "#colapsar_desplegar2");
		if(expand2.valor == true)
			validarExpand(expand2, "#expandir2");
	}
	
	var cancelar = function() {
		limpiar_texto();
		if(expand1.valor == true)
			validarExpand(expand1, "#expandir1");
		
		if(expand2.valor == true)
			validarExpand(expand2, "#expandir2");
		
		validarColap(colap1, "#colapsar_desplegar1");
		if (colap2.valor ==true){}else{
			validarColap(colap2, "#colapsar_desplegar2");
		}
	}
	
/////////////////////////metodo guardar donde activa el evento submit del formulario de registro///////////////////////
	var guardar = function() {
		$("form.formUsuario").on("submit", function(e) {
			e.preventDefault();//detiene el evento
			var frm = $(this).serialize();//parsea los datos del formulario
			console.log(frm);
			if($("#login").val()!="" && $("#pass").val() != ""){
				$.ajax({//enviar datos por ajax
					method:"POST",
					url:"SL_Usuario",
					data: frm//datos a enviar
					}).done(function(info) {//informacion que el servlet le reenvia al jsp
						verResultado(info);
						if(expand1.valor == true)
		  					validarExpand(expand1, "#expandir1");
		  				
		  				if(expand2.valor == true)
		  					validarExpand(expand2, "#expandir2");
		  				
		  				validarColap(colap1, "#colapsar_desplegar1");
		  				if (colap2.valor ==true){}else{
		  					validarColap(colap2, "#colapsar_desplegar2");
		  				}
					});
			}
		});
	}
//////////////////////////////////////FUNSIÓN PRINCIPAL/////////////////////////////////////////////////////////////
	$(document).ready(function() {
		//cargar scripts dataTables
		LoadDataTablesScripts2(AllTables);
		
		//add tooltip
		$('.form-control').tooltip();
		$('[data-toggle="tooltip"]').tooltip();

		//Cargar ejemplo para validaciones
		LoadBootstrapValidatorScript(FormValidUsu);
	
		// Add Drag-n-Drop feature				
		WinMove();	
		
		guardar();//activar evento de guardar
		
		validarColap(colap1, "#colapsar_desplegar1");
	});
////////////////////////////////////funsión que valida los campos del formulario de usuarios///////////////////////
	function FormValidUsu() {
		$('.formUsuario').bootstrapValidator({
			message: 'Este valor no es valido',
			fields: {
				login:{
					validators: {
						notEmpty:{
			                message: "Este campo es requerido y no debe estar vacio"
			            },
	 					callback: {
	        					message: 'Este campo no debe ser igual a los otros registros',
	         				callback: function (value, validator, $field) {
	         					if($('.formUsuario #opcion').val()!="actualizar"){
	         						var tabla = $("#tabla_usuario").DataTable();
		         					var filas = tabla.rows();
		         					var noigual = true;
		             				filas.every(function(index, loop, rowloop) {
		     							if(value == tabla.row(index).data().login){
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
				pass:{
					validators: {
						notEmpty:{
			                message: 'Este campo es requerido y no debe estar vacio'
			            },
			            stringLength: {
							min: 8,
							message: 'La contraseña debe tener un mínimo de 8 caracteres'
						}
			        }
				}
			}
		});
	}
	
</script>
