<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="ls-theme-indigo">
  <head>
    <title>Cadastro de Categoria | i9 Finanças</title>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="description" content="Sistema financeiro">
    <link href="css/estiloGfinancas.css" rel="stylesheet" type="text/css">
    <link href="javascripts/bbnloading.css" rel="stylesheet" type="text/css">
    <link rel="icon" sizes="192x192" href="images/ico-boilerplate.png">
    <link rel="apple-touch-icon" href="images/ico-boilerplate.png">
    
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
						<% out.print(usuario);	%>
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

  <a href="javascript:history.back()"  class="ls-go-next"><span class="ls-text">Voltar</span></a>

  <!-- Nome do produto/marca com sidebar -->
    <h1 class="ls-brand-name">
      <a href="index.jsp" class="ls-ico-lamp">
        <small>Modulo financeiro</small>
        i9 Finanças
      </a>
    </h1>

  <!-- Nome do produto/marca sem sidebar quando for o pre-painel  -->
</div>


    <aside class="ls-sidebar">

  <div class="ls-sidebar-inner">
      <a href=""  class="ls-go-prev"><span class="ls-text">Voltar</span></a>

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
              <li><a href="usuario.jsp">Usuário</a></li>
            </ul>
          </li>
        </ul>
      </nav> 


  </div>
