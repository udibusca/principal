<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="ls-theme-indigo">
<head>
<title>Cadastro de Usuário | i9 Finanças</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="Sistema financeiro">
<link href="css/estiloGfinancas.css" rel="stylesheet" type="text/css">
<link href="javascripts/bbnloading.css" rel="stylesheet" type="text/css">
<link rel="icon" sizes="192x192" href="images/ico-boilerplate.png">
<link rel="apple-touch-icon" href="images/ico-boilerplate.png">
<link href="css/metro/crimson/jtable.css" rel="stylesheet"
	type="text/css" />
<link href="css/jquery-ui-1.10.3.custom.css" rel="stylesheet"
	type="text/css" />

<script src="javascripts/jquery-1.8.2.js" type="text/javascript"></script>
<script src="javascripts/jquery-ui-1.10.3.custom.js"
	type="text/javascript"></script>
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
		<span class="ls-show-sidebar ls-ico-menu"></span> <a href="javascript:history.back()"
			class="ls-go-next"><span class="ls-text">Voltar</span></a>
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
					<li><a href="#" class="ls-ico-cog" title="Cadastros">Cadastros</a>
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
		<h1 class="ls-title-intro ls-ico-text2">Usuário</h1>
		<!-- Migalhas de pão -->
		<ol class="ls-breadcrumb">
			<li><a href="index.jsp">Início</a></li>
			<li>Usuário</li>
		</ol>
		<!-- Filtros/cadastro -->
		<div class="ls-box-filter">
			<form action="" class="ls-form ls-form-inline ls-float-left">
				<label class="ls-label col-md-8 col-sm-8">
				      <input type="text" id="q" name="q" aria-label="Faça sua busca por usuário" placeholder="Nome do usuário" required="" class="ls-field">
				</label>
			    <div class="ls-actions-btn">
			      <input type="submit" value="Pesquisar" class="ls-btn" title="Buscar">
			    </div>				
			</form>
			<label class="ls-float-right">
			<button data-ls-module="modal" data-target="#myAwesomeModal"
				class="ls-btn-primary">
				<span class="ls-ico-user-add"> </span> Adicionar usuário
			</button>			   
			</label>
		</div>
		<!-- Grid de registros -->
		<div id="containerTbl">
			<table class="ls-table ls-table-striped">
				<thead>
					<tr>
					    <th>#</th>
						<th>Nome</th>
						<th>E-mail</th>
						<th>Usuário</th>
						<th>Status</th>
						<th></th>
					</tr>
				</thead>
				<tbody id="tabela"></tbody>
			</table>
		</div>
	</div>

	<!-- Modal de cadastro -->
	<div class="ls-modal" id="myAwesomeModal">
		<form id="cusuario" method="GET"
			class="ls-form ls-form-horizontal row">
			<div class="ls-modal-large">
				<div class="ls-modal-header">
					<button data-dismiss="modal">&times;</button>
					<h4 class="ls-modal-title">Cadastrar novo usuário</h4>
				</div>
				<div class="ls-modal-body">
					<fieldset>	
						<label class="ls-label col-md-4 col-xs-12"> <b
							class="ls-label-text">Nome do usuário</b> <input type="text"
							name="nome" placeholder="Digite o seu nome"
							class="ls-field" required>
						</label>
						<label class="ls-label col-md-4 col-xs-12"> <b
							class="ls-label-text">Email do usuário</b> <input type="email"
							name="email" placeholder="Digite o seu email" class="ls-field"
							required>
						</label>
						<label class="ls-label col-md-4 col-xs-12"> <b
							class="ls-label-text">Usuário</b> <input type="text"
							name="usuario" placeholder="Digite seu usuário" class="ls-field"
							required>
						</label>
						<label class="ls-label col-md-4 col-xs-12"> <b
							class="ls-label-text">Senha</b> <input type="password"
							name="senha" placeholder="Digite sua senha"
							class="ls-field" required>
						</label>
						<input type="hidden" name="ativo" value="1"> <!-- Passa o usuario sempre ativo no cadastro -->
					</fieldset>
				</div>
				<div class="ls-modal-footer ls-txt-right ls-actions-btn">
					<button type="submit" class="ls-btn-primary">Salvar</button>
					<button type="reset" class="ls-btn">Limpar</button>
					<button class="ls-btn-danger" data-dismiss="modal">Cancelar</button>
				</div>
			</div>
		</form>
	</div>
	<!-- Modal de editar -->
	<div class="ls-modal" id="modalEdita">
		<form id="cusuarioedita" method="GET"
			class="ls-form ls-form-horizontal row">
			<div class="ls-modal-large">
				<div class="ls-modal-header">
					<button data-dismiss="modal">&times;</button>
					<h4 class="ls-modal-title"> Editar usuário </h4>
				</div>
				<div class="ls-modal-body">
					<fieldset>
                         <label class="ls-label col-md-4 col-xs-12"> <b
							class="ls-label-text">Código</b> <input type="text"
							name="idusuario" id="idusuario" class="ls-field" readonly="readonly">
						</label>
						<!-- <input type="hidden" name="idusuario" id="idusuario"> -->				
						<label class="ls-label col-md-4 col-xs-12"> <b
							class="ls-label-text">Nome do usuário</b> <input type="text"
							name="nome" id="nome" placeholder="Digite o seu nome"
							class="ls-field" required>
						</label>
						<label class="ls-label col-md-4 col-xs-12"> <b
							class="ls-label-text">Email do usuário</b> <input type="email"
							name="email" id="email" placeholder="Digite o seu email" class="ls-field"
							required>
						</label>
						<label class="ls-label col-md-4 col-xs-12"> <b
							class="ls-label-text">Usuário</b> <input type="text"
							name="usuario" id="usuario" placeholder="Digite seu usuário" class="ls-field"
							required>
						</label>
						<input type="hidden" id="senha" name="senha">
						<input type="hidden" id="ativo" name="ativo" value="1"> <!-- Passa o usuario sempre ativo no cadastro -->
					</fieldset>
				</div>
				<div class="ls-modal-footer ls-txt-right ls-actions-btn">
					<button type="submit" class="ls-btn-primary">Salvar</button>
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

