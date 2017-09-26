<%@page import="Entidades.Usuario, Entidades.Rol, Datos.DT_Vw_rol_opciones,Entidades.Unidad_de_Medida"%>
<%@page import="Datos.DT_consumo_bomba"%>
<%@page import="Datos.DT_categoria_Ing_Engre, java.util.*, Entidades.TipoCategoria, java.sql.ResultSet ;"%>
<%@page language="java"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%> 
<%
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<div id="dialogBomb" class= "col-xm-offset-1 col-xm-10">
	<div class="contenido" style="margin-left: 20px;"></div>
</div>  
<!--///////////////////////Directorios donde estan los jsp /////////////////////////////// -->
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Consumos</a></li>
			<li><a href="#">Consumo de la bomba</a></li>
		</ol>
	</div>
</div>
<!--///////////////////////DataTable de los consumos de la bomba/////////////////////////////// -->
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-th"></i> <span>Lista de consumos de la bomba</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar2" class="collapse-link" onclick="validar(colap2);"> 
						<i class="fa fa-chevron-up"></i></a> 
					<a id="expandir2" class="expand-link" onclick="validar(expand2);"> 
						<i class="fa fa-expand"></i></a>
					<a class="cerrar" title="Inhabilitado"> 
						<i class="fa fa-times"></i></a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding table-responsive">
			<div class="form-group col-md-offset-3 col-md-6 text-center">
				<label class="control-label text-info" style="font-size: large;">Registros mostrados por periodo</label>
				<input id="anioBuscar" name="anioBuscar" type="text" class="form-control" placeholder="Año de registros"
					data-toggle="tooltip" data-placement="top" title="Año a buscar" style="text-align:center;">
				<select class="populate placeholder" name="periodoBuscar" id=periodoBuscar>
					<option value="1">Primera mitad</option>
					<option value="2">Segunda mitad</option>
				</select>
				<button id="btnBuscar" type="button" class="btn btn-info" onclick= "cargar_consumoB();" 
				style="margin-top: 5px;">Buscar registros</button>
			</div>
			<div style="text-align: center;">
					<label Style='margin-top: 10px; margin-bottom: 10px;'> <input
						type="checkbox" id="mostrar_consumoB" onclick="">MOSTRAR CONSUMO DE BOMBA INACTIVOS
					</label>
				</div>
				<table class="table table-bordered table-striped table-hover table-heading table-datatable"
					id="tbl_consumoB" style="width:100%;">
					<thead>
						<tr>
							<th>Consumo actual</th>
							<th>Fecha de registro</th>
							<th>Lectura actual</th>
							<th>Acción</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
    <!--///////////////////////Formulario principal de consumos de la bomba/////////////////////////////// -->
<div class="row" id="formularioConsumoBomba">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-edit"></i> <span>Formulario de Consumos de la Bomba</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link" id="colapsar_desplegar1" onclick="validar(colap1);"> 
					<i class="fa fa-chevron-up"></i></a> 
					<a class="expand-link"  id="expandir1" onclick="validar(expand1);"> 
					<i class="fa fa-expand"></i></a>
					<a class="cerrar_formulario_consumo_bomba" onclick="cancelar();"> 
						<i class="fa fa-times"></i></a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content">
				<form  class="form-horizontal" role="form" id="formConsB" method="post" action="validators.html">
					<input type="hidden" id="opcion" name="opcion" value="guardar">
					<input type="hidden" id="bombaID" name="bombaID" value="">
					<div class="form-group">
						<label class="col-sm-5 control-label">Lectura del mes actual: </label>
						<div class="col-sm-4">
							<input id="lecturaActual" name="lecturaActual" type="text" class="form-control" placeholder="0.0"
								data-toggle="tooltip" data-placement="top" data-bv-numeric="true" 
								title="Requerido" data-bv-numeric-message="¡Este valor no es un número!">
						</div> 
					</div>
					<div class="form-group">
						<%
						DT_consumo_bomba cb =DT_consumo_bomba.getInstance();
						ArrayList<Unidad_de_Medida> lista = new ArrayList<Unidad_de_Medida>();
						lista = cb.listaUnidadDeMedida();	
						%>
						
						<label class="col-sm-5 control-label">Unidad de medida:</label>	
						<div class="col-sm-4">
							<select class="populate placeholder" name="unidadMedida" id="unidadMedida">
