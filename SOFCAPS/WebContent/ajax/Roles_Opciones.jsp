<%@page language="java"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8" import="Entidades.Usuario, Entidades.Rol, Datos.DT_Vw_rol_opciones,java.sql.ResultSet ;"%> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
%>
<%
	DT_Vw_rol_opciones dtvro = new DT_Vw_rol_opciones();

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
<div id="dialogCat" class= "col-xm-offset-1 col-xm-10">
	<div class="contenido" style="margin-left: 20px;"></div>
</div>  
<!--///////////////////////Directorios donde estan los jsp /////////////////////////////// -->
<div class="row">
	<div id="breadcrumb" class="col-xs-12">
		<ol class="breadcrumb">
			<!--<li><a href="index.html">Home</a></li>-->
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Roles y Opciones</a></li>
		</ol>
	</div>
</div>
<!--///////////////////////Final de los directorios/////////////////////////////// -->

<!--///////////////////////MODAL PARA MOSTRAR FORMULARIOS /////////////////////////////// -->
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
		<h3>Gestión de Roles y Opciones</h3>
	</div>
</div>
<!--End Dashboard 1-->
<!--Start Dashboard 2-->
<div class="row-fluid">
	<div id="dashboard_links" class="col-xs-12 col-sm-2 pull-right">
		<ul class="nav nav-pills nav-stacked"
		style="background: #4C9480 url(./img/devoops_pattern_b10.png) 0 0 repeat;">
			<li class="active"><a href="#" class="tab-link" id="Rol">Roles</a></li>
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
								<a class="cerrar" title="Inhabilitado"> 
									<i class="fa fa-times"></i></a>
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
		<div id="dashboard-Rol_Opcion" class="row"
		style="visibility: hidden; position: absolute;">
			<div class="col-xs-12" style="margin-top: 20px;">
				<h4 class="page-header">Asignar Opciones a Roles</h4>
			</div>

			<form class="form-horizontal formRolOpcion" role="form"
				id="defaultForm" method="post" action="./SL_RolOpcion">
				
				<div class="form-group">
					<label style="margin-left:5px;" class="col-sm-3 text-right control-label">Roles</label>
					<div class="col-sm-6">
						<select style="margin-left:5px;" class="populate placeholder" name="rol1" id="rol1">
							<option value="">ROLES</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-12 col-md-offset-4 col-md-3">
						<button style="margin-left:30px;" class="btn btn-primary btn-label-left btn-lg" 
						id="nuevaOpcion" type="button">
							<span><i class="fa fa-save"></i></span> Nueva opción
						</button>
					</div>
				</div>
				<fieldset>
					<legend style="margin-left:5px;">Opciones</legend>
				</fieldset>
			</form>
			<div class="row">
				<div class="col-xs-12 col-sm-12  col-md-offset-1 col-md-10">
					<div class="box" style="top: 0px; left: 0px; opacity: 1;">
						<div class="box-header">
							<div class="box-name">
								<i class="fa fa-sitemap"></i> <span>Opciones del rol</span>
							</div>
							<div class="box-icons">
								<a id="colapsar_desplegar2" class="collapse-link"> 
									<i class="fa fa-chevron-up"></i></a> 
								<a id="expandir2" class="expand-link" onclick="validar(expand2);" >
									<i class="fa fa-expand"></i></a>
							</div>
							<div class="no-move"></div>
						</div>
						<div class="box-content">
							<div class="text-center" id="OcultarCancelarOp" style="display:none;">
								<button type='button' class='btn btn-default btn-label-left btn-lg' 
								onclick='cancelarAgOpcion();' >
								<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button>
							</div>
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
			<div class="clearfix"></div>
			<div style="height: 15px;"></div>
		</div>
		<!--End Dashboard Tab 2-->
		
	</div>
	<div class="clearfix"></div>
</div>
<!--End Dashboard 2 -->

<div style="height: 40px;"></div>

