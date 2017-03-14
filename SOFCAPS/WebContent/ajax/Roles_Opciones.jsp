<%@page language="java"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<!--Start Breadcrumb-->
<div class="row">
	<div id="breadcrumb" class="col-xs-12">
		<ol class="breadcrumb">
			<!--<li><a href="index.html">Home</a></li>-->
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Roles y Opciones</a></li>
		</ol>
	</div>
</div>
<!--End Breadcrumb-->
				<!-- MODAL PARA MOSTRAR FORMULARIOS -->
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
<!--Start Dashboard 1-->
<div id="dashboard-header" class="row">
	<div class="col-sm-12 col-md-12 text-center">
		<h3>Gestion de Roles y Opciones</h3>
	</div>
</div>
<!--End Dashboard 1-->
<!--Start Dashboard 2-->
<div class="row-fluid">
	<div id="dashboard_links" class="col-xs-12 col-sm-2 pull-right">
		<ul class="nav nav-pills nav-stacked"
		style="background: #4C9480 url(./img/devoops_pattern_b10.png) 0 0 repeat;">
			<li class="active"><a href="#" class="tab-link" id="Rol">Roles</a></li>
			<li><a href="#" class="tab-link" id="Opcion">Opciones</a></li>
			<li><a href="#" class="tab-link" id="Rol_Opcion">Asignar Permisos</a></li>
		</ul>
	</div>
	<div id="dashboard_tabs" class="col-xs-12 col-sm-10">
	
		<!--Start Dashboard Tab 1-->
		<div id="dashboard-Rol" class="row"
		style="visibility: visible; position: relative;">
			<div class="col-xs-12" style="margin-top: 20px;">
				<h4 class="page-header">Roles</h4>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-12  col-md-offset-1 col-md-10">
					<div class="box" style="top: 0px; left: 0px; opacity: 1;">
						<div class="box-header">
							<div class="box-name">
								<i class="fa fa-plus-square-o"></i> <span>Registro de Roles</span>
							</div>
							<div class="box-icons">
								<a id="colapsar_desplegar1" class="collapse-link"> 
									<i class="fa fa-chevron-up"></i></a> 
								<a id="expandir1" class="expand-link"> 
									<i class="fa fa-expand"></i></a>
							</div>
							<div class="no-move"></div>
						</div>
						<div class="box-content">
							<div class="table-responsive">
								<table class="table table-bordered table-striped table-hover table-heading table-datatable" 
								id="tabla_rol" style="width:100%;">
									<thead>
										<tr>
											<th>Rol</th>
											<th></th>
										</tr>
									</thead>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="clearfix"></div>
			<div style="height: 15px;"></div>
		</div>
		<!--End Dashboard Tab 1-->
		
		<!--Start Dashboard Tab 2-->
		<div id="dashboard-Opcion" class="row" style="visibility: hidden; position: absolute;">
			<div class="col-xs-12" style="margin-top: 20px;">
				<h4 class="page-header">Opciones</h4>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-12  col-md-offset-1 col-md-10">
					<div class="box" style="top: 0px; left: 0px; opacity: 1;">
						<div class="box-header">
							<div class="box-name">
								<i class="fa fa-plus-square-o"></i> <span>Registro de Opciones</span>
							</div>
							<div class="box-icons">
								<a id="colapsar_desplegar1" class="collapse-link"> 
									<i class="fa fa-chevron-up"></i></a> 
								<a id="expandir1" class="expand-link"> 
									<i class="fa fa-expand"></i></a>
							</div>
							<div class="no-move"></div>
						</div>
						<div class="box-content">
							<div class="table-responsive">
								<table class="table table-bordered table-striped table-hover table-heading table-datatable" 
								id="tabla_opcion" style="width:100%;">
									<thead>
										<tr>
											<th>Opción</th>
											<th></th>
										</tr>
									</thead>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--End Dashboard Tab 2-->
		
		<!--Start Dashboard Tab 3-->
		<div id="dashboard-Rol_Opcion" class="row"
		style="width: 100%; visibility: hidden; position: absolute;">
			<div class="col-xs-12" style="margin-top: 20px;">
				<h4 class="page-header">Asignar Opciones a Roles</h4>
			</div>

			<form class="form-horizontal formRolOpcion" role="form"
				id="defaultForm" method="post" action="./SL_RolOpcion">
				
				<div class="form-group">
					<label class="col-sm-2 text-right control-label">Roles</label>
					<div class="col-sm-4">
						<select class="populate placeholder" name="rol1" id="rol1">
							<option value="">ROLES</option>
						</select>
					</div>
					<label class="col-sm-2 text-right control-label">Opciones</label>
					<div class="col-sm-4">
						<select class="populate placeholder" name="opcion1" id="opcion1">
							<option value="">OPCIONES</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-12 col-md-offset-4 col-md-3">
						<button type="submit" style="margin-left: 25px;"
							class="btn btn-primary btn-label-left">
							<span><i class="fa fa-clock-o"></i></span> Guardar
						</button>
					</div>
					<div class="col-sm-12 col-md-3">
							<button type="button" class="btn btn-warning btn-label-left">
								<span><i class="fa fa-clock-o"></i></span> Nuevo
							</button>
						</div>
				</div>
				<div class="clearfix"></div>
			</form>
		</div>
		<!--End Dashboard Tab 3-->
		
	</div>
	<div class="clearfix"></div>
