<%@page import="Datos.DTOtros_Ing_Egreg, java.util.*, Entidades.Otros_Ing_Egreg , java.sql.ResultSet ;"%>
<%@page language="java"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<div id="dialog" class="col-xm-offset-1 col-xm-10">
	<div class="contenido" style="margin-left: 20px;"></div>
</div>
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Finanzas</a></li>
			<li><a href="#">Gestión de Otros Ingresos y Egresos</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-search"></i> <span>Registro de Otros Ingresos y Egresos</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"  id="colapsar_desplegar1" onclick="validar(colap1);" > 
						<i class="fa fa-chevron-up"></i> </a> 
					<a class="expand-link" id="expandir1" onclick="validar(expand1);"> 
						<i class="fa fa-expand"></i></a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content">
				<form class="form-horizontal" role="form" id="formOI" method="post" action="">
					<input type="hidden" id="opcion" name="opcion" value="guardar">
<!-- 					<input type="hidden" id="actual" name="actual">  -->
					<input type="hidden" id="Otros_Ing_Egreg_ID" name="Otros_Ing_Egreg_ID">
					
					<div class="form-group">
						<label class="col-sm-4 control-label text-info">Descripción</label>
						<div class="col-sm-4">
							<input id="descripcion" name="descripcion" type="text" class="form-control" autofocus>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label text-info">monto</label>
						<div class="col-sm-4">
							<input id="monto" name="monto" type="number" class="form-control">
						</div>
					</div>
<!-- 					<div class="form-group"> -->
<!-- 						<label class="col-sm-2 control-label">Fecha: </label> -->
<!-- 						<div class="col-sm-4"> -->
<!-- 							<input id="fecha" name="fecha" type="text" class="form-control" placeholder="0.0" -->
<!-- 								data-toggle="tooltip" data-placement="bottom" -->
<!-- 								title="Tooltip para fecha"> -->
<!-- 						</div> 	 -->
<!-- 					</div> -->
					<div class="form-group">
					<!-- FORMA PARA CREAR PERIODOS DE TIEMPO CON JQUERY UI -->
						<label  class="col-sm-4 control-label text-info">Fecha </label>
						<div class="col-sm-4">
							<input id="fecha" name="fecha" type="text" class="form-control"
								placeholder="fecha de inicio">
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-4 text-right control-label">Categoria</label>
						<div class="col-sm-4">
							<select class="populate placeholder" name="categoria_Ing_Egreg_ID" id="categoria_Ing_Egreg_ID">
								<option value="">Categoria</option>
							</select>
						</div>
					</div>
