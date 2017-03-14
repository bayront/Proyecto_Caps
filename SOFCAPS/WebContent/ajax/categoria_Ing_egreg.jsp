<%@page import="Datos.DT_categoria_Ing_Engre, java.util.*, Entidades.TipoCategoria, java.sql.ResultSet ;"%>
<%@page language="java"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8"%> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.html">Dashboard</a></li>
			<li><a href="#">Consumos</a></li>
			<li><a href="#">Crear Consumo</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-search"></i> <span>Registros de consumos</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link" id="colapsar_desplegar1"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a>
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
								placeholder="" data-toggle="tooltip" data-placement="bottom" title="Tooltip para nombre">
						</div>
					</div>
					
					<%
						DT_categoria_Ing_Engre dt = DT_categoria_Ing_Engre.getInstance();
						ArrayList<TipoCategoria> lista = new ArrayList<TipoCategoria>();
						lista = dt.listaCategoriaIE();
						
						ResultSet rs = dt.cargarDatosTabla();
						
					%>
					<div class="form-group">
						<label class="col-sm-3 control-label">Tipo de categoria:</label>
						<div class="col-sm-5">
							<select class="populate placeholder" name="tipoCategoria"
								id="tipoCategoria">
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

<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name text-center">
					<i class="fa fa-th"></i> <span>Lista de Categorías de ingresos y egresos</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar2" class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a id="expandir2" class="expand-link"> <i class="fa fa-expand"></i>
					</a>
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

// Run Select2 plugin on elements
function DemoSelect2() {
	
	$('#tipoCategoria').select2();
}