</div>
<!--End Dashboard 2 -->

<div style="height: 40px;"></div>

<script type="text/javascript">
var datos_Rol_Opciones;

function DemoSelect2() {
	$('#opciones').select2();
	$('#opcion1').select2();
	$('#rol1').select2();
	$('#opcion2').select2();
}

//metodo para cargar sobre un select rol los registros
function cargarSelectRol(selectRol) {//parametro id select
	var datos;
	$.ajax({
        type: "GET",
        url: "./SL_Rol",
        dataType: "json",
        success: function(response)
        {
        	datos = response.aaData;
        	$(selectRol).empty();
        	$(response.aaData).each(function(i, v) {
        		console.log(v.rol_ID+": "+v.nomRol);//agregar datos al select
        		$(selectRol).append('<option value="' + v.rol_ID + '">' + v.nomRol + '</option>');
			});
        }
	});
}
//metodo para activar click en los tag y cargar los roles
var activarDatosSelect = function(tag, rol) {//recibe el tag para click y el select-rol
	tag.on("click", function() {
		cargarSelectRol(rol);
		console.log("cargar roles");
	});
}

var verResultado = function(r) {
	if(r == "BIEN"){
		listarRol();
		listarOpcion();
		alert("Se guardaron los datos carrectamente");
	}
	if(r == "ERROR"){
		alert("ERROR: No se pudo realizar la accion");
	}
	if(r =="VACIO"){
		alert("VACIO: No se realizo ninguna accion");
	}
}
var activarForm = function(servlet) {
	$("form.formulario").on("click", "button.guardarForm", function() {
		console.log("CRUD ROL");
		var frm = $("form.formulario").serialize();
		console.log(frm);
		$.ajax({
	        type: "POST",
	        url: servlet,
	        data: frm,
	        dataType: "text",
	        success: function(response){
	        	console.log(response);
	        	CloseModalBox();
	        	verResultado(response);
	        }
		});
	});
}
function abrirDialogo(head, body, food, callback, servlet) {
	OpenModalBox(head, body, food);
	callback(servlet);
}
var listarOpcion = function() {
	var tablaOpcion = $('#tabla_opcion').DataTable( {
		responsive: true,
		"destroy": true,
		'bProcessing': false,
		'bServerSide': false,
		ajax: {
			"method":"GET",
			"url":"./SL_Opcion",
			"dataSrc":"aaData"
		},
		"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
    	"bJQueryUI": true,
		"language":idioma_esp,
		"columns": [
            { "data": "opcion" },
            {"defaultContent":"<button type='button' class='editarOpcion btn btn-primary' data-toggle='tooltip' "+
				"data-placement='bottom' title='Editar'>"+
				"<i class='fa fa-pencil-square-o'></i> </button>  "+
				"<button type='button' class='eliminarOpcion btn btn-danger' data-toggle='tooltip' "+
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
					var head = "<div><h3>Formulario de Opciones</h3></div>";
					var body = frmOpcionAg;
					var foot = "<div Style='text-align: center; margin-bottom: -10px;'>"+
						"<button type='button' class='btn btn-secondary' Style='margin-left: 10px;'"+
						"onclick='CloseModalBox()'> Cancelar</button> </div>";
					abrirDialogo(head, body, foot, activarForm, "SL_Opcion");
				}
			}]
	});
	seleccionarEditarOpcion('#tabla_opcion tbody', tablaOpcion);
	seleccionarEliminarOpcion('#tabla_opcion tbody', tablaOpcion);
}
var seleccionarEliminarOpcion = function(tbody, table) {
	$(tbody).on("click", "button.eliminarOpcion", function() {
		var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
		var opcion_ID;
		table.rows().every(function(index, loop, rowloop) {
			console.log("indices: "+ index +" : "+datos);
			if(index == datos){
				opcion_ID = table.row(index).data().opcion_ID;
				console.log("opcion_ID: " + opcion_ID);
			}
		}); 
		console.log(opcion_ID);
		var head = "<div><h3>Borrar Opción</h3></div>";
		var body = "<p Style='text-align: center;'>¿Esta seguro de borrar esta registro?</p>";
		var foot = frmOpcionElim +
		"<input type='hidden' id='opcion_ID' type='text' class='form-control' name='opcion_ID' value="+opcion_ID+" />"+
		"<div class='col-sm-12 col-md-offset-4 col-md-3'>"+
		"<button type='button' class='btn btn-default btn-label-left guardarForm' style='margin-left:65px;'>"+
		"<span><i class='fa fa-clock-o'></i></span> Eliminar Opción</button>"+
		"</div> </form>";
		abrirDialogo(head, body, foot, activarForm, "SL_Opcion");
	});
}
var seleccionarEditarOpcion = function(tbody, table) {
	$(tbody).on("click", "button.editarOpcion", function() {
		var datos = table.row($(this).parents("tr")).index();
		var opcion_ID, opcion, descripcion;
		table.rows().every(function(index, loop, rowloop) {
			console.log("indices: "+ index +" : "+datos);
			if(index == datos){
				opcion_ID = table.row(index).data().opcion_ID;
				opcion = table.row(index).data().opcion;
				descripcion = table.row(index).data().descripcion;
				console.log("opcion_ID: " + opcion_ID + ", dato: " + opcion);
			}
		});
		var head = "<div><h3>Editar Opción</h3></div>";
		var body = frmOpcionAct +
		"<input type='hidden' id='opcion_ID' type='text' class='form-control' name='opcion_ID' value="+opcion_ID+" />"+
		"<div class='form-group'> <label class='col-sm-4 control-label'>Nombre la Opción</label>"+
		"<div class='col-sm-5'> <input id='opcion' type='text' class='form-control' name='opcion' value='"+opcion+"' /> </div>"+
		"</div> <div class='clearfix'></div>"+
		"<div class='form-group'> <label class='col-sm-4 control-label'>Descripción</label>"+
		"<div class='col-sm-5'>"+
		"<textarea class='form-control' id='descripcion' name='descripcion' rows='3' cols='45' >"+descripcion+
		"</textarea> </div>"+frmOpcionAct2;
		var foot = "<div Style='text-align: center; margin-bottom: -10px;'>"+
		"<button type='button' class='btn btn-secondary' Style='margin-left: 10px;'"+
		"onclick='CloseModalBox()'> Cancelar</button> </div>";
		abrirDialogo(head, body, foot, activarForm, "SL_Opcion");
	});
}

