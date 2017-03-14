<%@page import="Entidades.Categoria"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Datos.DTCategoria"%>
<%@page import="java.sql.ResultSet"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>




<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.html">Categoría</a></li>
			<li><a href="#">Crear categoría</a></li>
		</ol>
	</div>
</div>
<div id="frm-agrega" >
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
		
		
	<!-- AQUI INICIA EL DIV PARA EL TITULO-->
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-search"></i> <span>Crear Categoría</span>
				</div>
				<div class="box-icons">
					<a id="colapsar_desplegar1" class="collapse-link colapsar1"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			
<!-- 			<div class="box-icons"> -->
<!-- 					<a id="colapsar_desplegar1" class="collapse-link"> <i -->
<!-- 						class="fa fa-chevron-up"></i></a> <a id="expandir1" -->
<!-- 						class="expand-link"> <i class="fa fa-expand"></i></a> -->
<!-- 				</div> -->
			

			<div class="box-content">
				 
					
				<form class="form-horizontal" role="form" id="frm-agrega"  >
				
					<input type="hidden" id="opcion" name="opcion" value="guardar">
<!-- 					<input type="hidden" id="actual" name="actual">  -->
<!-- 					<input type="hidden" id="Tarifa_ID" name="Tarifa_ID"> -->
					<div class="form-group">
						<label class="col-sm-2 control-label text-info">Nombre Categoría</label>
						<div class="col-sm-5"><input type="text" class="form-control"
								placeholder="nombre de Categoría" data-toggle="tooltip"
								data-placement="bottom" id="nomCategoria"
								title="Ingrese el nombre de la categoria"></div>
					</div> 
					
					
						
					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-3">
							<button  id="opcion"  class="btn btn-primary btn-label-left btn-lg"  class="ajax-link action guardado"  value="guardar" onClick="enviarMensaje();"" >
								<span><i class="fa fa-save"></i></span>Guardar
							</button>
						</div>
					<div class="col-sm-4">
							<button id="cancelar_nuevo" type="reset" class="btn btn-default btn-label-left btn-lg" onclick="cancelar();">
								<span><i class="fa fa-reply txt-danger"></i></span>Cancelar
								</button>
						</div>
					</div>
						
						
					<div class="col-sm-offset-2 col-sm-8">
							<p class="mensaje"></p>
					</div>
					
				</form>
			</div> 
			
			
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
					<a id="colapsar_desplegar2" class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> 
					<a id="expandir2" class="expand-link"> <i class="fa fa-expand"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding table-responsive">
			
			
			<div style="display: block; text-align: center;">
					<button onclick="limpiar_texto();" style="position: inherit;" type="button" class="btn btn-success btnNuevo" id="center_button">
						<i class=" fa fa-plus"></i>
					</button>
				</div>
				
				<table class="table  table-bordered table-striped table-hover table-heading table-datatable"
					id="datatable-1">
					<thead>
						<tr>
							
								<th>ID</th>
								<th>Categoría</th>
                                 <th>Acciones</th>
								
						</tr>
					</thead>
					
							<tbody>
							<%
								DTCategoria dtp = DTCategoria.getInstance();
								ResultSet rs = dtp.Categorias();
								rs.beforeFirst();

								while (rs.next()) {
							%>

							<tr>

								<td class="categoria_ID_td"><%=rs.getInt("categoria_ID")%></td>
								<td class="nomCategoria_td"><%=rs.getString("nomCategoria")%></td>
								<td>
								<button style="position:left" type='button' class='btn btn-primary action btnEdit editadarAbrir' data-toggle='modal' data-target='#modalEliminar' >
									<i class='fa fa-pencil-square-o'></i>
								</button>
								<button style="position:left" type='button' class='btn btn-danger action btnID'>
									<i class='fa fa-trash-o'></i>
								</button> 
								</td>
								

							</tr>
							<%
								}
							%>

						</tbody>
					
					
					
				</table>
			</div>
		</div>
	</div>
</div>


<!-- Ejemplo con x -->
<div class="row">