var verResultado = function(r) {
	if(r == "BIEN"){
// 		console.log("cambiar esto en verResultado");
// 		alert("Se realizo la operación correctamente");
// 		location.reload();
// 		console.log("cambiar esto ahi mismo");
		
// 		limpiar_texto();
		listarT();
		alert("Se realizo la operación correctamente");
	}
	if(r == "Error"){
		alert("ERROR: No se pudo realizar la operación");
	}
	if(r =="VACIO"){
		alert("VACIO: No se realizo ninguna operación");
	}
}

	function guardar()
	{
		$(".formCatIE").on("submit", function(e) { 
			e.preventDefault();
			var frm = $(this).serialize();
			console.log(frm);
			$.ajax({//enviar datos por ajax
				method:"post",
				url:"./SL_ajax_table_categoriaIE",
				data: frm//datos a enviar
				}).done(function(info) {
				console.log(info);
					limpiar_texto();
					verResultado(info);
// 					colapsar_desplegar($("#colapsar_desplegar2"));
// 					colapsar_desplegar($("#colapsar_desplegar1"));
				});
			});
	}

	function abrirDialogo() {
		OpenModalBox(
				"<div><h3>Borrar Categoría de ingresos y egresos</h3></div>",
				"<p Style='text-align:center; color:salmon; font-size:x-large;'>¿Esta seguro que desea eliminar este registro?</p>",
				"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-2 col-md-3'>"+
				"<button style='margin-left:-10px; color:#ece1e1;' type='button' id='eliminar_categoria' "+
				"class='btn btn-danger btn-label-left'>"+
				"<span style='margin-right:-6px;'><i class='fa fa-trash-o'></i></span>Eliminar catIngEg</button>"+
				"<div style='margin-top: 5px;'></div> </div>"+
				"<div class='col-sm-12 col-md-offset-1 col-md-4 text-center' Style='margin-bottom: -10px;'>"+
				"<button type='button' class='btn btn-default btn-label-left' Style='margin-left:10px;' onclick='CloseModalBox()'>"+
				"<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
		eliminar();
	}
	
	var eliminar = function() {
		$("#eliminar_categoria").on("click", function() {
			frmElim = $("#frmEliminarCategoria").serialize();
			console.log("datos a eliminar: " + frmElim);
			$.ajax({
				method:"POST",
				url:"SL_ajax_table_categoriaIE",
				data: frmElim
			}).done(function(info) {
				 	limpiar_texto();
				 	verResultado(info);
			});
			CloseModalBox();
		});
	}

	var agregar_nuevo_categoria = function() {
		limpiar_texto();
// 		colapsar_desplegar($("#colapsar_desplegar2"));
// 		colapsar_desplegar($("#colapsar_desplegar1"));
	}
	
	
	var limpiar_texto = function() {//limpiar texto del formulario
		$("#opcion").val("guardar");
		$("#catIE_ID").val("");
		$("#nombreCategoria").val("");
	}
	
	var cancelar = function() {
		limpiar_texto();
// 		colapsar_desplegar($("#colapsar_desplegar1"));
// 		colapsar_desplegar($("#colapsar_desplegar2"));
	}

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
    	"bJQueryUI": true,
		"language":idioma_esp,
		"columns": [
            { "data": "nombreCategoria" },
            { "data": "tipoCategoria.descripcion" },
            {"defaultContent":"<button type='button' class='editarCategoria btn btn-primary' data-toggle='tooltip' "+
				"data-placement='bottom' title='Editar'>"+
				"<i class='fa fa-pencil-square-o'></i> </button>  "+
				"<button type='button' class='eliminarCategoria btn btn-danger' data-toggle='tooltip' "+
				"data-placement='bottom' title='Eliminar'>"+
				"<i class='fa fa-trash-o'></i> </button>"}
            ],
            "dom":"<rt><'row'<'form-inline' <'col-sm-12 text-center'B>>>"
				 +"<'row' <'form-inline' <'col-sm-6'l><'col-sm-6'f>>>"
				 +"<rt>"
				 +"<'row'<'form-inline'"
				 +"<'col-sm-6 col-md-6 col-lg-6'i><'col-sm-6 col-md-6 col-lg-6'p>>>",
            "buttons":[{
				"text": "<i class='fa fa-user-plus'></i>",
				"titleAttr": "Agregar usuario",
				"className": "btn btn-success",
				"action": function() {
					agregar_nuevo_categoria();
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
	obtener_datos_editar("#tbl_CategoriaIE tbody",tablaCatIE);
	obtener_id_eliminar('#tbl_CategoriaIE tbody',tablaCatIE);
}
var obtener_id_eliminar = function(tbody, table) {
	$(tbody).on("click", "button.eliminarCategoria", function() {
		var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
		var cat_ID;
		table.rows().every(function(index, loop, rowloop) {
			console.log("indices: "+ index +" : "+datos);
			if(index == datos){
				cat_ID = table.row(index).data().categoria_Ing_Egreg_ID;
				$("#frmEliminarCategoria #catIE_ID").val(cat_ID);
			}
		});
		//solo se obtiene el id que es oculto
		abrirDialogo();
	});
}

var obtener_datos_editar = function(tbody, table) {
	$(tbody).on("click", "button.editarCategoria", function() {
		var datos = table.row($(this).parents("tr")).index();
		var catID, tipoCat_ID, nombreCat;
		table.rows().every(function(index, loop, rowloop) {
			console.log("indices: "+ index +" : "+datos);
			if(index == datos){
				catID = table.row(index).data().categoria_Ing_Egreg_ID;
				tipoCat_ID = table.row(index).data().tipoCategoria.tipoCategoria_ID;
				nombreCat = table.row(index).data().nombreCategoria;
				$("#nombreCategoria").val(nombreCat);
				$("#catIE_ID").val(catID);
				$("#tipoCategoria").val(tipoCat_ID);
				$("#tipoCategoria").change();
				$("#opcion").val("actualizar");
			}
		});
// 		colapsar_desplegar($("#colapsar_desplegar1"));
// 		colapsar_desplegar($("#colapsar_desplegar2"));
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
	//LoadSelect2Script(MakeSelect2);
}
	
	
	$(document).ready(function() {
		
		LoadDataTablesScripts2(AllTables);
		
		$('.form-control').tooltip();
		LoadSelect2Script(DemoSelect2);
		// Load example of form validation
		LoadBootstrapValidatorScript(DemoFormValidator);
		
		// Add drag-n-drop feature to boxes
		WinMove();
		guardar();
// 		colapsar_desplegar($("#colapsar_desplegar1"));
	});
	

</script>