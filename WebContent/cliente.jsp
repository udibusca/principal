<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>	
<!DOCTYPE html>
<html class="ls-theme-indigo">
<head>
<title>Cadastro de Clientes | i9 Finanças</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="Sistema financeiro">
<link href="css/estiloGfinancas.css" rel="stylesheet" type="text/css">
<link href="javascripts/bbnloading.css" rel="stylesheet" type="text/css">
<link rel="icon" sizes="192x192" href="images/ico-boilerplate.png">
<link rel="apple-touch-icon" href="images/ico-boilerplate.png">
<script src="javascripts/money-blur.js" type="text/javascript"></script>
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

		<!-- Barra de Notificações -->

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
		<span class="ls-show-sidebar ls-ico-menu"></span> <a href="javascript:history.back()" class="ls-go-next"><span class="ls-text">Voltar</span></a>
		<!-- Nome do produto/marca com sidebar -->
		<h1 class="ls-brand-name">
		<a href="index.jsp" class="ls-ico-lamp">
		   <small>Modulo financeiro</small> i9 Finanças
			</a>
		</h1>

		<!-- Nome do produto/marca sem sidebar quando for o pre-painel  -->
	</div>


	<aside class="ls-sidebar">

		<div class="ls-sidebar-inner">
			<a href="" class="ls-go-prev"><span class="ls-text">Voltar</span></a>

			<nav class="ls-menu">
				<ul>
					<li><a href="index.jsp" class="ls-ico-dashboard"
						title="Dashboard">Dashboard</a></li>
					<li><a href="movimentos.jsp" class="ls-ico-trophy"
						title="Movimentos">Movimentos</a></li>
      <!-- <li><a href="relatorioMensal.jsp" class="ls-ico-stats" title="Relatórios da revenda">Relatório mensal</a></li>-->
					<li><a href="#" class="ls-ico-cog" title="Configurações">Cadastros</a>
						<ul>
							<li><a href="cliente.jsp">Cliente</a></li>
							<li><a href="fornecedor.jsp">Fornecedor</a></li>
							<li><a href="categoria.jsp">Categoria</a></li>
							<li><a href="usuario.jsp">Usuario</a></li>
						</ul></li>
				</ul>
			</nav>


		</div>
	</aside>

	<main class="ls-main ">
	<div class="container-fluid">
		<h1 class="ls-title-intro ls-ico-user">Cliente</h1>
		<!-- Migalhas de pão -->
		<ol class="ls-breadcrumb">
			<li><a href="index.jsp">Início</a></li>
			<li>Clientes</li>
		</ol>
		<!-- Filtros/cadastro -->
		<div class="ls-box-filter">
			<form action="" class="ls-form ls-form-inline ls-float-left">
				<label class="ls-label col-md-8 col-sm-8">
				      <input type="text" id="buscaQ" name="buscaQ" aria-label="Faça sua busca por cliente" placeholder="Nome do cliente" required="" class="ls-field">
				</label>
			    <div class="ls-actions-btn">
			      <input type="submit" value="Pesquisar" class="ls-btn" title="Buscar">
			    </div>				
			</form>
			<label class="ls-float-right">
			<button data-ls-module="modal" data-target="#myAwesomeModal"
				class="ls-btn-primary">
				<span class="ls-ico-user-add"> </span> Adicionar cliente
			</button>			   
			</label>
		</div>	
		<!-- Grid de registros -->
		<div id="containerTbl">
			<table class="ls-table ls-table-striped">
				<thead>
					<tr>
						<th>N°Registro</th>				
						<th>CPF</th>
						<th>Nome</th>
						<th>Dta Cadastro</th>
						<th></th>
					</tr>
				</thead>
				<tbody id="tabela"></tbody>
			</table>
		</div>
	</div>

	<!-- Modal de cadastro cliente -->
	<div class="ls-modal" id="myAwesomeModal">
		<form id="ccliente" method="GET"
			class="ls-form ls-form-horizontal row">
			<div class="ls-modal-large">
				<div class="ls-modal-header">
					<button data-dismiss="modal">&times;</button>
					<h4 class="ls-modal-title">Cadastrar novo cliente</h4>
				</div>
				<div class="ls-modal-body">
					<fieldset>
						<label class="ls-label col-md-4 col-xs-12"> 
						<b class="ls-label-text">CPF (Somente Números)</b> <input type="text" onfocusout="validaCampoCpf(this, false)" name="cpf" placeholder="00000000000" maxlength="11">
						</label>					
						<label class="ls-label col-md-8 col-xs-12">
						<b class="ls-label-text">Nome</b> <input type="text" name="nome"
							placeholder="Nome completo" class="ls-field" required>
						</label>
						<label class="ls-label col-md-4 col-xs-12"> 
						<b class="ls-label-text">CEP</b> <input type="text" name="cep"
							placeholder="CEP" class="ls-field" required>
						</label>						
						<label class="ls-label col-md-6 col-xs-12"> 
						<b class="ls-label-text">Endereço</b> <input type="text" name="endereco"
							placeholder="Endereço" class="ls-field" required>
						</label>
						<label class="ls-label col-md-2 col-xs-12"> 
						<b class="ls-label-text">Numero</b> <input type="text" name="numero"
							placeholder="Numero" class="ls-field" required>
						</label>
						<label class="ls-label col-md-4 col-xs-12"> 
						<b class="ls-label-text">Complemento</b> <input type="text" name="complemento"
							placeholder="Complemento" class="ls-field" required>
						</label>
						<label class="ls-label col-md-4 col-xs-12"> 
						<b class="ls-label-text">Cidade</b> <input type="text" name="cidade"
							placeholder="Cidade" class="ls-field" required>
						</label>
						<label class="ls-label col-md-4 col-xs-12"> 
						<b class="ls-label-text">Bairro</b> <input type="text" name="bairro"
							placeholder="Bairro" class="ls-field" required>
						</label>						
						<label class="ls-label col-md-4 col-xs-12">
						<b class="ls-label-text">Valor Compra/Saldo Devedor</b>
							<div class="ls-prefix-group">
								<span class="ls-label-text-prefix">R$</span>
								<input type="text" name="saldo" onkeypress="return(MascaraMoeda(this,'.',',',event))" 
								class="ls-field" required>
							</div><br/> <!-- onfocusout="Movimentos.onlyNumbers(this)" -->
							<a href="#" class="ls-tooltip-right" 
							aria-label="Valor corresponde ao saldo devedor ou o valor da compra do cliente ao efetuar uma compra/movimentação">Info</a>
						</label>																																										 
					</fieldset>
				<input type="hidden" name="ativo" value="1"> <!-- Passa o usuario sempre ativo no cadastro -->
				</div>
				<input type="hidden" id="ativo" name="ativo" value="1">
				<div class="ls-modal-footer ls-txt-right ls-actions-btn">
					<button type="submit" id="salvarCliente" class="ls-btn-primary">Salvar</button>
					<button type="reset" class="ls-btn">Limpar</button>
					<button class="ls-btn-danger" data-dismiss="modal">Cancelar</button>
				</div>
			</div>
		</form>
	</div>
	
	<!-- Modal de editar cliente -->
	<div class="ls-modal" id="modalEdita">
		<form id="cclienteedita" method="GET"
			class="ls-form ls-form-horizontal row">
			<div class="ls-modal-large">
				<div class="ls-modal-header">
					<a data-dismiss="modal">&times;</a>
					<h4 class="ls-modal-title">Editar cliente</h4>
				</div>
				<div class="ls-modal-body">
					<fieldset>
					<label class="ls-label col-md-4 col-xs-12"> <b
							class="ls-label-text">N°Registro</b>
							<input type="text" name="idcliente" id="idcliente" class="ls-field" readonly="readonly">
						</label>
						<label class="ls-label col-md-4 col-xs-12"> <b
							class="ls-label-text">CPF (Somente números)</b> <input type="text" name="cpf" id="cpf" onfocusout="validaCampoCpf(this, true)" class="ls-mask-cpf" placeholder="00000000000">
						</label> 
						<label class="ls-label col-md-4 col-xs-12"> <b
							class="ls-label-text">Nome</b> <input type="text" name="nome" id="nome"
							placeholder="Nome completo" class="ls-field" required>
						</label>
						<label class="ls-label col-md-4 col-xs-12"> 
						<b class="ls-label-text">CEP</b> <input type="text" name="cep" id="cep"
							placeholder="CEP" class="ls-field" required>
						</label>						
						<label class="ls-label col-md-6 col-xs-12"> 
						<b class="ls-label-text">Endereço</b> <input type="text" name="endereco" id="endereco"
							placeholder="Endereço" class="ls-field" required>
						</label>
						<label class="ls-label col-md-2 col-xs-12"> 
						<b class="ls-label-text">Numero</b> <input type="text" name="numero" id="numero"
							placeholder="Numero" class="ls-field" required>
						</label>
						<label class="ls-label col-md-4 col-xs-12"> 
						<b class="ls-label-text">Complemento</b> <input type="text" name="complemento" id="complemento"
							placeholder="Complemento" class="ls-field" required>
						</label>
						<label class="ls-label col-md-4 col-xs-12"> 
						<b class="ls-label-text">Cidade</b> <input type="text" name="cidade" id="cidade"
							placeholder="Cidade" class="ls-field" required>
						</label>
						<label class="ls-label col-md-4 col-xs-12"> 
						<b class="ls-label-text">Bairro</b> <input type="text" name="bairro" id="bairro"
							placeholder="Bairro" class="ls-field" required>
						</label>						
						<label class="ls-label col-md-4 col-xs-12"> <b class="ls-label-text">Saldo</b>
							<div class="ls-prefix-group">
								<span class="ls-label-text-prefix">R$</span>
								<input type="text" name="saldo" id="saldo" onkeypress="return(MascaraMoeda(this,'.',',',event))" class="ls-field" required>
							</div>
						</label> 
					</fieldset>
				</div>
				<input type="hidden" id="ativo" name="ativo" value="1">
				<input type="hidden" id="endereco_idendereco" name="endereco_idendereco" value="0">
				<div class="ls-modal-footer ls-txt-right ls-actions-btn">
					<button type="submit" id="editarCliente" class="ls-btn-primary">Salvar</button>
					<button class="ls-btn-danger" data-dismiss="modal">Cancelar</button>
				</div>
			</div>
		</form>
	</div>
	</main>
	<aside class="ls-notification">
		<nav class="ls-notification-list" id="ls-feedback-curtain"
			style="left: 1796px;">
			<h3 class="ls-title-2">Ajuda</h3>
			<ul>
				<li><a href="#">&gt; Manual</a></li>
			</ul>
		</nav>
	</aside>

	<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script> -->
	<script src="javascripts/libs/jquery-2.1.0.min.js" type="text/javascript"></script>
	<script src="javascripts/locastyle.js" type="text/javascript"></script>
	<script src="javascripts/bbnloading.js" type="text/javascript"></script>
	<script>
	
	var Movimentos = {};
	
	Movimentos.floatToMoney = function(price){
		price = new String(price).replace('.', ',');
		return price;
	}
	
	Movimentos.onlyNumbers = function(element){
		var reg = /([0-9]{1,}),([0-9]{2}$)/g;
		if(!reg.test(element.value)) element.value = '';
	}
	
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
	
	
	$(document).ready(function() {
		$.ajax({
		url : 'http://localhost:8080/app/cliente',
		method : 'GET',
		cache : false,
		data : {metodo : 'listar'},
		beforeSend: function(){		
			//cria o loader
			BbnLoading.createSpin();
		},
		success : function(data) {
			
			//mata o loader no callback de sucesso da requisição ajax
			BbnLoading.removeModalDiv();
			
			if(data.length <= 0){
				//manipulação do dom para 
				var node = document.createElement("p");
				var textnode = document.createTextNode("Não há dados para serem listados");
				node.appendChild(textnode); 
				document.getElementById('containerTbl').appendChild(node);
			}
			else
			for (i in data) {
				id = data[i].idcliente;
				var newRow = $("<tr>");
				var cols = "";
				cols += '<td>' + id+ '</td>';
				cols += '<td>' + data[i].cpf+ '</td>';
				cols += '<td>' + data[i].nome+ '</td>';
			    cols += '<td>'+$.date(data[i].data_cadastro)+'</td>';
				cols += '<td>';
				cols += '<a href="#" onclick="editarRegistro('+id+')" class="ls-btn-sm">Editar</a>';	
			    cols += '<a href="#" onclick="apagarRegistro('+id+')" class="ls-btn-primary-danger ls-btn-sm">Excluir</a>';
				cols += '</td>';
				newRow.append(cols);
				$("#tabela").append(newRow);
				}
			}
		});
	});
		// função cadastrar
		$("#ccliente").submit(function(e) {
			var url = "http://localhost:8080/app/cliente?metodo=cadastrar";
			var formData = $("#ccliente").serializeArray();
    		var data = {};
    		for(i in formData){
    			data[formData[i].name] = formData[i].value;
    		}
    		if(!!data.saldo){
    			data.saldo = data.saldo.replace(',', '.')
    		}
    		$.ajax({
				type : "GET",
				url : url,
				data : data,
				success : function(data) {
					locastyle.modal.close();
					location.reload();
				}
			});
			e.preventDefault();
		});		
		// função excluir
		function apagarRegistro(id) {
			var url = 'http://localhost:8080/app/cliente';
			$.ajax({
				url : url + "?metodo=excluir&idcliente="+id,
				type : 'GET',
				success : function(res) {
					if (res != 'success') {
						alert("Registro apagado com sucesso.");
						history.go(0);
					}
				}
			});
		}
        // função editar
		function editarRegistro(id) {
        	var url = 'http://localhost:8080/app/cliente';
        	$.ajax ({
        		url: url+"?metodo=editar&idcliente="+id,
		        type:'GET',
		        success:function(data){ 
		        		for(i in data){
		        			$("#idcliente").val(data[i].idcliente)
		        			$("#cpf").val(data[i].cpf)
		        			$("#nome").val(data[i].nome)	        			
 		        			$("#cep").val(data[i].endereco.cep)
		        			$("#endereco").val(data[i].endereco.endereco)
		        			$("#numero").val(data[i].endereco.numero)
		        			$("#complemento").val(data[i].endereco.complemento)
		        			$("#cidade").val(data[i].endereco.cidade)
		        			$("#bairro").val(data[i].endereco.bairro)
		        			$("#saldo").val(Movimentos.floatToMoney(data[i].saldo))
		        			$("#ativo").val(data[i].ativo)
		        			$("#endereco_idendereco").val(data[i].endereco_idendereco)
		        			
		        		}
		        }
        	});
        	locastyle.modal.open("#modalEdita");
          }
         // função atualizar
    	$("#cclienteedita").submit(function(e) {
    	    var url = 'http://localhost:8080/app/cliente?metodo=atualiza';
    	    
    	    var formData = $("#cclienteedita").serializeArray();
    		var data = {};
    		
    		for(i in formData){
    			data[formData[i].name] = formData[i].value;
    		}
    		if(!!data.saldo){
    			data.saldo = data.saldo.replace(',', '.')
    		}
    	    $.ajax({
    				type: "GET",
    				url: url,
    				data: data,
    				success: function(data){
    				    locastyle.modal.close();  // fecha a modal
    		    	    location.reload();        // carrega pagina
    				}
    			});
    	    e.preventDefault();
    	});
    	function validaCampoCpf(element, isEdit){
        	if(!validarCPF(element.value)){
        		element.className = 'invalidIdMovimento';
        		if(!isEdit) $("#salvarCliente").addClass('ls-disabled');
        		else $("#editarCliente").addClass('ls-disabled');
        	}else{
        		element.className = '';
        		if(!isEdit) $("#salvarCliente").removeClass('ls-disabled');
        		else $("#editarCliente").removeClass('ls-disabled');
        	}
        }
    	// Crédito: http://www.geradorcpf.com/javascript-validar-cpf.htm
    	function validarCPF(cpf) {  
    	    cpf = cpf.replace(/[^\d]+/g,'');    
    	    if(cpf == '') return false; 
    	    // Elimina CPFs invalidos conhecidos    
    	    if (cpf.length != 11 || 
    	        cpf == "00000000000" || 
    	        cpf == "11111111111" || 
    	        cpf == "22222222222" || 
    	        cpf == "33333333333" || 
    	        cpf == "44444444444" || 
    	        cpf == "55555555555" || 
    	        cpf == "66666666666" || 
    	        cpf == "77777777777" || 
    	        cpf == "88888888888" || 
    	        cpf == "99999999999")
    	            return false;       
    	    // Valida 1o digito 
    	    add = 0;    
    	    for (i=0; i < 9; i ++)       
    	        add += parseInt(cpf.charAt(i)) * (10 - i);  
    	        rev = 11 - (add % 11);  
    	        if (rev == 10 || rev == 11)     
    	            rev = 0;    
    	        if (rev != parseInt(cpf.charAt(9)))     
    	            return false;       
    	    // Valida 2o digito 
    	    add = 0;    
    	    for (i = 0; i < 10; i ++)        
    	        add += parseInt(cpf.charAt(i)) * (11 - i);  
    	    rev = 11 - (add % 11);  
    	    if (rev == 10 || rev == 11) 
    	        rev = 0;    
    	    if (rev != parseInt(cpf.charAt(10)))
    	        return false;       
    	    return true;   
    	}	
	</script>
</body>
</html>