<%@page import="Datos.DT_categoria_Ing_Engre, java.util.*, Entidades.TipoCategoria, java.sql.ResultSet ;"%>
<%@page language="java"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Usuario</a></li>
			<li><a href="#">Usuarios</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
				<div class="box-header">
						<div class="box-name">
							<i class="fa fa-search"></i> <span>Crear Usuario</span>
						</div>
						<div class="box-icons">
							<a id="colapsar_desplegar1" class="collapse-link"> <i class="fa fa-chevron-up"></i></a> 
							<a id="expandir1" class="expand-link"> <i class="fa fa-expand"></i></a>
						</div>
						<div class="no-move"></div>
				</div>
				<div class="box-content">
				
				<form class="form-horizontal formUsuario" role="form" id="defaultForm" method="POST" action="validators.html">
				
					<input type="hidden" id="opcion" name="opcion" value="guardar">
					<input type="hidden" id="Usuario_ID" name="Usuario_ID">
					
					
					<div class="form-group">
						<label class="col-sm-4 control-label text-info">Login</label>
						<div class="col-sm-4"><input id="login" name="login" type="text" class="form-control"  autofocus></div>
					</div> 
					<div class="form-group">
						<label class="col-sm-4 control-label text-info">Password</label>
							<div class="col-sm-4"><input id="pass" name="pass" type="text" class="form-control" ></div>
					</div>
					
					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-3">
							<button  id="btnEnviar" type="submit" class="btn btn-info btn-label-left">
								<span><i class="glyphicon glyphicon-save text-info"></i></span><font color="black">Guardar</font>
							</button>
						</div>
						<div class="col-sm-3">
							<button type="button" class="btn btn-info btn-label-left" onclick="cancelar();">
								<span><i class="fa fa-clock-o txt-info"></i></span><font color="black"> Cancelar</font>
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
					<i class="fa fa-th"></i> <span>Lista de Usuario</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar2" class="collapse-link"> <i class="fa fa-chevron-up"></i></a> 
					<a id="expandir2" class="expand-link"> <i class="fa fa-expand"></i></a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding table-responsive">
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="tabla_usuario" style="with:100%;">
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

	/*
	function DemoSelect2() {
		$('#s2_with_tag').select2({
			placeholder : "Select OS"
		});
		$('#s2_rol').select2();
	}*/
	
	function AllTables() {
		LoadSelect2Script(MakeSelect2);
		iniciarTabla();
	}
	
	function MakeSelect2() {
		$('select').select2();
		$('.dataTables_filter').each(
			function() {
				$(this).find('label input[type=text]').attr('placeholder', 'Buscar');
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
	
	var limpiar_texto = function() {//limpiar texto del formulario
		$("#opcion").val("guardar");
		$("#usuario_id").val("");
		$("#login").val("").focus();
		$("#pass").val("");
		$("#Usuario_id").val("");
	}
	
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
			"columns": [
	            { "data": "login" },
	            { "data": "pass" },
	            {"defaultContent":"<button type='button' class='editarUsuario btn btn-primary' data-toggle='tooltip' "+
					"data-placement='bottom' title='Editar'>"+
					"<i class='fa fa-pencil-square-o'></i> </button>  "+
					"<button type='button' class='eliminarUsuario btn btn-danger' data-toggle='tooltip' "+
					"data-placement='bottom' title='Eliminar'>"+
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
	
	var verResultado = function(r) {
		if(r == "BIEN"){
			console.log("cambiar esto en verResultado");
			alert("Se realizo la operación correctamente");
// 			location.reload();
// 			console.log("cambiar esto ahi mismo");
			
			limpiar_texto();
			iniciarTabla();
		}
		if(r == "Error"){
			alert("ERROR: No se pudo realizar la operación");
		}
		if(r =="VACIO"){
			alert("VACIO: No se realizo ninguna operación");
		}
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
				verResultado(info);
			});
			CloseModalBox();
		});
	}
	
	var seleccionarEliminarUsuario = function(tbody, table) {
		console.log("seleccionar eliminar usuario activo");
		$(tbody).on("click", "button.eliminarUsuario", function() {
			var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
			var usuario_ID;
			table.rows().every(function(index, loop, rowloop) {
				console.log("indices: "+ index +" : "+datos);
				if(index == datos){
					usuario_ID = table.row(index).data().usuario_ID;
					console.log("usuario_ID: " + usuario_ID);
					$("#frmEliminarUsuario #usuario_id").val(usuario_ID);
				}
			});
			abrirDialogo();
		});
	}
	
	var seleccionarEditarUsuario = function(tbody, table) {
		console.log("seleccionar editar usuario activo");
		$(tbody).on("click", "button.editarUsuario", function() {
			var datos = table.row($(this).parents("tr")).index();
			var usuario_ID, login, pass;
			table.rows().every(function(index, loop, rowloop) {
				console.log("indices: "+ index +" : "+datos);
				if(index == datos){
					usuario_ID = table.row(index).data().usuario_ID;
					console.log("usuario_ID: " + usuario_ID);
					login = table.row(index).data().login;
					pass = table.row(index).data().pass;
					$("#Usuario_ID").val(usuario_ID);
					$("#login").val(login);
					$("#pass").val(pass);
					$("#opcion").val("actualizar");
				}
			});
// 			colapsar_desplegar($("#colapsar_desplegar1"));
// 			expandir($("#expandir1"));
// 			colapsar_desplegar($("#colapsar_desplegar2"));
		});
	}
	
	var agregar_nuevo_usuario = function() {
		limpiar_texto();
// 		colapsar_desplegar($("#colapsar_desplegar2"));
// 		colapsar_desplegar($("#colapsar_desplegar1"));
// 		expandir($("#expandir1"));
	}
	
	var cancelar = function() {
		limpiar_texto();
// 		expandir($("#expandir1"));
// 		colapsar_desplegar($("#colapsar_desplegar1"));
// 		colapsar_desplegar($("#colapsar_desplegar2"));
	}
	
	//metodo guardar donde activa el evento submit del formulario de registro
	var guardar = function() {
		$("form.formUsuario").on("submit", function(e) {
			e.preventDefault();//detiene el evento
			var frm = $(this).serialize();//parsea los datos del formulario
			console.log(frm);
			$.ajax({//enviar datos por ajax
			method:"POST",
			url:"SL_Usuario",
			data: frm//datos a enviar
			}).done(function(info) {//informacion que el servlet le reenvia al jsp
				verResultado(info);
			});
// 			colapsar_desplegar($("#colapsar_desplegar1"));
// 			expandir($("#expandir1"));
// 			colapsar_desplegar($("#colapsar_desplegar2"));
		});
	}
	
	var agregar_nuevo_usuario = function() {
		limpiar_texto();
// 		expandir($("#expandir1"));
// 		colapsar_desplegar($("#colapsar_desplegar1"));
// 		colapsar_desplegar($("#colapsar_desplegar2"));
	}
	
	$(document).ready(function() {
		//cargar scripts dataTables
		LoadDataTablesScripts2(AllTables);
		
		//add tooltip
		$('.form-control').tooltip();
		$('[data-toggle="tooltip"]').tooltip();

		//Cargar ejemplo para validaciones
		LoadBootstrapValidatorScript(DemoFormValidator);
	
		// Add Drag-n-Drop feature				
		WinMove();	
		
		guardar();//activar evento de guardar
		
// 		colapsar_desplegar($("#colapsar_desplegar1"));
	});
	
</script>
