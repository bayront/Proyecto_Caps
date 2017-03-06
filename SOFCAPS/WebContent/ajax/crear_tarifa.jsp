<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="index.html">Tarifa</a></li>
			<li><a href="#">Crear Tarifa</a></li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12">
		<div class="box">
		<!-- AQUI INICIA EL DIV PARA EL TITULO-->
			<div class="box-header">
				<div class="box-name">
					<i class="fa fa-search"></i> <span>Crear Tarifas</span>
				</div>
				<div class="box-icons">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="expand-link"> <i class="fa fa-expand"></i>
					</a>
				</div>
				<div class="no-move"></div>
			</div>
			<!-- AQUI TERMINA EL TITULO  -->
			<div class="box-content">
				<form class="form-horizontal" role="form" id="defaultForm" method="post" action="validators.html">
					<div class="form-group has-success has-feedback">
						<label class="col-sm-2 control-label">Limite superior</label>
							<div class="col-sm-4">
								<input type="text" class="form-control"
								placeholder="limite superior" data-toggle="tooltip"
								data-placement="bottom" title="Tooltip para limite superior">
							</div>
					</div>
					
					<div class="form-group has-success has-feedback">
						<label class="col-sm-2 control-label">Limite inferior</label>
							<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Limite inferior"
								data-toggle="tooltip" data-placement="bottom"
								title="Tooltip para limite inferior">
							</div> 
						</div>
						
					<div class="form-group has-success has-feedback">
					<label class="col-sm-2 control-label">Monto</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" placeholder="Monto"
								data-toggle="tooltip" data-placement="bottom"
								title="Tooltip para Monto">
						</div> 
					</div> 
					<div class="clearfix"></div>
					<div class="form-group">
					
						<div class="col-sm-2">
							<button type="submit" class="btn btn-primary btn-label-left">
								<span><i class="fa fa-upload"></i></span>Guardar
							</button>
						</div>
						<div class="col-sm-offset-2 col-sm-2">
							<button type="cancel" class="btn btn-default btn-label-left">
								<span><i class="fa fa-clock-o txt-danger"></i></span> Cancelar
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>