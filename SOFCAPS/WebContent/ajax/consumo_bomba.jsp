<%@page import="Datos.DT_categoria_Ing_Engre, java.util.*, Entidades.TipoCategoria, java.sql.ResultSet ;"%>
<%@page language="java"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<div id="dialogBomb" class= "col-xm-offset-1 col-xm-10">
	<div class="contenido" style="margin-left: 20px;"></div>
</div>  

<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Consumos</a></li>
			<li><a href="#">Consumo de la bomba</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-edit"></i> <span>Consumo de la Bomba</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link" id="colapsar_desplegar1" onclick="validar(colap1);"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"  id="expandir1" onclick="validar(expand1);"> <i class="fa fa-expand"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content">
				<form  class="form-horizontal" role="form" id="formConsB" method="post" action="validators.html">
					<input type="hidden" id="opcion" name="opcion" value="guardar">
					<input type="hidden" id="bombaID" name="bombaID" value="">
<!-- 					<input type="hidden" id="fechaLecturaActual" name="fechaLecturaActual" value="guardar"> -->
					<div class="form-group">
						<label class="col-sm-2 control-label">Lectura del mes actual: </label>
						<div class="col-sm-4">
							<input id="lecturaActual" name="lecturaActual" type="text" class="form-control" placeholder="0.0"
								data-toggle="tooltip" data-placement="bottom"
								title="Tooltip para lectura actual">
						</div> 	
					</div>
					
					<div class="form-group">
					<!-- FORMA PARA CREAR PERIODOS DE TIEMPO CON JQUERY UI -->
						<label  class="col-sm-2 control-label">Fecha actual</label>
						<div class="col-sm-4">
							<input id="fecha" name="fecha" type="text" class="form-control"
								placeholder="fecha de inicio">
						</div>
					</div>
					
					<!-- Agregar espacio con clase *.clearfix* -->
					<div class="clearfix"></div>

					<div class="form-group">
						<label class="col-sm-2 control-label">Observaciones: </label>
						<!-- PARA AGREGAR VALIDACION DE NOMBRE DE USUARIO AGREGAR NAME=*username* -->
						<div class="col-sm-3">
							<textarea class="form-control" rows="5" id="observaciones" name="observaciones" style="max-width: 200%; margin: 0px; height: 200px; width: 908px;"></textarea>
						</div>
					</div>
					
					<div class="form-group">

						<!-- PARA COLOR NEGRO DEJAR CON CLASE *control-label* -->
						<label class="col-sm-2 control-label">Consumo actual de la bomba: </label>
						<div class="col-sm-4">

							<!-- PARA COLOR NEGRO DEJAR CON CLASE *form-control* -->
							<input id="consumoActual" name="consumoActual" type="text" class="form-control"
								placeholder="0.0" data-toggle="tooltip"
								data-placement="bottom" title="Tooltip para el consumo actual de la bomba" readonly>
						</div>
						
						<div class="col-sm-5">
							<button id = "btnCalcular" type="button" class="btn btn-warning btn-label-left">
								<span><i class="fa fa-plus-square"></i></span> Calcular consumo
							</button>
						</div>
					</div>
					
					<div class="clearfix"></div>
					
					<div class="form-group">
					<!-- Tipos de botones para enviar -->
						<div class="col-sm-offset-2 col-sm-3">
							<button id = "btnEnviar" type="submit" class="btn btn-primary btn-label-left">
								<span><i class="fa fa-save"></i></span> Guardar consumo
							</button>
						</div>
						
						<div class="col-sm-4">
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

<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name text-center">
					<i class="fa fa-th"></i> <span>Lista de consumos de la bomba</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar2" class="collapse-link" onclick="validar(colap2);"> <i class="fa fa-chevron-up"></i>
					</a> <a id="expandir2" class="expand-link" onclick="validar(expand2);"> <i class="fa fa-expand"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding table-responsive">
				<table class="table table-bordered table-striped table-hover table-heading table-datatable"
					id="tbl_consumoB" style="width:100%;">
					<thead>
						<tr>
							<th>Consumo actual</th>
							<th>Fecha de registro</th>
							<th>Lectura actual</th>
							<th>Observaciones</th>
							<th></th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>

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

<script type="text/javascript">
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


	function DemoTimePicker(){
		$('#fecha').timepicker({setDate: new Date()});
	}
// Run Select2 plugin on elements

