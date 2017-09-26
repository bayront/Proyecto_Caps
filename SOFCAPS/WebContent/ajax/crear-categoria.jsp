<%@page import="Entidades.Usuario, Entidades.Rol, Datos.DT_Vw_rol_opciones,Datos.DTCategoria, java.util.*, Entidades.Categoria, java.sql.ResultSet ;"%>
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
			<li><a href="#">Área de Secretaría</a></li>
			<li><a href="#">Gestión de categorías</a></li>
		</ol>
	</div>
</div>
<!--///////////////////////DataTable de las categorías/////////////////////////////// -->
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-th"></i> <span>Lista de Categorías</span>
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
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="tabla_categoria" style="width:100%;">
					<thead>
						<tr>
							<th>Nombre de la categoría</th>
							<th>Descripción</th>
							<th>Acción</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!--///////////////////////Formulario principal de las categorías/////////////////////////////// -->
<div class="row" id="formularioCategoria">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-edit"></i> <span>Formulario de Categorías</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar1" onclick="validar(colap1);" class="collapse-link"> 
						<i class="fa fa-chevron-up"></i></a> 
					<a id="expandir1" class="expand-link" onclick="validar(expand1);">
						<i class="fa fa-expand"></i></a>
					<a class="cerrar_formulario_categoria" onclick="cancelar();"> 
						<i class="fa fa-times"></i></a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content">
				<form class="form-horizontal" role="form" id="formTarifa" method="post" >
					<input type="hidden" id="opcion" name="opcion" value="guardar">
					<input type="hidden" id="categoria_ID" name="categoria_ID">
					<div class="form-group">
						<label class="col-sm-4 control-label text-info">Nombre de la Categoría</label>
						<div class="col-sm-4">
							<input id="nomCategoria" name="nomCategoria" type="text" 
							class="form-control" autofocus title="Requerido">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label text-info">Descripción</label>
						<div class="col-sm-4">
							<textarea maxlength="150" id="descripcion" name="descripcion" class="form-control" 
							title="No requerido" style="max-width:100%; height:110px;"></textarea>
							<div id="contadorText">150 caracteres permitidos</div>
						</div>
					</div>
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
<!--///////////////////////Formulario y dialogo de eliminción /////////////////////////////// -->
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
var nomCate = "";//variable para ver ver si estoy digitando un registro
var expand1 = new Expand1();//se crean los objetos que representan los botones de cada dialogo
var colap1 =  new Colap1();
var expand2 = new Expand2();
var colap2 =  new Colap2();
////////////////////////////Funsión para cargar los plugin de botones de dataTables y listar la tabla////////////////
	function AllTables() {
		iniciarTabla();
		LoadSelect2Script(MakeSelect2);
	}
	
	var limpiar_texto = function() {///////////////////////////////limpiar texto del formulario
		$("#opcion").val("guardar");
		$("#nomCategoria").val("");
		$("#descripcion").val("");
		$("form#formTarifa").data('bootstrapValidator').resetForm();////////////////resetear las validaciones
	}