<div id="frm-edita" class="expanded">
	<div class="expanded-padding">
		<div class="col-xs-12 col-sm-12">
			<div class="box">
				<div class="box-header">
					<div class="box-name">
						<i class="fa fa-search"></i> <span>Formulario de Edición</span>
					</div>
					<div class="box-icons">
						<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a> <a class="close-link"> <i class="fa fa-times"></i>
					</a>
					</div>

				</div>
				<div class="box-content">
					<h4 class="page-header">Registro de Categorías</h4>

					<div class="form-group">
						<label class="col-sm-2 control-label">Nombre de Categoría</label>
						<div class="col-sm-4">
							<input type="text" class="form-control"
								placeholder="nomCategoría" data-toggle="tooltip"
								data-placement="bottom" id="nomCategoria_edit"
								title="Ingrese el nombre de la categorìa">
						</div>
						<input type="hidden" id="categoria_ID_edit">
					</div>

					<div class="clearfix">
							<div class="form-group">
								<div class="col-sm-15 col-sm-3">
									<button id="opcion" 
										class="ajax-link action editado btn btn-info btn-label-left" 
										onClick="enviarMensaje3();" >
										<span><i class="glyphicon glyphicon-save text-info"></i></span><font
											color="black">Guardar</font>
									</button>
								</div>
<!-- 								<div class="col-sm-offset-2 col-sm-2"> -->
<!-- 							<button type="reset" class="btn btn-default btn-label-left" id="cancelar_editado">  -->
<!-- 								<span><i class="fa fa-clock-o txt-danger "></i></span> -->
<!-- 								cancelar -->
<!-- 							</button> -->

<!-- 						</div> -->
								
								
								<div class="col-sm-15 col-sm-3">
									<button id="cancelar_editado" type="reset"
										class="btn btn-info btn-label-left" onclick="cancelar();">
										<span><i class="fa fa-clock-o txt-danger"></i></span><font
											color="black"> Cancelar</font>
									</button>
								</div>
							</div>



						</div>
					<div class="form-group"></div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
</div>
<!-- termina ejemplo con x -->



<script>
	//////////////////////////////////////////////////////REFRESCAR////////////////////////////////////////////////////////////////////////////////////////// -->

	function refrescar() {

		var opcion = "refrescar";
		var table = $('#datatable-1').DataTable();

		$.ajax({
			url : "SL_Categoria",
			type : "post",
			datatype : 'html',
			data : {
				'opcion' : opcion
			},
			success : function(data) {
				$('#datatable-1').html(data);

				$('#datatable-1').dataTable().fnDestroy();
				$('#datatable-1').addClass(
						"table table-hover table-heading table-datatable");
				cargar();

			}
		});
		//alert("Refrescado");

	}

	////////////////////////////////////////////////////////ACTUALIZAR//////////////////////////////////////////////////////////////////////////////////////// -->

	function actualizar() {

		var opcion = "actualizar";
		var nomCategoria = $("#nomCategoria_edit").val();
		var categoria_ID = $("#categoria_ID_edit").val();
		$.ajax({
			url : "SL_Categoria",
			type : "post",
			datatype : 'html',
			//--------------------------------------//
			data : {
				'opcion' : opcion,
				'nomCategoria' : nomCategoria,
				'categoria_ID' : categoria_ID
			},

			//--------------------------------------//

			success : function(data) {
				$('#datatable-1').html(data);
				$('#datatable-1').dataTable().fnDestroy();
				$('#datatable-1').addClass(
						"table table-hover table-heading table-datatable");
				refrescar();

			}

		});
		alert("¡Actualizado!");
	}

	////////////////////////////////////////////////////////ELIMINAR//////////////////////////////////////////////////////////////////////////////////////// -->

	$('#datatable-1')
			.on(
					'click',
					'.btnID',
					function()//Esta funcion es para poner un onClick en todos los botones con la clase .btnID  ///No puede ser id tiene que ser clase
					{
						var opcion = "eliminar";
						var row = $(this).closest('tr');//Se obtiene el tag "tr" mas cercano y se guarda en la variable row
						var str = row.find('.categoria_ID_td').text();//se busca en el mismo "tr" el tag que tenga la clase "idAlergia_td" y se obtiene el texto, que en este caso es un "td"
						var categoria_ID = parseInt(str.trim(), 10);//esto no es necesario, lo hice por un error todo raro
						console.log(str);//esto es de prueba
						var table = $('#datatable-1').DataTable();//esto ya lo conocen
						$
								.ajax({
									url : "SL_Categoria",
									type : "post",
									datatype : 'html',
                                    "language":idioma_esp,
									data : {
										'opcion' : opcion,
										'categoria_ID' : categoria_ID
									},
									success : function(data) {
										$('#datatable-1').html(data);
										$('#datatable-1').dataTable()
												.fnDestroy();
										$('#datatable-1')
												.addClass(
														"table table-hover table-heading table-datatable");
										refrescar();

									}
								});
						alert("¡Eliminado!");
					});
	////////////////////////////////////////////////////////OBTENER DATOS PARA EDICION//////////////////////////////////////////////////////////////////////////////////////// -->

	$('#datatable-1').on('click', '.btnEdit', function()//Es basicamente lo mismo que para eliminar solo que aqui la informacion obtenida se coloca en el formulario de edicion
	{
		var row = $(this).closest('tr');
		var categoria_ID = row.find('.categoria_ID_td').text();
		var nomCategoria = row.find('.nomCategoria_td').text();
		$('#nomCategoria_edit').val(nomCategoria);//Aca le paso las variables al formulario de edicion, asi es como se llena un "value"
		$('#categoria_ID_edit').val(categoria_ID);
		var body = $('body');
		body.toggleClass('body-expanded');
		$('#frm-edita').fadeIn();
	});
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
	function enviarMensaje() {
		guardar();

	}

	function enviarMensaje3() {
		actualizar();

	}

	//////////////////////////////////////////////

	function guardar() {

		var opcion = $("#opcion").val();
		var nomCategoria = $("#nomCategoria").val();

		$.ajax({
			url : "SL_Categoria",
			type : "post",
			datatype : 'html',
			//--------------------------------------//
			data : {
				'opcion' : opcion,
				'nomCategoria' : nomCategoria

			},

			//--------------------------------------//

			success : function(data) {
				$('#datatable-1').html(data);
				$('#datatable-1').dataTable().fnDestroy();
				$('#datatable-1').addClass(
						"table table-hover table-heading table-datatable");
				refrescar();
				colapsar_desplegar($(".colapsar1"));
			}

		});
		alert("¡Guardado!");
	}

	/////////////////////////////DATATABLES PLUGIN CON 3 VARIANTES DE CONFIGURACIONES/////////////////////////////

	function AllTables() {
		cargar();
		//LoadSelect2Script(MakeSelect2);
	}
	var cargar = function() {
		$('#datatable-1').DataTable();
	}

	/////////////////////////////CONTROLAR LA BUSQUEDA EN LA TABLA CARGADA/////////////////////////////
