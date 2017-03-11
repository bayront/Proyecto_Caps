<%@page import="Entidades.Categoria"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Datos.DTCategoria"%>
<%@page import="java.sql.ResultSet"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<div id="frm-agrega" class="expanded">
	<div class="expanded-padding">
		<div class="col-xs-12 col-sm-12">
			<div class="box">
				<div class="box-header">
					<div class="box-name">
						<i class="fa fa-search"></i> <span>Formulario de Categoria</span>
					</div>
					<div class="box-icons">
						<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
						</a> <a class="close-link"> </a>
					</div>

				</div>
				<div class="box-content">
					<h4 class="page-header">Registro de Categorias</h4>

					<div class="form-group">
						<label class="col-sm-2 control-label">Nombre de Categoria</label>
						<div class="col-sm-4">
							<input type="text" class="form-control"
								placeholder="nombre de categoria" data-toggle="tooltip"
								data-placement="bottom" id="nomCategoria"
								title="digite el nombre de la categoria">
						</div>

					</div>

					<div class="clearfix">

						<div class="col-sm-offset-2 col-sm-2">
							<button id="cancelar_nuevo" type="reset"
								class="btn btn-default btn-label-left">
								<span><i class="fa fa-clock-o txt-danger"></i></span> cancelar
							</button>

						</div>

						<div class="col-sm-2">
							<button id="opcion" title="Guardar"
								class="ajax-link action guardado" onClick="enviarMensaje();"
								value="guardar">
								<span><i class="fa fa-clock-o"></i></span> Registrar
							</button>
						</div>
					</div>
					<div class="form-group"></div>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
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
						</a> <a class="close-link"> </a>
					</div>

				</div>
				<div class="box-content">
					<h4 class="page-header">Registro de Categorias</h4>

					<div class="form-group">
						<label class="col-sm-2 control-label">Nombre de Categoria</label>
						<div class="col-sm-4">
							<input type="text" class="form-control"
								placeholder="nomCategoria" data-toggle="tooltip"
								data-placement="bottom" id="nomCategoria_edit"
								title="digite el nombre de la categoria">
						</div>
						<input type="hidden" id="categoria_ID_edit">
					</div>

					<div class="clearfix">

						<div class="col-sm-offset-2 col-sm-2">
							<button type="reset" class="btn btn-default btn-label-left" id="cancelar_editado"> 
								<span><i class="fa fa-clock-o txt-danger "></i></span>
								cancelar
							</button>

						</div>

						<div class="col-sm-2">
							<button id="opcion" title="actualizar"
								class="ajax-link action editado" onClick="enviarMensaje3();">
								<span><i class="fa fa-clock-o"></i></span> Registrar
							</button>
						</div>
					</div>
					<div class="form-group"></div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->


<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-location-arrow"></i> <span>Lista de
						Categorias</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a> <a class="close-link"> <i class="fa fa-times"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<div class="box-content no-padding">
				<div class="row padding-opc">
					<div class="col-md-12">
						<div class="col-md-12 col-xs-12 col-sm-12 agregar">
							<a class="ajax-link pull-right " id="btn-agrega-abrir" href="#"
								title="Nuevo Registro"> <i class="fa fa-plus-circle fa-2x"></i>
							</a>
						</div>

					</div>
				</div>
				<div>

					<table style="overflow-x: scroll; white-space: nowrap"
						class="table table-hover table-heading table-datatable"
						id="datatable-1">
						<thead>
							<tr>

								<th>Acciones</th>
								<th>ID</th>
								<th>Categoria</th>

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

								<td>
									<button class='btn btn-danger ajax-link action btnID'>Eliminar</button>
									<button
										class='btn btn-info ajax-link action btnEdit editadarAbrir'>Editar</button>

								</td>
								<td class="categoria_ID_td"><%=rs.getInt("categoria_ID")%></td>
								<td class="nomCategoria_td"><%=rs.getString("nomCategoria")%></td>

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
</div>

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
			}

		});
		alert("¡Guardado!");
	}

	/////////////////////////////DATATABLES PLUGIN CON 3 VARIANTES DE CONFIGURACIONES/////////////////////////////

	function AllTables() {
		cargar();
		LoadSelect2Script(MakeSelect2);
	}
	var cargar = function() {
		$('#datatable-1').DataTable();
	}

	/////////////////////////////CONTROLAR LA BUSQUEDA EN LA TABLA CARGADA/////////////////////////////
	function MakeSelect2() {
		$('select').select2();
		$('.dataTables_filter').each(
				function() {
					$(this).find('label input[type=text]').attr('placeholder',
							'Buscar');
				});
	}
	/////////////////////////////CONTROLAR EL EVENTO FADEIN DE LA VENTANA EDITAR/////////////////////////////
	function editOrDeleteCustomer(event) {
		var link = jQuery(event.currentTarget);
		var url = link.attr('href');
		jQuery.get(url, function(data) {
			$('#frm-edita').fadeIn();
		});
	}
	/////////////////////////////ESCONDER LOS FORMULARIOS DE EDICION Y DE AGREGAR/////////////////////////////

	$(document).ready(function() {

		$('#frm-agrega').hide();
		$('#frm-edita').hide();
		/////////////////////////////LLAMAR A LA FUNCION QUE CARGA LOS REGISTROS DE LA TABLA/////////////////////////////
		LoadDataTablesScripts(AllTables);

		/////////////////////////////ESTILO PARA LOS TOOLTIP/////////////////////////////
		$('.form-control').tooltip();
		/////////////////////////////CONTROLAR EL FORMULARIO AGREGAR /////////////////////////////
		$('#btn-agrega-abrir').click(function() {
			var body = $('body');
			body.toggleClass('body-expanded');
			$('#frm-agrega').fadeIn();
		});
		$('.guardado').click(function() {
			var body = $('body');
			body.toggleClass('body-expanded');
			$('#frm-agrega').fadeOut();
		});
		$('#cancelar_nuevo').click(function() {
			var body = $('body');
			body.toggleClass('body-expanded');
			$('#frm-agrega').fadeOut();
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