<%
									for(int i = 0; i < lista.size(); i++){
								%>
										<option value="<%=lista.get(i).getUnidad_de_Medida_ID() %>"> <%=lista.get(i).getTipoMedida() %></option>
								<%
									}
								%>
							</select>
						</div>
					</div>
					
					<div class="form-group has-feedback">
					<!-- FORMA PARA CREAR PERIODOS DE TIEMPO CON JQUERY UI -->
						<label  class="col-sm-5 control-label">Fecha actual</label>
						<div class="col-sm-4">
							<input id="fecha" name="fecha" type="text" class="form-control"
								placeholder="fecha de inicio" title="Requerido">
								<span class="fa fa-calendar txt-success form-control-feedback"></span>
						</div>
					</div>
					
					<!-- Agregar espacio con clase *.clearfix* -->
					<div class="clearfix"></div>

					<div class="form-group">
						<label class="col-sm-5 control-label">Observaciones: </label>
						<!-- PARA AGREGAR VALIDACION DE NOMBRE DE USUARIO AGREGAR NAME=*username* -->
						<div class="col-sm-4">
							<textarea maxlength="250" class="form-control" rows="5" id="observaciones" name="observaciones" 
							style="max-width:100%; height:110px;" title="No Requerido"></textarea>
							<div id="contadorText">250 caracteres permitidos</div>
						</div>
					</div>
					
					<div class="form-group">

						<!-- PARA COLOR NEGRO DEJAR CON CLASE *control-label* -->
						<label class="col-sm-5 control-label">Consumo actual de la bomba: </label>
						<div class="col-sm-3">
							<!-- PARA COLOR NEGRO DEJAR CON CLASE *form-control* -->
							<input id="consumoActual" name="consumoActual" type="text" class="form-control"
								placeholder="0.0" data-toggle="tooltip"
								data-placement="top" title="Requerido" readonly>
						</div>
						
						<div class="col-sm-3">
							<button id = "btnCalcular" type="button" class="btn btn-warning btn-label-left">
								<span><i class="fa fa-gear"></i></span> Calcular consumo
							</button>
						</div>
					</div>
					
					<div class="clearfix"></div>
					
					<div class="form-group">
					<!-- Tipos de botones para enviar -->
						<div class="col-sm-offset-4 col-sm-3">
							<button id = "btnEnviar" type="submit" class="btn btn-primary btn-label-left">
								<span><i class="fa fa-save"></i></span> Guardar
							</button>
						</div>
						
						<div class="col-sm-3">
							<button id = "btnCancelar" type="button" class="btn btn-default btn-label-left" onclick= "cancelar();">
								<span><i class="fa fa-reply txt-danger"></i></span> Cancelar
							</button>
						</div>
					</div>
					
				</form>
			</div>
		</div>
	</div>
</div>
        <!--///////////////////////Formulario y dialogo de eliminación /////////////////////////////// -->
<div>
	<form id="frmEliminarConsumoB" action="" method="POST">
		<input type="hidden" id="bombaID" name="bombaID" value="">
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

 <!--///////////////////////Formulario y dialogo de activación /////////////////////////////// -->
<div>
	<form id="frmActivarConsumoB" action="" method="POST">
		<input type="hidden" id="bombaID" name="bombaID" value="">
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
</div>


