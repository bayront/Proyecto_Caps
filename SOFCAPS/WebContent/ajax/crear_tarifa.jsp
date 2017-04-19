<%@page language="java"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8" import="Entidades.Usuario, Entidades.Rol, Datos.DT_Vw_rol_opciones, java.sql.ResultSet;"%> 
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
<div id="dialog" class="col-xm-offset-1 col-xm-10">
	<div class="contenido" style="margin-left: 20px;"></div>
</div>
<!--///////////////////////Directorios donde estan los jsp /////////////////////////////// -->
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Área de Secretaría</a></li>
			<li><a href="#">Gestión de tarifas</a></li>
		</ol>
	</div>
</div>

<!--///////////////////////DataTable de las tarifas/////////////////////////////// -->
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-th"></i> <span>Lista de Tarifas</span>
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
							<th>Limite Inferior</th>
							<th>Limite Superior</th>
							<th>Monto</th>
							<th>Categoría</th>
							<th>Acción</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!--///////////////////////Formulario principal de las tarifas/////////////////////////////// -->
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-edit"></i> <span>Formulario de Tarifas</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar1" onclick="validar(colap1);" class="collapse-link"> <i class="fa fa-chevron-up"></i></a> 
					<a id="expandir1" onclick="validar(expand1);" class="expand-link"> <i class="fa fa-expand"></i></a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content">
				<form class="form-horizontal" role="form" id="formTarifa" method="post" action="">
					<input type="hidden" id="opcion" name="opcion" value="guardar">
					<input type="hidden" id="Tarifa_ID" name="Tarifa_ID">
					<div class="form-group">
						<label class="col-sm-4 control-label text-info">limite Inferior</label>
						<div class="col-sm-4">
							<input id="lim_Inf" name="lim_Inf" title="Requerido"
							class="form-control tarifa" autofocus>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label text-info">Limite Superior</label>
						<div class="col-sm-4">
							<input id="lim_Sup" name="lim_Sup" title="No requerido, si no existe lim_Sup no digite nada"
							class="form-control tarifa">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label text-info">monto</label>
						<div class="col-sm-4">
							<input id="monto" name="monto" data-bv-numeric="true" title="Requerido"
							class="form-control tarifa" data-bv-numeric-message="¡Este valor no es un número!">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 text-right control-label">Categoría</label>
						<div class="col-sm-4">
							<select class="populate placeholder tarifa" name="categoria_ID" id="categoria_ID">
								<option value="">Categoria</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 text-right control-label">Unidad de medida</label>
						<div class="col-sm-4">
							<select class="populate placeholder tarifa" name="unidadMedida_ID" id="unidadMedida_ID">
								<option value="">Unidad de medida</option>
							</select>
						</div>
					</div>
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
<!--///////////////////////Formulario y dialogo de eliminción /////////////////////////////// -->
<div>
	<form id="frmEliminarTarifa" action="" method="POST">
		<input type="hidden" id="tarifa_ID" name="tarifa_ID" value="">
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
////////////////////////////Funsión para cargar los plugin de botones de dataTables y listar la tabla////////////////
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
	
	var limpiar_texto = function() {//////////////////////////////limpiar texto del formulario
		$("#opcion").val("guardar");
		$("#lim_Inf").val("");
		$("#lim_Sup").val("");
		$("#monto").val("");
		$("form#formTarifa").data('bootstrapValidator').resetForm();////////////////resetear las validaciones
	}
//////////////////////////funsión que muestra el resultado mediant un dialogo//////////////////////////////////////
	var verResultado = function(r) {//parametro(resultado-String)
		if(r == "BIEN"){
			mostrarMensaje("#dialog", "CORRECTO", 
					"¡Se realizó la acción correctamente, todo bien!", "#d7f9ec", "btn-info");
			limpiar_texto();
			$('#tabla_tarifa').DataTable().ajax.reload();
		}
		if(r == "ERROR"){
			mostrarMensaje("#dialog", "ERROR", 
					"¡Ha ocurrido un error, no se pudo realizar la acción!", "#E97D7D", "btn-danger");
		}
		if(r =="VACIO"){
			mostrarMensaje("#dialog", "VACIO", 
					"¡No se especificó la acción a realizar!", "#FFF8A7", "btn-warning");
		}
	}
