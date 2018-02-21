<%@page import="Entidades.Factura_Maestra"%>
<%@page import="Entidades.Contrato"%>
<%@page import="Entidades.Reconexion"%>
<%@page import="Entidades.Serie"%>
<%@page import="Entidades.Usuario, Entidades.Rol, Datos.DT_Vw_rol_opciones,Datos.DT_reciboCaja, java.util.* ,java.sql.ResultSet;"%>
<%@page language="java"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%> 
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
<div id="dialog" class= "col-xm-offset-1 col-xm-10">
	<div class="contenido" style="margin-left: 20px;"></div>
</div> 
<div id="dialogCancel" class= "col-xm-offset-1 col-xm-10">
	<div class="contenido" style="margin-left: 20px;"></div>
</div> 
<!--///////////////////////Directorios donde estan los jsp /////////////////////////////// -->
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Recibos de caja</a></li>
		</ol>
	</div>
</div>
<!--///////////////////////Formulario principal de los recibos de caja/////////////////////////////// -->
<div id="formulario" class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-edit"></i> <span>Formulario de Recibos de caja</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar1" onclick="validar(colap1);" class="collapse-link"> 
						<i class="fa fa-chevron-up"></i> </a> 
					<a id="expandir1" onclick="validar(expand1);" class="expand-link"> 
						<i class="fa fa-expand"></i> </a>
					<a class="cerrar" onclick="cancelar();"> 
						<i class="fa fa-times"></i> </a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content">
				<form class="form-horizontal" role="form" id ="formReciboCaja">
					<input type="hidden" id="cliente_ID" name="cliente_ID">
					<input type="hidden" id="opcion" name="opcion" value="guardar">
					<div class="form-group has-error has-feedback">
						<label class="col-sm-4 control-label">Fecha:</label>
						<div class="col-sm-4">
							<input type="text" name="fechaRecibo" id="input_date" class="form-control" placeholder="Date" readonly > 
								<span class="fa fa-calendar txt-danger form-control-feedback"></span>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-4 control-label">Nombre del cliente:</label>
						<div class="col-sm-5">
							<input id = "nombreClienteCompleto" type="text" class="form-control" placeholder="Seleccione el nombre del cliente"
								data-toggle="tooltip" data-placement="bottom"
								title="Nombre completo del cliente" readonly>
						</div>
						<div class="col-sm-5 col-md-3">
							<button type="button" class="blue" id="abrir_modal">
								<span><i class="fa fa-search"></i></span> Buscar Cliente
							</button>
						</div>
					</div>
					
					<div class="form-group">
					<%
						DT_reciboCaja rc =new DT_reciboCaja();
						ArrayList<Serie> listaSeries = new ArrayList<Serie>();
						listaSeries = rc.listaSeries();
					%>
						<label class="col-sm-4 control-label">En concepto de:</label>
						<div class="col-sm-5">
							<select id="concepto" name="serie" class="populate placeholder">
							<option value="" >--Seleccione un concepto a pagar--</option>
							<%
								for(int i = 0; i < listaSeries.size(); i++){
								%>
									<option value="<%=listaSeries.get(i).getSerie_ID() %>"><%=listaSeries.get(i).getDescripcion() %></option>
							<%
								}
							%>	
							</select>
						</div>
					</div>
						
					<div class="clearfix"></div>	
					<div class="form-group has-success has-feedback">
						<label class="col-sm-4 control-label">Facturas: </label>
						<div class="col-sm-4">
							<select id="factura" name="factura" class="populate placeholder">
								<option value="">--Seleccione la factura--</option>
							</select>
						</div>
					</div>
						
					<div class="form-group has-success has-feedback">
						<label class="col-sm-4 control-label">Contratos:</label>
						<div class="col-sm-4">
							<select id="contrato" name="contrato" class="populate placeholder">
								<option value="">--Seleccione el contrato--</option>
							</select>
						</div>
					</div>
						
					<div class="form-group has-success has-feedback">
						<label class="col-sm-4 control-label">Reconexiones: </label>
						<div class="col-sm-4">
							<select id="reconexion" name="reconexion" class="populate placeholder">
								<option value="">--Seleccione la orden de reconexión--</option>
							</select>
						</div>
					</div>
						
					<div class="form-group has-error has-feedback">
						<label class="col-sm-4 control-label">Monto total: </label>
						<div class="col-sm-3">
							<input type="number" id="monto" class="form-control"
								name="monto" placeholder="C$ 0.00" > <span
								class="fa fa-money txt-danger form-control-feedback"></span>
						</div>
					</div>
					
					<div class="clearfix"></div>
					<div class="form-group">
						<div class="col-sm-offset-3 col-sm-4">
							<button id="btnAgregar" type="button" class="btn btn-primary btn-label-left">
								<span><i class="fa fa-save"></i></span> Guardar Recibo
							</button>
						</div>
						<div class="col-sm-3">
							<button type="button" class="btn btn-default btn-label-left" onclick="cancelar();">
								<span><i class="fa fa-mail-reply txt-danger"></i></span> Cancelar acción
							</button>
						</div>
					</div>
					
					<div class="clearfix"></div>
					<div class="text-center">
						<p style="font-size:x-large; font-family:"Roboto"; font-weight:600;" class="mensaje"></p>
					</div>
					<div class="clearfix"></div>
				</form>
			</div>
		</div>
	</div>