var verResultado = function(r) {
	if(r == "BIEN"){
		mostrarMensaje("#dialogBomb", "CORRECTO", 
				"¡Se realizó la operación correctamente, todo bien!", "#d7f9ec", "btn-info");
		limpiar_texto();
		$('#tbl_consumoB').DataTable().ajax.reload();
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
}

	function guardar(){
		$("#formConsB").on("submit", function(e) { 
			e.preventDefault();
			var frm = $(this).serialize();
			console.log(frm);
			if($("#lecturaActual").val() !="" && $("#fecha").val() != "" && $("#consumoActual").val() != ""){
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
	  					if (colap2.valor ==true){}else{
	  						validarColap(colap2, "#colapsar_desplegar2");
	  					}
						verResultado(info);
				});
			}
		});
	}

	function abrirDialogo() {
		OpenModalBox(
				"<div><h3>Borrar Categoría de ingresos y egresos</h3></div>",
				"<p Style='text-align: center;'>¿Esta seguro que desea eliminar este registro?</p>",
				"<div Style='text-align: center; margin-bottom: -10px;'>"+
				"<button type='button' id='eliminar_consumoB' class='btn btn-primary'>Eliminar </button>"
				+ "<button type='button' class='btn btn-secondary' Style='margin-left: 10px;' onclick='CloseModalBox()'> Cancelar</button>"
				+ "</div>");
		eliminar();
	}
	
	var eliminar = function() {
		$("#eliminar_consumoB").on("click", function() {
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
			CloseModalBox();
		});
	}
	
	var agregar_nuevo_consumoB = function() {
		limpiar_texto();
		validarExpand(expand1, "#expandir1");
		if(colap1.valor==false)
			validarColap(colap1, "#colapsar_desplegar1");
		validarColap(colap2, "#colapsar_desplegar2");
		if(expand2.valor == true)
			validarExpand(expand2, "#expandir2");
	}
	
	
	var limpiar_texto = function() {//limpiar texto del formulario
		$("#opcion").val("guardar");
		$("#lecturaActual").val("");
		$("#fecha").val("");
		$("#observaciones").val("");
		$("#consumoActual").val("");
		$("#bombaID").val("");
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

function listarT() {
	console.log("listar bomba");
	var tablaConsumoB = $('#tbl_consumoB').DataTable( {
		responsive: true,
		'destroy': true,
		'bProcessing': true,
		'bServerSide': true,	
		"ajax": {
			"method":"GET",
			"url":"./SL_Consumo_bomba",
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
            { "data": "consumoActual" },
            { "data": null,
                render: function ( data, type, row ) {
                	var fechaS = data.fechaLecturaActual;
                	var f;
                	if(fechaS.slice(0,3) == "ene"){
                		if(fechaS.slice(5,6)!=","){
                			f = new Date(fechaS.slice(8,12), 0, fechaS.slice(4,6));
                		}else{
                			f = new Date(fechaS.slice(7,11), 0, fechaS.slice(3,5));
                		}
                	}else{
                		f = new Date(data.fechaLecturaActual);
                	}
                	var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
                	return fecha;
                }},
            { "data": "lecturaActual" },
            { "data": "observaciones" },
            {"defaultContent":"<button type='button' id='editarConsumoB' class='editarConsumoB btn btn-primary' data-toggle='tooltip' "+
				"data-placement='top' title='Editar consumo_bomba'>"+
				"<i class='fa fa-pencil-square-o'></i> </button>  "+
				"<button type='button' id='eliminar_consumoB' class='eliminar_consumoB btn btn-danger' data-toggle='tooltip' "+
				"data-placement='top' title='Eliminar consumo_bomba'>"+
				"<i class='fa fa-trash-o'></i> </button>"}
            ],
            "dom":"<rt><'row'<'form-inline' <'col-sm-12 text-center'B>>>"
				 +"<'row' <'form-inline' <'col-sm-6'l><'col-sm-6'f>>>"
				 +"<rt>"
				 +"<'row'<'form-inline'"
				 +"<'col-sm-6 col-md-6 col-lg-6'i><'col-sm-6 col-md-6 col-lg-6'p>>>",
            "buttons":[{
				"text": "<i class='fa fa-user-plus'></i>",
				"titleAttr": "Agregar consumo_bomba",
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
	obtener_id_eliminar('#tbl_consumoB tbody',tablaConsumoB);
}

var obtener_id_eliminar = function(tbody, table) {
	console.log("eliminar");
	$(tbody).on("click", "button.eliminar_consumoB", function() {
		var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
		var bomba_ID;
		table.rows().every(function(index, loop, rowloop) {
			console.log("indices: "+ index +" : "+datos);
			if(index == datos){
				bomba_ID = table.row(index).data().bomba_ID;
				$("#frmEliminarConsumoB #bombaID").val(bomba_ID);
			}
		});
		//solo se obtiene el id que es oculto
		abrirDialogo();
	});
}

var obtener_datos_editar = function(tbody, table) {
	console.log("modificar");
	$(tbody).on("click", "button.editarConsumoB", function() {
		var datos = table.row($(this).parents("tr")).index();
		var consumoActual, lecturaActual, fecha, observaciones, bombID;
		table.rows().every(function(index, loop, rowloop) {
			console.log("indices: "+ index +" : "+datos);
			if(index == datos){
				
				bombID = table.row(index).data().bomba_ID;
				consumoActual = table.row(index).data().consumoActual;
				lecturaActual = table.row(index).data().lecturaActual;
				var fechaS = table.row(index).data().fechaLecturaActual;
            	var f;
            	console.log(fechaS);
            	if(fechaS.slice(0,3) == "ene"){
            		if(fechaS.slice(5,6)!=","){
            			f = new Date(fechaS.slice(8,12), 0, fechaS.slice(4,6));
            		}else{
            			f = new Date(fechaS.slice(7,11), 0, fechaS.slice(3,5));
            		}
            	}else{
            		f = new Date(data.fechaLecturaActual);
            	}
            	var fecha2 = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
				fecha = fecha2;
				observaciones = table.row(index).data().observaciones;
				$("#lecturaActual").val(lecturaActual);
				$("#bombaID").val(bombID);
				console.log(fecha);
				$("#fecha").val(fecha);
				$("#consumoActual").val(consumoActual);
				$("#observaciones").val(observaciones);
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

function AllTables() {
	//cargar PDF Y EXCEL
	$.getScript('plugins/datatables/nuevo/jszip.min.js', function(){
		$.getScript('plugins/datatables/nuevo/pdfmake.min.js',function(){
			$.getScript('plugins/datatables/nuevo/vfs_fonts.js',function(){
				console.log("PDF Y EXCEL cargado");
				listarT();
			});
		});
	});
}
	
	
	$(document).ready(function() {
		LoadTimePickerScript(AllTimePickers);
		LoadDataTablesScripts2(AllTables);
		validarColap(colap1, "#colapsar_desplegar1");
		
		
		$('#fecha').datepicker({
			setDate : new Date(),
			dateFormat: 'dd/mm/yy',
			onSelect: function(dateText, inst) {
				$("#fecha").val(dateText.toString());
			}
		});
		$('.form-control').tooltip();
		// Load example of form validation
		LoadBootstrapValidatorScript(formValidBomba);
		
		$("#btnCalcular").click(function(){
			var bombaID = $("#formConsB #bombaID").val();
			var lecturaActual = $("#lecturaActual").val();
			var opcion = $("#formConsB #opcion").val();
			$.ajax({
				method: "post",
				url: "SL_calcular_ConsumoBomba",
				data: {"bombaID": bombaID, "opcion": opcion, "lecturaActual" :lecturaActual},
				success: function(data)
				{
					var consumo = parseFloat(data);
					$("#consumoActual").val(consumo);
				}
			});
		});
		// Add drag-n-drop feature to boxes
		WinMove();
		guardar();
	});
	
	function formValidBomba() {
		$('#formConsB').bootstrapValidator({
			message: 'Este valor no es valido',
			fields: {
				lecturaActual:{
					validators: {
						notEmpty:{
			                message: "Este campo es requerido y no debe estar vacio"
			            },
			            greaterThan: {
							value: 0,
							inclusive: false,
							message: 'El campo debe ser mayor que 0'
						},
						callback: {
           					message: 'la lectura actual debe ser mayor que los otros registros anteriores',
            				callback: function (value, validator, $field) {
            					if($('#formConsB #opcion').val()!="actualizar"){
            						var tabla = $('#tbl_consumoB').DataTable();
                					var filas = tabla.rows();
                					var noigual = true;
                    				filas.every(function(index, loop, rowloop) {
            							if(value < tabla.row(index).data().lecturaActual){
            								noigual = false;
            							}
                    				});
                    				return noigual;
            					}else{
            						var tabla = $('#tbl_consumoB').DataTable();
                					var filas = tabla.rows();
                					var noigual = true;
                    				filas.every(function(index, loop, rowloop) {
            							if(value < tabla.row(index).data().lecturaActual){
            								noigual = false;
            							}
                    				});
                    				return noigual;
								}
            				}
        				}
			        }
				},
				fecha:{
					validators: {
						notEmpty:{
			                message: "Este campo es requerido y no debe estar vacio"
			            }
			        }
				},
				consumoActual:{
					validators: {
						notEmpty:{
			                message: "Este campo es requerido y no debe estar vacio"
			            }
			        }
				}
			}
		});
	}
	

</script>