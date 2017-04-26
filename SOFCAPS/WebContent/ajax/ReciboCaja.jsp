<%@page import="Entidades.Factura_Maestra"%>
<%@page import="Entidades.Contrato"%>
<%@page import="Entidades.Reconexion"%>
<%@page import="Entidades.Serie"%>
<%@page import="Entidades.Usuario, Entidades.Rol, Datos.DT_Vw_rol_opciones,Datos.DT_reciboCaja, java.util.* ,java.sql.ResultSet;"%>
<%@page language="java"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%> 
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
<div id="dialog" class= "col-xm-offset-1 col-xm-10">
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
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding table-responsive">
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="dt_ReciboCaja" style="width:100%;">
					<thead>
						<tr>
							<th>Nombre del cliente</th>
							<th>Concepto</th>
							<th>Documento</th>
							<th>Monto</th>
							<th>Acción</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!--///////////////////////Formulario principal de los recibos de caja/////////////////////////////// -->
<div class="row">
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
						<i class="fa fa-expand"></i>
					</a>
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
						DT_reciboCaja rc =DT_reciboCaja.getInstance();
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
							<input type="number" id="montoTotal" class="form-control"
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
				</form>
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
////////////////////////////////variables para el WEBSOCKET//////////////////////////////////////////////////
var wsUri = "ws://"+window.location.host+"/SOFCAPS/serverendpointdemo";
var websocket = new WebSocket(wsUri);

//evento que notifica que la conexion esta abierta
websocket.onopen = function(evt) { //manejamos los eventos...
    console.log("Conectado..."); //... y aparecerá en la pantalla
};

//evento onmessage para resibir mensaje del serverendpoint
websocket.onmessage = function(evt) { // cuando se recibe un mensaje
	console.log("Mensaje recibido de webSocket: " + evt.data);
	verResultado(evt.data);
};

//evento si hay algun error en la comunicacion con el web_socket
websocket.onerror = function(evt) {
    console.log("oho!.. error:" + evt.data);
};

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
		mostrarMensaje("#dialog", "CORRECTO", 
			"¡Se realizó la acción correctamente, todo bien!", "#d7f9ec", "btn-info");
 		$('#dt_ReciboCaja').DataTable().ajax.reload();
 		websocket.send("ACTUALIZADO");
 	}else if(r == "ERROR"){
 		mostrarMensaje("#dialog", "ERROR", 
 				"¡Ha ocurrido un error, no se pudo realizar la acción!", "#E97D7D", "btn-danger");
 	}else if(r =="VACIO"){
		mostrarMensaje("#dialog", "VACIO",
				"¡Debe seleccionar el cliente!", "#FFF8A7","btn-warning");
	}else if(r =="ACTUALIZADO"){
		mostrarMensaje("#dialog", "ACTUALIZADO", 
				"¡Otro usuario a realizado un cambio, se actualizaron los datos!", "#86b6dd", "btn-primary");
		$('#dt_ReciboCaja').DataTable().ajax.reload();
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
	validarExpand(expand1, "#expandir1");
	if(colap1.valor==false)
		validarColap(colap1, "#colapsar_desplegar1");
	
	validarColap(colap2, "#colapsar_desplegar2");
	if(expand2.valor == true)
		validarExpand(expand2, "#expandir2");
	
	$("button#abrir_modal").focus();
}