</div>
<!--///////////////////////DataTable de los recibos de caja/////////////////////////////// -->
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-th"></i> <span>Lista de Recibos de caja</span>
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
				<div class="form-group col-md-offset-3 col-md-6 text-center">
					<label class="control-label text-info" style="font-size: large;">Registros mostrados por periodo</label>
					<input id="anioBuscar" name="anioBuscar" type="text" class="form-control" placeholder="Año de registros"
						data-toggle="tooltip" data-placement="top" title="Año a buscar" style="text-align:center;">
					<select class="populate placeholder" name="periodoBuscar" id=periodoBuscar>
						<option value="1">Primera mitad</option>
						<option value="2">Segunda mitad</option>
					</select>
					<button id="btnBuscar" type="button" class="btn btn-info" onclick= "cargar_Recibos();" 
					style="margin-top: 5px;">Buscar registros</button>
				</div>
				<div style="width:100%; padding-top:15px; display:inline-block;"></div>
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="dt_ReciboCaja" style="width:100%;">
					<thead>
						<tr>
							<th>Nombre del cliente</th>
							<th>Concepto</th>
							<th>Documento</th>
							<th>fecha</th>
							<th>Monto</th>
							<th>No. Recibo</th>
							<th>Acción</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!--///////////////////////Formulario y dialogo de eliminción /////////////////////////////// -->
