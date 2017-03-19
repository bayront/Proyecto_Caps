<%@page import="Datos.DTCategoria, java.util.*, Entidades.Categoria, java.sql.ResultSet ;"%>
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
			<li><a href="index.html">Categoria</a></li>
			<li><a href="#">Crear categoria</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-search"></i> <span>Crear Categorias</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar1" onclick="validar(colap1);" class="collapse-link"> <i class="fa fa-chevron-up"></i></a> 
					<a id="expandir1" onclick="validar(expand1);" class="expand-link"> <i class="fa fa-expand"></i></a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content">
				<form class="form-horizontal" role="form" id="formTarifa" method="post" onsubmit="return validarFormulario()">
					<input type="hidden" id="opcion" name="opcion" value="guardar">
<!-- 					<input type="hidden" id="actual" name="actual">  -->
					<input type="hidden" id="categoria_ID" name="categoria_ID">
					<div class="form-group">
						<label class="col-sm-4 control-label text-info">Nombre de la Categoría</label>
						<div class="col-sm-4">
							<input id="nomCategoria" name="nomCategoria" type="text" class="form-control" autofocus>
						</div>
					</div>
<!-- 					<div class="form-group"> -->
<!-- 						<label class="col-sm-4 control-label text-info">Limite -->
<!-- 							Superior</label> -->
<!-- 						<div class="col-sm-4"> -->
<!-- 							<input id="lim_Sup" name="lim_Sup" type="text" class="form-control"> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="form-group"> -->
<!-- 						<label class="col-sm-4 control-label text-info">monto</label> -->
<!-- 						<div class="col-sm-4"> -->
<!-- 							<input id="monto" name="monto" type="text" class="form-control"> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="form-group"> -->
<!-- 						<label class="col-sm-4 text-right control-label">Categoria</label> -->
<!-- 						<div class="col-sm-4"> -->
<!-- 							<select class="populate placeholder" name="categoria_ID" id="categoria_ID"> -->
<!-- 								<option value="">Categoria</option> -->
<!-- 							</select> -->
<!-- 						</div> -->
<!-- 					</div> -->
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
							<button id="btnEnviar" type="submit" class="btn btn-primary btn-label-left btn-lg" >
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
					<i class="fa fa-th"></i> <span>Lista de Categorias</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar2" onclick="validar(colap2);" class="collapse-link"> <i class="fa fa-chevron-up"></i></a> 
					<a id="expandir2" onclick="validar(expand2);" class="expand-link"> <i class="fa fa-expand"></i></a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding table-responsive">
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="tabla_tarifa" style="width:100%;">
					<thead>
						<tr>
							<th>Nombre Categoria</th>
<!-- 							<th>Limite Superior</th> -->
<!-- 							<th>Monto</th> -->
<!-- 							<th>Categoría</th> -->
							<th>Acción</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>

<div>
	<form id="frmEliminarTarifa" action="" method="POST">
		<input type="hidden" id="categoria_ID" name="categoria_ID" value="">
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
var expand1 = new Expand1();//se crean los objetos que representan los botones de cada dialogo
var colap1 =  new Colap1();
var expand2 = new Expand2();
var colap2 =  new Colap2();


// window.onload = function () {
// 	//document.formTarifa.focus();
// 	document.formTarifa.addEventListener('submit', validarFormulario);
// 	console.log("aca estoy");
// 	}
	 
// 	function validarFormulario(evObject) {
// 	evObject.preventDefault();
// 	var todoCorrecto = true;
// 	var formulario = document.formTarifa;
// 	for (var i=0; i<formulario.length; i++) {
// 	                if(formulario[i].type =='text') {
// 	                               if (formulario[i].value == null || formulario[i].value.length == 0 || /^\s*$/.test(formulario[i].value)){
// 	                               alert (formulario[i].name+ ' no puede estar vacío o contener sólo espacios en blanco');
// 	                               todoCorrecto=false;
// 	                               }
// 	                }
// 	                }
// 	if (todoCorrecto ==true) {formulario.submit();}
// 	}


function validarFormulario(){
 
		var nomCategoria = document.getElementById('nomCategoria').value;
		if(nomCategoria == null || nomCategoria.length == 0 || /^\s+$/.test(nomCategoria)){
			alert('ERROR: El campo nombre no debe ir vacío o lleno de solamente espacios en blanco');
			return false;
		}return true;}


// 	var eliminar_Editar_Activo = false;
// 	var tablaTarifa;
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
		$("#nomCategoria").val("");
