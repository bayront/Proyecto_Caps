
<%@page import="Entidades.Usuario, Entidades.Rol, Datos.DT_Vw_rol_opciones,Datos.DTOtros_Ing_Egreg, java.util.*, Entidades.Otros_Ing_Egreg , java.sql.ResultSet ;"%>
<%@page language="java"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
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
<div id="dialog" class="col-xm-offset-1 col-xm-10">
	<div class="contenido" style="margin-left: 20px;"></div>
</div>
<!--///////////////////////Directorios donde estan los jsp /////////////////////////////// -->
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Finanzas</a></li>
			<li><a href="#">Gestión de Otros Ingresos y Egresos</a></li>
		</ol>
	</div>
</div>
<!--///////////////////////DataTable de otros ingresos y egresos/////////////////////////////// -->
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name text-center">
					<i class="fa fa-th"></i> <span>Lista de Otros ingresos y egresos</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar2" class="collapse-link" onclick="validar(colap2);"> 
						<i class="fa fa-chevron-up"></i>
					</a> <a id="expandir2" class="expand-link" onclick="validar(expand2);"> 
						<i class="fa fa-expand"></i></a>
					<a class="cerrar" title="Inhabilitado"> 
						<i class="fa fa-times"></i></a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding table-responsive">
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="tabla_OI" style="width:100%;">
					<thead>
						<tr>
							<th>Monto</th>
							<th>Fecha del registro</th>
							<th>Categoría</th>
							<th>Acción</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!--///////////////////////Formulario principal de otros ingresos y egresos/////////////////////////////// -->
<div class="row" id="formularioOtrosIngresos">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-edit"></i> <span>Formulario de Otros Ingresos y Egresos</span>
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
				<form class="form-horizontal" role="form" id="formOI" method="post" action="">
					<input type="hidden" id="opcion" name="opcion" value="guardar">
					<input type="hidden" id="Otros_Ing_Egreg_ID" name="Otros_Ing_Egreg_ID">
					
					<div class="form-group has-success">
						<label class="col-sm-4 control-label text-info">Descripción</label>
						<div class="col-sm-4">
							<textarea maxlength="250" title="No Requerido" id="descripcion" name="descripcion" 
							class="form-control" style="max-width:100%; height:110px;"></textarea>
							<div id="contadorText">250 caracteres permitidos</div>
						</div>
					</div>
					<div class="form-group has-success">
						<label class="col-sm-4 control-label text-info">monto</label>
						<div class="col-sm-4">
							<input id="monto" name="monto" data-bv-numeric="true" class="form-control"
							data-bv-numeric-message="¡Este valor no es un número!" title="Requerido">
						</div>
					</div>
					<div class="form-group has-success has-feedback">
					<!-- FORMA PARA CREAR PERIODOS DE TIEMPO CON JQUERY UI -->
						<label  class="col-sm-4 control-label text-info">Fecha </label>
						<div class="col-sm-4">
							<input id="fecha" name="fecha" type="text" class="form-control"
								placeholder="fecha del registro" title="Requerido">
								<span class="fa fa-calendar txt-success form-control-feedback"></span>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-4 text-right control-label">Categoría</label>
						<div class="col-sm-4">
							<select class="populate placeholder" name="categoria_Ing_Egreg_ID" 
							id="categoria_Ing_Egreg_ID">
								<option value="0">--Seleccione la categoría--</option>
							</select>
						</div>
					</div>
					<div class="form-group" style="margin-top: 20px;">
						<div class="col-sm-offset-3 col-sm-4">
							<button id="btnEnviar" type="submit" class="btn btn-primary btn-label-left btn-lg">
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
<!--///////////////////////Formulario y dialogo de eliminción /////////////////////////////// -->
<div>
	<form id="frmEliminarOI" action="" method="POST">
		<input type="hidden" id="Otros_Ing_Egreg_ID" name="Otros_Ing_Egreg_ID" value="">
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
////////////////////////////////variables para el WEBSOCKET//////////////////////////////////////////////////
var wsUri = "ws://"+window.location.host+"/SOFCAPS/serverendpointdemo";
var websocket;
if (!(websocket instanceof WebSocket) || websocket.readyState !== WebSocket.OPEN) {
	websocket = new WebSocket(wsUri);
	console.log("nueva webOtrosIng");
	//evento que notifica que la conexion esta abierta
	websocket.onopen = function(evt) { //manejamos los eventos...
	    console.log("Conectado..."); //... y aparecerá en la pantalla
	};
	//evento onmessage para resibir mensaje del serverendpoint
	websocket.onmessage = function(evt) { // cuando se recibe un mensaje
		console.log("Mensaje recibido de webOtrosIng: " + evt.data);
		verResultado(evt.data);
	};
	//evento si hay algun error en la comunicacion con el web_socket
	websocket.onerror = function(evt) {
	    console.log("oho!.. error:" + evt.data);
	};
}else
	console.log("no conectar webOtrosIng");
	
	var expand1 = new Expand1();//se crean los objetos que representan los botones de cada dialogo
	var colap1 =  new Colap1();
	var expand2 = new Expand2();
	var colap2 =  new Colap2();
