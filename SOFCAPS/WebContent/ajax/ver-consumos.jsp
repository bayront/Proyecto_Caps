<%@page language="java"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8" import="Entidades.Usuario, Entidades.Rol, Datos.DT_Vw_rol_opciones, java.sql.ResultSet ;"%> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
%>
<%
	String nombre_usuario = "";
	nombre_usuario = (String) session.getAttribute("nombre_usuario");
	nombre_usuario = nombre_usuario==null?"":nombre_usuario;


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
<div id="dialog" class= "col-xm-offset-1 col-xm-10">
	<div class="contenido" style="margin-left: 20px;"></div>
</div> 
<!--///////////////////////Directorios donde estan los jsp /////////////////////////////// -->
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Consumos</a></li>
			<li><a href="#">Consumos de los clientes</a></li>
		</ol>
	</div>
</div>
<!--///////////////////////Formulario principal de consumos de los clientes/////////////////////////////// -->
<div id="formulario" class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box" style="top: 0px; left: 0px; opacity: 1;">

			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-edit"></i> <span>Formulario de consumos de los clientes</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar1" class="collapse-link" onclick="validar(colap1);"> 
						<i class="fa fa-chevron-up"></i></a> 
					<a id="expandir1" class="expand-link"  onclick="validar(expand1);"> 
						<i class="fa fa-expand"></i></a>
					<a class="cerrar" onclick="cancelar();"> 
						<i class="fa fa-times"></i></a>
				</div>
				<div class="no-move"></div>
			</div>

			<div class="box-content">
				<form class="form-horizontal" role="form" id="defaultForm"
					method="POST" action="./SL_consumo">
					<input type="hidden" id="opcion" name="opcion" value="guardar">
					<input type="hidden" id="userC" name="userC" value="<%=nombre_usuario %>">
					<input type="hidden" id="consumo_ID" name="consumo_ID"> 
					<input type="hidden" id="cliente_ID" name="cliente_ID"> 
					<input type="hidden" id="contrato_ID" name="contrato_ID">
					
					<h4 class="page-header"
						Style="text-align: center; font-size: xx-large;">Cliente</h4>

					<div class="form-group">

						<label class="col-sm-4 control-label">Nombres</label>
						<div class="col-sm-5">
							<input type="text" class="form-control"
								id="nombreClienteCompleto" placeholder="Nombres"
								data-toggle="tooltip" data-placement="bottom"
								title="Nombre completo">
						</div>
						<div class="col-sm-5 col-md-3">
							<button type="button" class="blue" id="abrir_modal">
								<span><i class="fa fa-search"></i></span> Buscar Cliente
							</button>
						</div>
					</div>
					<div class="form-group">
						<label for="numContrato" class="col-sm-4 control-label">Número
							del contrato</label>
						<div class="col-sm-4">
							<input type="text" id="numContrato" class="form-control"
								placeholder="contrato" id="numContrato">
						</div>
					</div>
					<div class="clearfix"></div>
					<div class="form-group">
						<label class="col-sm-4 control-label">Medidor</label>
						<div class="col-sm-5">
							<input type="text" class="form-control" id="numMedidor" name="numMedidor"
								placeholder="medidor" data-toggle="tooltip" data-placement="top"
								title="número del medidor">
						</div>
					</div>
					<h4 class="page-header"
						Style="text-align: center; font-size: xx-large;">Consumo</h4>
					
					<div class="form-group has-success has-feedback">
						<label class="col-sm-4 control-label">Lectura Actual</label>
						<div class="col-sm-5">
							<input data-bv-numeric="true" class="form-control" name="lectura" data-bv-numeric-message="¡Este valor no es un número!"
								id="lectura_Actual" data-toggle="tooltip" data-placement="top" title="Requerido">
						</div>
					</div>
					<div class="clearfix"></div>

					<div class="form-group has-success has-feedback">
						<label class="col-sm-4 control-label">Fecha de corte</label>
						<div class="col-sm-5">
							<input type="text" id="fecha_fin" class="form-control"
								name="fecha" placeholder="Fecha de corte" title="Requerido"><span
								class="fa fa-calendar txt-success form-control-feedback"></span>
						</div>
					</div>
					<div class="clearfix"></div>

					<div class="form-group has-success">
						<label class="col-sm-4 control-label">Consumo</label>
						<div class="col-sm-5">
							<!-- PARA DEJAR SIN USO A INPUT AGREGAR ATRIBUTO *disabled* -->
							<input type="text" class="form-control" name="consumoTotal"
								placeholder="el consumo es un campo calculado" id="consumoTotal">
						</div>
					</div>

					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-3">
							<button type="submit" class="btn btn-primary btn-label-left btn-lg" id="btnConsumo"
							data-toggle='tooltip' data-placement='bottom' title='guardar consumo' >
								<span><i class="fa fa-save"></i></span> Guardar
							</button>
						</div>
						<div class="col-sm-4">
							<button type="button"
								class="btn btn-default btn-label-left btn-lg"
								onclick="cancelar();">
								<span><i class="fa fa-reply txt-danger"></i></span> Cancelar
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
<!--///////////////////////DataTable de los consumos de los clientes/////////////////////////////// -->
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-th"></i> <span>Lista de consumos</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar2" onclick="validar(colap2);" class="collapse-link"> 
						<i class="fa fa-chevron-up"></i> </a> 
					<a id="expandir2" onclick="validar(expand2);" class="expand-link"> 
						<i class="fa fa-expand"></i> </a>
					<a class="cerrar" title="Inhabilitado"> 
						<i class="fa fa-times"></i></a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding table-responsive">
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="tabla_consumo" style="width:100%;">
					<thead>
						<tr>
							<th>Lectura Actual</th>
							<th>Consumo</th>
							<th>Nombre del Cliente</th>
							<th>Num medidor</th>
							<th>Acción</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!--///////////////////////DataTable del historial de consumos/////////////////////////////// -->