// 	function MakeSelect2() {
// 		$('select').select2();
// 		$('.dataTables_filter').each(
// 				function() {
// 					$(this).find('label input[type=text]').attr('placeholder',
// 							'Buscar');
// 				});
// 	}
// 	/////////////////////////////CONTROLAR EL EVENTO FADEIN DE LA VENTANA EDITAR/////////////////////////////
	function editOrDeleteCustomer(event) {
		var link = jQuery(event.currentTarget);
		var url = link.attr('href');
		jQuery.get(url, function(data) {
			$('#frm-edita').fadeIn();
		});
	}
	/////////////////////////////ESCONDER LOS FORMULARIOS DE EDICION Y DE AGREGAR/////////////////////////////

	var limpiar_texto = function() {//limpiar texto del formulario
		$("#opcion").val("guardar");
		$("#nomCategoria").val("");
		colapsar_desplegar($(".colapsar1"));
	}
	
	$(document).ready(function() {

		//$('#frm-agrega').hide();
		$('#frm-edita').hide();
		/////////////////////////////LLAMAR A LA FUNCION QUE CARGA LOS REGISTROS DE LA TABLA/////////////////////////////
		LoadDataTablesScripts(AllTables);

		colapsar_desplegar($(".colapsar1"));
		/////////////////////////////ESTILO PARA LOS TOOLTIP/////////////////////////////
		$('.form-control').tooltip();
		/////////////////////////////CONTROLAR EL FORMULARIO AGREGAR /////////////////////////////
		$('#btn-agrega-abrir').click(function() {
			var body = $('body');
			body.toggleClass('body-expanded');
			//$('#frm-agrega').fadeIn();
		});
		$('.guardado').click(function() {
			var body = $('body');
			body.toggleClass('body-expanded');
			//$('#frm-agrega').fadeOut();
		});
		$('#cancelar_nuevo').click(function() {
			var body = $('body');
			body.toggleClass('body-expanded');
			//$('#frm-agrega').fadeOut();
		});
		/////////////////////////////CONTROLAR EL FORMULARIO AGREGAR Y CERRAR FORMULARIO EDITAR/////////////////////////////

		$('.editado').click(function() {

			var body = $('body');
			body.toggleClass('body-expanded');
			$('#frm-edita').fadeOut();
		});
		$('#cancelar_editado').click(function() {

			var body = $('body');
			body.toggleClass('body-expanded');
			$('#frm-edita').fadeOut();
		});
		$('.editadarAbrir').click(function() {

			var body = $('body');
			body.toggleClass('body-expanded');
			$('#frm-edita').fadeIn();
		});

		/////////////////////////////CONTROL DE VENTANAS (PROPIO DE LA PLANTILLA)/////////////////////////////

	});

	////////////////////////////////////////////////////////////////////////////////////////////////
</script>