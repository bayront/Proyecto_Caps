<%@page import="Datos.DTContrato, java.util.*, Entidades.RegimenPropiedad, Entidades.Sector, Entidades.Categoria, Entidades.Cliente, java.sql.ResultSet ;"%>
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
			<li><a href="index.html">Dashboard</a></li>
			<li><a href="#">Forms</a></li>
			<li><a href="#">Forms layouts</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-search"></i> <span>Registrar Contrato</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link" id="colapsar_desplegar1" onclick="validar(colap1);"> 
					<i class="fa fa-chevron-up"></i></a>
					 <a class="expand-link" id="expandir1" onclick="validar(expand1);"> 
					 <i class="fa fa-expand"></i></a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content">
				<h4 class="page-header">Datos</h4>
				<form class="form-horizontal formContrato" role="form">
					<input type="hidden" id="opcion" name="opcion" value="guardar">
					<input type="hidden" id="fechaContrato" name="fechaContrato">
					<input type = "hidden" id="contrato_ID" name ="contrato_ID" >
					<input type = "hidden" id="cliente_ID" name ="cliente_ID" >
					
					<%
						DTContrato dt = DTContrato.getInstance();
						ArrayList<Cliente> listaCl = new ArrayList<Cliente>();
						listaCl = dt.listaCliente();
						
						ResultSet rs = dt.cargarDatos();
						
					%>
						<div class="form-group has-warning has-feedback">
							<label class="col-sm-4 control-label">Seleccione el cliente</label>
								<div class="col-sm-4">
								<select id= "nombreCliente" name="nombreCliente" type = "simple"
									class="populate placeholder">
									<option value="">-- Seleccione --</option>
								<%
									for(int i = 0; i < listaCl.size(); i++){
								%>
										<option value="<%=listaCl.get(i).getCliente_ID() %>"> <%=listaCl.get(i).getNombreCompleto() %></option>
								<%
									}
								%>
								</select>
								</div>
						</div>
					
					<%
						ArrayList<RegimenPropiedad> listaR = new ArrayList<RegimenPropiedad>();
						listaR = dt.listaRegimenPropiedad();
						
					%>
					<div class="form-group has-warning has-feedback">
						<label class="col-sm-4 control-label">Regimen de propiedad</label>
						<div class="col-sm-4">
								<select id= "regimenPropiedad" name="regimenPropiedad" type = "simple"
									class="populate placeholder">
									<option value="">-- Seleccione --</option>
								<%
									for(int i = 0; i < listaR.size(); i++){
								%>
										<option value="<%=listaR.get(i).getRegimenPropiedad_ID() %>"> <%=listaR.get(i).getRegimenPro() %></option>
								<%
									}
								%>
								</select>
						</div>
					</div>
					
					<div class="form-group has-warning has-feedback">
					
						<%
						ArrayList<Sector> listaS = new ArrayList<Sector>();
						listaS = dt.listaSector();						
						%>
						<label class="col-sm-4 control-label">Sector</label>
						<div class="col-sm-4">
								<select id="sector" name="sector" type = "simple"
									class="populate placeholder">
									<option value="">-- Seleccione --</option>
								<%
									for(int i = 0; i < listaS.size(); i++){
								%>
										<option value="<%=listaS.get(i).getSector_ID() %>"> <%=listaS.get(i).getNombreSector() %></option>
								<%
									}
								%>
								</select>
						</div>
					</div>
					
					<%
						ArrayList<Categoria> listaC = new ArrayList<Categoria>();
						listaC = dt.listaCategoria();						
						%>
					<div class="form-group has-warning has-feedback">
						<label class="col-sm-4 control-label">Categoría</label>
						<div class="col-sm-4">
							<select id="categoria" name="categoria" type = "simple"
								class="populate placeholder">
								<option value="">-- Seleccione --</option>
								<%
									for(int i = 0; i < listaC.size(); i++){
										System.out.println("cantidad Cat: "+listaC.size());
								%>
										<option value="<%=listaC.get(i).getCategoria_ID() %>"> <%=listaC.get(i).getNomCategoria() %></option>
								<%
									}
								%>
							</select>
						</div>
					</div>
										
					<div class="form-group has-success has-feedback">
						<label class="col-sm-4 control-label">Número de medidor</label>
						<div class="col-sm-4">
							<input type="text" id= "numMedidor" name="numMedidor" class="form-control" placeholder="Numero de medidor"
							data-toggle="tooltip" data-placement="bottom"
							title="número del medidor único">
						</div>
					</div>
					<div class="form-group has-success has-feedback">
						<label class="col-sm-4 control-label">Monto contrato</label>
						<div class="col-sm-4">
							<input type="number" id= "montoContrato" name="montoContrato" class="form-control" 
							placeholder="Monto contrato" data-toggle="tooltip" data-placement="bottom"
							title="Cantidad a pagar del cliente por el contrato">
						</div>
					</div>
					<div class="form-group has-success has-feedback">
						<label for="cuotas" class="col-sm-4 control-label">Cuotas</label>
						<div class="col-sm-4">
							<input type="number" id= "cuotas" name="cuotas" class="form-control"
								placeholder="Spinner">
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

