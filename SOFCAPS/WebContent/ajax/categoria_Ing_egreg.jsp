<%@page import="Entidades.Usuario, Entidades.Rol, Datos.DT_Vw_rol_opciones, Datos.DT_categoria_Ing_Engre, java.util.*, Entidades.TipoCategoria, java.sql.ResultSet ;"%>
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
<div id="dialogCat" class= "col-xm-offset-1 col-xm-10">
	<div class="contenido" style="margin-left: 20px;"></div>
</div>  
<!--///////////////////////Directorios donde estan los jsp /////////////////////////////// -->
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.jsp">Inicio</a></li>
			<li><a href="#">Finanzas</a></li>
			<li><a href="#">Categorías de ingresos y egresos</a></li>
		</ol>
	</div>
</div>
<!--///////////////////////DataTable de las categorias de ingresos y egresos/////////////////////////////// -->
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-th"></i> <span>Lista de Categorías de ingresos y egresos</span>
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
					id="tbl_CategoriaIE" style="width:100%;">
					<thead>
						<tr>
							<th>Nombre de la Categoría</th>
							<th>Tipo de categoría</th>
							<th></th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!--///////////////////////Formulario principal de las categorias de ingresos y egresos/////////////////////////////// -->
<div class="row" id="formularioCategoriaIE">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-edit"></i> <span>Gestión de categorías</span>
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
				<form class="form-horizontal formCatIE" role="form" id="defaultForm" method="post" action="">
					<input type = "hidden" id="catIE_ID" name ="catIE_ID" >
					<input type = "hidden" id="opcion" name ="opcion" value ="guardar">
					<div class="form-group">
						<label class="col-sm-4 control-label">Nombre de la categoría:</label>
						<div class="col-sm-4">
							<input  id= "nombreCategoria" name="nombreCategoria" type="text" class="form-control"
								placeholder="" data-toggle="tooltip" data-placement="top" title="digite la categoría de ingreso o egreso">
						</div>
					</div>
					<%
						DT_categoria_Ing_Engre dt = DT_categoria_Ing_Engre.getInstance();
						ArrayList<TipoCategoria> lista = new ArrayList<TipoCategoria>();
						lista = dt.listaCategoriaIE();
					
						ResultSet rs = dt.cargarDatosTabla();	
					%>
					<div class="form-group">
						<label class="col-sm-4 control-label">Tipo de categoría:</label>
						<div class="col-sm-4">
							<select class="populate placeholder" name="tipoCategoria" id="tipoCategoria">
								<option value="">-- Seleccione --</option>
								<%
									for(int i = 0; i < lista.size(); i++){
								%>
										<option value="<%=lista.get(i).getTipoCategoria_ID() %>"> <%=lista.get(i).getDescripcion() %></option>
								<%
									}
								%>
							</select>
						</div>
					</div>
					
					<div class="clearfix"></div>
					
					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-3">
							<button type="submit" class="btn btn-primary btn-label-left">
								<span><i class="fa fa-download"></i></span> Guardar
							</button>
						</div>
						<div class="col-sm-4">
							<button type="button" class="btn btn-default btn-label-left" onclick= "cancelar();">
								<span><i class="fa fa-clock-o txt-danger"></i></span> Cancelar
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
	<form id="frmEliminarCategoria" action="" method="POST">
		<input type="hidden" id="catIE_ID" name="catIE_ID" value="">
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
var nombreCatValid = "";///////////variable para validar si el usuario esta editando un registro 
var expand1 = new Expand1();////////////se crean los objetos que representan los botones de cada dialogo
var colap1 =  new Colap1();
var expand2 = new Expand2();
var colap2 =  new Colap2();
//////////////////// correr Select2 plugin en los elementos select////////////////////////////////////
function DemoSelect2() {
	$('#tipoCategoria').select2();
}
////////////////////////////////////////funsión que muestra en patalla el mensaje de la opreación///////////////////
var verResultado = function(r) {
	if(r == "BIEN"){
		mostrarMensaje("#dialogCat", "CORRECTO", 
				"¡Se realizó la operación correctamente, todo bien!", "#d7f9ec", "btn-info");
 		limpiar_texto();
		$('#tbl_CategoriaIE').DataTable().ajax.reload();
	}
	if(r == "ERROR"){
		mostrarMensaje("#dialogCat", "ERROR", 
				"¡Ha ocurrido un error, no se pudo realizar la operación!", "#E97D7D", "btn-danger");
	}
	if(r =="VACIO"){
		mostrarMensaje("#dialogCat", "VACIO", 
				"¡No se especificó la opreración a realizar!", "#FFF8A7", "btn-warning");
	}
}
////////////////////////////funsión que abre el dialogo para eliminar un registro///////////////////////////////
	function abrirDialogo() {
		OpenModalBox(
				"<div><h3>Borrar Categoría de ingresos y egresos</h3></div>",
				"<p Style='text-align:center; color:salmon; font-size:x-large;'>¿Esta seguro que desea eliminar este registro?</p>",
				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-2 col-md-3'>"+
				"<button style='margin-left:-10px; color:#ece1e1;' type='button' id='eliminar_categoria' "+
				"class='btn btn-danger btn-label-left'>"+
				"<span style='margin-right:-6px;'><i class='fa fa-trash-o'></i></span>Eliminar registro</button>"+
				"<div style='margin-top: 5px;'></div> </div>"+
				"<div class='col-sm-12 col-md-offset-1 col-md-4 text-center' Style='margin-bottom: -10px;'>"+
				"<button type='button' class='btn btn-default btn-label-left' Style='margin-left:10px;' onclick='CloseModalBox()'>"+
				"<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
		eliminar();
	}
///////////////////////////////////////funsión que activa el evento click del boton eliminar////////////////////////
	var eliminar = function() {
		$("#eliminar_categoria").on("click", function() {
			frmElim = $("#frmEliminarCategoria").serialize();
			console.log("datos a eliminar: " + frmElim);
			$.ajax({
				method:"POST",
				url:"SL_ajax_table_categoriaIE",
				data: frmElim
			}).done(function(info) {
				 	verResultado(info);
			});
			CloseModalBox();
		});
	}

	var agregar_nuevo_categoria = function() {
		document.getElementById('formularioCategoriaIE').style.display = 'block';
		//$("#expandir1").prop('disabled', true);
		limpiar_texto();
		validarExpand(expand1, "#expandir1");
		if(colap1.valor==false)
			validarColap(colap1, "#colapsar_desplegar1");
		validarColap(colap2, "#colapsar_desplegar2");
		if(expand2.valor == true)
			validarExpand(expand2, "#expandir2");
		
		$("#nombreCategoria").focus();
// 		table.search('').draw();
	}
	
	
	var limpiar_texto = function() {//limpiar texto del formulario
		$("#opcion").val("guardar");
		$("#catIE_ID").val("");
		$("#nombreCategoria").val("");
		$("#tipoCategoria").val("");
		$("#tipoCategoria").change();
		$("#defaultForm").data('bootstrapValidator').resetForm();////////////////resetear las validaciones
	}
	
	var cancelar = function() {
		limpiar_texto();
		document.getElementById('formularioCategoriaIE').style.display = 'none';
		if(expand1.valor == true)
			validarExpand(expand1, "#expandir1");
		
		if(expand2.valor == true)
			validarExpand(expand2, "#expandir2");
		
		validarColap(colap1, "#colapsar_desplegar1");
		if (colap2.valor ==true){}else{
			validarColap(colap2, "#colapsar_desplegar2");
		}
	}
//////////////////////////////funsión que lista el dataTaable con los registros de la base de datos con ajax/////////////////
function listarT() {
	var tablaCatIE = $('#tbl_CategoriaIE').DataTable( {
		responsive: true,
		"destroy": true,
		'bProcessing': false,
		'bServerSide': false,
		ajax: {
			"method":"GET",
			"url":"./SL_ajax_table_categoriaIE",
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
            { "data": "nombreCategoria" },
            { "data": "tipoCategoria.descripcion" },
            {"defaultContent":"<button type='button' class='editarCategoria btn btn-primary' data-toggle='tooltip' "+
				"data-placement='top' title='Editar categoria de ingreso o egreso'>"+
				"<i class='fa fa-pencil-square-o'></i> </button>  "+
				"<button type='button' class='eliminarCategoria btn btn-danger' data-toggle='tooltip' "+
				"data-placement='top' title='Eliminar categoria de ingreso o egreso'>"+
				"<i class='fa fa-trash-o'></i> </button>"}
            ],
            "dom":"<rt><'row'<'form-inline' <'col-sm-12 text-center'B>>>"
				 +"<'row' <'form-inline' <'col-sm-6'l><'col-sm-6'f>>>"
				 +"<rt>"
				 +"<'row'<'form-inline'"
				 +"<'col-sm-6 col-md-6 col-lg-6'i><'col-sm-6 col-md-6 col-lg-6'p>>>",
            "buttons":[{
				"text": "<i class='fa fa-plus-square'></i>",
				"titleAttr": "Agregar categoria de ingreso o egreso",
				"className": "btn btn-success",
				"action": function() {
					agregar_nuevo_categoria();
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
	tablaCatIE.page.len(0).draw();
	$('#tbl_CategoriaIE_length').each( function() {
		$(this).find('label select').attr('disabled', 'disabled');
	});	
	$('#tbl_CategoriaIE_filter').each( function() {
		$(this).find('label input[type=search]').on( 'keyup change', function () {
	    	if($(this).val() == ""){
	    		tablaCatIE.page.len(0).draw();
	    		$('#tbl_CategoriaIE_length').each( function() {
	    			$(this).find('label select').attr('disabled', 'disabled');
	    		});
	    	}else{
	    		tablaCatIE.page.len(10).draw();
	    		$('#tbl_CategoriaIE_length').each( function() {
	    			$(this).find('label select').removeAttr('disabled');
	    		});
	    	}
	    });	
	});
	obtener_datos_editar("#tbl_CategoriaIE tbody",tablaCatIE);
	obtener_id_eliminar('#tbl_CategoriaIE tbody',tablaCatIE);
}
///////////////////////////funsión que activa el evento click del boton de eliminar de cada boton del dataTable/////////////////////
var obtener_id_eliminar = function(tbody, table) {
	$(tbody).on("click", "button.eliminarCategoria", function() {
		var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
		var cat_ID;
		table.rows().every(function(index, loop, rowloop) {
			if(index == datos){
				cat_ID = table.row(index).data().categoria_Ing_Egreg_ID;
				$("#frmEliminarCategoria #catIE_ID").val(cat_ID);
			}
		});
		//solo se obtiene el id que es oculto
		abrirDialogo();
	});
}
////////////////////////función que activa el evento sobre el boton editar del dataTable/////////////////////////////
var obtener_datos_editar = function(tbody, table) {
	$(tbody).on("click", "button.editarCategoria", function() {
		var datos = table.row($(this).parents("tr")).index();
		var catID, tipoCat_ID, nombreCat;
		table.rows().every(function(index, loop, rowloop) {
			if(index == datos){
				console.log("editar");
				catID = table.row(index).data().categoria_Ing_Egreg_ID;
				tipoCat_ID = table.row(index).data().tipoCategoria.tipoCategoria_ID;
				nombreCat = table.row(index).data().nombreCategoria;
				$("#nombreCategoria").val(nombreCat);
				nombreCatValid = nombreCat;
				$("#catIE_ID").val(catID);
				$("#tipoCategoria").val(tipoCat_ID);
				$("#tipoCategoria").change();
				$("#opcion").val("actualizar");
			}
		});
		document.getElementById('formularioCategoriaIE').style.display = 'block';
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
				LoadSelect2Script(MakeSelect2);
			});
		});
	});
}	
////////////////////////////////////////////MÉTODO PRINCIPAL///////////////////////////////////////////////////////////
	$(document).ready(function() {
		
		LoadDataTablesScripts2(AllTables);
		
		$('.form-control').tooltip();
		LoadSelect2Script(DemoSelect2);
		// Load example of form validation
		LoadBootstrapValidatorScript(formValidCat_Ing_Egreg);
		
		// Add drag-n-drop feature to boxes
		WinMove();
		
	});
//////////////////////////funsión que activa las validaciones del formulario de cat_ing_egreg/////////////////////////////
	function formValidCat_Ing_Egreg() {
		$('#defaultForm').bootstrapValidator({
			message: '¡Este valor no es valido!',
			fields: {
				tipoCategoria:{
					validators: {
						notEmpty:{
			                message: "¡Seleccione el tipo de categoría!"
			            }
			        }
				},
				nombreCategoria:{
					validators: {
						notEmpty:{
			                message: "¡Este campo es requerido y no debe estar vacio!"
			            },
						callback: {
           					message: '¡Este campo no debe ser igual a los otros registros!',
            				callback: function (value, validator, $field) {
            					if(nombreCatValid == value){
            						return true;
            					}
            					
            					var tabla = $('#tbl_CategoriaIE').DataTable();
            					var filas = tabla.rows();
            					var noigual = true;
                				filas.every(function(index, loop, rowloop) {
        							if(value == tabla.row(index).data().nombreCategoria){
        								noigual = false;
        							}
                				});
                				return noigual;
            				}
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
				url:"./SL_ajax_table_categoriaIE",
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
</script>