<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="ls-theme-indigo">
  <head>
    <title>Movimentos | i9 Finanças</title>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="description" content="Sistema financeiro">
    <link href="css/estiloGfinancas.css" rel="stylesheet" type="text/css">
    <link href="javascripts/bbnloading.css" rel="stylesheet" type="text/css">
    <link rel="icon" sizes="192x192" href="images/ico-boilerplate.png">
    <link rel="apple-touch-icon" href="images/ico-boilerplate.png">
<script>
function MascaraMoeda(objTextBox, SeparadorMilesimo, SeparadorDecimal, e){
    var sep = 0;
    var key = '';
    var i = j = 0;
    var len = len2 = 0;
    var strCheck = '0123456789';
    var aux = aux2 = '';
    var whichCode = (window.Event) ? e.which : e.keyCode;
    if ((whichCode == 13) || (whichCode == 0) || (whichCode == 8)) return true;
    key = String.fromCharCode(whichCode); // Valor para o código da Chave
    if (strCheck.indexOf(key) == -1) return false; // Chave inválida
    len = objTextBox.value.length;
    for(i = 0; i < len; i++)
        if ((objTextBox.value.charAt(i) != '0') && (objTextBox.value.charAt(i) != SeparadorDecimal)) break;
    aux = '';
    for(; i < len; i++)
        if (strCheck.indexOf(objTextBox.value.charAt(i))!=-1) aux += objTextBox.value.charAt(i);
    aux += key;
    len = aux.length;
    if (len == 0) objTextBox.value = '';
    if (len == 1) objTextBox.value = '0'+ SeparadorDecimal + '0' + aux;
    if (len == 2) objTextBox.value = '0'+ SeparadorDecimal + aux;
    if (len > 2) {
        aux2 = '';
        for (j = 0, i = len - 3; i >= 0; i--) {
            if (j == 3) {
                aux2 += SeparadorMilesimo;
                j = 0;
            }
            aux2 += aux.charAt(i);
            j++;
        }
        objTextBox.value = '';
        len2 = aux2.length;
        for (i = len2 - 1; i >= 0; i--)
        objTextBox.value += aux2.charAt(i);
        objTextBox.value += SeparadorDecimal + aux.substr(len - 2, len);
    }
    return false;
}
</script>    
</head>
  <body>
    <div class="ls-topbar ">
		<div class="ls-notification-topbar">
			<!-- Links de apoio -->
			<div class="ls-alerts-list">
				<a href="#" class="ls-ico-question" data-ls-module="topbarCurtain"
					data-target="#ls-feedback-curtain"><span>Ajuda</span></a>
			</div>
			<%
				String usuario = (String) session.getAttribute("usuario");
				if (usuario != null) {
			%>
			<!-- Dropdown com detalhes da conta de usuário -->
			<div data-ls-module="dropdown" class="ls-dropdown ls-user-account">
				<a href="#" class="ls-ico-user"> <span class="ls-name">
						<%
							out.print(usuario);
						%>
				</span>
				</a>

				<nav class="ls-dropdown-nav ls-user-menu">
					<ul>
						<li><a href="login?param=logout">Sair</a></li>
						<%
							} else {
								String direcionaURL = "404.jsp";
								response.sendRedirect(direcionaURL);
						%>

						<h3>Você não tem acesso para acessar está página</h3>
						<%
							}
						%>
					</ul>
				</nav>
			</div>
		</div>
  <span class="ls-show-sidebar ls-ico-menu"></span>
  <a href="#"  class="ls-go-next"><span class="ls-text">Voltar</span></a>
  <!-- Nome do produto/marca com sidebar -->
    <h1 class="ls-brand-name">
      <a href="index.jsp" class="ls-ico-lamp">
        <small>Modulo financeiro</small>
        i9 Finanças
      </a>
    </h1>
  <!-- Nome do produto/marca sem sidebar quando for o pre-painel  -->