<div id="historial" class="row" style="display:none;">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name text-center">
					<i class="fa fa-th"></i> <span>Historial de consumos</span>
				</div>
				<div class="box-icons">
					<a id="abrir_historial" class="expand-link"> 
						<i class="fa fa-expand"></i></a>
					<a class="cerrar_historial" onclick="cerrarHistorial();"> 
						<i class="fa fa-times"></i></a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding table-responsive">
				<div style="width:100%; padding-top:15px;"></div>
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="tabla_consumo_historial" style="width:100%;">
					<thead>
						<tr>
							<th>Nombres del Cliente</th>
							<th>Fecha de corte</th>
							<th>Lectura</th>
							<th>Consumo</th>
							<th>Num_Contrato</th>
							<th>Num_medidor</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!--///////////////////////Formulario y dialogo de eliminción /////////////////////////////// -->
<div>
	<form id="frmEliminarConsumo" action="" method="DELETE">
		<input type="hidden" id="consumo_id" name="consumo_id" value="">
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

<!-- Imprimir  -->

<div>
	<form id="frmImprimirConsumo" action="" method="POST">
		<input type="hidden" id="consumo_id" name="consumo_id" value="">
		<input type="hidden" id="opcion" name="opcion" value="imprimir">

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




<!-- fin imprimir -->

<script type="text/javascript">
//objetos websockets
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

websocket.onclose = function(){
	//message('<p class="event">Socket Status: '+socket.readyState+' (Closed)');
	console.log("Desconectado, status de conexión: " + websocket.readyState);
}	

	var expand1 = new Expand1();//se crean los objetos que representan los botones de cada dialogo
	var colap1 =  new Colap1();
	var expand2 = new Expand2();
	var colap2 =  new Colap2();
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
	
