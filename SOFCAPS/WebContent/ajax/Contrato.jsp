<%@page import="Datos.DTContrato, java.util.*, Entidades.Usuario, Entidades.Rol, Datos.DT_Vw_rol_opciones, Entidades.RegimenPropiedad, Entidades.Sector, Entidades.Categoria, Entidades.Cliente, java.sql.ResultSet ;"%>
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
			<li><a href="#">Gestión de Contratos</a></li>
			<li><a href="#">Contratos</a></li>
		</ol>
	</div>
</div>
<!--///////////////////////DataTable de los contratos/////////////////////////////// -->
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
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
							<th>Nombre del cliente</th>
							<th>Fecha contrato</th>
							<th>Número contrato</th>
							<th>Número de Medidor</th>
							<th>Monto contrato</th>
							<th>Regimen propiedad</th>
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
<!--///////////////////////Formulario principal de contrato /////////////////////////////// -->
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-edit"></i> <span>Formulario de contratos</span>
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
					
					<input type = "hidden" id="nombreCliente" name ="nombreCliente" >
					<div class="form-group has-warning has-feedback">
						<label class="col-sm-5 control-label">Nombre del cliente:</label>
						<div class="col-sm-4">
							<input id = "nombreClienteCompleto" type="text" class="form-control" 
							placeholder="Seleccione el nombre del cliente" name="nombreClienteCompleto"
							data-toggle="tooltip" data-placement="bottom" title="Nombre completo del cliente">
						</div>
						<div class="col-sm-5 col-md-3">
							<button type="button" class="blue" id="abrir_modal">
								<span><i class="fa fa-search"></i></span> Buscar Cliente
							</button>
						</div>
					</div>
					
					<div class="form-group has-warning has-feedback">
						<label class="col-sm-5 control-label">Direccion</label>
						<div class="col-sm-4">
						<input id = "direccionCliente" type="text" class="form-control" 
							placeholder="Escriba la direccion del cliente" name="direccionCliente"
							data-toggle="tooltip" data-placement="bottom" title="Direccion cliente">	
						</div>
					</div>
					
					<div class="form-group has-warning has-feedback">
						<label class="col-sm-5 control-label">Numero de personas</label>
						<div class="col-sm-4">
							<input id= "cantidadPersonas" name="cantidadPersonas" class="form-control" data-placement="top"
								placeholder="Cantidad Personas" data-toggle="tooltip" title="Cantidad de personas">
						</div>	
					</div>
					
					<%
						DTContrato dt = DTContrato.getInstance();
						ArrayList<RegimenPropiedad> listaR = new ArrayList<RegimenPropiedad>();
						listaR = dt.listaRegimenPropiedad();
						
					%>
					<div class="form-group has-warning has-feedback">
						<label class="col-sm-5 control-label">Regimen de propiedad</label>
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
						<label class="col-sm-5 control-label">Sector</label>
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
						<label class="col-sm-5 control-label">Categoría</label>
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
						<label class="col-sm-5 control-label">Número de medidor</label>
						<div class="col-sm-4">
							<input type="text" id= "numMedidor" name="numMedidor" class="form-control" placeholder="Numero de medidor"
							data-toggle="tooltip" data-placement="top"
							title="Número del medidor único">
						</div>
					</div>
					<div class="form-group has-success has-feedback">
						<label class="col-sm-5 control-label">Monto contrato</label>
						<div class="col-sm-4">
							<input id= "montoContrato" name="montoContrato" class="form-control" 
							placeholder="Monto contrato" data-toggle="tooltip" data-placement="top" data-bv-numeric="true"
							title="Cantidad a pagar del cliente por el contrato" data-bv-numeric-message="¡Este valor no es un número!">
						</div>
					</div>
					<div class="form-group has-success has-feedback">
						<label for="cuotas" class="col-sm-5 control-label">Cuotas</label>
						<div class="col-sm-4">
							<input id= "cuotas" name="cuotas" class="form-control" data-placement="top"
								placeholder="Numero de cuotas" data-toggle="tooltip" title="Número de cuotas">
						</div>
					</div>
					
					<div class="form-group">
						<div class="col-sm-offset-3 col-sm-3 text-center">
							<button type="submit" class="btn btn-primary btn-label-left btn-lg" 
							id="guardar" style="margin-left: 30px;">
								<span><i class="fa fa-save"></i></span> Guardar
							</button>
						</div>
						<div class="col-sm-3 text-center">
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
<!--///////////////////////Formulario y dialogo de eliminción /////////////////////////////// -->
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