var listarRol = function() {
	var tablaRol = $('#tabla_rol').DataTable( {
		responsive: true,
		"destroy": true,
		'bProcessing': false,
		'bServerSide': false,
		ajax: {
			"method":"GET",
			"url":"./SL_Rol",
			"dataSrc":"aaData"
		},
		"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
    	"bJQueryUI": true,
		"language":idioma_esp,
		"columns": [
            { "data": "nomRol" },
            {"defaultContent":"<button type='button' class='editarRol btn btn-primary' data-toggle='tooltip' "+
				"data-placement='bottom' title='Editar'>"+
				"<i class='fa fa-pencil-square-o'></i> </button>  "+
				"<button type='button' class='eliminarRol btn btn-danger' data-toggle='tooltip' "+
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
					var head = "<div><h3>Formulario de Roles</h3></div>";
					var body = frmRolAg;//frmRol esta abajo
					var foot = "<div Style='text-align: center; margin-bottom: -10px;'>"+
						"<button type='button' class='btn btn-default btn-label-left btn-lg' Style='margin-left: 10px;'"+
						"onclick='CloseModalBox()'><span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>";
					abrirDialogo(head, body, foot, activarForm, "SL_Rol");
				}
			}]
	});
	seleccionarEditarRol('#tabla_rol tbody', tablaRol);
	seleccionarEliminarRol('#tabla_rol tbody', tablaRol);
}
var seleccionarEliminarRol = function(tbody, table) {
	$(tbody).on("click", "button.eliminarRol", function() {
		var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
		var rol_ID;
		table.rows().every(function(index, loop, rowloop) {
			console.log("indices: "+ index +" : "+datos);
			if(index == datos){
				rol_ID = table.row(index).data().rol_ID;
				console.log("rol_ID: " + rol_ID);
			}
		});
		var head = "<div><h3>Borrar Rol</h3></div>";
		var body = "<p Style='text-align:center; color:salmon; font-size:x-large;'>¿Esta seguro de borrar este rol?</p>";
		var foot = frmRolElim +
		"<input type='hidden' id='rol_ID' type='text' class='form-control' name='rol_ID' value="+rol_ID+" />"+
		"<div class='col-sm-12 col-md-offset-3 col-md-3'>"+
		"<button type='button' class='btn btn-danger btn-label-left guardarForm' style='margin-left:5px;color:#ece1e1;'>"+
		"<span><i class='fa fa-trash-o'></i></span> Eliminar Rol </button> </div>"+
		"<div class='col-sm-12 col-md-3 text-center'>"+
		"<button type='button' class='btn btn-default btn-label-left btn-lg' onclick='CloseModalBox();' >"+
		"<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button>"+
		"</div> </form>";
		abrirDialogo(head, body, foot, activarForm, "SL_Rol");
	});
}
var seleccionarEditarRol = function(tbody, table) {
	$(tbody).on("click", "button.editarRol", function() {
		var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
		var rol_ID, nomRol;
		table.rows().every(function(index, loop, rowloop) {
			console.log("indices: "+ index +" : "+datos);
			if(index == datos){
				rol_ID = table.row(index).data().rol_ID;
				nomRol = table.row(index).data().nomRol;
				console.log("rol_ID: " + rol_ID + ", dato: " + nomRol);
			}
		});
		var head = "<div><h3>Editar Rol</h3></div>";
		var body = frmRolAct +
		"<input type='hidden' id='rol_ID' type='text' class='form-control' name='rol_ID' value="+rol_ID+" />"+
		"<div class='form-group'> <label class='col-sm-3 col-md-offset-1 control-label'>Nombre del Rol</label>"+
		"<div class='col-sm-5'> <input id='nomRol' type='text' class='form-control' name='nomRol' value='"+nomRol+"' /> </div>"+frmRolAct2;
		var foot = "<div Style='text-align: center; margin-bottom: -10px;'>"+
		"<button type='button' class='btn btn-default btn-label-left btn-lg' Style='margin-left: 10px;'"+
		"onclick='CloseModalBox()'><span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>";
		abrirDialogo(head, body, foot, activarForm, "SL_Rol");
	});
}
var activarDatosTag = function(tag, funcion) {//recibe el tag para click y el select-rol
	tag.on("click", function() {
		funcion();
		console.log("cargar roles en primer tag");
	});
}
function AllTables() {
	listarRol();
}