//////////////////////////////////funsión que carga los plugin de los botones para el dataTable///////////////////
	function AllTables() {
		//cargar PDF Y EXCEL
		$.getScript('plugins/datatables/nuevo/jszip.min.js', function(){
			$.getScript('plugins/datatables/nuevo/pdfmake.min.js',function(){
				$.getScript('plugins/datatables/nuevo/vfs_fonts.js',function(){
					iniciarTabla();
					LoadSelect2Script(MakeSelect2);
				});
			});
		});
	}
	
	
	function imprimir()
	{
		var descripcion ="";
		var monto = "";
		var fecha = "";		
		descripcion = $("#descripcion").val();
		monto = $("#monto").val();
		fecha = $('#fecha').val();
	
			
		window.open("SL_ReporteOtros?descripcion="+descripcion+"&monto="+monto+"&fecha="+fecha, '_blank');
		console.log("Error en metodo imprimir");
	}
	
	var limpiar_texto = function() {//limpiar texto del formulario
		$( "form #info" ).remove();
		$("#opcion").val("guardar");
		$("#descripcion").val("").prop('readonly', false);
		$("#monto").val("").prop('readonly', false);
		$("#fecha").val("").removeAttr('disabled');
		$("#categoria_Ing_Egreg_ID").val("");
		$("#categoria_Ing_Egreg_ID").change().removeAttr('disabled');
		$("button#btnEnviar").removeAttr('disabled');
		$("#formOI").data('bootstrapValidator').resetForm();////////////////resetear las validaciones
	}
/////////////////////////////////funsión que muestra un dialogo con el resultado de la opreación/////////////////
	var verResultado = function(r) {////////////parametro: respuesta(String)
		if(r == "BIEN"){
			mostrarMensaje("#dialog", "CORRECTO", 
					"¡Se realizó la acción correctamente, todo bien!", "#d7f9ec", "btn-info");
			limpiar_texto();
			$('#tabla_OI').DataTable().ajax.reload();
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
			$('#tabla_OI').DataTable().ajax.reload();
		}
	}