<!-- Modal sucesso! -->

<div class="ls-modal" id="cadastroSucesso">
  <div class="ls-modal-box">
    <div class="ls-modal-header">
      <button data-dismiss="ls-dismissable">&times;</button>
      <h4 class="ls-modal-title">Sucesso</h4>
    </div>
    <div class="ls-modal-body" id="myModalBody">
      <p>Cadastrado com sucesso!</p>
    </div>
    <div class="ls-modal-footer">
      <button class="ls-btn ls-float-right" data-dismiss="ls-dismissable"> Não </button>
      <button id="confirma" type="submit" class="ls-btn-primary ls-float-right"> Sim </button>
    </div>
  </div>
</div>



	<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script> -->
	<script src="javascripts/libs/jquery-2.1.0.min.js"
		type="text/javascript"></script>
	<script src="javascripts/locastyle.js" type="text/javascript"></script>
	<script src="javascripts/bbnloading.js" type="text/javascript"></script>
	<script>
        $(function () { 
        	$.ajax({
        		url:'http://localhost:8080/app/usuario',
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
	        				id = dados[i].idusuario;
	        				var newRow = $("<tr>");
	        			    var cols = "";
	
	        			    cols += '<td>'+id+'</td>';
	        			    cols += '<td>'+dados[i].nome+'</td>';
	        			    cols += '<td>'+dados[i].email+'</td>';
	        			    cols += '<td>'+dados[i].usuario+'</td>';
	        			    if(dados[i].ativo == 1 ){
	        			    	cols += '<td>Ativo</td>';	
	        			    }else{
	        			    	cols += '<td>Desativado</td>';
	        			    }
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
    	$("#cusuario").submit(function(e) {
    	    var url = "http://localhost:8080/app/usuario?metodo=cadastrar";
    	    $.ajax({
    				type: "GET",
    				url: url,
    				data: $("#cusuario").serialize(),
    				success: function(data){
    					$('#cusuario').each (function(){
    			            this.reset();
    			        });
    				    locastyle.modal.close();  // fecha a modal
    		    	    location.reload();        // carrega pagina
    				}
    			});
    	    e.preventDefault();
    	});
        // função excluir
		function apagarRegistro(id) {
        	var url = 'http://localhost:8080/app/usuario';
        	$.ajax ({
        		url: url+"?metodo=excluir&idusuario="+id,
		        type:'GET',
		        success:function(res){
		        	if (res != 'success') {
		        		//locastyle.modal.open("#cadastroSucesso");
		        		alert("Registro apagado com sucesso.");
		        		history.go(0);
		        		}
		        	}
        	});
        }
        // função editar
		function editarRegistro(id) {
        	var url = 'http://localhost:8080/app/usuario';
        	//locastyle.modal.open("#modalEdita");
        	$.ajax ({
        		url: url+"?metodo=editar&idusuario="+id,
		        type:'GET',
		        success:function(data){ 
		        		for(i in data){
		        			$("#idusuario").val(data[i].idusuario)
		        			$("#nome").val(data[i].nome)
		        			$("#email").val(data[i].email)
		        			$("#usuario").val(data[i].usuario)
		        			$("#senha").val(data[i].senha)
		        			$("ativo").val(data[i].ativo)
		        			//console.log(data);
		        		}
		        }
        	});
        	locastyle.modal.open("#modalEdita");
          }
         // função atualizar
    	$("#cusuarioedita").submit(function(e) {
    	    var url = "http://localhost:8080/app/usuario?metodo=atualiza";
    	    $.ajax({
    				type: "GET",
    				url: url,
    				data: $("#cusuarioedita").serialize(),
    				success: function(data){
    				    locastyle.modal.close();  // fecha a modal
    		    	    location.reload();        // carrega pagina
    				}
    			});
    	    e.preventDefault();
    	});        
  </script>
</body>
</html>