//////////////////////////funsión que muestra el resultado mediant un dialogo//////////////////////////////////////
	var verResultado = function(r) {//parametro(resultado-String)
		if(r == "BIEN"){
			var texto ="¡Se realizó la acción correctamente, todo bien!", color="#29a3b1";
			$(".mensaje").html(texto).css({"color":color});
			$(".mensaje").fadeOut(7000, function() {//se muestra el mensaje por un tiempo y luego se oculta
				$(this).fadeIn(4000);	
				$(this).html("");
			});
			limpiar_texto();
			$('#tabla_consumo').DataTable().ajax.reload();
			websocket.send("ACTUALIZADO");
		}
		if(r == "ERROR"){
			mostrarMensaje("#dialog", "ERROR", 
					"¡Ha ocurrido un error, no se pudó realizar la acción!", "#E97D7D", "btn-danger");
		}
		if(r =="VACIO"){
			mostrarMensaje("#dialog", "VACIO", 
					"¡No se especificó la acción a realizar!", "#FFF8A7", "btn-warning");
		}
		if(r =="ACTUALIZADO"){
			mostrarMensaje("#dialog", "ACTUALIZADO", 
					"¡Otro usuario a realizado un cambio, se actualizaron los datos!", "#86b6dd", "btn-primary");
			$('#tabla_consumo').DataTable().ajax.reload();
		}
		if(r == "LECTURAMENOR"){
			mostrarMensaje("#dialog", "ERROR", 
					"¡La lectura que ha digitado debe ser mayor que la lectura anterior!", "#E97D7D", "btn-danger");
		}
		if(r == "FECHAMENOR"){
			mostrarMensaje("#dialog", "ERROR", 
					"¡La fecha debe ser mayor que el registro anterior de este cliente!", "#E97D7D", "btn-danger");
		}
	}