<!--///////////////////////Formulario y dialogo de eliminción /////////////////////////////// -->
<div>
	<form id="frmImprimirContrato" action="" method="GET">
		<input type="hidden" id="numContrato" name="numContrato" value="">
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




<script type="text/javascript">
var numMed = "";////////////////////variable para saber si estoy editando un registro
var expand1 = new Expand1();/////////////se crean los objetos que representan los botones de cada dialogo
var colap1 = new Colap1();
var expand2 = new Expand2();
var colap2 = new Colap2();
////////////////////////////////////Correr plugin SELECT2 sobre los selects mencionados//////////////////////////////
function DemoSelect2(){
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
				LoadSelect2Script(MakeSelect2);
			});
		});
	});
}


function abrirDialogoC() {////////////////////abre dialogo con muestra si desae eliminar el registro del contrato
	OpenModalBox(
			"<div><h3>Imprimir Contrato</h3></div>",
			"<p Style='text-align:center; color:blue; font-size:x-large;'>¿Esta seguro que desea imprimir este contrato?</p>",
			"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-3 col-md-3'>"+
			"<button type='button' id='imprimir_contrato' class='btn btn-primary btn-label-left'"+
			" style=' color: #ece1e1;' >"+
			"<span><i class='fa fa-print'></i></span> Imprimir Contrato</button>"+
			"<div style='margin-top: 5px;'></div> </div>"+
			"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-3 text-center'>"+
			"<button type='button' class='btn btn-default btn-label-left' onclick='CloseModalBox()'>"+
			"<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
	imprimir();
}

var imprimir = function() {
	$("#imprimir_contrato").on("click", function() {
		var numContrato = "";
		numContrato = $('#frmImprimirContrato #numContrato').val();
		console.log(numContrato);
		window.open("SL_ContratoReporte?numContrato="+numContrato + "&opcion=imprimir",'_blank');
		console.log("el numContrato del jsp"+"  "+numContrato);
		CloseModalBox();
	});
}

/////////////////////////activar evento del boton eliminar que esta en la fila seleccionada del dataTable///////////
var obtener_id_imprimir = function(tbody, table) {//parametros(id_tabla, objeto dataTable)
	$(tbody).on("click","button.imprimir",function() {
		var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
		table.rows().every(function(index, loop, rowloop) {
			if (index == datos) {
				var numContrato = $("#frmImprimirContrato #numContrato").val(table.row(index).data().numContrato);
			}
		});
		abrirDialogoC();
	});
}



///////////////////////////////Funsión para setear la fecha del contrato en el input fecha_contrato///////////////////
var obtenerFechaActual = function() {
	var f = new Date();
	console.log(f.getDate() + "/" + (f.getMonth() +1) + "/" + f.getFullYear());
	$("#fechaContrato").val(f.getDate() + "/" + (f.getMonth() +1) + "/" + f.getFullYear());
}

var verResultado = function(r) {//parametro(resultado-String)
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
			"<p Style='text-align:center; color:salmon; font-size:x-large;'>¿Esta seguro que desea eliminar este registro?</p>",
			"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-3 col-md-3'>"+
			"<button type='button' id='eliminar_contrato' class='btn btn-danger btn-label-left'"+
			" style=' color: #ece1e1;' >"+
			"<span><i class='fa fa-trash-o'></i></span> Borrar Contrato</button>"+
			"<div style='margin-top: 5px;'></div> </div>"+
			"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-3 text-center'>"+
			"<button type='button' class='btn btn-default btn-label-left' onclick='CloseModalBox()'>"+
			"<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
	eliminar();
}

var limpiar_texto = function() {/////////////////////////limpiar texto del formulario
	$("#opcion").val("guardar");
	$("#contrato_ID").val("");
	$("#nombreCliente").val("").change();
	$("#nombreClienteCompleto").val("");
	$("#direccionCliente").val("");
	$("#cantidadPersonas").val("");
	$("#numMedidor").val("");
	$("#montoContrato").val("");
	$("#cuotas").val("").change();
	$("#regimenPropiedad").val("").change();
	$("#sector").val("").change();
	$("#categoria").val("").change();
	$("form.formContrato").data('bootstrapValidator').resetForm();////////////////resetear las validaciones
}

var agregar_nuevo_contrato = function() {//////////////agregar nuevo registro limpiando texto y abriendo el form
	limpiar_texto();
	validarExpand(expand1, "#expandir1");
	if (colap1.valor == false)
		validarColap(colap1, "#colapsar_desplegar1");
	validarColap(colap2, "#colapsar_desplegar2");
	if (expand2.valor == true)
		validarExpand(expand2, "#expandir2");
	
	$("#nombreCliente").focus();
}

var cancelar = function() {////////////////cancela la acción limpiando el texto y colapsando el formulario
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
/////////////////////////funsión que activa el evento click para eliminar un registro del dataTable///////////////////
var obtener_id_eliminar = function(tbody, table) {//parametro(id_tabla, objeto dataTable)
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
///////////////////////////funsión que activa el evento click del boton editar del dataTable///////////////////////
var obtener_datos_editar = function(tbody, table) {//parametro(id_tabla, objeto dataTable)
	$(tbody).on("click", "button.editarContrato", function() {
		var datos = table.row($(this).parents("tr")).index();
		var contrato_ID, numMedidor, cuotas, montoContrato, cliente, nombreCliente, regimenPropiedad, sector, categoria, cantidadPersonas, direccionCliente;
		table.rows().every(function(index, loop, rowloop) {
			if(index == datos){
				contrato_ID = table.row(index).data().contrato_ID;
				numMedidor = table.row(index).data().numMedidor;
				cuotas = table.row(index).data().cuotas;
				montoContrato = table.row(index).data().montoContrato;
				cliente = table.row(index).data().cliente.cliente_ID;
				nombreCompleto = table.row(index).data().cliente.nombreCompleto;
				regimenPropiedad = table.row(index).data().regimenPropiedad.regimenPropiedad_ID;
				sector = table.row(index).data().sector.sector_ID;
				categoria = table.row(index).data().categoria.categoria_ID;
				cantidadPersonas = table.row(index).data().cantidadPersonas;
				direccionCliente = table.row(index).data().direccionCliente;
				$("#contrato_ID").val(contrato_ID);
				$("#nombreCliente").val(cliente).change();
				$("#nombreClienteCompleto").val(nombreCompleto);
				$("#numMedidor").val(numMedidor);
				$("#cuotas").val(cuotas);
				$("#montoContrato").val(montoContrato);
				$("#regimenPropiedad").val(regimenPropiedad).change();
				$("#sector").val(sector).change();
				$("#categoria").val(categoria).change();
				$("#cantidadPersonas").val(cantidadPersonas).change();
				$("#direccionCliente").val(direccionCliente).change();
				$("#opcion").val("actualizar");
				numMed = numMedidor;
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
            { "data": "cliente.nombreCompleto"},
            { "data": null,
                render: function ( data, type, row ) {
                	var f = new Date(data.fechaContrato);
        			var fecha = f.getDate()+"/"+(f.getMonth()+1)+"/"+f.getFullYear();
                	return fecha;
                }},
            { "data": "numContrato",  "width": "6%"},
            { "data": "numMedidor" },
            { "data": "montoContrato" },
            { "data": "regimenPropiedad.regimenPro" },
            { "data": "sector.nombreSector" },
            { "data": "categoria.nomCategoria",  "width": "6%"},
            {"defaultContent":"<button type='button' class='editarContrato btn btn-primary' data-toggle='tooltip' "+
				"data-placement='top' title='Editar contrato'>"+
				"<i class='fa fa-pencil-square-o'></i> </button>  "+
				
				"<button type='button' class='eliminarContrato btn btn-danger' data-toggle='tooltip' "+
				"data-placement='top' title='Eliminar contrato'>"+
				"<i class='fa fa-trash-o'></i> </button>"+
				
				"<button type='button' class='imprimir btn btn-basic' data-toggle='tooltip' "+
				"data-placement='top' title='Imprimir contrato'>"+
				"<i class='glyphicon glyphicon-print'></i> </button>"
            }
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
	obtener_id_imprimir('#dt_Contrato tbody',tablaContrato);
}
///////////////////funsión que crea un dataTable para traer en cliente mediante un dialogo////////////
function filtrarTabla(){
	console.log("buscarCliente");
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
			        "carga": 1//para decirle al servlet que cargue solo clinte
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
		console.log("cambiar cliente");
		var datos = table.row($(this).parents("tr")).data();
		console.log(datos);
		$("#nombreClienteCompleto").val(datos.nombre1 + " " + datos.nombre2 + " " + datos.apellido1 + " " + datos.apellido2);
		$("#nombreCliente").val(datos.cliente_ID);
		
		$('.formContrato').bootstrapValidator('revalidateField', 'nombreClienteCompleto');
		CloseModalBox();
	});
}
/////////////////////////////////////////////////FUNSIÓN PRINCIPAL/////////////////////////////////////////////////
$(document).ready(function() {
	
	$("#cuotas").spinner();
	$("#cantidadPersonas").spinner();
	
	// Add slider for change test input length
	FormLayoutExampleInputLength($( ".slider-style" ));
	
	// Inicializar datePicker
	$('#input_date').datepicker({setDate: new Date()});
	
	//Añadir tootlip para form-controls
	$('.form-control').tooltip();
	
	LoadSelect2Script(DemoSelect2);
	
	// Cargar plugin de validaciones
	LoadBootstrapValidatorScript(formValidContrato);
	
	// Add drag-n-drop feature to boxes
	WinMove();
	
	obtenerFechaActual();
	
	validarColap(colap1, "#colapsar_desplegar1");
	
	LoadDataTablesScripts2(AllTables);
	
	//MODAL para mostrar una tabla con el cliente
	$('#abrir_modal').on('click',function(e) {
		OpenModalBox(
		"<div><h3>Buscar Cliente</h3></div>",
		"<div class='table-responsive'>"
		+ "<table class='table table-bordered table-striped table-hover table-heading table-datatable'"+
		"id='datatable-filter'>"
		+ "<thead>"
		+ "<tr>"
		+ "<th><label><input type='text' name='Nombre 1'/></label></th>"
		+ "<th><label><input type='text' name='Nombre 2'/></label></th>"
		+ "<th><label><input type='text' name='Apellido 1'/></label></th>"
		+ "<th><label><input type='text' name='Apellido 2'/></label></th>"
		+ "<th><label><input type='text' name='Cédula'/></label></th>"
		+ "<th></th>"
		+ "</tr>"														
		+ "</thead>"														
		+ "<tfoot>"														
		+ "<tr> <th Style='color: #5d96c3;'>Nombre1</th>"
		+ "<th Style='color: #5d96c3;'>Nombre2</th>"
		+ "<th Style='color: #5d96c3;'>Apellido1</th>"
		+ "<th Style='color: #5d96c3;'>Apellido2</th>"
		+"<th Style='color: #5d96c3;'>Número de cédula</th>"
		+"<th></th> </tr>"													
		+ "</tfoot>"														
		+ "</table>"														
		+ "</div>",
		"<div Style='text-align: center; margin-bottom: -5px;'><button type='button' class='btn-default btn-label-left btn-lg' "
		+"onclick='CloseModalBox()'><span><i class='fa fa-reply txt-danger'></i></span>Cancelar</button></div>");
		
		filtrarTabla();		
	});
});
////////////////////////////////////Funsión que valida el formulario de contratos/////////////////////////////////////
function formValidContrato() {
	$('.formContrato').bootstrapValidator({
		message : 'Este valor no es valido',
		fields : {
			nombreClienteCompleto:{
				validators: {
					notEmpty:{
		                message: "¡Este campo es requerido y no debe estar vacio!"
		            },
		            callback:{
		            	message: "¡Seleccione un cliente!",
		            	callback: function (value, validator, $field) {
        					if($(".formContrato #nombreCliente").val()==""){
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
					notEmpty:{
		                message: "¡Este campo es requerido y no debe estar vacio!"
		            }
		        }
			},
			sector:{
				validators: {
					notEmpty:{
		                message: "¡Este campo es requerido y no debe estar vacio!"
		            }
		        }
			},
			categoria:{
				validators: {
					notEmpty:{
		                message: "¡Este campo es requerido y no debe estar vacio!"
		            }
		        }
			},
			numMedidor:{
				validators: {
					callback: {
       					message: '¡Este campo no debe ser igual a los otros registros!',
        				callback: function (value, validator, $field) {
        					if(numMed == value){
								return true;
							}
        					var tabla = $('#dt_Contrato').DataTable();
							var filas = tabla.rows();
							var noigual = true;
							filas.every(function(index,loop, rowloop) {
								if (value == tabla.row(index).data().numMedidor) {
										noigual = false;
								}
							});
							return noigual;
        				}
    				},
    				notEmpty:{
		                message: "¡Este campo es requerido y no debe estar vacio!"
		            },
		            stringLength: {
						max: 30,
						message: '¡Este campo solo permite 30 caracteres!'
					}
		        }
			},
			cuotas:{
				validators: {
    				notEmpty:{
		                message: "¡Este campo es requerido y no debe estar vacio!"
		            },
		            digits: {
						message: '¡El campo solo puede contener números enteros!'
					},
		            greaterThan: {
						value: 0,
						inclusive: true,
						message: '¡El campo debe ser mayor que 0!'
					}
		        }
			},
			montoContrato:{
				validators: {
    				notEmpty:{
		                message: "¡Este campo es requerido y no debe estar vacio!"
		            },
		            greaterThan: {
						value: 0,
						inclusive: true,
						message: '¡El campo debe ser mayor o igual que 0!'
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
    });
}

</script>