var cancelar = function() {////////////////cancela la acción limpiando el texto y colapsando el formulario
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

var limpiar_texto = function() {////////////////////////limpiar texto del formulario
	$("#opcion").val("guardar");
	$("#cliente_ID").val("");
	$("#nombreClienteCompleto").val("");
	$("#concepto").val("");
	$("#factura").val("");
	$("#contrato").val("");
	$("#reconexion").val("");
	$("#montoTotal").val("");
}

///////////////////////////////Ejecutar el metodo DataTable para llenar la Tabla///////////////////////////////////
function iniciarTabla(){
	validarColap(colap1, "#colapsar_desplegar1");
	var tablaRecibo = $('#dt_ReciboCaja').DataTable( {
		responsive: true,
		ajax: {
			"method":"GET",
			"url":"./SL_ReciboCaja",
			"data": {
		        "idserie": 4, "cliente_ID":0
		    },
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
			{ "data": "cliente.nombreCompleto"},
            { "data": "serie.descripcion" },
            { "data": "numDocumento"
//                 render: function ( data, type, row ) {
//                 	var documento = data.numDocumento;
//                 	var concepto;
//                 	if(data.serie.serie_ID == 1)
//                 		concepto = "factura";
//                 	else if(data.serie.serie_ID == 2)
//                 		concepto = "contrato";
//                 	else
//                 		concepto = "reconexion";
//                 	$("#"+concepto+" option").each(function(){
//                 		if(documento ==  $(this).attr('value'))
//                 			documento = $(this).text();
//                 	});
//                 	return documento;
            },
            { "data": "montoTotal"},
            {"defaultContent":"<button type='button' class='editarDetalle btn btn-primary' title='Editar detalle'>"+
				"<i class='fa fa-pencil-square-o'></i> </button>  "+
				"<button type='button' class='eliminarDetalle btn btn-danger' title='Eliminar detalle'>"+
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
}
///////////////////funsión que crea un dataTable para traer en cliente y el contrato mediante un dialogo////////////
function filtrarTabla(){
	    $('#datatable-filter thead th label input').each( function () {
	        var title = $(this).attr("name");
	        $(this).attr("placeholder", title);
	    } );
	    var table = $('#datatable-filter').DataTable({
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
         	$(response.aaData).each(function(i, v) {
             	datos = response.aaData;
                $(select).empty();
                $(select).append("<option value=''>--Seleccione la factura--</option>");
                $(response.aaData).each(function(i, v) {
                		$(select).append('<option value="' + v.numFact + '"> Número de factura: ' 
                				+ v.numFact +'</option>');	
         		});
                activarChangeFactura("#factura", response.aaData);
 			});  	        	
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
         success: function(response)
         {	
         	$(response.aaData).each(function(i, v) {
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
 			});  	        	
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
         success: function(response)
         {	
         	$(response.aaData).each(function(i, v) {
             		datos = response.aaData;
                 	$(select).empty();
                 	$(select).append("<option value=''>--Seleccione el contrato--</option>");
                 	$(response.aaData).each(function(i, v) {
                 			$(select).append('<option value="' + v.contrato_ID + '">' +"No. Contrato: " + v.numContrato + " - " + "No. Medidor: " + v.numMedidor +'</option>');
         			});
                activarChangeContrato(select, response.aaData);
      			console.log("id cliente form: " + cliente_ID_form );
 			});  	        	
         }
 	});
}

$(function () {//funsion para cargar un DatePicker
    $.datepicker.setDefaults($.datepicker.regional["es"]);
    $("#input_date").datepicker({
        dateFormat: 'yy/mm/dd',
        firstDay: 1
    }).datepicker("setDate", new Date());
 });
 
 //////////////////////////////funsion que activa el evento click del boton de agregar//////////////////////////////
var activarBotonAgregar = function() {
	$("#btnAgregar").on("click", function() {
		var idCliente = $("#cliente_ID").val();
		if (idCliente != 0 || idCliente != ""){
			var frm = $("#formReciboCaja").serialize();
			console.log(frm);
// 			$.ajax({//enviar datos por ajax
// 	 			type:"POST",
// 	 			url:"./SL_ReciboCaja",
// 	 			data: frm//datos a enviar
// 	 		}).done(function(info) {//informacion que el servlet le reenvia al jsp
// 	 			console.log(info);
// 				verResultado(info);//se envia a verificar que mensaje respondio el servlet
// 	 		});
		}else if (idCliente == 0 || idCliente == ""){
			verResultado("VACIO");
		}
	});
}
//////////////////////////////funsiones que detectan cuando un select cambia su valor///////////////////////////////
function activarChangeFactura(select, aaData) {
	$(select).change(function() {
		var factura = $("#factura").val();
		var montoTotal, factura_maestra_ID;
		$(aaData).each(function(i, v) {
			if (factura == v.numFact) {
				montoTotal = v.totalPago;
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
					$("#montoTotal").val(response);
					verResultado(response);
				}
			}
		});
	});
}
function activarChangeContrato(select, aaData) {
	$(select).change( function() {
			var contrato_ID = $(select).val();
			var montoContrato, cuotas;
			$(aaData).each(function(i, v) {
				if (contrato_ID == v.contrato_ID) {
					montoContrato = v.montoContrato;
					cuotas = v.cuotas;
				}
			});
			console.log("montoContrato: " + montoContrato + ", cuotas: " + cuotas);
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
						$("#montoTotal").val(response.montoContrato);
						mostrarMensaje("#dialog", "MONTO RESTANTE",
							"Este documento tiene un monto restante a pagar de: " + response.montoContrato
							+ " </br>Cuota No. " + response.cuotas, "#d7f9ec", "btn-info");
					}
				}
			});
		});
}
///////////////////////////////función que activa el evento change del select de concepto////////////////////////////
function activarChange(select) {
	$(select).change(function() {//cuando se elija otra opcion del select
		var concepto = $(select).val();
		console.log("id del concepto: " + concepto)
		if (concepto == 1) {
			cargarSelectFactura("#factura");
			desactivarSelect("#contrato");
			desactivarSelect("#reconexion");
			activarSelect("#factura");
		} else if (concepto == 2) {
			cargarSelectContrato('#contrato');
			desactivarSelect("#factura");
			desactivarSelect("#reconexion");
			activarSelect('#contrato');
		} else if (concepto == 3) {
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