<!-- 					<div class="form-group"> -->
<!-- 						<label class="col-sm-4 text-right control-label">Unidad de medida</label> -->
<!-- 						<div class="col-sm-4"> -->
<!-- 							<select class="populate placeholder" name="unidadMedida_ID" id="unidadMedida_ID"> -->
<!-- 								<option value="">Unidad de medida</option> -->
<!-- 							</select> -->
<!-- 						</div> -->
<!-- 					</div> -->
					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-3">
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
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding table-responsive">
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="tabla_OI" style="width:100%;">
					<thead>
						<tr>
							<th>Descripción</th>
							
							<th>Monto</th>
							<th>Fecha de registro</th>
							<th>Categoría</th>
							<th>Acción</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>

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
	function AllTables() {
		//cargar PDF Y EXCEL
		$.getScript('plugins/datatables/nuevo/jszip.min.js', function(){
			$.getScript('plugins/datatables/nuevo/pdfmake.min.js',function(){
				$.getScript('plugins/datatables/nuevo/vfs_fonts.js',function(){
					console.log("PDF Y EXCEL cargado");
					iniciarTabla();
				});
			});
		});
		LoadSelect2Script(MakeSelect2);
	}
	
	function MakeSelect2() {
		$('select').select2();
		$('.dataTables_filter').each(
			function() {
				$(this).find('label input[type=text]').attr('placeholder','Buscar');
			});
	}
	
	var limpiar_texto = function() {//limpiar texto del formulario
		$("#opcion").val("guardar");
		$("#descripcion").val("");
		$("#monto").val("");
		$("#fecha").val("");
	}
	

	function DemoTimePicker(){
		$('#fecha').timepicker({setDate: new Date()});
	}
	
	function guardar() {
		$("#formOI").on("submit", function(e) {
			e.preventDefault();//detiene el evento
  			var frm = $(this).serialize();//parsea los datos del formulario
  			console.log(frm);
  			if($("#formOI #monto").val() !="" && $("#formOI #fecha").val() != ""){
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
  			}
		});
	}
	
	var verResultado = function(r) {
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
	            { "data": "descripcion" },
	            { "data": "monto" },
	            { "data": null,
	                render: function ( data, type, row ) {
	                	f = new Date(data.fecha);
	                	var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
	                	return fecha;
	                }},
	            { "data": "categoria_Ing_Egreg.nombreCategoria" },
	            {"defaultContent":"<button type='button' class='editarOI btn btn-primary' data-toggle='tooltip' "+
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
		obtener_datos_editar('#tabla_OI tbody', tablaO);
		obtener_id_eliminar('#tabla_OI tbody', tablaO);
	}
	
	var agregar_nuevo_OI = function() {
		limpiar_texto();
		validarExpand(expand1, "#expandir1");
		if(colap1.valor==false)
			validarColap(colap1, "#colapsar_desplegar1");
		validarColap(colap2, "#colapsar_desplegar2");
		if(expand2.valor == true)
			validarExpand(expand2, "#expandir2");
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
	
	function guardar()
	{
		$("#formOI").on("submit", function(e) { 
			e.preventDefault();
			var frm = $(this).serialize();
			console.log(frm);
			$.ajax({//enviar datos por ajax
				method:"post",
				url:"./SL_Otros_Ing_Egreg",
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
			});
	}
	
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
			validarExpand(expand1, "#expandir1");
			if(colap1.valor==false)
				validarColap(colap1, "#colapsar_desplegar1");
			validarColap(colap2, "#colapsar_desplegar2");
			if(expand2.valor == true)
				validarExpand(expand2, "#expandir2");
		});
		
		
		
	}
	
	var obtener_id_eliminar = function(tbody, table) {
		$(tbody).on("click", "button.eliminar", function() {
			var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
			var Otros_Ing_Egreg_ID;
			table.rows().every(function(index, loop, rowloop) {
				console.log("indices: "+ index +" : "+datos);
				if(index == datos){
					Otros_Ing_Egreg_ID = table.row(index).data().otros_Ing_Egreg_ID;
					console.log("Otros_Ing_Egreg_ID: " + Otros_Ing_Egreg_ID );
					$("#frmEliminarOI #Otros_Ing_Egreg_ID").val(Otros_Ing_Egreg_ID);
				}
			});
			abrirDialogo();
		});
	}
	
	function abrirDialogo() {
		OpenModalBox(
				"<div><h3>Borrar Otros ingresos y egresos</h3></div>",
				"<p Style='text-align:center; color:salmon; font-size:x-large;'>¿Esta seguro de borrar esto?</p>",
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
	
	$(document).ready(function() {
		LoadDataTablesScripts2(AllTables);
		
		$('.form-control').tooltip();
		$('[data-toggle="tooltip"]').tooltip();
		WinMove();
		validarColap(colap1, "#colapsar_desplegar1");
	
		LoadTimePickerScript(AllTimePickers);
		
		LoadBootstrapValidatorScript(FormValidators);	
		//cargar scripts dataTables
		$('#fecha').datepicker({
			setDate : new Date(),
			dateFormat: 'dd/mm/yy',
			onSelect: function(dateText, inst) {
				$("#fecha").val(dateText.toString());
				//$("#fechaLecturaActual").val(dateText.toString());
			}
		});
		cargarSelect("#categoria_Ing_Egreg_ID")//traer unidadMedidas
		guardar();
	});
	
	function cargarSelect(select) {//parametro id select
		var datos;
		$.ajax({
	        type: "GET",
	        url: "./SL_ajax_table_categoriaIE",
	        dataType: "json",
// 	        data: {
// 		        "carga": carga//para decirle al servlet que cargue datos
// 		    },
	        success: function(response)
	        {
	        	datos = response.aaData;
	        	$(select).empty();
	        	$(response.aaData).each(function(i, v) {
	        			$(select).append('<option value="' + v.categoria_Ing_Egreg_ID + '">' + v.nombreCategoria + '</option>');
	        			
	        		
				});
	        }
		});
	}
	
	
	function FormValidators() {
		$('#formOI').bootstrapValidator({
			message: 'Este valor no es valido',
            live: 'enabled',
            excluded: ':disabled',
			fields: {
				monto:{
					validators:{
						greaterThan: {
							value: 0,
							inclusive: false,
							message: 'El campo debe ser mayor que 0'
						},
	                    notEmpty:{
			                message: "Este campo es requerido y no debe estar vacio"
			            }
					}
				},
				fecha:{
					validators:{
	                    notEmpty:{
			                message: "Este campo es requerido y no debe estar vacio"
			            }
					}
				}
			}
		});
	}
</script>