</aside>

    <main class="ls-main ">
	<div class="container-fluid">
		<h1 class="ls-title-intro ls-ico-text2">Categoria</h1>
		<!-- Migalhas de pão -->
		<ol class="ls-breadcrumb">
			<li><a href="index.jsp">Início</a></li>
			<li>Categoria</li>
		</ol>
		<!-- Filtros/cadastro -->
		<div class="ls-box-filter">
			<form action="" class="ls-form ls-form-inline ls-float-left">
				<label class="ls-label col-md-8 col-sm-8">
				      <input type="text" id="q" name="q" aria-label="Faça sua busca por categoria" placeholder="Nome do categoria" required="" class="ls-field">
				</label>
			    <div class="ls-actions-btn">
			      <input type="submit" value="Pesquisar" class="ls-btn" title="Buscar">
			    </div>				
			</form>
			<label class="ls-float-right">
			   <button data-ls-module="modal" data-target="#myAwesomeModal" class="ls-btn-primary"> <span class="ls-ico-plus"> </span> Adicionar categoria </button>
			</label>
		</div>
		<!-- Grid de registros -->
		<div id="containerTbl">
			<table class="ls-table ls-table-striped">
			  <thead>
			    <tr>
			      <th>Descrição</th>
			      <th>Dta Cadastro</th>
			      <th></th>
			      <th></th>
			    </tr>
			  </thead>
			  <tbody id="tabela">
			  </tbody>
			</table>
		</div>
	</div>

		<!-- Modal de cadastro categoria -->
		<div class="ls-modal" id="myAwesomeModal">
		<form  id="ccat" method="GET" class="ls-form ls-form-horizontal row">
		  <div class="ls-modal-large">
		    <div class="ls-modal-header">
		      <button data-dismiss="modal">&times;</button>
		      <h4 class="ls-modal-title">Cadastrar nova Categoria</h4>
		    </div>
		    <div class="ls-modal-body">
			  <fieldset>
			    <label class="ls-label col-md-4 col-xs-12">
				   <b class="ls-label-text">Nome da Categoria</b>
				   <input type="text" name="nome" placeholder="Descrição da despesa" class="ls-field" required>
			    </label>
			  </fieldset>
			  <input type="hidden" name="ativo" id="ativo" value="1"> <!-- Passa o usuario sempre ativo no cadastro -->
		    </div>
		    <div class="ls-modal-footer ls-txt-right ls-actions-btn">
		      <button type="submit" class="ls-btn-primary">Salvar</button>
		      <button type="reset" name="limpar" class="ls-btn">Limpar</button>
		      <button class="ls-btn-danger" data-dismiss="modal">Cancelar</button>
		    </div>
		  </div>
		 </form>
		</div>
	</main>

		<!-- Modal de editar categoria -->
		<div class="ls-modal" id="modalEdita">
		<form  id="ccategoriaedita" method="GET" class="ls-form ls-form-horizontal row">
		  <div class="ls-modal-large">
		    <div class="ls-modal-header">
		      <button data-dismiss="modal">&times;</button>
		      <h4 class="ls-modal-title">Editar Categoria</h4>
		    </div>
		    <div class="ls-modal-body">
			  <fieldset>
			    <label class="ls-label col-md-4 col-xs-12">
				   <b class="ls-label-text">Código</b>
				   <input type="text" name="idcategoria" id="idcategoria" class="ls-field" readonly="readonly">
			    </label>			  
			    <label class="ls-label col-md-4 col-xs-12">
				   <b class="ls-label-text">Nome da Categoria</b>
				   <input type="text" id="nome" name="nome" placeholder="Descrição da despesa" class="ls-field" required>
			    </label>
			  </fieldset>
              <input type="hidden" name="ativo" id="ativo" value="1">
		    </div>
		    <div class="ls-modal-footer ls-txt-right ls-actions-btn">
		      <button type="submit" class="ls-btn-primary">Salvar</button>
		      <button class="ls-btn-danger" data-dismiss="modal">Cancelar</button>
		    </div>
		  </div>
		 </form>
		</div>


    <aside class="ls-notification"> 
      <nav class="ls-notification-list" id="ls-feedback-curtain" style="left: 1796px;">
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
    
    
    $(document).ready(function(){
 	 $.ajax({
		url:'http://localhost:8080/app/categoria',
		method:'GET',
		cache:false,
		data:{metodo:'listar'},
		beforeSend: function(){
			
			//cria o loader
			BbnLoading.createSpin();
		},
		success: function(data){
			
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
			for(i in data){
				var id = data[i].idcategoria;
				var newRow = $("<tr>");
			    var cols = "";

			    cols += '<td>'+data[i].nome+'</td>';
			    cols += '<td>'+$.date(data[i].dtaCadastro)+'</td>';
			    cols += '<td></td>';
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
	$("#ccat").submit(function(e) {
	    var url = "http://localhost:8080/app/categoria?metodo=cadastrar";
	    $.ajax({
				type: "GET",
				url: url,
				data: $("#ccat").serialize(),
				success: function(data){
					$('#ccat').each (function(){
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
    	var url = 'http://localhost:8080/app/categoria';
    	$.ajax ({
    		url: url+"?metodo=excluir&idcategoria="+id,
	        type:'GET',
	        success:function(res){
	        	if (res != 'success') {
	        		alert("Registro apagado com sucesso.");
	        		history.go(0);
        		}
        	}
	    });
    }
    // função editar
	function editarRegistro(id) {
    	var url = 'http://localhost:8080/app/categoria';
    	$.ajax ({
    		url: url+"?metodo=editar&idcategoria="+id,
	        type:'GET',
	        success:function(data){ 
	        		for(i in data){
	        			$("#idcategoria").val(data[i].idcategoria);
	        			$("#nome").val(data[i].nome);
	        			$("#ativo").val(data[i].ativo);
	        		}
	        }
    	});
    	locastyle.modal.open("#modalEdita");
      }
    // função atualizar
	$("#ccategoriaedita").submit(function(e) {
	    var url = "http://localhost:8080/app/categoria?metodo=atualiza";
	    $.ajax({
				type: "GET",
				url: url,
				data: $("#ccategoriaedita").serialize(),
				success: function(data){
				    locastyle.modal.close();  // fecha a modal
		    	    location.reload();        // carrega pagina
				}
			});
	    e.preventDefault();
	});    
	</script>
<div class="ls-modal" id="confirmaExcluir">
  <div class="ls-modal-box">
    <div class="ls-modal-header">
      <button data-dismiss="ls-dismissable">&times;</button>
      <h4 class="ls-modal-title">Remover</h4>
    </div>
    <div class="ls-modal-body" id="myModalBody">
      <p>Deseja remover essa categoria?</p>
    </div>
    <div class="ls-modal-footer">
      <button class="ls-btn ls-float-right" data-dismiss="ls-dismissable">Não</button>
      <button id="confirma" type="submit" class="ls-btn-primary">Sim</button>
    </div>
  </div>
</div>
  </body>
</html>