</div>
  <a href="" id="irAoTopo"></a>
  <aside class="ls-sidebar">
  <div class="ls-sidebar-inner">
      <a href="javascript:history.back()"  class="ls-go-prev"><span class="ls-text">Voltar</span></a>
      
      <nav class="ls-menu">
        <ul>
           <li><a href="index.jsp" class="ls-ico-dashboard" title="Dashboard">Dashboard</a></li>
           <li><a href="movimentos.jsp" class="ls-ico-trophy" title="Movimentos">Movimentos</a></li>
      <!-- <li><a href="relatorioMensal.jsp" class="ls-ico-stats" title="Relatórios da revenda">Relatório mensal</a></li>-->
           <li>
            <a href="#" class="ls-ico-cog" title="Configurações">Cadastros</a>
            <ul>
              <li><a href="cliente.jsp">Cliente</a></li>
              <li><a href="fornecedor.jsp">Fornecedor</a></li>
              <li><a href="categoria.jsp">Categoria</a></li>
              <li><a href="usuario.jsp">Usuario</a></li>
            </ul>
          </li>
        </ul>
      </nav>
  </div>
</aside>
    <main class="ls-main ">
      <div class="container-fluid">
        <h1 class="ls-title-intro ls-ico-trophy">Movimentos</h1>
		<!-- Migalhas de pão -->
		<ol class="ls-breadcrumb">
			<li><a href="index.jsp">Início</a></li>
			<li>Movimentos</li>
		</ol>
		<div class="ls-txt-right">
		   <button data-ls-module="modal" data-target="#addMovimento" class="ls-btn-primary"> <span class="ls-ico-trophy"> </span> Adicionar movimento</button>
		</div>
		<!-- Filtros -->
		<div class="ls-box-filter">
		  <form id="filtros" class="ls-form ls-form-inline">
		    <input name="status" value="" type="hidden">
		    <label class="ls-label col-lg-3 col-md-6 col-sm-12">
		      <b class="ls-label-text">Período</b>
		      <div class="ls-custom-select">
		        <select name="periodo" id="select_period" class="ls-select" onchange="Movimentos.selecionarPeriodo(this.value)">
		            <option value="1">Hoje</option>
		            <option value="2">Ontem</option>
		            <option value="3">Últimos 30 dias</option>
		            <option value="7">Personalizado</option>
		        </select>
		      </div>
		    </label>
		
		    <label class="ls-label col-lg-2 col-md-3 col-sm-12">
		      <div class="ls-prefix-group">
		        <span data-target="#ls-popover-0" id="new_feature_custom_filter_2" data-ls-module="popover" data-content="Escolha o período desejado e clique em 'Filtrar'."></span>
		        <input name="range_start" class="datepicker ls-daterange" placeholder="dd/mm/aaaa" id="range_start" data-ls-daterange="#datepicker2" type="text" disabled="disabled">
		        <a class="ls-label-text-prefix ls-ico-calendar" data-trigger-calendar="#datepicker1" href="#"></a>
		      </div>
		    </label>
		    <label class="ls-label col-lg-2 col-md-3 col-sm-12">
		      <div class="ls-prefix-group">
		        <span data-target="#ls-popover-1" id="new_feature_custom_filter_3" data-ls-module="popover" data-content="Clique em 'Filtrar' para exibir  o período selecionado."></span>
		        <input data-date-pair="datepicker1" name="range_end" class="datepicker ls-daterange" placeholder="dd/mm/aaaa" id="range_end" type="text" disabled="disabled">
		        <a class="ls-label-text-prefix ls-ico-calendar" data-trigger-calendar="#datepicker2" href="#"></a>
		      </div>
		    </label>

		    <label class="ls-label col-lg-4 col-md-8 col-sm-12">
		      <b class="ls-label-text">Categoria</b>
		      <div class="ls-custom-select">
		        <select name="categoria" class="ls-select select_categoria">
		        <option>Selecione</option>
		        </select>
		      </div>
		    </label>
		    </label>
		    <input class="ls-btn-primary" value="Pesquisar" type="submit">
		  </form>
		</div>
	<!-- Grid de registros -->
	<div id="containerTbl">
		<table class="ls-table ls-table-striped">
		  <thead>
		    <tr>
		      <th>Descrição</th>
		      <th>Categoria</th>
		      <th>Cliente/Fornecedor</th>
		      <th>Valor</th>
		      <th>Dta Cadastro</th>
		      <th>Ações</th>
		    </tr>
		  </thead>
		  <tbody id="tabela"></tbody>
		</table>
	</div>
        <div class="ls-txt-center">
        	<a href="#irAoTopo" class="ls-btn-primary ls-btn-lg ls-ico-circle-up">Ir ao topo</a>
        </div>
        </br>
        
		<!-- Modal de Add Movimento -->
		<div class="ls-modal" id="addMovimento">
		<form id="addMov" method="GET" class="ls-form ls-form-horizontal row">
		  <div class="ls-modal-large">
		    <div class="ls-modal-header">
		      <button data-dismiss="modal">&times;</button>
		      <h4 class="ls-modal-title">Adicionar Movimento</h4>
		    </div>
		    <div class="ls-modal-body">
			  <fieldset>
			    <label class="ls-label col-md-6 col-xs-12">
			          <b class="ls-label-text">Tipo de movimentação</b>
			          <div class="ls-custom-select col-md-6 col-xs-12">
			          <select name="tipo_mov" id="tipo_mov" onchange="Movimentos.changingForm(this.value)">
				          <option value="1">Cliente</option>
				          <option value="2">Fornecedor</option>
				          <option value="0">Outros</option>
			          </select>
			          </div>
			    </label>
			    <label id="containercpf_cnpj" class="ls-label col-md-6 col-xs-12">
		          <b class="ls-label-text">CPF (Somente numeros)</b>
			      <input type="number" maxlength="11" name="cpf_cnpj" id="cpf_cnpj" class="ls-field" 
			      onfocusout="Movimentos.buscaIdcliente_fornecedor(this.value)"
			      data-ls-module="charCounter">
		         </label>
		        <div class="col-md-12 col-xs-12" id="container_valores" style="padding:0;">
		        	<label class="ls-label col-md-6 col-xs-12">
				      	<b class="ls-label-text">Nome do cliente</b>
				      	<input type="text" id="nomeCliente" class="ls-field col-md-6" disabled>
			      	</label>
			      	<label class="ls-label col-md-6 col-xs-12">
				      	<b class="ls-label-text">Saldo Devedor</b>
				      	<div class="ls-prefix-group">
				      		<span class="ls-label-text-prefix">R$</span>
				      		<input type="text" id="saldoCliente" class="ls-field col-md-6" disabled>
				      	</div>
			      	</label>
			      	
				    <label class="ls-label col-md-6 col-xs-12">
				      	<b class="ls-label-text">Valor do produto</b>
				      	<div class="ls-prefix-group">
  			  			<span class="ls-label-text-prefix">R$</span>
				      	<input type="text" name="valorCompra" id="valorCompra"
				      	onfocusout="Movimentos.verificarUsoSaldo(this.value)"
				      	onkeypress="return(MascaraMoeda(this,'.',',',event))" 
				      	placeholder="Valor do produto ou serviço Ex : 500,00" 
				      	class="ls-field col-md-6" 
				      	onfocusout="Movimentos.verificarUsoSaldo()" required>
				      	</div>
			      	</label>
			      	<label class="ls-label col-md-6 col-xs-12">
				      	<b class="ls-label-text">Abater do saldo ?</b>
					    <input type="checkbox" name="usarSaldo" id="usarSaldo">
			      	</label>
			    </div>
			    <label class="ls-label col-md-6 col-xs-12">
		          <b class="ls-label-text">Categoria</b>
		           <div class="ls-custom-select">
			        <select name="idcategoria" class="ls-select select_categoria">
			        </select>
		          </div>
		         </label>
			    </label>			    
			    <label class="ls-label col-md-12 col-xs-12">
			      <b class="ls-label-text">Descrição</b>
			      <textarea type="" name="dsc" placeholder="" class="ls-field" data-ls-module="charCounter" maxlength="100" required></textarea>
			    </label>

			  </fieldset>		      
		    </div>
		    <div class="ls-modal-footer ls-txt-right ls-actions-btn">
		      <input type="hidden" name="usuario_idusuario" value="17">
		      <button type="submit" id="enviaMovimentacao" class="ls-btn-primary ls-disabled">Salvar</button>
		      <button type="reset" class="ls-btn">Limpar</button>
		      <button class="ls-btn-danger" data-dismiss="modal">Cancelar</button>
		    </div>
		  </div>
		 </form>
		</div>
		
		<!-- Modal de edição -->
		<div class="ls-modal" id="editMovimento">
		<form id="editMov" method="GET" class="ls-form ls-form-horizontal row">
		  <div class="ls-modal-large">
		    <div class="ls-modal-header">
		      <button data-dismiss="modal">&times;</button>
		      <h4 class="ls-modal-title">Editar Movimento</h4>
		    </div>
		    <div class="ls-modal-body">
			  <fieldset>
			    <label class="ls-label col-md-6 col-xs-12">
			          <b class="ls-label-text">Tipo de movimentação</b>
			          <input type="text" id="tipo_movEditar" disabled>
			          <input type="hidden" id="id" name="id">
			    </label>
			    <label class="ls-label col-md-6 col-xs-12">
				      	<b class="ls-label-text">Nome do cliente</b>
				      	<input type="text" id="nomeClienteEditar" disabled>
			    </label>
				<label class="ls-label col-md-6 col-xs-12">
				<b class="ls-label-text">Valor Movimentação</b>
					<span class="ls-prefix-group">
	  			  		<span class="ls-label-text-prefix">R$</span>
					    <input type="text" name="valorEditar" id="valorEditar" disabled>
					</span>
			    </label>
			    <label class="ls-label col-md-6 col-xs-12">
				      	<b class="ls-label-text">Categoria</b>
				      	<input type="text" id="categoriaEditar" disabled>
			    </label>	    
			    <label class="ls-label col-md-12 col-xs-12">
			      <b class="ls-label-text">Descrição</b>
			      <textarea name="dsc" id="dscEditar" placeholder="" class="ls-field" required></textarea>
			    </label>

			  </fieldset>		      
		    </div>
		    <div class="ls-modal-footer ls-txt-right ls-actions-btn">
		      <button type="submit" id="enviaMovimentacao" class="ls-btn-primary">Salvar</button>
		    </div>
		  </div>
		 </form>
		</div>
      <!-- Fim conteudo -->   
      </div>
    </main>

    <aside class="ls-notification"> 
      <nav class="ls-notification-list" id="ls-feedback-curtain" style="left: 1796px;">
        <h3 class="ls-title-2">Ajuda</h3>
        <ul>
          <li><a href="#">&gt; Manual</a></li>
        </ul>
      </nav>
    </aside>

    <!-- We recommended use jQuery 1.10 or up -->
    <!-- <script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script> -->
    <script src="javascripts/libs/jquery-2.1.0.min.js" type="text/javascript"></script>
    <script src="javascripts/locastyle.js" type="text/javascript"></script>
    <script src="javascripts/bbnloading.js" type="text/javascript"></script>
    <script src="javascripts/libs/jquery.mask.js" type="text/javascript"></script>
    <script>
    	var Movimentos = {};
    	//cpf-cnpj
    	Movimentos.buscaIdcliente_fornecedor = function(cpf_cnpj){
    		$.ajax({
	    		url:'http://localhost:8080/app/movimentacao',
	    		method:'GET',
	    		cache:false,
	    		data:{metodo:'getidcliente_fornecedor',cpf_cnpj:cpf_cnpj},
	    		beforeSend: function(){
	    			//cria o loader
	    			BbnLoading.createSpin();
	    		},
	    		success: function(data){
	    			//mata o loader no callback de sucesso da requisição ajax
	    			BbnLoading.removeModalDiv();
	    			if(data.length >= 1){
	    				$("#cpf_cnpj").removeClass('invalidIdMovimento');
	    				$("#enviaMovimentacao").removeClass('ls-disabled');
	    				
	    				if(!!data[0].idfornecedor && $("#tipo_mov").val() == '2'){
	    					var node = document.createElement("input");
		    				node.type='hidden';
		    				node.value=data[0].idfornecedor;
		    				node.name='idfornecedor';
		    				document.getElementById('addMov').appendChild(node);
		    				document.getElementById('nomeCliente').value = data[0].nome;
		    				document.getElementById('saldoCliente').value = "Não aplicável";
	    				}else if(!!data[0].idcliente && $("#tipo_mov").val() == '1'){
	    					var node = document.createElement("input");
		    				node.type='hidden';
		    				node.value=data[0].idcliente;
		    				node.name='idcliente';
		    				document.getElementById('addMov').appendChild(node);
		    				document.getElementById('nomeCliente').value = data[0].nome;
		    				document.getElementById('saldoCliente').value = data[0].saldo;
	    				}else{
	    					document.getElementById('cpf_cnpj').className='invalidIdMovimento';
	    				}
	    			}else{
	    				document.getElementById('cpf_cnpj').className='invalidIdMovimento';
	    			}
	    		}
    		});
    	}
    	
    	Movimentos.changingForm = function(value){
    		switch(value){
    		//cliente
    		case'1':
    			document.getElementById('containercpf_cnpj').innerHTML = ""+
    			'<b class="ls-label-text">CPF (Somente números)</b>'+
  			    '<input type="number" maxlength="11" name="cpf_cnpj" id="cpf_cnpj" onfocusout="Movimentos.buscaIdcliente_fornecedor(this.value)" class="ls-field">';
  			    document.getElementById('container_valores').innerHTML = ""+
  			  	'<label class="ls-label col-md-6 col-xs-12">'+
			    '  	<b class="ls-label-text">Nome do cliente</b>'+
			    '  	<input type="text" id="nomeCliente" class="ls-field col-md-6" disabled>'+
		      	'</label>'+
		      	'<label class="ls-label col-md-6 col-xs-12">'+
			    '  	<b class="ls-label-text">Saldo Devedor</b>'+
			    '  	<div class="ls-prefix-group">'+
			  	'	<span class="ls-label-text-prefix">R$</span>'+
			    '  	<input type="text" id="saldoCliente" class="ls-field col-md-6" disabled>'+
			    '  	</div>'+
		      	'</label>'+
			  	'<label class="ls-label col-md-6 col-xs-12">'+
			  	'  	<b class="ls-label-text">Valor do produto</b>'+
			  	'  	<div class="ls-prefix-group">'+
			  	'	<span class="ls-label-text-prefix">R$</span>'+
			  	'  	<input type="text" name="valorCompra" id="valorCompra" onfocusout="Movimentos.verificarUsoSaldo(this.value);" placeholder="Valor do produto ou serviço Ex : 500,00" class="ls-field col-md-6" onfocusout="Movimentos.verificarUsoSaldo()" required>'+
			  	'  	</div>'+
		      	'</label>'+
		      	'<label class="ls-label col-md-6 col-xs-12">'+
			  	'  	<b class="ls-label-text">Abater do saldo ?</b>'+
				'    <input type="checkbox" name="usarSaldo" id="usarSaldo">'+
		      	'</label>';
    			break;
    		//fornecedor
    		case'2':
    			document.getElementById('containercpf_cnpj').innerHTML = ""+
    			'<b class="ls-label-text">CNPJ (Somente números)</b>'+
  			    '<input type="number" maxlength="14" name="cpf_cnpj" id="cpf_cnpj" onfocusout="Movimentos.buscaIdcliente_fornecedor(this.value)" class="ls-field">';
  			  	document.getElementById('container_valores').innerHTML = ""+
  			  	'<label class="ls-label col-md-6 col-xs-12">'+
			    '  	<b class="ls-label-text">Nome do fornecedor</b>'+
			    '  	<input type="text" id="nomeCliente" class="ls-field col-md-6" disabled>'+
		      	'</label>'+
		      	'<label class="ls-label col-md-6 col-xs-12">'+
			    '  	<b class="ls-label-text">Saldo Devedor</b>'+
			    '  	<input type="text" id="saldoCliente" class="ls-field col-md-6" disabled>'+
		      	'</label>'+
			  	'<label class="ls-label col-md-6 col-xs-12">'+
			  	'  	<b class="ls-label-text">Valor da movimentação</b>'+
			  	'  	<div class="ls-prefix-group">'+
			  	'	<span class="ls-label-text-prefix">-</span>'+
			  	'  	<input type="text" name="valor" id="valor" onfocusout="Movimentos.onlyNumbers(this)" placeholder="Exemplo: 500,39" class="ls-field col-md-6" onfocusout="Movimentos.verificarUsoSaldo()" required>'+
			  	'	<span class="ls-label-text-prefix">Saída</span>'+
			  	'  	</div>'+
		      	'</label>';
    			break;
    		//outros
    		case'0':
    			$("#containercpf_cnpj").find('input').attr('disabled', 'disabled');
    			document.getElementById('container_valores').innerHTML = ""+
  			  	'<label class="ls-label col-md-6 col-xs-12">'+
		      	'<b class="ls-label-text">Valor da movimentação (Entrada ou saída)</b>'+
		      	'<input type="text" name="valor" id="valor" onfocusout="Movimentos.onlyNumbers(this)" placeholder="Exemplo: 500,39" class="ls-field col-md-6" required>'
		      	'</label>';
    			break;
    		}
    	}
    	
    	Movimentos.floatToMoney = function(price){
    		price = new String(price).replace('.', ',')
    		if(price < 0) return '-R$ '+price;
    		else return "R$ "+price;
    	}
    	
    	Movimentos.tratarForm = function(data){
    		if(!!data.valorCompra){
    			data.valorCompra = data.valorCompra.replace(',', '.');	
    			if(data.usarSaldo == 'on') data.saldo = parseFloat($("#saldoCliente").val().replace('R$', '').replace(',', '.')) - parseFloat(data.valorCompra);
    			data.valor = data.valorCompra;
        		delete data.valorCompra;
    		}else{
    			data.valor = data.valor.replace(',','.');
    			data.valor = parseFloat(data.valor).toFixed(2);
    		}
    		
    		//se for uma movimentação proveniente de fornecedor, ele tem que ser negativo
    		if(data.tipo_mov == '2'){
    			data.valor = '-'+data.valor;
    		}
    		
    		return data;
		}
    	
    	Movimentos.verificarUsoSaldo = function(){
    		var preco = parseFloat(document.getElementById('valorCompra').value.replace(',','.'));
    		var saldo = parseFloat(document.getElementById('saldoCliente').value.replace('R$', '').replace(',', '.'));
    		if(preco > saldo){
    			document.getElementById('usarSaldo').setAttribute('disabled', 'disabled')
    		}else{
    			document.getElementById('usarSaldo').removeAttribute('disabled');
    		}
    	}
    	
    	Movimentos.onlyNumbers = function(element){
    		var reg = /([0-9]{1,}),([0-9]{2}$)/g;
    		if(!reg.test(element.value)) element.value = '';
    	}
    	
    	Movimentos.selecionarPeriodo  = function(valor){
    		if(valor != '7'){
    			$("#range_start").attr('disabled', 'disabled');
    			$("#range_end").attr('disabled', 'disabled');
    		}else if(valor == '7'){
    			$("#range_start").removeAttr('disabled', 'disabled');
    			$("#range_end").removeAttr('disabled', 'disabled');
    		}
    	}
    	
    	$("#addMov").submit(function(e) {
    		e.preventDefault();
    		
    		var formData = $("#addMov").serializeArray();
    		var data = {};
    		
    		for(i in formData){
    			data[formData[i].name] = formData[i].value;
    		}
    		data = Movimentos.tratarForm(data);
    		
    		var url = "http://localhost:8080/app/movimentacao?metodo=cadastrar";
    	    $.ajax({
    				type: "GET",
    				url: url,
    				data: data,
    				success: function(data){
    					$("#addMov").each (function(){
    			            this.reset();
    			        });
    				    locastyle.modal.close();  // fecha a modal
    		    	    setTimeout(function(){location.reload()}, 500);
    				}
    			});
    	});
    	
	    $(function () {
	    	$.date = function(dateObject) {
	            var d = new Date(dateObject);
	            var dia = d.getDate();
	            var mes = d.getMonth() + 1;
	            var ano = d.getFullYear();
	            if (dia < 10) {
	                dia = "0" + dia;
	            }
	            if (mes < 10) {
	                mes = "0" + mes;
	            }
	            var date = dia + "/" + mes + "/" + ano;
	            return date;
	        };
	        
	        //pega todas as categorias e popula os selects com os options
	        $.ajax({
	    		url:'http://localhost:8080/app/categoria',
	    		method:'GET',
	    		cache:false,
	    		data:{metodo:'listar'},
	    		success:function(data){
	    			var teste = '';
	    			for(i in data){
	    				teste+='<option value="'+data[i].idcategoria+'">'+data[i].nome+'</option>';
	    			}
	    			$(".select_categoria").append(teste);
	    		}
	        });
	        
	    	$.ajax({
	    		url:'http://localhost:8080/app/movimentacao',
	    		method:'GET',
	    		cache:false,
	    		data:{metodo:'listar'},
	    		beforeSend: function(){
	    			//cria o loader
	    			BbnLoading.createSpin();
	    		},
	    		success: function(dados){
	    			
	    			//mata o loader no callback de sucesso da requisição ajax
	    			BbnLoading.removeModalDiv();
	    			
	    			if(dados.length <= 0){
	    				//manipulação do dom para
	    				var node = document.createElement("p");
	    				var textnode = document.createTextNode("Não há dados para serem listados");
	    				node.appendChild(textnode); 
	    				document.getElementById('containerTbl').appendChild(node);
	    			}
	    			else
	        			for(i in dados){
	        				//console.log(dados);
	        				id = dados[i].id;
	        				var newRow = $("<tr>");
	        			    var cols = "";
	        			    
	        			    valorAtual = (dados[i].valor < 0) ? '<span style="color:red">'+Movimentos.floatToMoney(dados[i].valor.toFixed(2))+'</span>' : '<span style="color:green">'+Movimentos.floatToMoney(dados[i].valor.toFixed(2))+'</span>';
	        			    
	        			    cols += '<td>'+dados[i].dsc+'</td>';
	        			    cols += '<td>'+dados[i].nome_categoria+'</td>';
	        			    cols += '<td>'+dados[i].cliente_fornecedor+'</td>';
	        			    cols += '<td>'+valorAtual+'</td>';
	        			    cols += '<td>'+$.date(dados[i].data_cadastro)+'</td>';
	        			    cols += '<td>';
	        			    cols += '<a href="#" onclick="editarRegistro('+id+')" class="ls-btn-sm">Editar</a>';
	        			    cols += '<a href="#" onclick="cancelarRegistro('+id+')" class="ls-btn-primary-danger ls-btn-sm">Deletar</a>';
	        			    cols += '</td>';
	
	        			    newRow.append(cols);
	        			    $("#tabela").append(newRow);
	        			}		
	    		} 
	    	});
	    	
	    	$("#editMov").submit(function(e) {
	    	    var url = "http://localhost:8080/app/movimentacao?metodo=atualiza";
	    	    $.ajax({
	    				type: "GET",
	    				url: url,
	    				data: $("#editMov").serialize(),
	    				success: function(data){
	    				    locastyle.modal.close();  // fecha a modal
	    		    	    location.reload();        // carrega pagina
	    				}
	    			});
	    	    e.preventDefault();
	    	});
	    	
	    	$("#filtros").submit(function(e) {
	    	    var url = "http://localhost:8080/app/movimentacao?metodo=filtrar";
	    	    $.ajax({
	    				type: "GET",
	    				url: url,
	    				data: $("#filtros").serialize(),
	    				success: function(data){
	    				    console.log(data);
	    				}
	    			});
	    	    e.preventDefault();
	    	}); 
	    	
	    	//Pega os totais do balanço geral
	    	var urlTotais = "http://localhost:8080/app/movimentacao?metodo=getTotais";
	    	$.ajax({
	    	type: "GET",
	    		url: urlTotais,
	    		success: function(data){
	    		   	var entradas = 0;
					var saidas = 0;
					var total = 0;
	    			for(i in data){
	    				entradas += data[i].entrada;
	    				saidas += data[i].saida;
	    		   	}

	    			total = entradas - saidas;
	    			entradas = Movimentos.floatToMoney(new String(entradas.toFixed(2)));
	    			saidas = Movimentos.floatToMoney(new String(saidas.toFixed(2)));
	    			
	    			document.getElementById('entradasGerais').innerHTML = entradas;
	    			document.getElementById('saidasGerais').innerHTML = "-"+saidas;
	    			document.getElementById('totalGerais').innerHTML = (total < 0) ? '<span class="ls-color-danger">'+Movimentos.floatToMoney(new String(total.toFixed(2)))+'</span>' : Movimentos.floatToMoney(new String(total.toFixed(2)));
	    		}
	    	});
	    	//Pega os totais do balanço geral
	    	var urlTotaisCurrentMonth = "http://localhost:8080/app/movimentacao?metodo=getTotaisCurrentMonth";
	    	$.ajax({
	    	type: "GET",
	    		url: urlTotaisCurrentMonth,
	    		success: function(data){
	    		   	var entradas = 0;
					var saidas = 0;
					var total = 0;
	    			for(i in data){
	    				entradas += data[i].entrada;
	    				saidas += data[i].saida;
	    		   	}

	    			total = entradas - saidas;
	    			entradas = Movimentos.floatToMoney(new String(entradas.toFixed(2)));
	    			saidas = Movimentos.floatToMoney(new String(saidas.toFixed(2)));
	    			
	    			document.getElementById('entradasCurrentMonth').innerHTML = entradas;
	    			document.getElementById('saidasCurrentMonth').innerHTML = "-"+saidas;
	    			document.getElementById('totaisCurrentMonth').innerHTML = (total < 0) ? '<span class="ls-color-danger">'+Movimentos.floatToMoney(new String(total.toFixed(2)))+'</span>' : Movimentos.floatToMoney(new String(total.toFixed(2)));
	    		}
	    	});
	    	
	    });

    	// função editar
    	function editarRegistro(id) {
        	var url = 'http://localhost:8080/app/movimentacao';
        	$.ajax ({
        		url: url+"?metodo=editar&id="+id,
    	        type:'GET',
    	        success:function(data){
    	        	for(i in data){
	    	        	$("#tipo_movEditar").val(data[i].tipo_movimentacao);
	    	        	$("#nomeClienteEditar").val(data[i].cliente_fornecedor);
	    	        	$("#valorEditar").val(data[i].valor);
	    	        	$("#categoriaEditar").val(data[i].nome_categoria);
	    	        	$("#dscEditar").val(data[i].dsc);
	    	        	$("#id").val(data[i].id);
    	        	}
    	        }
        	});
        	locastyle.modal.open("#editMovimento");
          }
    	function cancelarRegistro(id) {
        	var url = 'http://localhost:8080/app/movimentacao';
        	$.ajax ({
        		url: url+"?metodo=cancelar&id="+id,
    	        type:'GET',
				beforeSend: function(){
	    			//cria o loader
	    			BbnLoading.createSpin();
	    		},
    	        success:function(data){
    	        	//cria o loader
	    			BbnLoading.removeModalDiv();
    	        	
    	        	if(data.result == 'OK'){
    	        		location.reload();
    	        	}
            	}
    	    });
        }
    </script>
  </body>
</html>