$(document).ready(function() {
	// Make all JS-activity for dashboard
	DashboardTabChecker();
	LoadBootstrapValidatorScript(DemoFormValidator);//validaciones
	LoadSelect2Script(DemoSelect2);
	 $('[data-toggle="tooltip"]').tooltip();
	 
	 LoadDataTablesScripts2(AllTables);
	 activarDatosTag($("li a#Rol"),listarRol);
	 activarDatosTag($("li a#Opcion"),listarOpcion);
	 activarDatosSelect($("li a#Rol_Opcion"), "#rol1");
	
});

var frmRolAg = "<form class='form-horizontal formulario' role='form' id='defaultForm' method='post' action='./SL_Rol'>"+
	"<input type='hidden' id='metodo' type='text' class='form-control' name='metodo' value='guardar'/>"+
	"<input type='hidden' id='rol_ID' type='text' class='form-control' name='rol_ID' />"+
	"<div class='form-group'> <label class='col-sm-3 col-md-offset-1 control-label'>Nombre del Rol</label>"+
		"<div class='col-sm-5'> <input id='nomRol' type='text' class='form-control' name='nomRol' /> </div>"+
	"</div> <div class='clearfix'></div>"+
	"<div class='form-group'> <div class='col-sm-12 col-md-offset-4 col-md-3'>"+
			"<button type='button' class='btn btn-primary btn-label-left guardarForm' style='margin-left:70px;'>"+
				"<span><i class='fa fa-save'></i></span> Guardar Rol</button>"+
		"</div> </div> </form>";
var frmRolElim = "<form class='form-horizontal formulario' role='form' id='defaultForm'"+
	" method='post' action='./SL_Rol'>"+
	"<input type='hidden' id='metodo' type='text' class='form-control' name='metodo' value='eliminar'/>";
var frmRolAct = "<form class='form-horizontal formulario' role='form' id='defaultForm' method='post' action='./SL_Rol'>"+
	"<input type='hidden' id='metodo' type='text' class='form-control' name='metodo' value='actualizar'/>";
var frmRolAct2 = "</div> <div class='clearfix'></div>"+
"<div class='col-sm-12 col-md-offset-4 col-md-3'>"+
"<button type='button' class='btn btn-success btn-label-left guardarForm' style='margin-left:55px;'>"+
"<span><i class='fa fa-repeat'></i></span> Actualizar Rol </button>"+
"</div> </form>";