///////////////////////////////Ejecutar el metodo DataTable para llenar la Tabla///////////////////////////////////
	function iniciarTabla(){
		console.log("cargar DataTable");
		var tablaTarifa = $('#tabla_tarifa').DataTable( {
			"destroy": true,
			responsive: true,
			'bProcessing': false,
			'bServerSide': false,
			"ajax": {
				"method":"GET",
				"url":"./SL_tarifa",
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
	            { "data": "lim_Inf" },
	            { "data": null,
	                render: function ( data, type, row ) {
	                	if(data.lim_Sup == null){
	                		return "";
	                	}else{
	                		return data.lim_Sup;
	                	}
	                }},
	            { "data": "monto" },
	            { "data": "categoria.nomCategoria" },
	            {"defaultContent":"<button type='button' class='editarTarifa btn btn-primary' title='editar tarifa'>"+
					"<i class='fa fa-pencil-square-o'></i> </button>  "+
					"<button type='button' class='eliminar btn btn-danger' title='eliminar tarifa'>"+
					"<i class='fa fa-trash-o'></i> </button>"}
	            ],
	            "dom":"<rt><'row'<'form-inline' <'col-sm-12 text-center'B>>>"
					 +"<'row' <'form-inline' <'col-sm-6'l><'col-sm-6'f>>>"
					 +"<rt>"
					 +"<'row'<'form-inline'"
					 +"<'col-sm-6 col-md-6 col-lg-6'i><'col-sm-6 col-md-6 col-lg-6'p>>>",
	            "buttons":[{
					"text": "<i class='fa fa-plus-square'></i>",
					"titleAttr": "Agregar tarifa",
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
	
	var agregar_nuevo_tarifa = function() {//////////////agregar nuevo registro limpiando texto y abriendo el form
		limpiar_texto();
		validarExpand(expand1, "#expandir1");
		if(colap1.valor==false)
			validarColap(colap1, "#colapsar_desplegar1");
		validarColap(colap2, "#colapsar_desplegar2");
		if(expand2.valor == true)
			validarExpand(expand2, "#expandir2");
		
		$("#lim_Inf").focus();
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
///////////////////////////funsión que activa el evento click del boton editar del dataTable///////////////////////
	var obtener_datos_editar = function(tbody, table) {//parametro(id_tabla, objeto dataTable)
		$(tbody).on("click", "button.editarTarifa", function() {
			var datos = table.row($(this).parents("tr")).data();	
			$("#lim_Inf").val(datos.lim_Inf);
			$("#lim_Sup").val(datos.lim_Sup);
			$("#monto").val(datos.monto);
			$("#Tarifa_ID").val(datos.tarifa_ID);
			$("#opcion").val("actualizar");
			$("#categoria_ID").val(datos.categoria.categoria_ID);
			$("#categoria_ID").change();
			$("#unidadMedida_ID").val(datos.unidad_de_Medida.unidad_de_Medida_ID);
			$("#unidadMedida_ID").change();
			console.log("categoria: "+datos.categoria.categoria_ID+", monto: "+datos.monto);
			validarExpand(expand1, "#expandir1");
			if(colap1.valor==false)
				validarColap(colap1, "#colapsar_desplegar1");
			validarColap(colap2, "#colapsar_desplegar2");
			if(expand2.valor == true)
				validarExpand(expand2, "#expandir2");
		});
	}
/////////////////////////funsión que activa el evento click para eliminar un registro del dataTable///////////////////
	var obtener_id_eliminar = function(tbody, table) {//parametro(id_tabla, objeto dataTable)
		$(tbody).on("click", "button.eliminar", function() {
			var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
			var tarifa_ID;
			table.rows().every(function(index, loop, rowloop) {
				console.log("indices: "+ index +" : "+datos);
				if(index == datos){
					tarifa_ID = table.row(index).data().tarifa_ID;
					console.log("tarifa_ID: " + tarifa_ID );
					$("#frmEliminarTarifa #tarifa_ID").val(tarifa_ID);
				}
			});
			abrirDialogo();
		});
	}

	function abrirDialogo() {////////////////////abre dialogo con muestra si desae eliminar el registro del contrato
		OpenModalBox(
				"<div><h3>Borrar Tarifa</h3></div>",
				"<p Style='text-align:center; color:salmon; font-size:x-large;'>¿Esta seguro de borrar esta tarifa?</p>",
				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-3 col-md-3'>"+
				"<button type='button' id='eliminar_tarifa' class='btn btn-danger btn-label-left'"+
				" style=' color: #ece1e1;' >"+
				"<span><i class='fa fa-trash-o'></i></span> Borrar tarifa</button>"+
				"<div style='margin-top: 5px;'></div> </div>"+
				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-3 text-center'>"+
				"<button type='button' class='btn btn-default btn-label-left' onclick='CloseModalBox()'>"+
				"<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
		eliminar();
	}
//////////////////////////////////eliminar los datos seteados en el formulario/////////////////////////////////////
	var eliminar = function() {
		$("#eliminar_tarifa").on("click", function() {
			frmElim = $("#frmEliminarTarifa").serialize();
			console.log("datos a eliminar: " + frmElim);
			$.ajax({
				method:"POST",
				url:"SL_tarifa",
				data: frmElim
			}).done(function(info) {
				verResultado(info);
				console.log(info);
			});
			CloseModalBox();
		});
	}
/////////////////////////////////////////////////FUNSIÓN PRINCIPAL/////////////////////////////////////////////////
	$(document).ready(function() {

		//cargar scripts dataTables
		LoadDataTablesScripts2(AllTables);
	
		// Añadir Tooltip para formularios
		$('.form-control').tooltip();
		//add tooltip
		$('[data-toggle="tooltip"]').tooltip();

		//Cargar ejemplo para validaciones
		LoadBootstrapValidatorScript(FormValidators);	
		
		WinMove();
		
		validarColap(colap1, "#colapsar_desplegar1");
		
		//cargar selects
		cargarSelect("#unidadMedida_ID", 3);//traer categorias
		cargarSelect("#categoria_ID", 2)//traer unidadMedidas
	});
///////////////////////funsión que carga un select que recibe el id del select y la opcion de la carga///////////////////////
	function cargarSelect(select, carga) {//parametro (id_select, metodo a cargar-INT)
		var datos;
		$.ajax({
	        type: "GET",
	        url: "./SL_tarifa",
	        dataType: "json",
	        data: {
		        "carga": carga//para decirle al servlet que cargue datos
		    },
	        success: function(response)
	        {
	        	datos = response.aaData;
	        	$(select).empty();
	        	$(response.aaData).each(function(i, v) {
	        		if(v.tipoMedida){
	        			$(select).append('<option value="' + v.unidad_de_Medida_ID + '">' +
	        					v.tipoMedida + '</option>');
	        		}else if(v.nomCategoria){
	        			$(select).append('<option value="' + v.categoria_ID + '">' + v.nomCategoria + '</option>');
	        		}
				});
	        }
		});
	}
////////////////////////funsión que valida el formulario de tarifas///////////////////////////////////////
	function FormValidators() {
		$('#formTarifa').bootstrapValidator({
			message: '¡Este valor no es valido!',
            live: 'enabled',
            excluded: ':disabled',
			fields: {
				lim_Inf:{
					validators: {
						greaterThan: {
							value: 0,
							inclusive: true,
							message: '¡El campo debe ser mayor o igual a 0!'
						},
						notEmpty:{
			                message: "¡Este campo es requerido y no debe estar vacio!"
			            },
			            digits: {
							message: '¡El campo solo puede contener números enteros!'
						}
			        }
				},
				lim_Sup:{
					validators: {
						greaterThan: {
							value: 0,
							inclusive: true,
							message: '¡El campo debe ser mayor o igual a 0!'
						},
			            digits: {
							message: '¡El campo solo puede contener números enteros!'
						}
			        }
				},
				monto:{
					validators:{
						greaterThan: {
							value: 0,
							inclusive: true,
							message: '¡El campo debe ser mayor que 0!'
						},
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
  				method:"post",
  				url:"./SL_tarifa",
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