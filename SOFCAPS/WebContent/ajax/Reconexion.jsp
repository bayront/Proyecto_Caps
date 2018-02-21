<%@page language="java"%>
<%@page contentType="text/html"%> 
<%@page pageEncoding="UTF-8" import="Entidades.Usuario, Entidades.Rol, Datos.DT_Vw_rol_opciones,java.sql.ResultSet ;"%> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
%>
<%
	String nombre_usuario = "";
	nombre_usuario = (String) session.getAttribute("nombre_usuario");
	nombre_usuario = nombre_usuario==null?"":nombre_usuario;
	
	DT_Vw_rol_opciones dtvro = new DT_Vw_rol_opciones();

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
			<li><a href="#">Reconexión</a></li>
		</ol>
	</div>
</div>

<!--///////////////////////DataTable de los contratos/////////////////////////////// -->
<input type="hidden" id="userC" name="userC" value="<%=nombre_usuario %>">
<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-th"></i> <span>Lista de Reconexiones</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar2" class="collapse-link"> 
<!-- 					onclick="validar(colap2);"  -->
						<i class="fa fa-chevron-up"></i></a> 
					<a id="expandir2" class="expand-link"> 
<!-- 					onclick="validar(expand2);" -->
						<i class="fa fa-expand"></i></a>
					<a class="cerrar" title="Inhabilitado"> 
						<i class="fa fa-times"></i></a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding table-responsive">
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="dt_Reconexion" style="width:100%;">
					<thead>
						<tr>
							<th>Nombre del Cliente</th>
							<th>Fecha Reconexión</th>
							<th>Cancelado</th>
							<th>Número de Factura</th>
							<th>Acción</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>

<!--///////////////////////Formulario y dialogo de eliminción /////////////////////////////// -->
<div>
	<form id="frmEliminarReconexion" action="" method="POST">
		<input type="hidden" id="reconexion_ID" name="reconexion_ID" value="">
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

function abrirDialogo() {////////////////////abre dialogo con muestra si desae eliminar el registro del contrato
	OpenModalBox(
			"<div><h3>Imprimir Aviso de Corte</h3></div>",
			"<p Style='text-align:center; color:blue; font-size:x-large;'>¿Esta seguro que desea imprimir el aviso de corte para este cliente?</p>",
			"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-offset-3 col-md-3'>"+
			"<button type='button' id='eliminar_reconexion' class='btn btn-primary btn-label-left'"+
			" style=' color: #ece1e1;' >"+
			"<span><i class='fa fa-print'></i></span> Imprimir</button>"+
			"<div style='margin-top: 5px;'></div> </div>"+
			"<div Style='margin-bottom: -10px;' class='col-sm-12 col-md-3 text-center'>"+
			"<button type='button' class='btn btn-default btn-label-left' onclick='CloseModalBox()'>"+
			"<span><i class='fa fa-reply txt-danger'></i></span> Cancelar</button> </div>");
	eliminar();
}

var verResultado = function(r) {//parametro(resultado-String)
	if(r == "BIEN"){
		mostrarMensaje("#dialog", "CORRECTO",
				"¡Se realizó la operación correctamente, todo bien!","#d7f9ec", "btn-info");
		$('#dt_Reconexion').DataTable().ajax.reload();
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
	$("#eliminar_reconexion").on("click", function() {
		var reconexionID = "";
		userC = $('#userC').val();
		reconexion_ID = $('#frmEliminarReconexion #reconexion_ID').val();
		console.log(reconexion_ID);
		window.open("SL_Reconexion?reconexion_ID="+reconexion_ID +"&userC="+userC +"&opcion=imprimir",'_blank');
		console.log("la reconexion_ID del jsp"+"  "+reconexion_ID);
		CloseModalBox();
	});
}




/////////////////////////activar evento del boton eliminar que esta en la fila seleccionada del dataTable///////////
var obtener_id_eliminar = function(tbody, table) {//parametros(id_tabla, objeto dataTable)
	$(tbody).on("click","button.eliminar",function() {
		var datos = table.row($(this).parents("tr")).index();//obtener la fila tr que es padre del boton que se toco y oobtener datos
		table.rows().every(function(index, loop, rowloop) {
			if (index == datos) {
				var reconexion_ID = $("#frmEliminarReconexion #reconexion_ID").val(table.row(index).data().reconexion_ID);
			}
		});
		abrirDialogo();
	});
}

/////////////////////////////////Ejecutar el metodo DataTable para llenar la Tabla/////////////////////////////////////////
var listar = function() {
	console.log("cargando dataTable");
	var tablaReconexion= $('#dt_Reconexion').DataTable( {
		responsive: true,
		'destroy': true,
		'bProcessing': false,
		'bServerSide': false,
		ajax: {
			"method":"GET",
			"url":"./SL_Reconexion",
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
                	var f1 = new Date(data.fecha_reconexion);
        			var fecha1 = f1.getDate()+"/"+(f1.getMonth()+1)+"/"+f1.getFullYear();
                	return fecha1;
                }},
                { "data": null,
		         	render: function ( data, type, row ) {
		         		var pagado;
		         		if(data.cancelado == 1)
		        			pagado = "<div class='checkbox'> <label> <input type='checkbox' checked disabled>"+
		        			"<i class='fa fa-square-o'></i> </label> </div>";
		        		else
		        			pagado = "<div class='checkbox'> <label> <input type='checkbox' disabled>"+
		        			"<i class='fa fa-square-o'></i> </label> </div>";
		               	return pagado;
		       	}},
            { "data": "factura_Maestra.numFact"},
            {"defaultContent":
				"<button type='button' class='eliminar btn btn-basic' data-toggle='tooltip' "+
				"data-placement='top' title='Imprimir Aviso de Corte'>"+
				"<i class='fa fa-print'></i> </button>"}
            ],
            "dom" : "<rt><'row'<'form-inline' <'col-sm-12 text-center'B>>>"
				+ "<'row' <'form-inline' <'col-sm-6'l><'col-sm-6'f>>>"
				+ "<rt>"
				+ "<'row'<'form-inline'"
				+ "<'col-sm-6 col-md-6 col-lg-6'i><'col-sm-6 col-md-6 col-lg-6'p>>>",
			"buttons":[
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
	tablaReconexion.columns.adjust().draw();
	obtener_id_eliminar('#dt_Reconexion tbody',tablaReconexion);

}


/////////////////////////////////////////////////FUNSIÓN PRINCIPAL/////////////////////////////////////////////////
$(document).ready(function() {
	///////cargar plugin para DataTable
	LoadDataTablesScripts2(AllTables);
	// Add drag-n-drop feature to boxes
	WinMove();
	
});
</script>