var frmOpcionAg = "<form class='form-horizontal formulario' role='form' id='defaultForm' method='post' action='./SL_Opcion'>"+
	"<input type='hidden' id='metodo' name='metodo' class='form-control' value='guardar' />"+
	"<input type='hidden' id='opcion_ID' name='opcion_ID' class='form-control' />"+
	"<div class='form-group'>"+
	"<label class='col-sm-4 control-label'>Nombre la Opción</label>"+
	"<div class='col-sm-5'> <input id='opcion' type='text' class='form-control' name='opcion' /> </div>"+
	"</div> <div class='clearfix'></div>"+
	"<div class='form-group'> <label class='col-sm-4 control-label'>Descripción</label>"+
	"<div class='col-sm-5'>"+
	"<textarea class='form-control' id='descripcion' name='descripcion' rows='3' cols='45'></textarea> </div>"+
	"</div> <div class='clearfix'></div> <div class='form-group'> "+
	"<div class='col-sm-12 col-md-offset-4 col-md-3'> "+
	"<button type='button' class='btn btn-primary btn-label-left guardarForm' style='margin-left:60px;'>"+
	"<span><i class='fa fa-clock-o'></i></span> Guardar Opción"+
	"</button> </div> </div> <div class='clearfix'></div> </form>";
var frmOpcionElim = "<form class='form-horizontal formulario' role='form' id='defaultForm' method='post' action='./SL_Opcion'>"+
	"<input type='hidden' id='metodo' name='metodo' class='form-control' value='eliminar' />";
var frmOpcionAct = "<form class='form-horizontal formulario' role='form' id='defaultForm' method='post' action='./SL_Opcion'>"+
"<input type='hidden' id='metodo' name='metodo' class='form-control' value='actualizar' />";;
var frmOpcionAct2 = "</div> <div class='clearfix'></div> <div class='form-group'> "+
"<div class='col-sm-12 col-md-offset-4 col-md-3'> "+
"<button type='button' class='btn btn-success btn-label-left guardarForm' style='margin-left:55px;'>"+
"<span><i class='fa fa-repeat'></i></span> Actualizar Opción"+
"</button> </div> </div> <div class='clearfix'></div> </form>";

///////////////////////////Metodo para cambiar valor de un elemnto cuando cambie el select/////////////////////////
//	$(selectRol).change(function(){//cuando se elija otra opcion del select
//	//parent(padre del elemento) - siblings(hermanos del el.) - find(busca hijo del el.)
////         if($(selectRol).parent("div").siblings("form").find("input[id*=Rol]").length){
////         	$(selectRol).parent("div").siblings("form").find("input[id*=Rol]").val($(selectRol+" option:selected").text());
////         	$(selectRol).parent("div").siblings("form").find("input[id=rol_ID]").val($(selectRol).val());
//// //         	if($(selectRol).parent("div").siblings("form").find("select[id=rol1]").length){
//// // 				$("select#rol1").val($(selectRol).val());
//// // 				$("select#rol1").change();
//// // 				//AGREGAR LOS CAMBIOS AQUI
//// //         	}
////         }
// if($(selectRol).parents("form").find("input[id*=Rol]").length){
// 	//parents(padres del elemento) - *(que contenga) - [](un atributo del el.)
// 	$(selectRol).parents("form").find("input[id*=Rol]").val($(selectRol+" option:selected").text());
// 	$(selectRol).parents("form").find("input[id=rol_ID]").val($(selectRol).val());
// }
//});


//////////////////////identificar la opcion seleccionada por defecto en select y setearlo a un elemento/////////////////////////
// 	var primer = 0;
// 	if (primer == 0) {
// 		if ($(selectRol).parent("div").siblings("form").find("input[id*=Rol]").length) {
// 			$("input#nomRol	").val(v.nomRol);
// 			$(selectRol).parent("div").siblings("form")
// 					.find("input[id=rol_ID]").val(v.rol_ID);
// 		}
// 		if ($(selectRol).parents("form").find("input[id*=Rol]").length) {
// 			$("input#nom_Rol").val(v.nomRol);
// 			$(selectRol).parents("form").find("input[id=rol_ID]").val(v.rol_ID);
// 		}
// 		primer += 1;
// 	}
///////////////////////////////limpiar texto de los formularios///////////////////////////////7777
// function limpiar(form) {
// 	$(form).find("input").each(function(i, v) {
// 		if($(v).is("#metodo")){
// 			$(v).val("guardar");
// 		}else{
// 			$(v).val("");
// 		}
// 	});
// }
</script>