<div>
	<form id="frmEliminarRecibo" action="" method="DELETE">
		<input type="hidden" id="reciboCaja_ID" name="reciboCaja_ID" value="">
		<input type="hidden" id="opcion" name="opcion" value="eliminar">

		<!-- 	Modal 	-->
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
var totalPagar = 0.0;
var pagado = 0.0;
var cuotasContrato = 0;
var cuotaActual = 0;
////////////////////////////////variables para el WEBSOCKET//////////////////////////////////////////////////
var wsUri = "ws://"+window.location.host+"/SOFCAPS/serverendpointdemo";
var websocket;
if (!(websocket instanceof WebSocket) || websocket.readyState !== WebSocket.OPEN) {
	websocket = new WebSocket(wsUri);
	console.log("nueva webRecibo");
	//evento que notifica que la conexion esta abierta
	websocket.onopen = function(evt) { //manejamos los eventos...
	    console.log("Conectado..."); //... y aparecerá en la pantalla
	};

	//evento onmessage para resibir mensaje del serverendpoint
	websocket.onmessage = function(evt) { // cuando se recibe un mensaje
		console.log("Mensaje recibido de webRecibo: " + evt.data);
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
	console.log("no conectar webRecibo");

var expand1 = new Expand1();//se crean los objetos que representan los botones de cada dialogo
var colap1 =  new Colap1();
var expand2 = new Expand2();
var colap2 =  new Colap2();

// Correr plugin Select2
function DemoSelect2(){
	$('#concepto').select2();
	$('#contrato').select2();
	$('#factura').select2();
	$('#reconexion').select2();
}
/////////////////////////////Funciones para activar y desactivar los select////////////////////////////////////
function desactivarSelect(select){
	$(select).attr('disabled', 'disabled');
}
function activarSelect(select){
	$(select).removeAttr('disabled');
}
	
//////////////////////////funsión que muestra el resultado mediante un dialogo//////////////////////////////////////
var verResultado = function(r) {//parametro(resultado-String)
	if(r == "BIEN"){
 		var texto ="¡Se realizó la acción correctamente, todo bien!", color="#29a3b1";
		$(".mensaje").html(texto).css({"color":color});
		$(".mensaje").fadeOut(7000, function() {//se muestra el mensaje por un tiempo y luego se oculta
			$(this).fadeIn(4000);	
			$(this).html("");
		});
		limpiar_texto();
		cargar_Recibos();
		websocket.send("ACTUALIZADO");
 	}else if(r == "ERROR"){
 		mostrarMensaje("#dialog", "ERROR", 
 				"¡Ha ocurrido un error, no se pudo realizar la acción!", "#E97D7D", "btn-danger");
 	}else if(r =="VACIO"){
		mostrarMensaje("#dialog", "VACIO",
				"¡Debe seleccionar el cliente y el documento a pagar!", "#FFF8A7","btn-warning");
	}else if(r =="ACTUALIZADO"){
		mostrarMensaje("#dialog", "ACTUALIZADO", 
				"¡Otro usuario a realizado un cambio, se actualizaron los datos!", "#86b6dd", "btn-primary");
		$('#dt_ReciboCaja').DataTable().ajax.reload();
	}else if(r =="CANCELADO"){
		mostrarMensaje("#dialogCancel", "CANCELADO", 
				"¡Se ha cancelado el documento correctamente, todo bien!", "#86b6dd", "btn-primary");
	}else{
 		mostrarMensaje("#dialog", "MONTO RESTANTE", 
 				"Este documento tiene un monto restante a pagar de: "+r, "#d7f9ec", "btn-info");
 	}
 }
/////////////////////////////////////Iniciar dataTables y cargar los plugins//////////////////////////////////////
function AllTables() {
	//cargar PDF Y EXCEL
	$.getScript('plugins/datatables/nuevo/jszip.min.js', function(){
		$.getScript('plugins/datatables/nuevo/pdfmake.min.js',function(){
			$.getScript('plugins/datatables/nuevo/vfs_fonts.js',function(){
				console.log("PDF Y EXCEL cargado");
				iniciarTabla();
				LoadSelect2Script(MakeSelect2);
			});
		});
	});
}

var agregar_nuevo_recibo = function() {//////////////agregar nuevo registro limpiando texto y abriendo el form
	limpiar_texto();
	document.getElementById('formulario').style.display = 'block';
	if(colap1.valor==false)
		validarColap(colap1, "#colapsar_desplegar1");
	
	validarColap(colap2, "#colapsar_desplegar2");
	if(expand2.valor == true)
		validarExpand(expand2, "#expandir2");
	
	$("button#abrir_modal").focus();
}

var cancelar = function() {////////////////cancela la acción limpiando el texto y colapsando el formulario
	limpiar_texto();
	document.getElementById('formulario').style.display = 'none';
	if(expand1.valor == true)
		validarExpand(expand1, "#expandir1");
	
	if(expand2.valor == true)
		validarExpand(expand2, "#expandir2");
	
	validarColap(colap1, "#colapsar_desplegar1");
	if (colap2.valor ==true){}else{
		validarColap(colap2, "#colapsar_desplegar2");
	}
}

var limpiar_texto = function() {////////////////////////limpiar texto del formulario
	$("#opcion").val("guardar");
	$("#cliente_ID").val("");
	$("#nombreClienteCompleto").val("");
	$("#monto").val("");
	$("#concepto").val("");
	$("#concepto").change();
	desactivarSelect("#concepto");
	
	$("#factura").empty();
    $("#factura").append("<option value=''>--Seleccione la factura--</option>");
	$("#factura").val("");
	$("#factura").change();
	desactivarSelect("#factura");
	
	$("#contrato").empty();
 	$("#contrato").append("<option value=''>--Seleccione el contrato--</option>");
	$("#contrato").val("");
	$("#contrato").change();
	desactivarSelect("#contrato");
	
	$("#reconexion").empty();
 	$("#reconexion").append("<option value=''>--Seleccione la orden de reconexion--</option>");
	$("#reconexion").val("");
	$("#reconexion").change();
	desactivarSelect("#reconexion");
}

var cargar_Recibos = function() {
	$('#dt_ReciboCaja').DataTable().state.clear();
	$('#dt_ReciboCaja').DataTable().clear().draw();
	$.ajax({
        type: "GET",
        url: "./SL_ReciboCaja",
        data: {
        	"idserie": 4, 
        	"cliente_ID":0,
	        "anioB": $("input#anioBuscar").val(),
	        "periodoB": $("select#periodoBuscar").val()
	    },
        success: function(response){
        	$('#dt_ReciboCaja').DataTable().rows.add(response.aaData).draw();
        }
	});
}

///////////////////////////////Ejecutar el metodo DataTable para llenar la Tabla///////////////////////////////////
function iniciarTabla(){
	var tablaRecibo = $('#dt_ReciboCaja').DataTable( {
		responsive: true,
		"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
		"pageLength": 0,
    	"bJQueryUI": true,
		"language":idioma_esp,
		drawCallback: function(settings){
            var api = this.api();
            $('td', api.table().container()).find("button").tooltip({container : 'body'});
            $("a.btn").tooltip({container: 'body'});
        },
		"columns": [
			{ "data": "cliente.nombreCompleto"},
            { "data": "serie.descripcion" },
            { "data": null,
                render: function ( data, type, row ) {
                	if(data.serie.serie_ID == 1)
                		return "No. factura: "+data.factura_Maestra.numFact;
                	else if(data.serie.serie_ID == 2)
                		return "Medidor: "+data.contrato.numMedidor+", No. contrato: "+data.contrato.numContrato;
                	else{
                		var f = new Date(data.reconexion.fecha_reconexion);
	                	var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
                		return "feche de reconexion: "+fecha;
                	}
            }},
            { "data": null,
                render: function ( data, type, row ) {
                	f = new Date(data.fecha);
                	var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
                	return fecha;
            }},
            { "data": "montoTotal"},
            { "data": "numReciboCaja"},
            {"defaultContent":"<button type='button' class='imprimirRecibo btn btn-basic' data-toggle='tooltip' "+
				"data-placement='top' title='Imprimir Recibo de caja'>"+
				"<i class='fa fa-print'></i> </button> "+
				"<button type='button' class='eliminarRecibo btn btn-danger' title='Eliminar Recibo de caja'>"+
				"<i class='fa fa-trash-o'></i> </button> "}
            ],
            "dom":"<rt><'row'<'form-inline' <'col-sm-12 text-center'B>>>"
				 +"<'row' <'form-inline' <'col-sm-6'l><'col-sm-6'f>>>"
				 +"<rt>"
				 +"<'row'<'form-inline'"
				 +"<'col-sm-6 col-md-6 col-lg-6'i><'col-sm-6 col-md-6 col-lg-6'p>>>",
            "buttons":[{
				"text": "<i class='fa fa-plus-square'></i>",
				"titleAttr": "Agregar Recibo de caja",
				"className": "btn btn-success",
				"action": function() {
					agregar_nuevo_recibo();
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
	
	tablaRecibo.page.len(0).draw();
	$('#dt_ReciboCaja_length').each( function() {
		$(this).find('label select').attr('disabled', 'disabled');
	});	
	$('#dt_ReciboCaja_filter').each( function() {
		$(this).find('label input[type=search]').on( 'keyup change', function () {
	    	if($(this).val() == ""){
	    		tablaRecibo.page.len(0).draw();
	    		$('#dt_ReciboCaja_length').each( function() {
	    			$(this).find('label select').attr('disabled', 'disabled');
	    		});
	    	}else{
	    		tablaRecibo.page.len(10).draw();
	    		$('#dt_ReciboCaja_length').each( function() {
	    			$(this).find('label select').removeAttr('disabled');
	    		});
	    	}
	    });	
	});
	obtener_id_imprimir('#dt_ReciboCaja tbody',tablaRecibo);
	obtener_id_eliminar('#dt_ReciboCaja tbody',tablaRecibo);
	cargar_Recibos();
}
/////////////////////////activar evento del boton imprimir que esta en la fila seleccionada del dataTable/////////////////
var obtener_id_imprimir = function(tbody, table) {//parametros(id_tabla, objeto dataTable)
	$(tbody).on("click","button.imprimirRecibo",function() {
		var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
		var reciboCaja_ID;
		table.rows().every(function(index, loop, rowloop) {
			if (index == datos) {
				reciboCaja_ID = table.row(index).data().reciboCaja_ID;
				console.log("recibo a imprimir "+reciboCaja_ID);
			}
		});
		OpenModalBox(
			"<div><h3>Imprimir Recibo de caja</h3></div>",
			"<p Style='text-align:center; color:blue; font-size:x-large;'>¿Esta seguro que desea imprimir el Recibo de caja?</p>",
			"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-3 col-md-3'>"+
			"<button type='button' id='imprimirR' class='btn btn-primary btn-label-left'"+
			" style=' color: #ece1e1;' >"+
			"<span><i class='fa fa-print'></i></span> Imprimir Recibo</button>"+
			"<div style='margin-top: 5px;'></div> </div>"+
			"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-3 text-center'>"+
			"<button type='button' class='btn btn-default btn-label-left' onclick='CloseModalBox()'>"+
			"<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
		imprimir(reciboCaja_ID);
	});
}
//////////////////////////////////funsion para imprimir al dar click al boton imprimirR/////////////////////////////////////
var imprimir = function(reciboCaja_ID) {
	$("#imprimirR").on("click", function() {
		console.log("imprimiendo recibo numero " + reciboCaja_ID);
		window.open("SL_ReciboCaja?idRecibo="+reciboCaja_ID + "&idserie=5" +"&cliente_ID=0",'_blank');
// 		console.log("la reconexion_ID del jsp"+"  "+reconexion_ID);
		CloseModalBox();
	});
}
/////////////////////////activar evento del boton eliminar que esta en la fila seleccionada del dataTable/////////////////
var obtener_id_eliminar = function(tbody, table) {//parametros(id_tabla, objeto dataTable)
	$(tbody).on("click","button.eliminarRecibo",function() {
		var id, concepto, servlet;
		var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
		table.rows().every(function(index, loop, rowloop) {
			if (index == datos) {
				var reciboCaja_ID = table.row(index).data().reciboCaja_ID;
				$("#frmEliminarRecibo #reciboCaja_ID").val(reciboCaja_ID);
				concepto = table.row(index).data().serie.serie_ID;
				if(concepto == 1){
					id = table.row(index).data().factura_Maestra.factura_Maestra_ID;
					servlet = "./SL_Factura_Maestra";
				}else if(concepto == 3){
					id = table.row(index).data().reconexion.reconexion_ID;
					servlet = "./SL_Reconexion";
				}
				console.log("recibo a eliminar: "+reciboCaja_ID+", servlet: "+servlet+", id: "+id+", concepto: "+concepto);
			}
		});
		OpenModalBox(
			"<div><h3>Borrar Recibo de caja</h3></div>",
			"<p Style='text-align:center; color:salmon; font-size:x-large;'>¿Esta seguro de borrar este recibo de caja?</p>",
			"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-3 col-md-3'>"+
			"<button type='button' id='eliminarR' class='btn btn-danger btn-label-left'"+
			" style=' color: #ece1e1;' >"+
			"<span><i class='fa fa-trash-o'></i></span> Borrar</button>"+
			"<div style='margin-top: 5px;'></div> </div>"+
			"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-3 text-center'>"+
			"<button type='button' class='btn btn-default btn-label-left' onclick='CloseModalBox()'>"+
			"<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
		eliminar(concepto, servlet, id);
	});
}
/////////////////////////////////funsión que envia los datos a eliminar al servlet por ajax//////////////////////
var eliminar = function(concepto, servlet, id) {
	$("#eliminarR").on("click", function() {
		var frmElim = $("#frmEliminarRecibo").serialize();
		console.log("datos a eliminar: " + frmElim);
		$.ajax({
			method:"POST",
			url:"SL_ReciboCaja",
			data: frmElim
		}).done(function(info) {
			console.log(info);
			if(info == "BIEN"){
				if(concepto != 2){
					console.log("actualizar cancelado");
					cancelarDocumento(servlet, id, false);
				}
				mostrarMensaje("#dialog", "CORRECTO", 
					"¡Se realizó la acción correctamente, todo bien!", "#d7f9ec", "btn-info");
			 	$('#dt_ReciboCaja').DataTable().ajax.reload();
			 	limpiar_texto();
			 	websocket.send("ACTUALIZADO");
			}else
				verResultado(info);
		});
		CloseModalBox();
	});
}
///////////////////funsión que crea un dataTable para traer en cliente y el contrato mediante un dialogo////////////
function filtrarTabla(){
	    $('#datatable-filter thead th label input').each( function () {
	        var title = $(this).attr("name");
	        $(this).attr("placeholder", title);
	    } );
	    var table = $('#datatable-filter').DataTable({
	    	responsive: true,
	    	"destroy": true,
	    	"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
	    	"bJQueryUI": true,
			"language":idioma_esp,
			ajax: {
				"method":"GET",
				"url":"./SL_Cliente",
				"data": {
			        "carga": 1//para decirle al servlet que cargue solo clinte + consumos
			    },
				"dataSrc":"aaData" 	
			},
			"columns": [
	            { "data": "nombre1"},
	            { "data": "nombre2"},
	            { "data": "apellido1"},
	            { "data": "apellido2"},
	            { "data": "cedula"},
	            {"defaultContent":"<button type='button' style='margin-left:15px;' class='activar btn btn-primary'"
	            +"title='Seleccionar cliente' id='seleccionarCl' >"
				+ "<i class='fa fa-upload'></i> </button>"}
	            ]
	    });
	 
	    // Aplicar la busqueda por columna
	    table.columns().every( function () {
	        var that = this;
	        $( 'input', this.header() ).on( 'keyup change', function () {
	            if ( that.search() !== this.value ) {
	                that.search( this.value) .draw();
	            }
	        } );
	    } );
	    cambiarCliente('#datatable-filter tbody', table);
}

/////////////////////////////funsión que setea el cliente y contrato en los input del formulario////////////////////
function cambiarCliente(tbody, table) {//parametro(id_tabla, objeto dataTable)
	$(tbody).on("click","button#seleccionarCl",function(){
		var datos = table.row($(this).parents("tr")).data();
		console.log(datos);
		$("#nombreClienteCompleto").val(datos.nombre1 + " " + datos.nombre2 + " " + datos.apellido1 + " " + datos.apellido2);
		$("#cliente_ID").val(datos.cliente_ID);
		var idCliente = $("#cliente_ID").val();
		
		if (idCliente != 0 || idCliente != ""){
			activarSelect("#concepto");
		}else if (idCliente == 0 || idCliente == ""){
			desactivarSelect("#concepto");
		}		
		CloseModalBox();
	});
}
////////////////////////funsiones que cargan los select de factura, contrato y reconexion////////////////////////////
function cargarSelectFactura(select) {//parametro id select
	var datos;
	//var cliente_ID_view;
	var total;
	var cliente_ID_form = $("#cliente_ID").val();
 	$.ajax({
         type: "GET",
         url: "./SL_ReciboCaja",
         dataType: "json",
         data: {"cliente_ID": cliente_ID_form, "idserie" : 1},
         success: function(response){
        	 datos = response.aaData;
             $(select).empty();
             $(select).append("<option value=''>--Seleccione la factura--</option>");
             $(response.aaData).each(function(i, v) {
             	$(select).append('<option value="' + v.factura_Maestra_ID + '"> Número de factura: ' 
             		+ v.numFact +'</option>');
      		});
            activarChangeFactura("#factura", response.aaData);	        	
         }
 	});
}
function cargarSelectReconexion(select) {//parametro id select
	var datos;
	//var cliente_ID_view;
	var total;
	var cliente_ID_form = $("#cliente_ID").val();
 	$.ajax({
         type: "GET",
         url: "./SL_ReciboCaja",
         dataType: "json",
         data: {"cliente_ID": cliente_ID_form, "idserie" : 3},
         success: function(response){	
        	datos = response.aaData;
            $(select).empty();
           	$(select).append("<option value=''>--Seleccione la orden de reconexion--</option>");
              $(response.aaData).each(function(i, v) {
             	var f = new Date(v.fecha_reconexion);
	        		var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
              	$(select).append('<option value="' + v.reconexion_ID+ '"> Fecha de la reconexion: ' 
              		+ fecha +'</option>');		
      		});            	
   			console.log("id cliente form: " + cliente_ID_form );	        	
         }
 	});
}
function cargarSelectContrato(select) {//parametro id select
	var datos;
	var cliente_ID_view;
	var cliente_ID_form = $("#cliente_ID").val();
 	$.ajax({
         type: "GET",
         url: "./SL_ReciboCaja",
         dataType: "json",
         data: {"cliente_ID": cliente_ID_form, "idserie" : 2},
         success: function(response){	
        	 datos = response.aaData;
             $(select).empty();
             $(select).append("<option value=''>--Seleccione el contrato--</option>");
             $(response.aaData).each(function(i, v) {
             	$(select).append('<option value="' + v.contrato_ID + '">' +"No. Contrato: " + v.numContrato + " - " + "No. Medidor: " + v.numMedidor +'</option>');
      		});
             activarChangeContrato(select, response.aaData);
   			console.log("id cliente form: " + cliente_ID_form );	        	
         }
 	});
}

$(function () {//funsion para cargar un DatePicker
    $.datepicker.setDefaults($.datepicker.regional["es"]);
    $("#input_date").datepicker({
        dateFormat: 'dd/mm/yy',
        firstDay: 1
    }).datepicker("setDate", new Date());
 });
 
function pagarDocumento(dato, valor) {
	console.log("pagar: "+$("#formReciboCaja #monto").val());
	if($("#formReciboCaja #monto").val()!=0 || $("#formReciboCaja #monto").val()!=""){
		$.ajax({//enviar datos por ajax
			type:"POST",
			url:"./SL_ReciboCaja",
			data: {"cliente_ID": $("#formReciboCaja #cliente_ID").val(),//datos a enviar
				"opcion": $("#formReciboCaja #opcion").val(),
				"fechaRecibo": $("#formReciboCaja #input_date").val(),
				"serie": $("#formReciboCaja #concepto").val(),
				dato: valor,
				"monto": $("#formReciboCaja #monto").val(),
				"totalPagar": totalPagar}
		}).done(function(info) {//informacion que el servlet le reenvia al jsp
			console.log(info);
			verResultado(info);//se envia a verificar que mensaje respondio el servlet
		});
	}else{
		mostrarMensaje("#dialog", "VACIO",
				"¡Debe escribir el monto a pagar!", "#FFF8A7","btn-warning");
	}
}
function cancelarDocumento(servlet, id, cancelado) {
	$.ajax({//enviar datos por ajax
		type:"POST",
		url:servlet,
		data: {"opcion": "cancelar",
			"id":id,
			"cancelado":cancelado
		}
	}).done(function(info) {//informacion que el servlet le reenvia al jsp
		console.log(info);
		console.log("fin cancelar");
		verResultado(info);//se envia a verificar que mensaje respondio el servlet
	});
}
 //////////////////////////////funsion que activa el evento click del boton de agregar//////////////////////////////
var activarBotonAgregar = function() {
	$("#btnAgregar").on("click", function() {
		var idCliente = $("#cliente_ID").val();
		if (idCliente != 0 || idCliente != ""){
			var dato ="", valor=0;
			if($("#formReciboCaja #concepto").val() == 1){//cuando el concepto es por facturas
				dato="factura";
				valor=$("#formReciboCaja #factura").val();//obtener el id de la factura
				pagado = totalPagar - pagado;
				console.log("pagado: "+pagado+", total a pagar: "+totalPagar+", monto escrito para factura: "
						+$("#formReciboCaja #monto").val());
				if(valor!=0 || valor!="")
					pagarDocumento(dato, valor);//mandar a pagar el documento-factura
				else
					verResultado("VACIO");
				if(totalPagar == (Math.round((parseFloat(pagado)+parseFloat($("#formReciboCaja #monto").val())) * 100) / 100)) {
					console.log("Factura PAGADA");
					cancelarDocumento("./SL_Factura_Maestra", valor, true);//si el total a pagar es igual a lo pagado cancelar
				}else
					console.log("No se puede cancelar la factura pues no es igual el monto a pagar");
			}else if($("#formReciboCaja #concepto").val() == 2){//cuando el concepto es por contrato
				dato="contrato";
				valor=$("#formReciboCaja #contrato").val();
				pagado = totalPagar - pagado;
				console.log("pagado: "+pagado+", total a pagar: "+totalPagar+", monto escrito para contrato: "
						+$("#formReciboCaja #monto").val());
				console.log("Cuotas del contrato: "+cuotasContrato+", cuota a pagar: "+cuotaActual);
				if(totalPagar == (Math.round((parseFloat(pagado)+parseFloat($("#formReciboCaja #monto").val())) * 100) / 100)) {
					//solo se cancelara el contrato si el monto a pagar es igual a lo pagado
					console.log("Contrato PAGADO");
					if(valor!=0 || valor!="")
						pagarDocumento(dato, valor);//mandar a pagar el documento-factura
					else
						verResultado("VACIO");
					verResultado("CANCELADO");
// 					cancelarDocumento("./SL_Contrato", valor, true);
				}else if(cuotasContrato == cuotaActual && totalPagar > (pagado + $("#formReciboCaja #monto").val())){
					console.log("No se puede cancelar el contrato pues no es igual el monto a pagar y la cuota no es igual");
				}else if(cuotasContrato < cuotaActual){
					console.log("No se puede agregar mas cuotas de las permitidas");
				}else if(cuotasContrato > cuotaActual){
					if(valor!=0 || valor!="")
						pagarDocumento(dato, valor);//mandar a pagar el documento-factura
					else
						verResultado("VACIO");
					console.log("pagar contrato");
				}
			}else if($("#formReciboCaja #concepto").val() == 3){
				dato="reconexion";
				valor=$("#formReciboCaja #reconexion").val();
				console.log("reconexion pagada");
				if(valor!=0 || valor!=""){
					console.log("pagar reconexion");
					pagarDocumento(dato, valor);//mandar a pagar el documento-factura
					cancelarDocumento("./SL_Reconexion", valor, true);
				}
				else
					verResultado("VACIO");
			}
		}else if (idCliente == 0 || idCliente == ""){
			verResultado("VACIO");
		}
	});
}
//////////////////////////////funsiones que detectan cuando un select cambia su valor///////////////////////////////
function activarChangeFactura(select, aaData) {
	$(select).change(function() {
		if($(select).val() != ""){
			var factura = $("#factura").val();
			var montoTotal, factura_maestra_ID;
			$(aaData).each(function(i, v) {
				if (factura == v.factura_Maestra_ID) {
					montoTotal = v.totalPago;
					totalPagar = montoTotal;
					factura_maestra_ID = v.factura_Maestra_ID;
				}
			});
			$.ajax({
				type : "GET",
				url : "./SL_Factura_Maestra",
				dataType : "json",
				data : {
					"factura_Maestra_ID" : factura_maestra_ID,
					"carga" : 5,
					"montoTotal" : montoTotal
				},
				success : function(response) {
					if (response == "ERROR")
						verResultado(response);
					else {
						console.log(response);
						$("#monto").val(response);
						pagado = response;
// 						verResultado(response);
					}
				}
			});
		}
	});
}
function activarChangeContrato(select, aaData) {
	$(select).change( function() {
		if($(select).val() != ""){
			var contrato_ID = $(select).val();
			var montoContrato, cuotas;
			$(aaData).each(function(i, v) {
				if (contrato_ID == v.contrato_ID) {
					montoContrato = v.montoContrato;
					cuotas = v.cuotas;
					cuotasContrato = cuotas;
				}
			});
			console.log("montoContrato: " + montoContrato + ", cuotas: " + cuotas);
			totalPagar = montoContrato;
			$.ajax({
				type : "POST",
				url : "./SL_Contrato",
				dataType : "json",
				data : {
					"contrato_ID" : contrato_ID,
					"opcion" : "calcular",
					"montoContrato" : montoContrato
				},
				success : function(response) {
					if (response == "ERROR")
						verResultado(response);
					else {
						$("#monto").val(response.montoContrato);
						pagado = response.montoContrato;
						cuotaActual = response.cuotas;
						mostrarMensaje("#dialog", "MONTO RESTANTE",
							"Este documento tiene un monto restante a pagar de: " + response.montoContrato
							+ " </br>Cuota No. " + response.cuotas, "#d7f9ec", "btn-info");
					}
				}
			});
		}	
	});
}
///////////////////////////////función que activa el evento change del select de concepto////////////////////////////
function activarChange(select) {
	$(select).change(function() {//cuando se elija otra opcion del select
		var concepto = $(select).val();
		console.log("id del concepto: " + concepto)
		if (concepto == 1 && $("#cliente_ID").val() != "") {
			cargarSelectFactura("#factura");
			desactivarSelect("#contrato");
			desactivarSelect("#reconexion");
			activarSelect("#factura");
		} else if (concepto == 2 && $("#cliente_ID").val() != "") {
			cargarSelectContrato('#contrato');
			desactivarSelect("#factura");
			desactivarSelect("#reconexion");
			activarSelect('#contrato');
		} else if (concepto == 3 && $("#cliente_ID").val() != "") {
			cargarSelectReconexion('#reconexion');
			desactivarSelect("#factura");
			desactivarSelect("#contrato");
			activarSelect("#reconexion");
		} else if (concepto == null || concepto == 0) {
			desactivarSelect("#factura");
			desactivarSelect("#contrato");
			desactivarSelect("#reconexion");
		}
	});
}
///////////////////////////////////////////FUNSIÓN PRINCIPAL////////////////////////////////////////////////////////
$(document).ready(function() {
	var d = new Date();
	$("input#anioBuscar").val(d.getFullYear());
	
	// Add slider for change test input length
	FormLayoutExampleInputLength($(".slider-style"));
	
	// Add tooltip to form-controls
	$('.form-control').tooltip();
	
	//cargar scripts dataTables
	LoadDataTablesScripts2(AllTables);
	
	LoadSelect2Script(DemoSelect2);
	
	// Add drag-n-drop feature to boxes
	WinMove();
	
	activarChange("#concepto");
	activarBotonAgregar();

	desactivarSelect("#contrato");
	desactivarSelect("#reconexion");
	desactivarSelect("#factura");
	desactivarSelect("#concepto");

	//MODAL para mostrar una tabla con el cliente y en contrato
	$('#abrir_modal').on('click',function(e) {
		OpenModalBox(
			"<div><h3>Buscar Cliente</h3></div>",
			"<div class='table-responsive'>"
			+ "<table class='table table-bordered table-striped table-hover table-heading table-datatable'"+
			"id='datatable-filter'>"
			+ "<thead>"
			+ "<tr>"
			+ "<th><label><input type='text' name='Nombre1'/></label></th>"
			+ "<th><label><input type='text' name='Nombre2'/></label></th>"
			+ "<th><label><input type='text' name='Apellido1'/></label></th>"
			+ "<th><label><input type='text' name='Apellido2'/></label></th>"
			+ "<th><label><input type='text' name='Cédula'/></label></th>"
			+ "<th></th>"
			+ "</tr>"
			+ "</thead>"
			+ "<tfoot>"
			+ "<tr> <th Style='color: #5d96c3;'>Nombre1</th>"
			+ "<th Style='color: #5d96c3;'>Nombre2</th>"
			+ "<th Style='color: #5d96c3;'>Apellido1</th>"
			+ "<th Style='color: #5d96c3;'>Apellido2</th>"
			+ "<th Style='color: #5d96c3;'>Número de cédula</th>"
			+ "<th></th> </tr>"
			+ "</tfoot>"
			+ "</table>"
			+ "</div>",
			"<div Style='text-align: center; margin-bottom: -5px;'><button type='button' class='btn-default btn-label-left btn-lg' "
			+ "onclick='CloseModalBox()'><span><i class='fa fa-reply txt-danger'></i></span>Cancelar</button></div>");

		filtrarTabla();
	});
});
</script>