// 		$("#lim_Sup").val("");
// 		$("#monto").val("");
	}
	
	var verResultado = function(r) {
		if(r == "BIEN"){
			mostrarMensaje("#dialog", "CORRECTO", 
					"¡Se realizó la acción correctamente, todo bien!", "#d7f9ec", "btn-info");
// 			location.reload();
// 			console.log("cambiar esto ahi mismo");
// 			limpiar_texto();
			$('#tabla_tarifa').DataTable().ajax.reload();
// 			$('#tabla_tarifa').DataTable().state.clear();
// 			iniciarTabla();
		}
		if(r == "ERROR"){
			mostrarMensaje("#dialog", "ERROR", 
					"¡Ha ocurrido un error, no se pudó realizar la acción!", "#E97D7D", "btn-danger");
		}
		if(r =="VACIO"){
			mostrarMensaje("#dialog", "VACIO", 
					"¡No se especificó la acción a realizar!", "#FFF8A7", "btn-warning");
		}
	}
	
	function iniciarTabla(){
		console.log("cargar DataTable");
		var tablaTarifa = $('#tabla_tarifa').DataTable( {
			"destroy": true,
			responsive: true,
			'bProcessing': false,
			'bServerSide': false,
			"ajax": {
				"method":"GET",
				"url":"./SL_Categoria",
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
	            $('td', api.table().container()).each(function () {
	               $(this).attr('title', $(this).text());
	            });
	            $('td', api.table().container()).tooltip({container: 'body'});
	            $('td', api.table().container()).find("button").tooltip({container : 'body'});
	            $("a.btn").tooltip({container: 'body'});
	        },
			"columns": [
	            { "data": "nomCategoria" },
// 	            { "data": "categoria_ID" },
// 	            { "data": null,
// 	                render: function ( data, type, row ) {
// 	                	if(data.lim_Sup == null){
// 	                		return "";
// 	                	}else{
// 	                		return data.lim_Sup;
// 	                	}
// 	                }},
// 	            { "data": "monto" },
// 	            { "data": "categoria.nomCategoria" },
	            {"defaultContent":"<button type='button' class='editarTarifa btn btn-primary' data-toggle='tooltip' "+
					"data-placement='bottom' title='Editar Categoría'>"+
					"<i class='fa fa-pencil-square-o'></i> </button>  "+
					"<button type='button' class='eliminar btn btn-danger' title='Eliminar Categoría'>"+
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
					"titleAttr": "Agregar categoría",
					"className": "btn btn-success",
					"action": function() {
						agregar_nuevo_tarifa();
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
		obtener_datos_editar('#tabla_tarifa tbody', tablaTarifa);
		obtener_id_eliminar('#tabla_tarifa tbody', tablaTarifa);
	}
	
	var agregar_nuevo_tarifa = function() {
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
	
	var guardar = function() {
	$("#formTarifa").on("submit", function(e) { //recordar numeral
		e.preventDefault();//detiene el evento
		var frm = $(this).serialize();//parsea los datos del formulario
		console.log(frm);
		$.ajax({//enviar datos por ajax
			method:"post",
			url:"./SL_Categoria",
			data: frm//datos a enviar
			}).done(function(info) {//informacion que el servlet le reenvia al jsp
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
// 		if(eliminar_Editar_Activo == true){
			
// 		}else{
			
// 		}
		$(tbody).on("click", "button.editarTarifa", function() {
// 			var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
// 			var tarifa_ID, lim_Inf, lim_Sup, monto, catID, unidadID;
// 			table.rows().every(function(index, loop, rowloop) {
// 				console.log("indices: "+ index +" : "+datos);
// 				if(index == datos){
// 					tarifa_ID = table.row(index).data().tarifa_ID;
// 					lim_Inf = table.row(index).data().lim_Inf;
// 					lim_Sup = table.row(index).data().lim_Sup;
// 					monto = table.row(index).data().monto;
// 					catID = table.row(index).data().categoria.categoria_ID;
// 					unidadID = table.row(index).data().unidad_de_Medida.unidad_de_Medida_ID;
// 					console.log("unidad: "+unidadID+", cat: "+catID);
// 					console.log("tarifa_ID: " + tarifa_ID);
// 					$("#lim_Inf").val(lim_Inf);
// 					$("#lim_Sup").val(lim_Sup);
// 					$("#monto").val(monto);
// 					$("#Tarifa_ID").val(tarifa_ID);
// 					$("#opcion").val("actualizar");
// 					$("#categoria_ID").val(catID);
// 					$("#categoria_ID").change();
// 					$("#unidadMedida_ID").val(unidadID);
// 					$("#unidadMedida_ID").change();
// 				}
// 			});
			var datos = table.row($(this).parents("tr")).data();
				$("#nomCategoria").val(datos.nomCategoria);
// 				$("#lim_Sup").val(datos.lim_Sup);
// 				$("#monto").val(datos.monto);
				$("#categoria_ID").val(datos.categoria_ID);
				$("#opcion").val("actualizar");
// 				$("#categoria_ID").val(datos.categoria.categoria_ID);
// 				$("#categoria_ID").change();
// 				$("#unidadMedida_ID").val(datos.unidad_de_Medida.unidad_de_Medida_ID);
// 				$("#unidadMedida_ID").change();
				//console.log("categoria: "+datos.categoria.categoria_ID+", monto: "+datos.monto);
// 			$(tbody).off("click", "button.editarTarifa");
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
			var categoria_ID;
			table.rows().every(function(index, loop, rowloop) {
				console.log("indices: "+ index +" : "+datos);
				if(index == datos){
					categoria_ID = table.row(index).data().categoria_ID;
					console.log("categoria_ID: " + categoria_ID );
					$("#frmEliminarTarifa #categoria_ID").val(categoria_ID);
				}
			});
			abrirDialogo();
// 			$(tbody).off("click", "button.eliminar");
		});
	}
	
	function abrirDialogo() {
		OpenModalBox(
				"<div><h3>Borrar Categoria</h3></div>",
				"<p Style='text-align:center; color:salmon; font-size:x-large;'>¿Esta seguro de borrar esta categoria?</p>",
				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-3 col-md-3'>"+
				"<button type='button' id='eliminar_tarifa' class='btn btn-danger btn-label-left'"+
				" style=' color: #ece1e1;' >"+
				"<span><i class='fa fa-trash-o'></i></span> Borrar Categoría</button>"+
				"<div style='margin-top: 5px;'></div> </div>"+
				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-3 text-center'>"+
				"<button type='button' class='btn btn-default btn-label-left' onclick='CloseModalBox()'>"+
				"<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
		eliminar();
	}
	
	var eliminar = function() {
		$("#eliminar_tarifa").on("click", function() {
			frmElim = $("#frmEliminarTarifa").serialize();
			console.log("datos a eliminar: " + frmElim);
			$.ajax({
				method:"POST",
				url:"SL_Categoria",
				data: frmElim
			}).done(function(info) {
				verResultado(info);
				console.log(info);
			});
			CloseModalBox();
		});
	}
	$(document).ready(function() {

		//cargar scripts dataTables
		LoadDataTablesScripts2(AllTables);
	
		// Añadir Tooltip para formularios
		$('.form-control').tooltip();
		//add tooltip
		$('[data-toggle="tooltip"]').tooltip();

		//Cargar ejemplo para validaciones
		LoadBootstrapValidatorScript(formCategoria);	
		
		WinMove();
		
		//Activar evento para guardar
		guardar();
		
		validarColap(colap1, "#colapsar_desplegar1");
		
		//cargar selects
		cargarSelect("#unidadMedida_ID", 3);//traer categorias
		cargarSelect("#categoria_ID", 2)//traer unidadMedidas
	});
	function cargarSelect(select, carga) {//parametro id select
		var datos;
		$.ajax({
	        type: "GET",
	        url: "./SL_Categoria",
	        dataType: "json",
	        data: {
		        "carga": carga//para decirle al servlet que cargue datos
		    },
	        success: function(response)
	        {
	        	datos = response.aaData;
	        	$(select).empty();
	        	$(response.aaData).each(function(i, v) {
	        		$(select).append('<option value="' + v.categoria_ID + '">' + v.nomCategoria + '</option>');
	        		
				});
	        }
		});
	}
	function formCategoria() {
		$('#formTarifa').bootstrapValidator({
			message: 'Este valor no es valido',
			fields: {
				nomCategoria:{
					validators: {
						notEmpty:{
			                message: "Este campo es requerido y no debe estar vacio"
			            },
	 					callback: {
	        					message: 'Este campo no debe ser igual a los otros registros',
	         				callback: function (value, validator, $field) {
	             				var tabla = $("#tabla_tarifa").DataTable();
	         					var filas = tabla.rows();
	         					var noigual = true;
	             				filas.every(function(index, loop, rowloop) {
	     							if(value == tabla.row(index).data().nomCategoria){
	     								noigual = false;
	     							}
	             				});
	             				return noigual;
	         				}
	     				}
			        }
				}
			}
		});
	}
	
	</script>