/////////////////////////////funsión que abre un dialogo y mostrara un contenido//////////////////////////////////
	function abrirDialogo(callback) {//parametro(funsion_js[eliminar])
		OpenModalBox(
				"<div><h3>Borrar Consumo</h3></div>",
				"<p Style='text-align:center; color:salmon; font-size:x-large;'>Esta seguro de borrar este consumo?</p>",
				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-2 col-md-3'>"+
				"<button style='margin-left:-10px; color:#ece1e1;' type='button' id='eliminar_consumo' "+
				"class='btn btn-danger btn-label-left'>"+
				"<span style='margin-right:-6px;'><i class='fa fa-trash-o'></i></span>Borrar consumo</button>"+
				"<div style='margin-top: 5px;'></div> </div>"+
				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-1 col-md-4 text-center'>"+
				"<button type='button' class='btn btn-default btn-label-left' Style='margin-left:10px;' onclick='CloseModalBox()'>"+
				"<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
		callback();
	}
	
	

	function abrirDialog() {//parametro(funsion_js[eliminar])
		OpenModalBox(
				"<div><h3>Imprimir consumo del cliente</h3></div>",
				"<p Style='text-align:center; color:blue; font-size:x-large;'>¿Esta seguro que desea imprimir el consumo de este cliente?</p>",
				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-3 col-md-3'>"+
				"<button type='button' id='imprimir_consumo' class='btn btn-primary btn-label-left'"+
				" style=' color: #ece1e1;' >"+
				"<span><i class='fa fa-print'></i></span> Imprimir</button>"+
				"<div style='margin-top: 5px;'></div> </div>"+
				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-3 text-center'>"+
				"<button type='button' class='btn btn-default btn-label-left' onclick='CloseModalBox()'>"+
				"<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
		imp();
	}

	
//////////////////////////////////eliminar los datos seteados en el formulario/////////////////////////////////////
	var imp = function() {
		$("#imprimir_consumo").on("click", function() {
			var consumo_ID = "";
			consumo_ID = $('#frmImprimirConsumo #consumo_id').val();
			console.log(consumo_ID );
			window.open("SL_ReporteConsumoCliente?consumo_id="+consumo_ID + "&opcion=imprimir",'_blank');
			console.log("El consumo_ID del jsp"+"  "+consumo_ID);
			CloseModalBox();
		});
	}

/////////////////////////activar evento del boton eliminar que esta en la fila seleccionada del dataTable///////////
	
	var obtener_id_imprimir = function(tbody, table) {//parametro(id_tabla, objeto dataTable)
		$(tbody).on("click", "button.imprimir", function() {
			var datos = table.row($(this).parents("tr")).data();
			$("form#frmImprimirConsumo #consumo_id").val(datos.consumo_ID);
			abrirDialog();
		});
	}
////////////////////////////////////////cerrar el modal del historial de consumos/////////////////////////////////
	function cerrarHistorial() {
		document.getElementById('historial').style.display = 'none';
		expandir($("#abrir_historial"));
		$('#tabla_consumo_historial').DataTable().state.clear();
		$('#tabla_consumo_historial').DataTable().clear().draw();
	}
///////////////////funsión que crea un dataTable para traer en cliente y el contrato mediante un dialogo////////////
	function cargarHistorial(contrato_ID){
		if($.fn.DataTable.isDataTable('#tabla_consumo_historial')){
			$('#tabla_consumo_historial').DataTable().state.clear();
			$('#tabla_consumo_historial').DataTable().clear().draw();
			$.ajax({
		        type: "GET",
		        url:"./SL_consumo",
				data: {
			        "carga": 3,
			        "contrato_ID" : contrato_ID
			    },
		        success: function(response){
		        	$('#tabla_consumo_historial').DataTable().rows.add(response.aaData).draw();
		        }
			});
		}else{
			var table = $('#tabla_consumo_historial').DataTable({
				responsive: true,
				"destroy": true,
		    	"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
		    	"bJQueryUI": true,
				"language":idioma_esp,
				ajax: {
					"method":"GET",
					"url":"./SL_consumo",
					"data": {
				        "carga": 3,
				        "contrato_ID" : contrato_ID
				    },
					"dataSrc":"aaData"
				},
				"columns": [
					{ "data": "cliente.nombreCompleto" },
					{ "data": null,
		                render: function ( data, type, row ) {
		                	var f = new Date(data.fecha_fin);
		        			var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
		                	return fecha;
		                }
					},
		            { "data": "lectura_Actual" },
		            { "data": "consumoTotal" },
		            { "data": "contrato.numContrato" },
		            { "data": "contrato.numMedidor" }
		     	]
		    });
		}
	}
///////////////////funsión que crea un dataTable para traer en cliente y el contrato mediante un dialogo////////////
	function filtrarTabla(){
		    $('#datatable-filter thead th label input').each( function () {
		        var title = $(this).attr("name");
		        $(this).attr("placeholder", "Buscar por " + title);
		    } );
		    var table = $('#datatable-filter').DataTable({
		    	responsive: true,
		    	"destroy": true,
		    	"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todo"]],
		    	"bJQueryUI": true,
				"language":idioma_esp,
				ajax: {
					"method":"GET",
					"url":"./SL_consumo",
					"data": {
				        "carga": 2//para decirle al servlet que cargue solo clinte + consumos
				    },
					"dataSrc":"aaData"
				},
				"columns": [
		            { "data": "nombreCompleto"},
		            { "data": "contratos[0].numContrato" },
		            { "data": "contratos[0].numMedidor" },
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
			console.log("cambiar cliente");
			var datos = table.row($(this).parents("tr")).data();
			console.log(datos);
			$("#nombreClienteCompleto").val(datos.nombreCompleto);
			$("#numContrato").val(datos.contratos[0].numContrato);
			$("#numMedidor").val(datos.contratos[0].numMedidor);
			$("#cliente_ID").val(datos.cliente_ID);
			$("#contrato_ID").val(datos.contratos[0].contrato_ID);
			
			CloseModalBox();
		});
	}
///////////////////////////funsión que activa el evento click del boton visualizar del dataTable///////////////////////
	var seleccionarvisualizarConsumo = function(tbody, table) {//parametro(id_tabla, objeto dataTable)
		$(tbody).on("click", "button.visualizarConsumo", function() {
			$("form#defaultForm #info" ).remove();
			$("form#defaultForm").prepend("<h2 id='info' Style='color:#3276D7; text-align:center;'>Visualización del Registro</h2>");
			var datos = table.row($(this).parents("tr")).data();
			var f = new Date(datos.fecha_fin);
			var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
			$("#lectura_Actual").val(datos.lectura_Actual).prop('readonly', true);
			$("#fecha_fin").val(fecha).prop('disabled', true);
			$("#consumoTotal").val(datos.consumoTotal).prop('readonly', true);
			$("#nombreClienteCompleto").val(datos.cliente.nombreCompleto).prop('readonly', true);
			$("#numContrato").val(datos.contrato.numContrato).prop('readonly', true);
			$("#numMedidor").val(datos.contrato.numMedidor).prop('readonly', true);
			$("#opcion").val("visualizar");
			$("#consumo_ID").val(datos.consumo_ID);
			$("#nombreClienteCompleto").prop('readonly', true);
			$("#numContrato").prop('readonly', true);
			$("#numMedidor").prop('readonly', true);
			$("#abrir_modal").prop('disabled', true);
			$("#abrir_modal").attr('title', 'Boton inhabilitado para esta opción');
			$("#cliente_ID").val(datos.cliente.cliente_ID);
			$("#contrato_ID").val(datos.contrato.contrato_ID);
			$("button#btnConsumo").prop('disabled', true);
			document.getElementById('formulario').style.display = 'block';
			if(colap1.valor==false)
				validarColap(colap1, "#colapsar_desplegar1");
			validarColap(colap2, "#colapsar_desplegar2");
			validarExpand(expand1, "#expandir1");
			if(expand2.valor == true)
				validarExpand(expand2, "#expandir2");
		});
	}
///////////////////////////funsión que activa el evento click del boton editar del dataTable///////////////////////
	var seleccionarEditarConsumo = function(tbody, table) {//parametro(id_tabla, objeto dataTable)
		$(tbody).on("click", "button.editarConsumo", function() {
			var datos = table.row($(this).parents("tr")).data();
			var f = new Date(datos.fecha_fin);
			var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
			$("#lectura_Actual").val(datos.lectura_Actual);
			$("#fecha_fin").val(fecha);
			$("#consumoTotal").val(datos.consumoTotal);
			$("#nombreClienteCompleto").val(datos.cliente.nombreCompleto);
			$("#numContrato").val(datos.contrato.numContrato);
			$("#numMedidor").val(datos.contrato.numMedidor);
			$("#opcion").val("actualizar");
			$("#consumo_ID").val(datos.consumo_ID);
			$("#nombreClienteCompleto").prop('readonly', true);
			$("#numContrato").prop('readonly', true);
			$("#numMedidor").prop('readonly', true);
			$("#abrir_modal").prop('disabled', true);
			$("#abrir_modal").attr('title', 'No puede editar el cliente');
			$("#cliente_ID").val(datos.cliente.cliente_ID);
			$("#contrato_ID").val(datos.contrato.contrato_ID);
			
			document.getElementById('formulario').style.display = 'block';
			if(colap1.valor==false)
				validarColap(colap1, "#colapsar_desplegar1");
			validarColap(colap2, "#colapsar_desplegar2");
			if(expand2.valor == true)
				validarExpand(expand2, "#expandir2");
		});
	}
///////////////////////////funsión que activa el evento click del boton ver historial del dataTable///////////////////////
	var visualizarHistorial = function(tbody, table) {//parametro(id_tabla, objeto dataTable)
		$(tbody).on("click", "button.verHistorial", function() {
			var datos = table.row($(this).parents("tr")).data();
			var contrato_ID = datos.contrato.contrato_ID;
			document.getElementById('historial').style.display = 'block';
			expandir($("#abrir_historial"));
			$("#abrir_historial").prop('disabled', true);
			cargarHistorial(contrato_ID);
		});
	}
///////////////////////////////Ejecutar el metodo DataTable para llenar la Tabla///////////////////////////////////
	function iniciarTabla(){
		var tablaConsumo = $('#tabla_consumo').DataTable( {
			responsive: true,
			"destroy": true,
			'bProcessing': false,
			'bServerSide': false,
			ajax: {
				"method":"GET",
				"url":"./SL_consumo",
				"data": {
			        "carga": 1//para decirle al servlet que cargue consumos + cliente + contrato
			    },
				"dataSrc":"aaData"
			},
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
	            { "data": "lectura_Actual" },
	            { "data": "consumoTotal" },
	            { "data": "cliente.nombreCompleto" },
	            { "data": "contrato.numMedidor" },
	            {"defaultContent":"<button type='button' class='visualizarConsumo btn btn-info' data-toggle='tooltip' "+
					"data-placement='top' title='Visualizar Registro'>"+
					"<i class='fa fa-info-circle'></i> </button>  "+
					"<button type='button' class='editarConsumo btn btn-primary' title='Editar consumo'>"+
					"<i class='fa fa-pencil-square-o'></i> </button>  "+
					"<button type='button' class='eliminarConsumo btn btn-danger' title='Eliminar consumo'>"+
					"<i class='fa fa-trash-o'></i> </button> "+
					"<button type='button' class='verHistorial btn btn-warning' data-toggle='tooltip' "+
					"data-placement='top' title='ver historial de consumos'>"+
					"<i class='fa fa-sitemap'></i> </button> "+
					"<button type='button' class='imprimir btn btn-basic' data-toggle='tooltip' "+
					"data-placement='top' title='Imprimir Consumo'>"+
					"<i class='fa fa-print'></i> </button>"}

	            ],
	            "dom":"<rt><'row'<'form-inline' <'col-sm-12 text-center'B>>>"
					 +"<'row' <'form-inline' <'col-sm-6'l><'col-sm-6'f>>>"
					 +"<rt>"
					 +"<'row'<'form-inline'"
					 +"<'col-sm-6 col-md-6 col-lg-6'i><'col-sm-6 col-md-6 col-lg-6'p>>>",
	            "buttons":[{
					"text": "<i class='fa fa-plus-square'></i>",
					"titleAttr": "Agregar consumo",
					"className": "btn btn-success",
					"action": function() {
						agregar_nuevo_consumo();
					}
				},
				{
	                text: '<i class="fa fa-print fa-o"></i>',
	                titleAttr: 'Imprimir reporte',
	                action: function(){
	                	imprimir();
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
		tablaConsumo.page.len(0).draw();
		$('#tabla_consumo_length').each( function() {
			$(this).find('label select').attr('disabled', 'disabled');
		});	
		$('#tabla_consumo_filter').each( function() {
			$(this).find('label input[type=search]').on( 'keyup change', function () {
		    	if($(this).val() == ""){
		    		tablaConsumo.page.len(0).draw();
		    		$('#tabla_consumo_length').each( function() {
		    			$(this).find('label select').attr('disabled', 'disabled');
		    		});
		    	}else{
		    		tablaConsumo.page.len(10).draw();
		    		$('#tabla_consumo_length').each( function() {
		    			$(this).find('label select').removeAttr('disabled');
		    		});
		    	}
		    });	
		});
		seleccionarEditarConsumo('#tabla_consumo tbody', tablaConsumo);
		seleccionarvisualizarConsumo('#tabla_consumo tbody', tablaConsumo);
		seleccionarEliminarConsumo('#tabla_consumo tbody', tablaConsumo);
		visualizarHistorial('#tabla_consumo tbody', tablaConsumo);
		obtener_id_imprimir('#tabla_consumo tbody', tablaConsumo);

	}
	
	function imprimir()
	{
		var consumo_ID ="";	
		userC = $('#userC').val();
		consumo_ID = $("#consumo_ID").val();
		window.open("SL_ReporteConsumoCT?consumo_ID="+consumo_ID+"&userC="+userC, '_blank');

		console.log("imprimir registro");
	}
	
	var agregar_nuevo_consumo = function() {//////////////agregar nuevo registro limpiando texto y abriendo el form
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
		$("form#defaultForm #info" ).remove();
		$("#consumo_ID").val("");
		$("#cliente_ID").val("");
		$("#contrato_ID").val("");
		$("#lectura_Actual").val("").prop('readonly', false);
		$("#fecha_fin").val("").prop('disabled', false);
		$("#consumoTotal").val("").prop('readonly', false);
		$("#nombreClienteCompleto").val("").prop('readonly', false);
		$("#numContrato").val("").prop('readonly', false);
		$("#numMedidor").val("").prop('readonly', false);
		$("#nombreClienteCompleto").prop('readonly', false);
		$("#numContrato").prop('readonly', false);
		$("#numMedidor").prop('readonly', false);
		$("#abrir_modal").prop('disabled', false);
		$("#abrir_modal").attr('title', '');
		$("#btnConsumo").prop('disabled', false);
		$("form#defaultForm").data('bootstrapValidator').resetForm();////////////////resetear las validaciones
	}
/////////////////////////funsión que activa el evento click para eliminar un registro del dataTable////////////////
	var seleccionarEliminarConsumo = function(tbody, table) {//parametro(id_tabla, objeto dataTable)
		$(tbody).on("click", "button.eliminarConsumo", function() {
			var datos = table.row($(this).parents("tr")).data();
			$("form#frmEliminarConsumo #consumo_id").val(datos.consumo_ID);
			abrirDialogo(eliminarConsumo);
		});
	}
//////////////////////////////////eliminar los datos seteados en el formulario/////////////////////////////////////
	var eliminarConsumo = function() {
		$("#eliminar_consumo").on("click", function() {
			var consumo_ID = $("#frmEliminarConsumo #consumo_id").val();//se obtiene el id del usuario que esta oculto
			console.log("consumo_ID:"+consumo_ID);
			$.ajax({
				type:"DELETE",
				url:"./SL_consumo",
				headers: {"consumo_ID": consumo_ID}
			}).done(function(info) {
				mostrarMensaje("#dialog", "CORRECTO", 
						"¡Se realizó la acción correctamente, todo bien!", "#d7f9ec", "btn-info");
				limpiar_texto();
				$('#tabla_consumo').DataTable().ajax.reload();
				websocket.send("ACTUALIZADO");
				CloseModalBox();
			});
		});
	}
/////////////////////////////////////////////////FUNSIÓN PRINCIPAL/////////////////////////////////////////////////
	$(document).ready(function() {

		//cargar scripts dataTables
		LoadDataTablesScripts2(AllTables);
		
		// Crear UI spinner
		$("#numContrato").spinner();

		// Inicializar DatePicker
		$('#fecha_fin').datepicker({
			setDate : new Date(),
			dateFormat: 'dd/mm/yy',
			onSelect: function(dateText, inst) {
				$("#fecha_fin").val(dateText.toString());
				$("#fecha_fin").change();
				$('form#defaultForm').bootstrapValidator('revalidateField', 'fecha');
			}
		});
	
		// Añadir Tooltip para formularios
		$('.form-control').tooltip();

		//Cargar plugins para validaciones
		LoadBootstrapValidatorScript(FormValidConsumo);

		//MODAL para mostrar una tabla con el cliente y en contrato
		$('#abrir_modal').on('click',function(e) {
			OpenModalBox(
			"<div><h3>Buscar Cliente</h3></div>",
			"<div class='table-responsive'>"
			+ "<table class='table table-bordered table-striped table-hover table-heading table-datatable'"+
			"id='datatable-filter'>"
			+ "<thead>"
			+ "<tr>"
			+ "<th><label><input type='text' name='Nombres'/></label></th>"
			+ "<th><label><input type='text' name='Num_Contrato'/></label></th>"
			+ "<th><label><input type='text' name='Medidor'/></label></th>"
			+ "<th></th>"
			+ "</tr>"														
			+ "</thead>"														
			+ "<tfoot>"														
			+ "<tr><th Style='color: #5d96c3;'>Nombre Completo</th>"+
			"<th Style='color: #5d96c3;'>Numero Contrato</th>"+
			"<th Style='color: #5d96c3;'>Medidor</th><th></th></tr>"														
			+ "</tfoot>"														
			+ "</table>"														
			+ "</div>",
			"<div Style='text-align: center; margin-bottom: -5px;'><button type='button' class='btn-default btn-label-left btn-lg' "
			+"onclick='CloseModalBox()'><span><i class='fa fa-reply txt-danger'></i></span>Cancelar</button></div>");
			
			filtrarTabla();		
		});
		
		// Add Drag-n-Drop feature				
		WinMove();	
		
		//añadir tooltip
		$('[data-toggle="tooltip"]').tooltip();
		
		$("input#lectura_Actual").keyup(function() {
			if($("form#defaultForm #contrato_ID").val()!="" && $("form#defaultForm #cliente_ID").val()!=""){
				var contrato_ID = $("form#defaultForm #contrato_ID").val();
				$.ajax({//enviar datos por ajax
		 			type:"GET",
		 			url:"./SL_consumo",
		 			data: {
		 				"carga": 3,
		 				"contrato_ID" : contrato_ID
				    }
		 			}).done(function(info) {//informacion que el servlet le reenvia al jsp
		 				if(info.aaData.length >0){
			 				var consumo_id = info.aaData[info.aaData.length-1].consumo_ID;
			 				var lectura_ant1 = info.aaData[info.aaData.length-1].lectura_Actual;
			 				var lectura_ant2 = info.aaData[info.aaData.length-2].lectura_Actual;
			 				if(consumo_id == $("form#defaultForm #consumo_ID").val())
			 					$( "#consumoTotal" ).val($( "#lectura_Actual" ).val() - lectura_ant2).change();
			 				else
			 					$( "#consumoTotal" ).val($( "#lectura_Actual" ).val() - lectura_ant1).change();
		 				}else
		 					$( "#consumoTotal" ).val($( "#lectura_Actual" ).val() - 0).change();
		 		});
            }
		});
	});
	
///////////////////////////Funsión que valida el formulario de consumos de clientes////////////////////////////////
	function FormValidConsumo() {
		$('form#defaultForm').bootstrapValidator({
			message: '¡Este valor no es valido!',
			fields: {
				lectura:{
					validators: {
						notEmpty:{
			                message: "¡Este campo es requerido y no debe estar vacio!"
			            },
			            greaterThan: {
	                        value: 0,
	                        inclusive: false,
	                        message: '¡El valor debe ser mayor o igual a 0!'
	                    },
	                    callback: {
           					message: '¡Seleccione un cliente antes de digitar la lectura!',
            				callback: function (value, validator, $field) {
            					if($("form#defaultForm #contrato_ID").val()=="" && $("form#defaultForm #cliente_ID").val()==""){
            						return false;
                                }else{
                                	return true;
                                }
            				}
        				}
			        }
				},
				fecha:{
					validators: {
						notEmpty:{
			                message: "¡Este campo es requerido y no debe estar vacio!"
			            }
			        }
				},
				consumoTotal:{
					validators: {
						notEmpty:{
			                message: "¡Este campo es requerido y no debe estar vacio!"
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
	 			type:"POST",
	 			url:"./SL_consumo",
	 			data: frm//datos a enviar
	 			}).done(function(info) {//informacion que el servlet le reenvia al jsp
	 			console.log(info);
			
				if(expand2.valor == true)
					validarExpand(expand2, "#expandir2");
				
				if (colap2.valor ==true){}else{
					validarColap(colap2, "#colapsar_desplegar2");
				}
				verResultado(info);//se envia a verificar que mensaje respondio el servlet	
	 			});
        });
	}
	
</script>