<script type="text/javascript">
var wsUri = "ws://"+window.location.host+"/SOFCAPS/serverendpointdemo";
var websocket;
if (!(websocket instanceof WebSocket) || websocket.readyState !== WebSocket.OPEN) {
	websocket = new WebSocket(wsUri);
	console.log("nueva webConsumoBomba");
	//evento que notifica que la conexion esta abierta
	websocket.onopen = function(evt) { //manejamos los eventos...
	    console.log("Conectado..."); //... y aparecerá en la pantalla
	};

	//evento onmessage para resibir mensaje del serverendpoint
	websocket.onmessage = function(evt) { // cuando se recibe un mensaje
		console.log("Mensaje recibido de webConsumoBomba: " + evt.data);
		verResultado(evt.data);
	};

	//evento si hay algun error en la comunicacion con el web_socket
	websocket.onerror = function(evt) {
	    console.log("oho!.. error:" + evt.data);
	};

	websocket.onclose = function(){
		//message('<p class="event">Socket Status: '+socket.readyState+' (Closed)');
		console.log("Desconectado, status de conexión: " + websocket.readyState);
	}
}else
	console.log("no conectar webConsumoBomba");
	
var actual = false;//variable para saber si el registro es el actual
var expand1 = new Expand1();//se crean los objetos que representan los botones de cada dialogo
var colap1 =  new Colap1();
var expand2 = new Expand2();
var colap2 =  new Colap2();
/////////////////////////////////Correr plugin SELECT2 sobre los selects mencionados/////////////////////////////
function DemoSelect2() {
	$('#unidadMedida').select2();
	$('#periodoBuscar').select2();
}
//////////////////////////funsión que muestra el resultado mediant un dialogo//////////////////////////////////////
var verResultado = function(r) {//parametro(resultado-String)
	if(r == "BIEN"){
		mostrarMensaje("#dialogBomb", "CORRECTO", 
			"¡Se realizó la operación correctamente, todo bien!", "#d7f9ec", "btn-info");
		limpiar_texto();
		cargar_consumoB();
// 		$('#tbl_consumoB').DataTable().ajax.reload();
		websocket.send("ACTUALIZADO");
	}
	if(r == "ERROR"){
		mostrarMensaje("#dialogBomb", "ERROR", 
			"¡Ha ocurrido un error, no se pudo realizar la operación!", "#E97D7D", "btn-danger");
	}
	if(r =="VACIO"){
		mostrarMensaje("#dialogBomb", "VACIO", 
			"¡No se especificó la opreración a realizar!", "#FFF8A7", "btn-warning");
	}
	if(r =="ACTUALIZADO"){
		mostrarMensaje("#dialogBomb", "ACTUALIZADO", 
			"¡Otro usuario a realizado un cambio, se actualizaron los datos!", "#86b6dd", "btn-primary");
		$('#tbl_consumoB').DataTable().ajax.reload();
	}
	if(r == "NOELIMINAR"){
		mostrarMensaje("#dialogBomb", "ERROR", 
			"¡No se puede eliminar un registro anterior al actual!", "#E97D7D", "btn-danger");
	}
}
function abrirDialogo() {////////////////////abre dialogo con muestra si desae eliminar el registro del contrato
	OpenModalBox(
			"<div><h3>Borrar Consumo</h3></div>",
			"<p Style='text-align: center; color:salmon; font-size:x-large;'>¿Esta seguro que desea eliminar este registro?</p>",
			"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-3 col-md-3'>"
			+"<button type='button' id='eliminar_consumoB' class='btn btn-danger btn-label-left'"
			+" style=' color: #ece1e1;' >"
			+"<span><i class='fa fa-trash-o'></i></span> Borrar consumo </button>"
			+"<div style='margin-top: 5px;'></div> </div>"
			+"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-3 text-center'>"
			+"<button type='button' class='btn btn-default btn-label-left' onclick='CloseModalBox()'>"
			+"<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
	eliminar();
}

function abrirDialogo2() {////////////////////abre dialogo con muestra si desae eliminar el registro del contrato
	OpenModalBox(
			"<div><h3>Reactivar Consumo</h3></div>",
			"<p Style='text-align:center; color:blue; font-size:x-large;'>¿Esta seguro que desea activar este registro?</p>",
			"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-2 col-md-3'>"
			+"<button type='button' id='activar_consumoB' class='btn btn-primary btn-label-left'"
			+" style='color:#ece1e1;' >"
			+"<span><i class='fa fa-user'></i></span>Activar Consumo </button>"
			+"<div style='margin-top: 5px;'></div>"
			+"</div> <div class='col-sm-12 col-md-offset-1 col-md-3 text-center' Style='margin-bottom: -10px;'>"
			+"<button type='button' class='btn btn-default btn-label-left' Style='margin-left: 10px;' onclick='CloseModalBox()'>"
			+"<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
	activar();
}

//////////////////////////////////activar los datos seteados en el formulario/////////////////////////////////////
var activar = function() {
	$("#activar_consumoB").on("click", function() {
			frmElim = $("#frmActivarConsumoB").serialize();
			console.log("datos a activar: " + frmElim);
			$.ajax({
			method:"POST",
			url:"./SL_Consumo_bomba",
			data: frmElim
			}).done(function(info) {
			 	verResultado(info);
			});
		
		CloseModalBox();
	});
}


//////////////////////////////////eliminar los datos seteados en el formulario/////////////////////////////////////
var eliminar = function() {
	$("#eliminar_consumoB").on("click", function() {
		if(actual == false)
			verResultado("NOELIMINAR");
		else{
			frmElim = $("#frmEliminarConsumoB").serialize();
			console.log("datos a eliminar: " + frmElim);
			$.ajax({
			method:"POST",
			url:"SL_Consumo_bomba",
			data: frmElim
			}).done(function(info) {
			 	limpiar_texto();
			 	verResultado(info);
			});
		}
		CloseModalBox();
	});
}
var agregar_nuevo_consumoB = function() {//////////////agregar nuevo registro limpiando texto y abriendo el form
	document.getElementById('formularioConsumoBomba').style.display = 'block';
	limpiar_texto();
	validarExpand(expand1, "#expandir1");
	if(colap1.valor==false)
		validarColap(colap1, "#colapsar_desplegar1");
	validarColap(colap2, "#colapsar_desplegar2");
	if(expand2.valor == true)
		validarExpand(expand2, "#expandir2");
	
	$("#lecturaActual").focus();
}
	
var limpiar_texto = function() {///////////limpiar texto del formulario
	$("#opcion").val("guardar");
	$("form#formConsB #info" ).remove();
	$("#lecturaActual").val("").prop('readonly', false);
	$("#fecha").val("").removeAttr('disabled');
	$("#observaciones").val("").prop('readonly', false);
	//$("#consumoActual").val("").prop('readonly', false);
	$("#bombaID").val("");
	$("#unidadMedida").val("");
	$("#unidadMedida").change().removeAttr('disabled');
	$("#btnCalcular").removeAttr('disabled');
	$("#btnEnviar").removeAttr('disabled');
	$("#formConsB").data('bootstrapValidator').resetForm();////////////////resetear las validaciones
}
	
var cancelar = function() {////////////////cancela la acción limpiando el texto y colapsando el formulario
	limpiar_texto();
	document.getElementById('formularioConsumoBomba').style.display = 'none';
	if(expand1.valor == true)
		validarExpand(expand1, "#expandir1");
	
	if(expand2.valor == true)
		validarExpand(expand2, "#expandir2");
	
	validarColap(colap1, "#colapsar_desplegar1");
	if (colap2.valor ==true){}else{
		validarColap(colap2, "#colapsar_desplegar2");
	}
}

var boton= 1;//varaible para validar si el check de activar clientes esta checkeado
/////////////////////////////////funsion que devuelve los botones dependiendo del check///////////////////////////
function botones() {
	if(boton ==1)
		return "<button type='button' class='visualizarConsumoB btn btn-info' data-toggle='tooltip' "+
		"data-placement='top' title='Visualizar Registro'>"+
		"<i class='fa fa-info-circle'></i> </button>  "+
		"<button type='button' id='editarConsumoB' class='editarConsumoB btn btn-primary' data-toggle='tooltip' "+
		"data-placement='top' title='Editar consumo de bomba'>"+
		"<i class='fa fa-pencil-square-o'></i> </button>  "+
		"<button type='button' id='eliminar_consumoB' class='eliminar_consumoB btn btn-danger' data-toggle='tooltip' "+
		"data-placement='top' title='Eliminar consumo de bomba'>"+
		"<i class='fa fa-trash-o'></i> </button>";
	else if(boton ==2)
		return "<button type='button' style='margin-left:15px;' class='activar btn btn-primary' title='activar Consumo de la Bomba'>"
		+ "<i class='fa fa-upload'></i>"
		+ "</button>";
}
///////////////////////////////Ejecutar el metodo DataTable para llenar la Tabla///////////////////////////////////
function listarT() {
	boton= 1;
	console.log("listar bomba");
	var tablaConsumoB = $('#tbl_consumoB').DataTable( {
		responsive: true,
		"destroy": true,
		"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
    	"bJQueryUI": true,
		"language":idioma_esp,
		"order": [[ 2, "asc" ]],
		drawCallback: function(settings){
            var api = this.api();
            $('td', api.table().container()).find("button").tooltip({container : 'body'});
            $("a.btn").tooltip({container: 'body'});
        },
		"columns": [
            { "data": "consumoActual"},
            { "data": null,
                render: function ( data, type, row ) {
                	var f = new Date(data.fechaLecturaActual);
                	var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
                	return fecha;
            }},
            { "data": "lecturaActual"},
            {"mData":null,
				render: function ( data, type, row ) {
                	return botones;
				}
			} ],
            "dom":"<rt><'row'<'form-inline' <'col-sm-12 text-center'B>>>"
				 +"<'row' <'form-inline' <'col-sm-6'l><'col-sm-6'f>>>"
				 +"<rt>"
				 +"<'row'<'form-inline'"
				 +"<'col-sm-6 col-md-6 col-lg-6'i><'col-sm-6 col-md-6 col-lg-6'p>>>",
            "buttons":[{
				"text": "<i class='fa fa-user-plus'></i>",
				"titleAttr": "Agregar consumo de bomba",
				"className": "btn btn-success",
				"action": function() {
					agregar_nuevo_consumoB();
					console.log("boton nuevo");
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
	obtener_datos_editar("#tbl_consumoB tbody",tablaConsumoB);
	obtener_datos_visualizar("#tbl_consumoB tbody",tablaConsumoB);
	obtener_id_eliminar('#tbl_consumoB tbody',tablaConsumoB);
	obtener_id_activar("#tbl_consumoB tbody", $('#tbl_consumoB').DataTable());//igual para el boton activar
	
	$("#mostrar_consumoB").change(function(){//evento que carga diferentes datos si el checkbox esta activo o no
		if($(this).is(':checked')){
        	boton= 2;
			document.getElementById('formularioConsumoBomba').style.display = 'none';
			cargar_consumoB();
        }else{
        	boton= 1;
        	cargar_consumoB();
        }
	});
	cargar_consumoB();
}
//////////////////////////////////////metodo para llenar al dataTable con los Contratos anulado////////////////////////
var cargar_consumoB = function() {
	console.log("Cargando DataTable para activación: "+boton+", "+$("input#anioBuscar").val()+", "+$("select#periodoBuscar").val());
	$('#tbl_consumoB').DataTable().state.clear();
	$('#tbl_consumoB').DataTable().clear().draw();
	$.ajax({
        type: "GET",
        url: "./SL_Consumo_bomba",
        data: {
	        "carga": boton,
	        "anioB": $("input#anioBuscar").val(),
	        "periodoB": $("select#periodoBuscar").val()
	    },
        success: function(response){
        	$('#tbl_consumoB').DataTable().rows.add(response.aaData).draw();
        }
	});
}

/////////////////////////funsión que activa el evento click para eliminar un registro del dataTable///////////////////
var obtener_id_activar = function(tbody, table) {//parametro(id_tabla, objeto dataTable)
	console.log("activar");
	$(tbody).on("click", "button.activar", function() {
		var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
		var bomba_ID;
		table.rows().every(function(index, loop, rowloop) {
			if(index == datos){
				bomba_ID = table.row(index).data().bomba_ID;
				$("#frmActivarConsumoB #bombaID").val(bomba_ID);
			}
		});
		abrirDialogo2();
	});
}

/////////////////////////funsión que activa el evento click para eliminar un registro del dataTable///////////////////
var obtener_id_eliminar = function(tbody, table) {//parametro(id_tabla, objeto dataTable)
	console.log("eliminar");
	$(tbody).on("click", "button.eliminar_consumoB", function() {
		var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
		var bomba_ID, lecturaActual;
		table.rows().every(function(index, loop, rowloop) {
			if(index == datos){
				lecturaActual = table.row(index).data().lecturaActual;
				bomba_ID = table.row(index).data().bomba_ID;
				$("#frmEliminarConsumoB #bombaID").val(bomba_ID);
			}
		});
		table.rows().every(function(index, loop, rowloop) {
			if(lecturaActual < table.row(index).data().lecturaActual)
				actual = false;
			else
				actual = true;
		});
		//solo se obtiene el id que es oculto
		abrirDialogo();
	});
}
///////////////////////////funsión que activa el evento click del boton visualizar del dataTable///////////////////////
var obtener_datos_visualizar = function(tbody, table) {//parametro(id_tabla, objeto dataTable)
	$(tbody).on("click", "button.visualizarConsumoB", function() {
		var datos = table.row($(this).parents("tr")).index();
		var fecha;
		table.rows().every(function(index, loop, rowloop) {
			if(index == datos){
				$("form#formConsB #info" ).remove();
				$("form#formConsB").prepend("<h2 id='info' Style='color:#3276D7; text-align:center;'>Visualización del Registro</h2>");
				var f = new Date(table.row(index).data().fechaLecturaActual);
            	var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
				$("#lecturaActual").val(table.row(index).data().lecturaActual).prop('readonly', true);
				$("#bombaID").val(table.row(index).data().bomba_ID);
				$("#fecha").val(fecha).attr('disabled', 'disabled');
				$("#consumoActual").val(table.row(index).data().consumoActual).prop('readonly', true);
				$("#observaciones").val(table.row(index).data().observaciones).prop('readonly', true);
				$("#unidadMedida").val(table.row(index).data().unidad_de_Medida.unidad_de_Medida_ID);
				$("#unidadMedida").change().attr('disabled', 'disabled');
				$("#opcion").val("visualizar");
				$("#btnCalcular").attr('disabled', 'disabled');
				$("#btnEnviar").attr('disabled', 'disabled');
			}
		});
		document.getElementById('formularioConsumoBomba').style.display = 'block';
		validarExpand(expand1, "#expandir1");
		if(colap1.valor==false)
			validarColap(colap1, "#colapsar_desplegar1");
		validarColap(colap2, "#colapsar_desplegar2");
		if(expand2.valor == true)
			validarExpand(expand2, "#expandir2");
	});
}
///////////////////////////funsión que activa el evento click del boton editar del dataTable///////////////////////
var obtener_datos_editar = function(tbody, table) {//parametro(id_tabla, objeto dataTable)
	console.log("modificar");
	$(tbody).on("click", "button.editarConsumoB", function() {
		var datos = table.row($(this).parents("tr")).index();
		var consumoActual, lecturaActual, fecha, observaciones, bombID, unidadMedidaID;
		table.rows().every(function(index, loop, rowloop) {
			if(index == datos){
				bombID = table.row(index).data().bomba_ID;
				consumoActual = table.row(index).data().consumoActual;
				lecturaActual = table.row(index).data().lecturaActual;
				var f = new Date(table.row(index).data().fechaLecturaActual);
            	var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
				observaciones = table.row(index).data().observaciones;
				unidadMedidaID = table.row(index).data().unidad_de_Medida.unidad_de_Medida_ID;
				$("#lecturaActual").val(lecturaActual);
				$("#bombaID").val(bombID);
				$("#fecha").val(fecha);
				$("#consumoActual").val(consumoActual);
				$("#observaciones").val(observaciones);
				$("#unidadMedida").val(unidadMedidaID);
				$("#unidadMedida").change();
				$("#opcion").val("actualizar");
			}
		});
		table.rows().every(function(index, loop, rowloop) {
			if(lecturaActual < table.row(index).data().lecturaActual)
				actual = false;
			else
				actual = true;
		});
		document.getElementById('formularioConsumoBomba').style.display = 'block';
		validarExpand(expand1, "#expandir1");
		if(colap1.valor==false)
			validarColap(colap1, "#colapsar_desplegar1");
		validarColap(colap2, "#colapsar_desplegar2");
		if(expand2.valor == true)
			validarExpand(expand2, "#expandir2");
	});
}	
////////////////////////////////Funsión para cargar los plugin de botones de dataTables y listar la tabla////////////////
function AllTables() {
	//cargar PDF Y EXCEL
	$.getScript('plugins/datatables/nuevo/jszip.min.js', function(){
		$.getScript('plugins/datatables/nuevo/pdfmake.min.js',function(){
			$.getScript('plugins/datatables/nuevo/vfs_fonts.js',function(){
				console.log("PDF Y EXCEL cargado");
				listarT();
				LoadSelect2Script(MakeSelect2);
			});
		});
	});
}
/////////////////////////////////////////////////FUNSIÓN PRINCIPAL/////////////////////////////////////////////////
$(document).ready(function() {
	var d = new Date();
	$("input#anioBuscar").val(d.getFullYear());
	
	LoadDataTablesScripts2(AllTables);
	
	LoadSelect2Script(DemoSelect2);	
	$('#fecha').datepicker({
		setDate : new Date(),
		dateFormat: 'dd/mm/yy',
		onSelect: function(dateText, inst) {
			$("#fecha").val(dateText.toString());
			$("#fecha").change();
			$('#formConsB').bootstrapValidator('revalidateField', 'fecha');
		}
	});
	
	//Añadir tootlip para form-controls
	$('.form-control').tooltip();
	
	// Cargar plugin de validaciones
	LoadBootstrapValidatorScript(formValidBomba);
	
	///////////////////evento click que calcula el consumo via ajax
	$("#btnCalcular").click(function(){
		var bombaID = $("#formConsB #bombaID").val();
		var lecturaActual = $("#lecturaActual").val();
		var opcion = $("#formConsB #opcion").val();
		$.ajax({
			method: "post",
			url: "SL_calcular_ConsumoBomba",
			data: {"bombaID": bombaID, "opcion": opcion, "lecturaActual" :lecturaActual},
			success: function(data){
				var consumo = parseFloat(data);
				$("#consumoActual").val(consumo);
				$("#consumoActual").change();
				$('#formConsB').bootstrapValidator('revalidateField', 'consumoActual');
			}
		});
	});
	// Add drag-n-drop feature to boxes
	WinMove();
	
	$('#observaciones').keyup(function() {//contador para el máximo de caracteres permitidos en las observaciones
        var chars = $(this).val().length;
        var diff = 250 - chars;
        $('#contadorText').html(diff+" caracteres permitidos");   
    });
});
    ///////////////////////////////Funsión que valida el formulario de consumo de bomba///////////////////////////////
function formValidBomba() {
	$('#formConsB').bootstrapValidator({
		message: '¡Este valor no es valido!',
		fields: {
			lecturaActual:{
				validators: {
					notEmpty:{
		                message: "¡Este campo es requerido y no debe estar vacio!"
		            },
		            greaterThan: {
						value: 0,
						inclusive: false,
						message: '¡El campo debe ser mayor que 0!'	
					},
					callback: {
          				message: '¡La lectura actual debe ser mayor que los otros registros anteriores!',
           				callback: function (value, validator, $field) {
           					if($("#formConsB #opcion").val() != "actualizar"){
           						var tabla = $('#tbl_consumoB').DataTable();
               					var filas = tabla.rows();
               					var noigual=true;
                   				filas.every(function(index, loop, rowloop) {
           							if(value <= tabla.row(index).data().lecturaActual)
           								noigual = false;
                   				});
                   				return noigual;
           					}else if(actual == false)
           						return {valid: false,message: '¡No puede editar un registro anterior al actual!'};
           					else{
           						var tabla = $('#tbl_consumoB').DataTable();
               					var filas = tabla.rows();
               					var noigual=true;
                   				filas.every(function(index, loop, rowloop) {
                   					if(tabla.row(index).data().bomba_ID < $("#formConsB #bombaID").val())
                   						if(value <= tabla.row(index).data().lecturaActual)
               								noigual = false;
                   				});
                   				if (noigual == true)
                   					return true;
                   				else
                   					return {valid: false,message: '¡La lectura actual debe ser mayor que los otros registros anteriores!'};
           					}
           				}
       				}
		        }
			},
			fecha:{
				validators: {
					notEmpty:{
		                message: "¡Este campo es requerido y no debe estar vacio!"
		            },
		            callback: {
       					message: '¡La fecha debe ser mayor que los anteriores registros!',
        				callback: function (value, validator, $field) {
        					var tabla = $('#tbl_consumoB').DataTable();
            				var filas = tabla.rows();
            				var noigual = true;
        					if($("#formConsB #opcion").val() != "actualizar"){
	            				var f = $("#formConsB #fecha").val().split("/");
	            				var fecha1 = new Date(f[2], f[1]-1, f[0]);
	                			filas.every(function(index, loop, rowloop) {
	                				var fecha2 = new Date(tabla.row(index).data().fechaLecturaActual);
	        						if(fecha1 <  fecha2)
	        							noigual = false;
	                			});
	                			return noigual;
        					}else{
	            				var f = $("#formConsB #fecha").val().split("/");
	            				var fecha1 = new Date(f[2], f[1]-1, f[0]);
	                			filas.every(function(index, loop, rowloop) {
	                				var fecha2 = new Date(tabla.row(index).data().fechaLecturaActual);
	                				if(tabla.row(index).data().bomba_ID < $("#formConsB #bombaID").val())
	                					if(fecha1 <  fecha2)
		        							noigual = false;
	                			});
	                			return noigual;
        					}
        				}
    				}
		        }
			},
			consumoActual:{
				validators: {
					notEmpty:{
		                message: "Este campo es requerido y no debe estar vacio"
		            },
		            callback:{
		            	message: '¡Vuelva a calcular el consumo!',
        				callback: function (value, validator, $field) {
        					var tabla = $('#tbl_consumoB').DataTable();
            				var filas = tabla.rows();
            				var noigual = true;
	           				if($("#formConsB #opcion").val() == "actualizar"){
    	       					filas.every(function(index, loop, rowloop) {
		        					if(tabla.row(index).data().bomba_ID == $("#formConsB #bombaID").val() &&
                    				$("#formConsB #lecturaActual").val() != tabla.row(index).data().lecturaActual){
                   						noigual = false;
                   						if($("#formConsB #consumoActual").val() != tabla.row(index).data().consumoActual){
                   							noigual = true;
                   						}
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
			unidadMedida:{
				validators: {
					notEmpty:{
		                message: "Este campo es requerido y no debe estar vacio"
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
    	method:"post",
    		url:"./SL_Consumo_bomba",
    		data: frm//datos a enviar
    		}).done(function(info) {
    		console.log(info);
    			if(expand1.valor == true)
    				validarExpand(expand1, "#expandir1");
    			
    			if(expand2.valor == true)
    				validarExpand(expand2, "#expandir2");
    			
    			validarColap(colap1, "#colapsar_desplegar1");
    			if (colap2.valor ==false)
    				validarColap(colap2, "#colapsar_desplegar2");
    			
    			verResultado(info);
    	});
    });
}
</script>