/////////////////////////////////////////funsión que carga el dataTable la primera vez//////////////////////////
	function iniciarTabla(){
		console.log("cargar DataTable");
		var tablaO = $('#tabla_OI').DataTable( {
			"destroy": true,
			responsive: true,
			'bProcessing': false,
			'bServerSide': false,
			"ajax": {
				"method":"GET",
				"url":"./SL_Otros_Ing_Egreg",
				"data": {
			        "carga": 1//para decirle al servlet que cargue datos
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
	            { "data": "monto" },
	            { "data": null,
	                render: function ( data, type, row ) {
	                	f = new Date(data.fecha);
	                	var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
	                	return fecha;
	                }},
	            { "data": "categoria_Ing_Egreg.nombreCategoria" },
	            {"defaultContent":"<button type='button' class='visualizarOI btn btn-info' data-toggle='tooltip' "+
					"data-placement='top' title='Visualizar Registro'>"+
					"<i class='fa fa-info-circle'></i> </button>  "+
					"<button type='button' class='editarOI btn btn-primary' data-toggle='tooltip' "+
					"data-placement='top' title='Editar Otros ingresos o egresos'>"+
					"<i class='fa fa-pencil-square-o'></i> </button>  "+
					"<button type='button' class='eliminar btn btn-danger' title='Eliminar Otros ingresos o egresos'>"+
					"<i class='fa fa-trash-o'></i>"+
					"</button>"}
	            ],
	            "dom":"<rt><'row'<'form-inline' <'col-sm-12 text-center'B>>>"
					 +"<'row' <'form-inline' <'col-sm-6'l><'col-sm-6'f>>>"
					 +"<rt>"
					 +"<'row'<'form-inline'"
					 +"<'col-sm-6 col-md-6 col-lg-6'i><'col-sm-6 col-md-6 col-lg-6'p>>>",
	            "buttons":[{
					"text": "<i class='fa fa-plus-square'></i>",
					"titleAttr": "Agregar Otros ingresos o egresos",
					"className": "btn btn-success",
					"action": function() {
						agregar_nuevo_OI();
					}
				},
				{
	                
	                text:      '<i class="fa fa-print fa-o"></i>',
	                titleAttr: 'Imprimir reporte',
	                action: function(){
	                	imprimir();
	                }
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
		obtener_datos_editar('#tabla_OI tbody', tablaO);
		obtener_id_eliminar('#tabla_OI tbody', tablaO);
		obtener_id_visualizar('#tabla_OI tbody', tablaO);
	}
	var agregar_nuevo_OI = function() {/////funsión para limpiar el texto y expandir el dialogo del formulario
		document.getElementById('formularioOtrosIngresos').style.display = 'block';
		limpiar_texto();
		validarExpand(expand1, "#expandir1");
		if(colap1.valor==false)
			validarColap(colap1, "#colapsar_desplegar1");
		validarColap(colap2, "#colapsar_desplegar2");
		if(expand2.valor == true)
			validarExpand(expand2, "#expandir2");
		
		$("#descripcion").focus();
	}
	
	var cancelar = function() {///////funsión que limpia el texto y oculta el formulario
		limpiar_texto();
		document.getElementById('formularioOtrosIngresos').style.display = 'none';
		if(expand1.valor == true)
			validarExpand(expand1, "#expandir1");
		
		if(expand2.valor == true)
			validarExpand(expand2, "#expandir2");
		
		validarColap(colap1, "#colapsar_desplegar1");
		if (colap2.valor ==true){}else{
			validarColap(colap2, "#colapsar_desplegar2");
		}
	}
/////////////////////funsión que activa el click para el boton visualizar del DataTable, y obtiene los datos////////////
	var obtener_id_visualizar = function(tbody, table) {
		$(tbody).on("click", "button.visualizarOI", function() {
			$("form#formOI").prepend("<h2 id='info' Style='color:#3276D7; text-align:center;'>Visualización del Registro</h2>");
			var datos = table.row($(this).parents("tr")).data();
			f = new Date(datos.fecha);
        	var fecha2 = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
			$("#descripcion").val(datos.descripcion).prop('readonly', true);
			$("#monto").val(datos.monto).prop('readonly', true);
			$("#Otros_Ing_Egreg_ID").val(datos.otros_Ing_Egreg_ID);
			$("#opcion").val("visualizar");
			$("#fecha").val(fecha2).attr('disabled', 'disabled');
			$("#categoria_Ing_Egreg_ID").val(datos.categoria_Ing_Egreg.categoria_Ing_Egreg_ID);
			$("#categoria_Ing_Egreg_ID").change().attr('disabled', 'disabled');
			//$('#selectid option:not(:selected)').attr('disabled',true);
			$("button#btnEnviar").attr('disabled', 'disabled');
			document.getElementById('formularioOtrosIngresos').style.display = 'block';
			validarExpand(expand1, "#expandir1");
			if(colap1.valor==false)
				validarColap(colap1, "#colapsar_desplegar1");
			validarColap(colap2, "#colapsar_desplegar2");
			if(expand2.valor == true)
				validarExpand(expand2, "#expandir2");
		});
	}
/////////////////////funsión que activa el click para el boton editar del dataTable, y obtiene los datos////////////
	var obtener_datos_editar = function(tbody, table) {
		$(tbody).on("click", "button.editarOI", function() {
			var datos = table.row($(this).parents("tr")).data();
			f = new Date(datos.fecha);
        	var fecha2 = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
			$("#descripcion").val(datos.descripcion);
			$("#monto").val(datos.monto);
			$("#Otros_Ing_Egreg_ID").val(datos.otros_Ing_Egreg_ID);
			$("#opcion").val("actualizar");
			$("#fecha").val(fecha2);
			$("#categoria_Ing_Egreg_ID").val(datos.categoria_Ing_Egreg.categoria_Ing_Egreg_ID);
			$("#categoria_Ing_Egreg_ID").change();
			document.getElementById('formularioOtrosIngresos').style.display = 'block';
			validarExpand(expand1, "#expandir1");
			if(colap1.valor==false)
				validarColap(colap1, "#colapsar_desplegar1");
			validarColap(colap2, "#colapsar_desplegar2");
			if(expand2.valor == true)
				validarExpand(expand2, "#expandir2");
		});
	}
///////////////////////////funsión que activa el evento click del boton eliminar que esta en el dataTable/////////////////////////
	var obtener_id_eliminar = function(tbody, table) {////parametro: tbody del dataTable, y el dataTable completo
		$(tbody).on("click", "button.eliminar", function() {
			var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
			var Otros_Ing_Egreg_ID;
			table.rows().every(function(index, loop, rowloop) {
				console.log("indices: "+ index +" : "+datos);
				if(index == datos){////////////////////////////////obtener los datos a eliminar
					Otros_Ing_Egreg_ID = table.row(index).data().otros_Ing_Egreg_ID;
					console.log("Otros_Ing_Egreg_ID: " + Otros_Ing_Egreg_ID );
					$("#frmEliminarOI #Otros_Ing_Egreg_ID").val(Otros_Ing_Egreg_ID);
				}
			});
			abrirDialogo();
		});
	}
/////////////////////////////////////funsión que aber el dialogo para confirmar eliminació de los datos//////////
	function abrirDialogo() {
		OpenModalBox(
				"<div><h3>Borrar el registro de ingreso o egreso</h3></div>",
				"<p Style='text-align:center; color:salmon; font-size:x-large;'>¿Esta seguro de borrar este registro?</p>",
				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-3 col-md-3'>"+
				"<button type='button' id='eliminar_OI' class='btn btn-danger btn-label-left'"+
				" style=' color: #ece1e1;' >"+
				"<span><i class='fa fa-trash-o'></i></span> Borrar</button>"+
				"<div style='margin-top: 5px;'></div> </div>"+
				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-3 text-center'>"+
				"<button type='button' class='btn btn-default btn-label-left' onclick='CloseModalBox()'>"+
				"<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
		eliminar();
	}
/////////////////////////////////funsión que envia los datos a eliminar al servlet por ajax//////////////////////
	var eliminar = function() {
		$("#eliminar_OI").on("click", function() {
			frmElim = $("#frmEliminarOI").serialize();
			console.log("datos a eliminar: " + frmElim);
			$.ajax({
				method:"POST",
				url:"SL_Otros_Ing_Egreg",
				data: frmElim
			}).done(function(info) {
				verResultado(info);
				console.log(info);
			});
			CloseModalBox();
		});
	}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////FUNSIÓN PRINCIPAL//////////////////////////////////////////
	$(document).ready(function() {
		//cargar scripts dataTables
		LoadDataTablesScripts2(AllTables);
		
		$('.form-control').tooltip();
		$('[data-toggle="tooltip"]').tooltip();
		
		WinMove();
		
		LoadBootstrapValidatorScript(FormValidators);
		
		$('#fecha').datepicker({
			setDate : new Date(),
			dateFormat: 'dd/mm/yy',
			onSelect: function(dateText, inst) {
				$("#fecha").val(dateText.toString());
				$("#fecha").change();
				$('#formOI').bootstrapValidator('revalidateField', 'fecha');
			}
		});
		
		cargarSelect("#categoria_Ing_Egreg_ID")//traer unidadMedidas
		
		$('#descripcion').keyup(function() {//contador para el máximo de caracteres permitidos en la descripción
	        var chars = $(this).val().length;
	        var diff = 250 - chars;
	        $('#contadorText').html(diff+" caracteres permitidos");   
	    });
	});
/////////////////////////////////////funsión que carga el select mediante ajax///////////////////////////////////
	function cargarSelect(select) {//parametro id select
		var datos;
		$.ajax({
	        type: "GET",
	        url: "./SL_ajax_table_categoriaIE",
	        dataType: "json",
	        success: function(response)
	        {
	        	datos = response.aaData;
	        	$(select).empty();
	        	$(select).append("<option value=''>--Seleccione la categoría--</option>");
	        	$(response.aaData).each(function(i, v) {
	        			$(select).append('<option value="' + v.categoria_Ing_Egreg_ID + '">' + v.nombreCategoria + '</option>');
				});
	        }
		});
	}
/////////////////////////////////////funsión que valida los campos del formulario////////////////////////////////
	function FormValidators() {
		$('#formOI').bootstrapValidator({
			message: '¡Este valor no es valido!',
			fields: {
				monto:{
					validators:{
						greaterThan: {
							value: 0,
							inclusive: false,
							message: '¡El campo debe ser mayor que 0!'
						},
	                    notEmpty:{
			                message: "¡Este campo es requerido y no debe estar vacio!"
			            }
					}
				},
				fecha:{
					validators:{
	                    notEmpty:{
			                message: "¡Este campo es requerido y no debe estar vacio!"
			            }
					}
				},
				categoria_Ing_Egreg_ID:{
					validators:{
	                    notEmpty:{
			                message: "¡Seleccione una categoría!"
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
	  			url:"./SL_Otros_Ing_Egreg",
	  			data: frm//datos a enviar
	  		}).done(function(info) {//informacion que el servlet le reenvia al jsp
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