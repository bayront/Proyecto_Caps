<%@page import="jdk.nashorn.internal.ir.WhileNode"%>
<%@page import="Datos.DT_Usuario_Rol, Datos.DTUsuario, Datos.DT_Rol, java.util.*, Entidades.Usuario, Entidades.Rol, Datos.DT_Vw_rol_opciones, java.sql.ResultSet ;"%>
<%@page language="java"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%> 
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
	
	Rol rol = new Rol();
	rol = (Rol)session.getAttribute("Rol");
	
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
	
	if(us != null && rol != null)
	{
		resultset=dtvro.obtenerOpc(rol);
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
<!--///////////////////////div donde se muestra un Dialogo ///////////////////////////////-->
<div id="dialog" class="col-xm-offset-1 col-xm-10">
	<div class="contenido" style="margin-left: 20px;"></div>
</div>
<!--///////////////////////Directorios donde estan los jsp /////////////////////////////// -->
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Usuarios y Roles</a></li>
		</ol>
	</div>
</div>
<!--///////////////////////DataTable de las categorias de usuarios y roles/////////////////////////////// -->
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-th"></i> <span>Lista de Usuarios y Roles</span>
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
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="dt_RolUsuario" style="width:100%;">
					<thead>
						<tr>
							<th>Usuario</th>
							<th>Rol</th>
							<th>Acción</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
	<!---------------------------- AQUI EMPIEZA FORMULARIO DE ROL USUARIO ---------------------------->
<div class="row" id="formularioUsuarioRol">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-search"></i> <span>Asignar Roles a Usuarios</span>
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
			<div class="box-content">
				<h4 class="page-header">Datos</h4>
				<form class="form-horizontal form_Usuario_Rol" role="form">
					<input type="hidden" id="opcion" name="opcion" value="guardar">
					<%
	  					DTUsuario dt = DTUsuario.getInstance();
						ArrayList<Usuario> listaU = new ArrayList<Usuario>();
						ResultSet rs = dt.cargarUsuarios();
						while(rs.next()){
							Usuario usu = new Usuario();
							usu.setUsuario_ID(rs.getInt("Usuario_ID"));
							usu.setLogin(rs.getString("login"));
							listaU.add(usu);
						}
				    %> 
						<div class="form-group has-warning has-feedback">
							<label class="col-sm-4 control-label">Seleccione el usuario</label>
							<div class="col-sm-4">
								<select id= "login" name="login" type = "simple" class="populate placeholder">
									<option value="">-- Seleccione --</option>
								<%
 									for(int i = 0; i < listaU.size(); i++){ 
 								%> 
										<option value="<%=listaU.get(i).getUsuario_ID() %>"> <%=listaU.get(i).getLogin() %></option>
								<%
									} 
								%> 
								</select>
							</div>
						</div>
					<%
					DT_Rol dtr = DT_Rol.getInstance();
					ArrayList<Rol> listaR = new ArrayList<Rol>();
					ResultSet rs2 = dtr.cargarRol();
					while(rs2.next()){
						Rol r = new Rol();
						r.setRol_ID(rs2.getInt("Rol_ID"));
						r.setNomRol(rs2.getString("nomRol"));
						listaR.add(r);
					} 
						
 					%> 
					<div class="form-group has-warning has-feedback">
						<label class="col-sm-4 control-label">Seleccione el rol</label>
						<div class="col-sm-4">
							<select id= "rol" name="rol" type = "simple"
								class="populate placeholder">
								<option value="">-- Seleccione --</option>
							<%
								for(int i = 0; i < listaR.size(); i++){ 
							%> 
									<option value="<%=listaR.get(i).getRol_ID() %>"> <%=listaR.get(i).getNomRol() %></option>
							<%
							} 
							%> 
							</select>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-3 col-sm-3">
							<button type="submit" class="btn btn-primary btn-label-left btn-lg" 
							id="guardar" style="margin-left: 30px;">
								<span><i class="fa fa-save"></i></span> Guardar
							</button>
						</div>
						<div class="col-sm-4">
							<button type="button"
								class="btn btn-default btn-label-left btn-lg" onclick="cancelar();">
								<span><i class="fa fa-reply txt-danger"></i></span> Cancelar
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-------------- AQUI TERMINA FORMULARIO DE ROL USUARIO ------------------------>

<!--///////////////////////Formulario y dialogo de eliminción/////////////////////////////// -->
<div>
	<form id="frmEliminarRolusu" action="" method="DELETE">
		<input type="hidden" id="Rol_ID" name="Rol_ID" value="">
		<input type="hidden" id="Usuario_ID" name="Usuario_ID" value="">
		<!-- MODAL -->
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
var expand1 = new Expand1();/////////////se crean los objetos que representan los botones de cada dialogo
var colap1 = new Colap1();
var expand2 = new Expand2();
var colap2 = new Colap2();
////////////////////correr Select2 plugin en los elementos select////////////////////////////////////
function DemoSelect2(){
	$('#login').select2({placeholder: "Seleccione Usuario..."});
	$('#rol').select2({placeholder: "Seleccione Rol..."});
}
var cancelar = function() {/////////////////////cancela la acción limpiando el texto y colapsando el formulario
	limpiar_texto();
	document.getElementById('formularioUsuarioRol').style.display = 'none';
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
function AllTables() {
	listar();
	LoadSelect2Script(MakeSelect2);
}
var limpiar_texto = function() {/////////////////////////limpiar texto del formulario
	$("#opcion").val("guardar");
	$("#login").val("").change();
	$("#rol").val("").change();
}
var verResultado = function(r) {
	if(r == "BIEN"){
		mostrarMensaje("#dialog", "CORRECTO",
				"¡Se realizó la operación correctamente, todo bien!","#d7f9ec", "btn-info");
		limpiar_texto();
		$('#dt_RolUsuario').DataTable().ajax.reload();
	}else if(r == "ERROR"){
		mostrarMensaje("#dialog", "ERROR",
				"¡Ha ocurrido un error, no se pudo realizar la operación!","#E97D7D", "btn-danger");
	}else if(r =="VACIO"){
		mostrarMensaje("#dialog", "VACIO",
				"¡No se especificó la operación a realizar!", "#FFF8A7","btn-warning");
	}else if(r == "NADA"){
		mostrarMensaje("#dialog", "SIN LLENAR",
				"¡Debe seleccionar el rol y el usuario!", "#FFF8A7","btn-warning");
	}
}
///////////////////////////////////guardar los datos setados en el formulario///////////////////////////////////////
var guardar = function() {
	$("form").on("submit", function(e) {
		e.preventDefault();//detiene el evento
		if($("#login").val()!="" && $("#rol").val()!=""){
			var frm = $(this).serialize();//parsea los datos del formulario
			console.log(frm);
			$.ajax({//enviar datos por ajax
				method:"GET",
				url:"Autenticación",
				data: frm//datos a enviar
			}).done(function(info) {//informacion que el servlet le reenvia al jsp
				verResultado(info);
				if (expand1.valor == true)
					validarExpand(expand1, "#expandir1");
				if (expand2.valor == true)
					validarExpand(expand2, "#expandir2");
				validarColap(colap1, "#colapsar_desplegar1");
				if (colap2.valor == true) {
				} else {
					validarColap(colap2, "#colapsar_desplegar2");
				}
			});
		}else
			verResultado("NADA");
	});
}
//////////////////////////////////eliminar los datos seteados en el formulario/////////////////////////////////////
var eliminar = function() {
	$("#eliminar_rolusu").on("click", function() {
		var Usuario_ID = $("#frmEliminarRolusu #Usuario_ID").val();
		var Rol_ID = $("#frmEliminarRolusu #Rol_ID").val();
		$.ajax({
			method:"DELETE",
			url:"Autenticación",
			headers: {"Usuario_ID": Usuario_ID, "Rol_ID": Rol_ID}
		}).done(function(info) {
			 	limpiar_texto();
			 	verResultado(info);
		});
		CloseModalBox();
	});
}
function abrirDialogo() {////////////////////abre dialogo con muestra si desae eliminar el registro del contrato
	OpenModalBox(
		"<div><h3>Borrar Rol para este Usuario</h3></div>",
		"<p Style='text-align:center; color:salmon; font-size:x-large;'>¿Esta seguro que desea eliminar este registro?</p>",
		"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-2 col-md-3'> "
			+ "<button type='button' id='eliminar_rolusu' class='btn btn-danger btn-label-left'"
			+" style='color:#ece1e1;' >"
			+ "<span><i class='fa fa-trash-o'></i></span>Eliminar registro </button>"
			+ "<div style='margin-top: 5px;'></div>"
			+ "</div> <div class='col-sm-12 col-md-offset-1 col-md-3 text-center' Style='margin-bottom: -10px;'>"
			+ "<button type='button' class='btn btn-default btn-label-left' Style='margin-left: 10px;' onclick='CloseModalBox()'>"
			+ "<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
	eliminar();
}
var agregar_nuevo_rolusuario = function() {///////////////////agregar nuevo registro limpiando texto y abriendo el form
	document.getElementById('formularioUsuarioRol').style.display = 'block';
	//$("#expandir1").prop('disabled', true);
	limpiar_texto();
	validarExpand(expand1, "#expandir1");
	if (colap1.valor == false)
		validarColap(colap1, "#colapsar_desplegar1");
	validarColap(colap2, "#colapsar_desplegar2");
	if (expand2.valor == true)
		validarExpand(expand2, "#expandir2");
	$("select#login").focus();
}
var obtener_id_eliminar = function(tbody, table) {
	$(tbody).on("click", "button.eliminarContrato", function() {
		var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
		var Rol_ID, Usuario_ID;
		table.rows().every(function(index, loop, rowloop) {
			if(index == datos){
				Usuario_ID = table.row(index).data().usuario_id;
				Rol_ID = table.row(index).data().rol_id;
				$("#frmEliminarRolusu #Usuario_ID").val(Usuario_ID);
				$("#frmEliminarRolusu #Rol_ID").val(Rol_ID);
			}
		});
		//solo se obtiene el id que es oculto
		abrirDialogo();
	});
}
var listar = function() {
	var tablaContrato = $('#dt_RolUsuario').DataTable( {
		responsive: true,
		'destroy': true,
		'bProcessing': false,
		'bServerSide': false,
		ajax: {
			"method":"GET",
			"url":"Autenticación",
			"dataSrc":"aaData",
			"data":{"opcion":"cargar"}
		},
		"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
    	"bJQueryUI": true,
		"language":idioma_esp,
		drawCallback : function(settings) {
			var api = this.api();
			$('td', api.table().container()).find("button").tooltip({container : 'body'	});
			$("a.btn").tooltip({container : 'body'});
		},
		"columns": [
            { "data": "usuario.login"},
            { "data": "rol.nomRol"},
            {"defaultContent":
				"<button type='button' class='eliminarContrato btn btn-danger' data-toggle='tooltip' "+
				"data-placement='top' title='Eliminar Rol al usuario'>"+
				"<i class='fa fa-trash-o'></i> </button>"}
            ],
            "dom":"<rt><'row'<'form-inline' <'col-sm-12 text-center'B>>>"
				 +"<'row' <'form-inline' <'col-sm-6'l><'col-sm-6'f>>>"
				 +"<rt>"
				 +"<'row'<'form-inline'"
				 +"<'col-sm-6 col-md-6 col-lg-6'i><'col-sm-6 col-md-6 col-lg-6'p>>>",
            "buttons":[{
				"text": "<i class='fa fa-user-plus'></i>",
				"titleAttr": "Agregar rol al usuario",
				"className": "btn btn-success",
				"action": function() {
					agregar_nuevo_rolusuario();
				}
			},
            {
                extend:    'csvHtml5',
                text:      '<i class="fa fa-file-text-o"></i>',
                titleAttr: 'csv'
            }]
	});
	obtener_id_eliminar('#dt_RolUsuario tbody',tablaContrato);
}
$(document).ready(function() {
	// Add slider for change test input length
	FormLayoutExampleInputLength($( ".slider-style" ));
	
	// Add tooltip to form-controls
	$('.form-control').tooltip();
	
	LoadSelect2Script(DemoSelect2);
	
	// Add drag-n-drop feature to boxes
	WinMove();
	//obtenerFechaActual();
	
	guardar();//activar evento de guardar
	
	LoadDataTablesScripts2(AllTables);
});
</script>