<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name text-center">
					<i class="fa fa-th"></i> <span>Lista de Contratos</span>
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
					id="dt_Contrato" style="width:100%;">
					<thead>
						<tr>
							<th>Nombre Cliente</th>
							<th>Fecha Contrato</th>
							<th>Número contrato</th>
							<th>Número de Medidor</th>
							<th>Monto Contrato</th>
							<th>Regimen Propiedad</th>
							<th>Sector</th>
							<th>Categoría</th>
							<th></th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>

<div>
	<form id="frmEliminarContrato" action="" method="POST">
		<input type="hidden" id=contrato_ID name="contrato_ID" value="">
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
var expand1 = new Expand1();/////////////se crean los objetos que representan los botones de cada dialogo
var colap1 = new Colap1();
var expand2 = new Expand2();
var colap2 = new Colap2();
////////////////////////////////////Correr plugin SELECT2 sobre los selects mencionados//////////////////////////////
function DemoSelect2(){
	$('#nombreCliente').select2({placeholder: "Seleccione cliente..."});
	$('#regimenPropiedad').select2({placeholder: "Seleccione regimen..."});
	$('#sector').select2({placeholder: "Seleccione sector..."});
	$('#categoria').select2({placeholder: "Seleccione categoria..."});
}
////////////////////////////////Funsión para cargar los plugin de botones de dataTables y listar la tabla////////////////
function AllTables() {
	$.getScript('plugins/datatables/nuevo/jszip.min.js', function(){
		$.getScript('plugins/datatables/nuevo/pdfmake.min.js',function(){
			$.getScript('plugins/datatables/nuevo/vfs_fonts.js',function(){
				console.log("PDF Y EXCEL cargado");
				listar();
			});
		});
	});
}
///////////////////////////////Funsión para setear la fecha del contrato en el input fecha_contrato///////////////////
var obtenerFechaActual = function() {
	var f = new Date();
	console.log(f.getDate() + "/" + (f.getMonth() +1) + "/" + f.getFullYear());
	$("#fechaContrato").val(f.getDate() + "/" + (f.getMonth() +1) + "/" + f.getFullYear());
}