//////////////////////////funsión que muestra el resultado mediant un dialogo///////////////////////////////////
	var verResultado = function(r) {//parametro(resultado-String)
		if(r == "BIEN"){
			mostrarMensaje("#dialog", "CORRECTO", 
					"¡Se realizó la acción correctamente, todo bien!", "#d7f9ec", "btn-info");
			$('#tabla_categoria').DataTable().ajax.reload();
			limpiar_texto();
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
///////////////////////////////Ejecutar el metodo DataTable para llenar la Tabla////////////////////////////////
	function iniciarTabla(){
		console.log("cargar DataTable");
		var tablaCat = $('#tabla_categoria').DataTable( {
			"destroy": true,
			responsive: true,
			'bProcessing': false,
			'bServerSide': false,
			"ajax": {
				"method":"GET",
				"url":"./SL_Categoria",
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
	            { "data": "nomCategoria" , "width": "25%"},
	            { "data": "descripcion" },
	            {"defaultContent":"<button type='button' class='editarCat btn btn-primary' data-toggle='tooltip' "+
					"data-placement='top' title='Editar Categoría'>"+
					"<i class='fa fa-pencil-square-o'></i> </button>  "/*+
					"<button type='button' class='eliminarCat btn btn-danger' title='Eliminar Categoría'>"+
					"<i class='fa fa-trash-o'></i>"+
					"</button>" , "width": "25%"*/}
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
						agregar_nuevo_categoria();
					}
				},
	            {
	                extend:    'csvHtml5',
	                text:      '<i class="fa fa-file-text-o"></i>',
	                titleAttr: 'csv'
	            }]
		});
		obtener_datos_editar('#tabla_categoria tbody', tablaCat);
		obtener_id_eliminar('#tabla_categoria tbody', tablaCat);
	}
	var agregar_nuevo_categoria = function() {//////////////agregar nuevo registro limpiando texto y abriendo el form
		document.getElementById('formularioCategoria').style.display = 'block';
		//$("#expandir1").prop('disabled', true);
		limpiar_texto();
		validarExpand(expand1, "#expandir1");
		if(colap1.valor==false)
			validarColap(colap1, "#colapsar_desplegar1");
		validarColap(colap2, "#colapsar_desplegar2");
		if(expand2.valor == true)
			validarExpand(expand2, "#expandir2");
		
		$("#nomCategoria").focus();
	}
	
	var cancelar = function() {////////////////cancela la acción limpiando el texto y colapsando el formulario
		limpiar_texto();
		document.getElementById('formularioCategoria').style.display = 'none';
		if(expand1.valor == true)
			validarExpand(expand1, "#expandir1");
		
		if(expand2.valor == true)
			validarExpand(expand2, "#expandir2");
		
		validarColap(colap1, "#colapsar_desplegar1");
		if (colap2.valor ==true){}else{
			validarColap(colap2, "#colapsar_desplegar2");
		}
	}
///////////////////////////funsión que activa el evento click del boton editar del dataTable////////////////////
	var obtener_datos_editar = function(tbody, table) {//parametro(id_tabla, objeto dataTable)
		$(tbody).on("click", "button.editarCat", function() {
			var datos = table.row($(this).parents("tr")).data();
				$("#nomCategoria").val(datos.nomCategoria);
				nomCate = datos.nomCategoria;
				$("#descripcion").val(datos.descripcion);
				$("#categoria_ID").val(datos.categoria_ID);
				$("#opcion").val("actualizar");
				document.getElementById('formularioCategoria').style.display = 'block';
				validarExpand(expand1, "#expandir1");
				if(colap1.valor==false)
					validarColap(colap1, "#colapsar_desplegar1");
				validarColap(colap2, "#colapsar_desplegar2");
				if(expand2.valor == true)
					validarExpand(expand2, "#expandir2");
		});
	}
/////////////////////////funsión que activa el evento click para eliminar un registro del dataTable////////////////
	var obtener_id_eliminar = function(tbody, table) {//parametro(id_tabla, objeto dataTable)
		$(tbody).on("click", "button.eliminarCat", function() {
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
		});
	}
	
	function abrirDialogo() {////////////////////abre dialogo con muestra si desae eliminar el registro del contrato
		OpenModalBox(
				"<div><h3>Borrar Categoría</h3></div>",
				"<p Style='text-align:center; color:salmon; font-size:x-large;'>¿Esta seguro de borrar esta categoría?</p>",
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
//////////////////////////////////eliminar los datos seteados en el formulario/////////////////////////////////////
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
/////////////////////////////////////////////////FUNSIÓN PRINCIPAL/////////////////////////////////////////////////
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
		
		$('#descripcion').keyup(function() {//contador para el máximo de caracteres permitidos en la descripción
	        var chars = $(this).val().length;
	        var diff = 150 - chars;
	        $('#contadorText').html(diff+" caracteres permitidos");   
	    });
	});
////////////////////////funsión que valida el formulario de categorías///////////////////////////////////////
	function formCategoria() {
		$('#formTarifa').bootstrapValidator({
			message: '¡Este valor no es válido!',
			fields: {
				nomCategoria:{
					validators: {
						stringLength: {
							max: 20,
							message: '¡Este campo solo permite 20 caracteres!'
						},
						callback: {
	        				message: '¡Este campo no debe ser igual a los otros registros!',
	         				callback: function (value, validator, $field) {
	         					if(nomCate == value){
	         						return true;
	         					}
	         					var tabla = $("#tabla_categoria").DataTable();
	         					var filas = tabla.rows();
	         					var noigual = true;
	             				filas.every(function(index, loop, rowloop) {
	     							if(value == tabla.row(index).data().nomCategoria){
	     								noigual = false;
	     							}
	             				});
	             				return noigual;
	         				}
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
	
	</script>