<script type="text/javascript">
var nomRolValid = "";
var servlet="";
var expand2 = new Expand2();//validacion para expandir el dialogo2
/////////////////////////////////////columnas que se veran en el datatable de opciones////////////////////////////// 
var columns_Rol_Opcion = [ { "data": "opcion" },
    {"defaultContent":"<button type='button' class='eliminarOpcion btn btn-danger' data-toggle='tooltip' "+
		"data-placement='top' title='Eliminar opción'>"+
		"<i class='fa fa-trash-o'></i> </button>"}];
var columns_Opcion = [{ "data": "opcion" },
	{ "data": "descripcion" },
    {"defaultContent":"<button type='button' class='seleccionarOpcion btn btn-primary' data-toggle='tooltip' "+
		"data-placement='top' title='Seleccionar opción'>"+
		"<i class='fa fa-upload'></i> </button>"}];

function DemoSelect2() {
	$('#rol1').select2();
}

/////////////////////////////////////metodo para cargar sobre un select rol los registros/////////////////////////////////
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
        		$(selectRol).append('<option value="' + v.rol_ID + '">' + v.nomRol + '</option>');
			});
        }
	});
}
////////////////////////////////metodo para activar click en los tag y cargar los roles//////////////////////////////////
var activarDatosSelect = function(tag, rol) {//recibe el tag para click y el select-rol
	tag.on("click", function() {
		cargarSelectRol(rol);
	});
}
//////////////////////funsión que muestra un dialogo con los resultados del servlet/////////////////////
var verResultado = function(r) {
	if(r == "BIEN"){
		mostrarMensaje("#dialogCat", "CORRECTO", 
				"¡Se realizó la operación correctamente, todo bien!", "#d7f9ec", "btn-info");
		recargarRol();
		if($.fn.DataTable.isDataTable('#tabla_opcion')){
			if($("#tabla_opcion thead th#desc").length){
				$('#tabla_opcion').DataTable().state.clear();
				$('#tabla_opcion').DataTable().clear().draw();
				$("#tabla_opcion").DataTable().destroy();
				$("#tabla_opcion thead th#desc").remove();
 				$('#rol1').val();
 				$('#rol1').change();
 				validarExpand(expand2, "#expandir2");
			}else{
				$('#rol1').val();
				$('#rol1').change();
			}
		}
	}
	if(r == "ERROR"){
		mostrarMensaje("#dialogCat", "ERROR", 
				"¡Ha ocurrido un error, no se pudo realizar la operación!", "#E97D7D", "btn-danger");
	}
	if(r =="VACIO"){
		mostrarMensaje("#dialogCat", "VACIO", 
				"¡No se especificó la opreración a realizar!", "#FFF8A7", "btn-warning");
	}
}
//////////////////////////////////funsión que abre el dialogo con los datos pasados y llama a un callback que activa
/////////////////////////////////el formulario para enviar datos al servlet y luego manda a llamar a una funsión
/////////////////////////////////que valida los datos del formulario///////////////////////////////////////////////////
function abrirDialogo(head, body, food) {
	OpenModalBox(head, body, food);
	LoadBootstrapValidatorScript(formularioValid);
}
/////////////funsión que se llama al dar click al tag de roles que recarga el dataTabel de roles//////////////////////
function recargarRol() {
	$('#tabla_rol').DataTable().ajax.reload();
}
/////////////////////////////funsión que cancela el método para agregar nuevas opciones///////////////////////////////
function cancelarAgOpcion(){
	$('#tabla_opcion').DataTable().state.clear();
	$('#tabla_opcion').DataTable().clear().draw();
	$("#tabla_opcion").DataTable().destroy();
	$("#tabla_opcion thead th#desc").remove();
	$('#rol1').val();
	$('#rol1').change();
	CloseModalBox();
	if(expand2.valor == true)
		validarExpand(expand2, "#expandir2");
	
	$("#OcultarCancelarOp").css("display","none");
}
////////////////////////funsión que activa el evento click sobre el boton agregar opcion de dataTable////////////////
var seleccionarAgregarOpcion = function(tbody, table) {
	$(tbody).on("click", "button.seleccionarOpcion", function() {
		var datos = table.row($(this).parents("tr")).index();
		var opcion_ID, rol_ID;
		table.rows().every(function(index, loop, rowloop) {
			if(index == datos){
				opcion_ID = table.row(index).data().opcion_ID;
				rol_ID = $("select#rol1").val();
			}
		});
		var head = "<div><h3>Agregar Opción al Rol</h3></div>";
		var body  = "<p Style='text-align:center; color:#3bade6; font-size:x-large;'>¿Esta seguro que desea agregar esta opción?</p>";
		var foot = frmOpcionAg +
		"<input type='hidden' id='opcion_ID' type='text' class='form-control' name='opcion_ID' value="+opcion_ID+" />"+
		"<input type='hidden' id='rol_ID' type='text' class='form-control' name='rol_ID' value="+rol_ID+" />"+
		"<div class='col-sm-12 col-md-offset-3 col-md-3'>"+ frmOpcionAg2;
		servlet = "SL_Rol_Opcion";
		abrirDialogo(head, body, foot);
	});
}
/////////////////////////////funsión que se activa cuando se quiere agregar una opcion al rol/////////////////////////
var agregarOpcion = function() {
	$("#nuevaOpcion").on("click",function(){
		$("#OcultarCancelarOp").css("display","block");
		if($("#tabla_opcion thead th#desc").length){
			$('#tabla_opcion').DataTable().state.clear();
			$('#tabla_opcion').DataTable().clear().draw();
			$.ajax({
		        type: "GET",
		        url: "./SL_Opcion",
		        success: function(response){
		        	$('#tabla_opcion').DataTable().rows.add(response.aaData).draw();
		        }
			});
			if(expand2.valor == false)
				validarExpand(expand2, "#expandir2");
		}else{
			$("#tabla_opcion thead th:contains('Opción')").after("<th id='desc'>Descripción</th>");
			$("#tabla_opcion").DataTable().destroy();
			listarOpcion(0,"./SL_Opcion", columns_Opcion, seleccionarAgregarOpcion);
			if(expand2.valor == false)
				validarExpand(expand2, "#expandir2");
		}
	});
}
////////////////////////////////funsion que lista las opciones///////////////////////////////////////////////////////////////
var listarOpcion = function(rol_ID, servlet, columns, callback) {
	var tablaOpcion = $('#tabla_opcion').DataTable( {
		responsive: true,
		"destroy": true,
		"stateSave": false,
		'bProcessing': false,
		'bServerSide': false,
		ajax: {
			"method":"GET",
			"url":servlet,
			"data": {"rol_ID": rol_ID//para decirle al servlet que cargue datos
		    },
			"dataSrc":"aaData"
		},
		"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
		"language":idioma_esp,
		drawCallback: function(settings){
            var api = this.api();
            $('td', api.table().container()).find("button").tooltip({container : 'body'});
        },
		"columns": columns,
            "dom":"<'row' <'form-inline' <'col-sm-6'l><'col-sm-6'f>>>"
				 +"<rt>"
				 +"<'row'<'form-inline'"
				 +"<'col-sm-6 col-md-6 col-lg-6'i><'col-sm-6 col-md-6 col-lg-6'p>>>"
	});
	callback('#tabla_opcion tbody', tablaOpcion);
}
/////////////////////funsión que activa el evento click sobre le boton eliminar del datatable opcion///////////////
var seleccionarEliminarOpcion = function(tbody, table) {
	$(tbody).on("click", "button.eliminarOpcion", function() {
		var datos = table.row($(this).parents("tr")).index();
		var opcion_ID, rol_ID;
		table.rows().every(function(index, loop, rowloop) {
			if(index == datos){
				opcion_ID = table.row(index).data().opcion_ID;
				rol_ID = $("select#rol1").val();
			}
		});
		var head = "<div><h3>Eliminar Opción</h3></div>";
		var body  = "<p Style='text-align:center; color:salmon; font-size:x-large;'>¿Esta seguro de borrar esta opción?</p>";
		var foot = frmOpcionElim +
		"<input type='hidden' id='opcion_ID' type='text' class='form-control' name='opcion_ID' value="+opcion_ID+" />"+
		"<input type='hidden' id='rol_ID' type='text' class='form-control' name='rol_ID' value="+rol_ID+" />"+
		"<div class='col-sm-12 col-md-offset-3 col-md-3'>"+
		"<button type='submit' class='btn btn-danger btn-label-left guardarForm' style='margin-left:5px;color:#ece1e1;'>"+
		"<span><i class='fa fa-trash-o'></i></span> Eliminar opción </button> </div>"+
		"<div class='col-sm-12 col-md-3 text-center'>"+
		"<button type='button' class='btn btn-default btn-label-left btn-lg' onclick='CloseModalBox();' >"+
		"<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button>"+
		"</div> </form>";
		servlet = "SL_Rol_Opcion";
		abrirDialogo(head, body, foot);
	});
}
/////////////////////////funsión que lista los roles en el dataTable///////////////////////////////////
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
		drawCallback: function(settings){
            var api = this.api();
            $('td', api.table().container()).find("button").tooltip({container : 'body'});
            $("a.btn").tooltip({container: 'body'});
        },
		"columns": [
            { "data": "nomRol" },
            {"defaultContent":"<button type='button' class='editarRol btn btn-primary' data-toggle='tooltip' "+
				"data-placement='top' title='Editar rol'>"+
				"<i class='fa fa-pencil-square-o'></i> </button>  "+
				"<button type='button' class='eliminarRol btn btn-danger' data-toggle='tooltip' "+
				"data-placement='top' title='Eliminar rol'>"+
				"<i class='fa fa-trash-o'></i> </button>  "+
				"<button type='button' class='verOpcion btn btn-warning' data-toggle='tooltip' "+
				"data-placement='top' title='ver opciones'>"+
				"<i class='fa fa-sitemap'></i> </button>"
			}
            ],
            "dom":"<rt><'row'<'form-inline' <'col-sm-12 text-center'B>>>"
				 +"<'row' <'form-inline' <'col-sm-6'l><'col-sm-6'f>>>"
				 +"<rt>"
				 +"<'row'<'form-inline'"
				 +"<'col-sm-6 col-md-6 col-lg-6'i><'col-sm-6 col-md-6 col-lg-6'p>>>",
            "buttons":[{
				"text": "<i class='fa fa-plus-square'></i>",
				"titleAttr": "Agregar Rol",
				"className": "btn btn-success",
				"action": function() {
					var head = "<div><h3>Formulario de Roles</h3></div>";
					var body = frmRolAg;//frmRol esta abajo
					var foot = "<div Style='text-align: center; margin-bottom: -10px;'>"+
						"<button type='button' class='btn btn-default btn-label-left btn-lg' Style='margin-left: 10px;'"+
						"onclick='CloseModalBox()'><span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>";
					servlet = "SL_Rol";
					abrirDialogo(head, body, foot);
				}
			}]
	});
	seleccionarEditarRol('#tabla_rol tbody', tablaRol);
	seleccionarEliminarRol('#tabla_rol tbody', tablaRol);
	seleccionarVerOpcion('#tabla_rol tbody', tablaRol);
	LoadSelect2Script(MakeSelect2);
}
/////////////////////////////funsión que envia el rol al otro tag para ver los roles//////////////////
var seleccionarVerOpcion = function(tbody, table) {
	$(tbody).on("click", "button.verOpcion", function() {
		var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
		var rol_ID;
		table.rows().every(function(index, loop, rowloop) {
 			if(index == datos){
				rol_ID = table.row(index).data().rol_ID;
			}
		});
		$('div#dashboard_tabs').find('div[id^=dashboard]').each(function(){
			$(this).css('visibility', 'hidden').css('position', 'absolute');
		});
		var attr = "Rol_Opcion";
		$('#'+'dashboard-'+attr).css('visibility', 'visible').css('position', 'relative');
		$("a#"+attr).closest('.nav').find('li').removeClass('active');
		$("a#"+attr).closest('li').addClass('active');
		
		$("select#rol1").val(rol_ID);
		$("select#rol1").change();
	});
}
/////////////////////////funsión que activa el boton eliminarRol del dataTable/////////////////////////////////////////
var seleccionarEliminarRol = function(tbody, table) {
	$(tbody).on("click", "button.eliminarRol", function() {
		var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
		var rol_ID;
		table.rows().every(function(index, loop, rowloop) {
			if(index == datos){
				rol_ID = table.row(index).data().rol_ID;
			}
		});
		var head = "<div><h3>Borrar Rol</h3></div>";
		var body = "<p Style='text-align:center; color:salmon; font-size:x-large;'>¿Esta seguro de borrar este rol?</p>";
		var foot = frmRolElim +
		"<input type='hidden' id='rol_ID' type='text' class='form-control' name='rol_ID' value="+rol_ID+" />"+
		"<div class='col-sm-12 col-md-offset-3 col-md-3'>"+
		"<button type='submit' class='btn btn-danger btn-label-left guardarForm' style='margin-left:5px;color:#ece1e1;'>"+
		"<span><i class='fa fa-trash-o'></i></span> Eliminar Rol </button> </div>"+
		"<div class='col-sm-12 col-md-3 text-center'>"+
		"<button type='button' class='btn btn-default btn-label-left btn-lg' onclick='CloseModalBox();' >"+
		"<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button>"+
		"</div> </form>";
		servlet = "SL_Rol";
		abrirDialogo(head, body, foot);
	});
}
///////////////////////////////////funsión que activa el boton para editar un rol del dataTable///////////////////////////
var seleccionarEditarRol = function(tbody, table) {
	$(tbody).on("click", "button.editarRol", function() {
		var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
		var rol_ID, nomRol;
		table.rows().every(function(index, loop, rowloop) {
			if(index == datos){
				rol_ID = table.row(index).data().rol_ID;
				nomRol = table.row(index).data().nomRol;
				nomRolValid = nomRol;
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
		servlet = "SL_Rol";
		abrirDialogo(head, body, foot);
	});
}
///////////////////////funsión que activa el click del tag el cual manda a llamar a un funsion para cargar datos////////////////
var activarDatosTag = function(tag, funsion) {//recibe el tag para click y el select-rol
	tag.on("click", function() {
		funsion();
	});
}
////////////////////////////funsion que activa el evento change del select de roles///////////////////
function activarChange(selectRol) {
	cargarSelectRol("#rol1");
	$(selectRol).change(function(){//cuando se elija otra opcion del select
		var rol_ID = $(selectRol).val();
		if($.fn.DataTable.isDataTable('#tabla_opcion')){
			$('#tabla_opcion').DataTable().state.clear();
			$('#tabla_opcion').DataTable().clear().draw();
			$.ajax({
		        type: "GET",
		        url: "./SL_Rol_Opcion",
		        data:{"rol_ID": rol_ID},
		        success: function(response){
		        	$('#tabla_opcion').DataTable().rows.add(response.aaData).draw();
		        }
			});
		}else{
			listarOpcion(rol_ID,"./SL_Rol_Opcion", columns_Rol_Opcion, seleccionarEliminarOpcion);
		}
	});
}
////////////////////////////////////funsión para cargar datatable rol al comienzo//////////////////////
function AllTables() {
	listarRol();
	LoadSelect2Script(MakeSelect2);
}

///////////////////////////////////FUNSIÓN PRINCIPAL////////////////////////////////////////////////////////
$(document).ready(function() {
	// Make all JS-activity for dashboard
	DashboardTabChecker();
	LoadBootstrapValidatorScript(DemoFormValidator);//validaciones
	LoadSelect2Script(DemoSelect2);
	 $('[data-toggle="tooltip"]').tooltip();
	 
	 LoadDataTablesScripts2(AllTables);
	 activarDatosTag($("li a#Rol"),recargarRol);
	 activarDatosSelect($("li a#Rol_Opcion"), "#rol1");
	 activarChange("#rol1");
	 agregarOpcion();
});

///////////////////////////////////////funsión que valida los datos del formulario de roles/////////////////////////////
function formularioValid() {
	$('form.formulario').bootstrapValidator({
		message: '¡Este valor no es valido!',
		fields: {
			nomRol:{
				validators: {
					notEmpty:{
		                message: "¡Este campo es requerido y no debe estar vacio!"
		            },
					callback: {
       					message: '¡Este campo no debe ser igual a los otros registros!',
        				callback: function (value, validator, $field) {
        					if(nomRolValid == value){
								return true;
							}
        					var tabla = $("#tabla_rol").DataTable();
        					var filas = tabla.rows();
        					var noigual = true;
            				filas.every(function(index, loop, rowloop) {
    							if(value == tabla.row(index).data().nomRol){
    								noigual = false;
    							}
            				});
            				return noigual;
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
        if($("form.formulario").find("#nomRol").length){
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
		}else if($("form.formulario").find("#nomRol").length <=0){
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
		}
    });
}
//////////////////////////////////datos que llenan el dialogo con un formulario de roles/////////////////////////////////
var frmRolAg = "<form class='form-horizontal formulario' role='form' id='defaultForm' method='post' action=''>"+
	"<input type='hidden' id='metodo' type='text' class='form-control' name='metodo' value='guardar'/>"+
	"<input type='hidden' id='rol_ID' type='text' class='form-control' name='rol_ID' />"+
	"<div class='form-group'> <label class='col-sm-3 col-md-offset-1 control-label'>Nombre del Rol</label>"+
		"<div class='col-sm-5'> <input id='nomRol' type='text' class='form-control' name='nomRol' /> </div>"+
	"</div> <div class='clearfix'></div>"+
	"<div class='form-group'> <div class='col-sm-12 col-md-offset-4 col-md-3'>"+
			"<button type='submit' class='btn btn-primary btn-label-left guardarForm' style='margin-left:70px;'>"+
				"<span><i class='fa fa-save'></i></span> Guardar Rol</button>"+
		"</div> </div> </form>";
var frmRolElim = "<form class='form-horizontal formulario' role='form' id='defaultForm'"+
	" method='post' action=''>"+
	"<input type='hidden' id='metodo' type='text' class='form-control' name='metodo' value='eliminar'/>";
var frmRolAct = "<form class='form-horizontal formulario' role='form' id='defaultForm' method='post' action=''>"+
	"<input type='hidden' id='metodo' type='text' class='form-control' name='metodo' value='actualizar'/>";
var frmRolAct2 = "</div> <div class='clearfix'></div>"+
"<div class='col-sm-12 col-md-offset-4 col-md-3'>"+
"<button type='submit' class='btn btn-success btn-label-left guardarForm' style='margin-left:55px;'>"+
"<span><i class='fa fa-repeat'></i></span> Actualizar Rol </button>"+
"</div> </form>";

var frmOpcionElim = "<form class='form-horizontal formulario' role='form' id='defaultForm' method='post' action='./SL_Rol_Opcion'>"+
	"<input type='hidden' id='metodo' name='metodo' class='form-control' value='eliminar' />";
var frmOpcionAg = "<form class='form-horizontal formulario' role='form' id='defaultForm' method='post' action='./SL_Rol_Opcion'>"+
	"<input type='hidden' id='metodo' name='metodo' class='form-control' value='guardar' />";
var frmOpcionAg2 = "<button type='submit' class='btn btn-success btn-label-left guardarForm' style='margin-left:5px;'>"+
	"<span><i class='fa fa-repeat'></i></span> Agregar Opción</button> </div>"+
	"<div class='col-sm-12 col-md-3 text-center'>"+
	"<button type='button' class='btn btn-default btn-label-left btn-lg' onclick='cancelarAgOpcion();' >"+
	"<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button>"+
	"</div> </form>";
</script>