var verResultado = function(r) {
	if(r == "BIEN"){
		mostrarMensaje("#dialog", "CORRECTO",
				"¡Se realizó la operación correctamente, todo bien!","#d7f9ec", "btn-info");
		limpiar_texto();
		$('#dt_Contrato').DataTable().ajax.reload();
	}
	if(r == "ERROR"){
		mostrarMensaje("#dialog", "ERROR",
				"¡Ha ocurrido un error, no se pudo realizar la operación!","#E97D7D", "btn-danger");
	}
	if(r =="VACIO"){
		mostrarMensaje("#dialog", "VACIO",
				"¡No se especificó la operación a realizar!", "#FFF8A7","btn-warning");
	}
}
///////////////////////////////////guardar los datos setados en el formulario///////////////////////////////////////
var guardar = function() {
	$("form").on("submit", function(e) {
		e.preventDefault();//detiene el evento
		var frm = $(this).serialize();//parsea los datos del formulario
		console.log(frm);
		if($(this).find("#montoContrato").val()!="" && $(this).find("#numMedidor").val()!="" 
			&& $(this).find("#cuotas").val() != ""){
			$.ajax({//enviar datos por ajax
				method:"POST",
				url:"./SL_Contrato",
				data: frm//datos a enviar
				}).done(function(info) {//informacion que el servlet le reenvia al jsp
				console.log(info);
				limpiar_texto();
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
		}
	});
}
//////////////////////////////////eliminar los datos seteados en el formulario/////////////////////////////////////
var eliminar = function() {
	$("#eliminar_contrato").on("click", function() {
		frmElim = $("#frmEliminarContrato").serialize();
		console.log("datos a eliminar: " + frmElim);
		$.ajax({
			method:"POST",
			url:"./SL_Contrato",
			data: frmElim
		}).done(function(info) {
			 	limpiar_texto();
			 	verResultado(info);
		});
		CloseModalBox();
	});
}

function abrirDialogo() {////////////////////abre dialogo con muestra si desae eliminar el registro del contrato
	OpenModalBox(
			"<div><h3>Borrar Contrato</h3></div>",
			"<p Style='text-align: center;'>¿Esta seguro que desea eliminar este registro?</p>",
			"<div Style='text-align: center; margin-bottom: -10px;'>"+
			"<button type='button' id='eliminar_contrato' class='btn btn-primary'>Eliminar </button>"
			+ "<button type='button' class='btn btn-secondary' Style='margin-left: 10px;' onclick='CloseModalBox()'> Cancelar</button>"
			+ "</div>");
	eliminar();
}

var limpiar_texto = function() {/////////////////////////limpiar texto del formulario
	$("#opcion").val("guardar");
	$("#contrato_ID").val("");
	$("#nombreCliente").val("").change();
	$("#numMedidor").val("");
	$("#montoContrato").val("");
	$("#cuotas").val("").change();
	$("#regimenPropiedad").val("").change();
	$("#sector").val("").change();
	$("#categoria").val("").change();
}

var agregar_nuevo_contrato = function() {///////////////////agregar nuevo registro limpiando texto y abriendo el form
	limpiar_texto();
	validarExpand(expand1, "#expandir1");
	if (colap1.valor == false)
		validarColap(colap1, "#colapsar_desplegar1");
	validarColap(colap2, "#colapsar_desplegar2");
	if (expand2.valor == true)
		validarExpand(expand2, "#expandir2");
}

var cancelar = function() {/////////////////////cancela la acción limpiando el texto y colapsando el formulario
	limpiar_texto();
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

var obtener_id_eliminar = function(tbody, table) {
	$(tbody).on("click", "button.eliminarContrato", function() {
		var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
		var contrato_ID;
		table.rows().every(function(index, loop, rowloop) {
			console.log("indices: "+ index +" : "+datos);
			if(index == datos){
				contrato_ID = table.row(index).data().contrato_ID;
				$("#frmEliminarContrato #contrato_ID").val(contrato_ID);
			}
		});
		//solo se obtiene el id que es oculto
		abrirDialogo();
	});
}

var obtener_datos_editar = function(tbody, table) {
	$(tbody).on("click", "button.editarContrato", function() {
		var datos = table.row($(this).parents("tr")).index();
		var contrato_ID, numMedidor, cuotas, montoContrato, cliente, regimenPropiedad, sector, categoria;
		table.rows().every(function(index, loop, rowloop) {
			console.log("indices: "+ index +" : "+datos);
			if(index == datos){
				contrato_ID = table.row(index).data().contrato_ID;
				numMedidor = table.row(index).data().numMedidor;
				cuotas = table.row(index).data().cuotas;
				montoContrato = table.row(index).data().montoContrato;
				cliente = table.row(index).data().cliente.cliente_ID;
				regimenPropiedad = table.row(index).data().regimenPropiedad.regimenPropiedad_ID;
				sector = table.row(index).data().sector.sector_ID;
				categoria = table.row(index).data().categoria.categoria_ID;
				$("#contrato_ID").val(contrato_ID);
				$("#nombreCliente").val(cliente).change();
				$("#numMedidor").val(numMedidor);
				$("#cuotas").val(cuotas);
				$("#montoContrato").val(montoContrato);
				$("#regimenPropiedad").val(regimenPropiedad).change();
				$("#sector").val(sector).change();
				$("#categoria").val(categoria).change();
				$("#opcion").val("actualizar");
			}
		});
		validarExpand(expand1, "#expandir1");
		if (colap1.valor == false)
			validarColap(colap1, "#colapsar_desplegar1");
		validarColap(colap2, "#colapsar_desplegar2");
		if (expand2.valor == true)
			validarExpand(expand2, "#expandir2");
	});
}

/////////////////////////////////Ejecutar el metodo DataTable para llenar la Tabla/////////////////////////////////////////
var listar = function() {
	console.log("cargando dataTable");
	var tablaContrato = $('#dt_Contrato').DataTable( {
		responsive: true,
		'destroy': true,
		'bProcessing': false,
		'bServerSide': false,
		ajax: {
			"method":"GET",
			"url":"./SL_Contrato",
			"dataSrc":"aaData"
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
            { "data": "cliente.nombreCompleto"},
            { "data": "fechaContrato" },
            { "data": "numContrato",  "width": "6%"},
            { "data": "numMedidor" },
            { "data": "montoContrato" },
            { "data": "regimenPropiedad.regimenPro" },
            { "data": "sector.nombreSector" },
            { "data": "categoria.nomCategoria",  "width": "6%"},
            {"defaultContent":"<button type='button' class='editarContrato btn btn-primary' data-toggle='tooltip' "+
				"data-placement='bottom' title='Editar contrato'>"+
				"<i class='fa fa-pencil-square-o'></i> </button>  "+
				"<button type='button' class='eliminarContrato btn btn-danger' data-toggle='tooltip' "+
				"data-placement='bottom' title='Eliminar contrato'>"+
				"<i class='fa fa-trash-o'></i> </button>"}
            ],
            "dom":"<rt><'row'<'form-inline' <'col-sm-12 text-center'B>>>"
				 +"<'row' <'form-inline' <'col-sm-6'l><'col-sm-6'f>>>"
				 +"<rt>"
				 +"<'row'<'form-inline'"
				 +"<'col-sm-6 col-md-6 col-lg-6'i><'col-sm-6 col-md-6 col-lg-6'p>>>",
            "buttons":[{
				"text": "<i class='fa fa-user-plus'></i>",
				"titleAttr": "Agregar contrato",
				"className": "btn btn-success",
				"action": function() {
					agregar_nuevo_contrato();
					console.log("boton nuevo contrato");
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
	tablaContrato.columns.adjust().draw();
	obtener_datos_editar("#dt_Contrato tbody",tablaContrato);
	obtener_id_eliminar('#dt_Contrato tbody',tablaContrato);
}
////////////////////////////////////////////FUNSIÓN PRINCIPAL/////////////////////////////////////////////////////////
$(document).ready(function() {
	$("#cuotas").spinner();
	
	// Add slider for change test input length
	FormLayoutExampleInputLength($( ".slider-style" ));
	
	// Initialize datepicker
	$('#input_date').datepicker({setDate: new Date()});
	
	// Add tooltip to form-controls
	$('.form-control').tooltip();
	
	LoadSelect2Script(DemoSelect2);
	
	// Load example of form validation
	LoadBootstrapValidatorScript(formValidContrato);
	
	// Add drag-n-drop feature to boxes
	WinMove();
	obtenerFechaActual();
	
	guardar();//activar evento de guardar
	validarColap(colap1, "#colapsar_desplegar1");
	
	LoadDataTablesScripts2(AllTables);
	
});
////////////////////////////////////Funsión que valida el formulario de contratos/////////////////////////////////////
function formValidContrato() {
	$('.formContrato').bootstrapValidator({
		message : 'Este valor no es valido',
		fields : {
			nombreCliente:{
				validators: {
					callback: {
       					message: 'Seleccione una opción',
        				callback: function (value, validator, $field) {
        					if($('.formContrato #nombreCliente').val()==""){
        						return false;
        					}else{
								return true;
							}
        				}
    				}
		        }
			},
			regimenPropiedad:{
				validators: {
					callback: {
       					message: 'Seleccione una opción',
        				callback: function (value, validator, $field) {
        					if($('.formContrato #regimenPropiedad').val()==""){
        						return false;
        					}else{
								return true;
							}
        				}
    				}
		        }
			},
			sector:{
				validators: {
					callback: {
       					message: 'Seleccione una opción',
        				callback: function (value, validator, $field) {
        					if($('.formContrato #sector').val()==""){
        						return false;
        					}else{
								return true;
							}
        				}
    				}
		        }
			},
			categoria:{
				validators: {
					callback: {
       					message: 'Seleccione una opción',
        				callback: function (value, validator, $field) {
        					if($('.formContrato #categoria').val()==""){
        						return false;
        					}else{
								return true;
							}
        				}
    				}
		        }
			},
			numMedidor:{
				validators: {
					callback: {
       					message: 'este campo no debe ser igual a los otros registros',
        				callback: function (value, validator, $field) {
        					if($('.formContrato #opcion').val()!="actualizar"){
								var tabla = $('#dt_Contrato').DataTable();
								var filas = tabla.rows();
								var noigual = true;
								filas.every(function(index,loop, rowloop) {
									if (value == tabla.row(index).data().numMedidor) {
											noigual = false;
									}
								});
								return noigual;
							}else{
								return true;
							}
        				}
    				},
    				notEmpty:{
		                message: "Este campo es requerido y no debe estar vacio"
		            }
		        }
			},
			cuotas:{
				validators: {
    				notEmpty:{
		                message: "Este campo es requerido y no debe estar vacio"
		            },
		            digits: {
						message: 'El campo solo puede contener números enteros'
					},
		            greaterThan: {
						value: 0,
						inclusive: true,
						message: 'El campo debe ser mayor que 0'
					}
		        }
			},
			montoContrato:{
				validators: {
    				notEmpty:{
		                message: "Este campo es requerido y no debe estar vacio"
		            },
		            greaterThan: {
						value: 0,
						inclusive: true,
						message: 'El campo debe ser mayor que 0'
					}
		        }
			}
		}
	});
}


</script>