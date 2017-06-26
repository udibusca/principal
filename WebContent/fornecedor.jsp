<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="ls-theme-indigo">
  <head>
    <title>Cadastro de fornecedores | i9 Finanças</title>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="description" content="Sistema financeiro">
    <link href="css/estiloGfinancas.css" rel="stylesheet" type="text/css">
    <link href="javascripts/bbnloading.css" rel="stylesheet" type="text/css">
    <link rel="icon" sizes="192x192" href="images/ico-boilerplate.png">
    <link rel="apple-touch-icon" href="images/ico-boilerplate.png">
    
    <script src="javascripts/libs/jquery.mask.js" type="text/javascript"></script>
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
		<h1 class="ls-title-intro ls-ico-bullhorn">Fornecedor</h1>
		<!-- Migalhas de pão -->
		<ol class="ls-breadcrumb">
			<li><a href="index.jsp">Início</a></li>
			<li>Fornecedor</li>
		</ol>
		<!-- Filtros/cadastro -->
		<div class="ls-box-filter">
			<form action="" class="ls-form ls-form-inline ls-float-left">
				<label class="ls-label col-md-8 col-sm-8">
				      <input type="text" id="q" name="q" aria-label="Faça sua busca por fornecedor" placeholder="Nome do fornecedor" required="" class="ls-field">
				</label>
			    <div class="ls-actions-btn">
			      <input type="submit" value="Pesquisar" class="ls-btn" title="Buscar">
			    </div>				
			</form>
			<label class="ls-float-right">
				<button data-ls-module="modal" data-target="#myAwesomeModal" class="ls-btn-primary"> <span class="ls-ico-user-add"> </span> Adicionar fornecedor</button>			   
			</label>
		</div>
		<!-- Grid de registros -->
		<div id="containerTbl">
			<table class="ls-table ls-table-striped">
			  <thead>
			    <tr>
			      <th>N°Registro</th>	    
			      <th>CNPJ</th>
			      <th>Nome Fantasia</th>
			      <th>Dta Cadastro</th>
			      <th></th>
			    </tr>
			  </thead>
			<tbody id="tabela"></tbody>
			</table>
		</div>	
	</div>

		<!-- Modal de cadastro fornecedor -->
		<div class="ls-modal" id="myAwesomeModal">
		<form  id="cfornecedor" method="GET" class="ls-form ls-form-horizontal row">
		  <div class="ls-modal-large">
		    <div class="ls-modal-header">
		      <a data-dismiss="modal">&times;</a>
		      <h4 class="ls-modal-title">Cadastrar novo Fornecedor</h4>
		    </div>
		    <div class="ls-modal-body">
			  <fieldset>
			    <label class="ls-label col-md-4 col-xs-12">
				   <b class="ls-label-text">CNJP (Somente números)</b>
				   <input type="text" name="cnpj" id="cnpj" onfocusout="validaCampoCnpj(this, false)" placeholder="0000000000000" maxlength="14">
			    </label>
			    <label class="ls-label col-md-8 col-xs-12">
			      <b class="ls-label-text">Nome Fantasia</b>
			      <input type="text" name="nome" placeholder="Nome completo" class="ls-field" required>
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
			     <input type="hidden" name="ativo" value="1">
			  </fieldset>		      
		    </div>
		    <div class="ls-modal-footer ls-txt-right ls-actions-btn">
		      <button type="submit" id="salvarFornecedor" class="ls-btn-primary">Salvar</button>
		      <button type="reset" class="ls-btn">Limpar</button>
		      <button class="ls-btn-danger" data-dismiss="modal">Cancelar</button>
		    </div>
		  </div>
		 </form>
		</div>
		
		
		<!-- Modal de editar fornecedor -->
		<div class="ls-modal" id="modalEdita">
		<form  id="editarfornecedor" method="GET" class="ls-form ls-form-horizontal row">
		  <div class="ls-modal-large">
		    <div class="ls-modal-header">
		      <a data-dismiss="modal">&times;</a>
		      <h4 class="ls-modal-title">Editar fornecedor</h4>
		    </div>
		    <div class="ls-modal-body">
			  <fieldset>
                <label class="ls-label col-md-2 col-xs-12"> 
                   <b class="ls-label-text">Código</b>
                   <input type="text"name="idfornecedor" id="idfornecedor" class="ls-field" readonly="readonly">
                </label>			  
			    <label class="ls-label col-md-4 col-xs-12">
				   <b class="ls-label-text">CNJP (Somente números)</b>
				   <input type="text" name="cnpj" id="cnpjEdit" class="ls-mask-cnjp" onfocusout="validaCampoCnpj(this, true)" placeholder="00000000000000" maxlength="14">
			    </label>
			    <label class="ls-label col-md-6 col-xs-12">
			      <b class="ls-label-text">Nome Fantasia</b>
			      <input type="text" name="nome" id="nome" placeholder="Nome completo" class="ls-field" required>
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
			    <input type="hidden" name="ativo" id="ativo" value="1">
			    <input type="hidden" id="idendereco" name="idendereco" value="0">
			  </fieldset>		      
		    </div>
		    <div class="ls-modal-footer ls-txt-right ls-actions-btn">
		      <button type="submit" id="editarFornecedor" class="ls-btn-primary">Salvar</button>
		      <button class="ls-btn-danger" data-dismiss="modal">Cancelar</button>
		    </div>
		  </div>
		 </form>
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
	
    $(document).ready(function() {
        	$.ajax({
        		url:'http://localhost:8080/app/fornecedor',
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
        				var id = dados[i].idfornecedor;
        				var newRow = $("<tr>");
        			    var cols = "";
        			    cols += '<td>'+dados[i].idfornecedor+'</td>';
        			    cols += '<td>'+dados[i].cnpj+'</td>';
        			    cols += '<td>'+dados[i].nome+'</td>';
        			    cols += '<td>'+$.date(dados[i].data_cadastro)+'</td>';
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
    	$("#cfornecedor").submit(function(e) {
    	    var url = "http://localhost:8080/app/fornecedor?metodo=cadastrar";
    	    $.ajax({
    				type: "GET",
    				url: url,
    				data: $("#cfornecedor").serialize(),
    				success: function(data){
    					$('#cfornecedor').each (function(){
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
        	var url = 'http://localhost:8080/app/fornecedor';
        	$.ajax ({
        		url: url+"?metodo=excluir&idfornecedor="+id,
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
        	var url = 'http://localhost:8080/app/fornecedor';
        	//locastyle.modal.open("#modalEdita");
        	$.ajax ({
        		url: url+"?metodo=editar&idfornecedor="+id,
		        type:'GET',
		        success:function(data){ 
		        		for(i in data){
		        			$("#idfornecedor").val(data[i].idfornecedor)
		        			$("#nome").val(data[i].nome)
		        			$("#cnpjEdit").val(data[i].cnpj);
		        			$("#cep").val(data[i].endereco.cep)
		        			$("#endereco").val(data[i].endereco.endereco)
		        			$("#numero").val(data[i].endereco.numero)
		        			$("#complemento").val(data[i].endereco.complemento)
		        			$("#cidade").val(data[i].endereco.cidade)
		        			$("#bairro").val(data[i].endereco.bairro)		        			
		        			$("#ativo").val(data[i].ativo)
		        			$("#idendereco").val(data[i].idendereco)
		        		}
		        }
        	});
        	locastyle.modal.open("#modalEdita");
          }
         // função atualizar
    	$("#editarfornecedor").submit(function(e) {
    	    var url = "http://localhost:8080/app/fornecedor?metodo=atualiza";
    	    $.ajax({
    				type: "GET",
    				url: url,
    				data: $("#editarfornecedor").serialize(),
    				success: function(data){
    				    locastyle.modal.close();  // fecha a modal
    		    	    location.reload();        // carrega pagina
    				}
    			});
    	    e.preventDefault();
    	});
        
        function validaCampoCnpj(element, isEdit){
        	if(!validarCNPJ(element.value)){
        		element.className = 'invalidIdMovimento';
        		if(!isEdit) $("#salvarFornecedor").addClass('ls-disabled');
        		else $("#editarFornecedor").addClass('ls-disabled');
        	}else{
        		element.className = '';
        		if(!isEdit) $("#salvarFornecedor").removeClass('ls-disabled');
        		else $("#editarFornecedor").removeClass('ls-disabled');
        	}
        }
    	function validarCNPJ(cnpj) {
   		 
    	    cnpj = cnpj.replace(/[^\d]+/g,'');
    	 
    	    if(cnpj == '') return false;
    	     
    	    if (cnpj.length != 14)
    	        return false;
    	 
    	    // Elimina CNPJs invalidos conhecidos
    	    if (cnpj == "00000000000000" || 
    	        cnpj == "11111111111111" || 
    	        cnpj == "22222222222222" || 
    	        cnpj == "33333333333333" || 
    	        cnpj == "44444444444444" || 
    	        cnpj == "55555555555555" || 
    	        cnpj == "66666666666666" || 
    	        cnpj == "77777777777777" || 
    	        cnpj == "88888888888888" || 
    	        cnpj == "99999999999999")
    	        return false;
    	         
    	    // Valida DVs
    	    tamanho = cnpj.length - 2
    	    numeros = cnpj.substring(0,tamanho);
    	    digitos = cnpj.substring(tamanho);
    	    soma = 0;
    	    pos = tamanho - 7;
    	    for (i = tamanho; i >= 1; i--) {
    	      soma += numeros.charAt(tamanho - i) * pos--;
    	      if (pos < 2)
    	            pos = 9;
    	    }
    	    resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
    	    if (resultado != digitos.charAt(0))
    	        return false;
    	         
    	    tamanho = tamanho + 1;
    	    numeros = cnpj.substring(0,tamanho);
    	    soma = 0;
    	    pos = tamanho - 7;
    	    for (i = tamanho; i >= 1; i--) {
    	      soma += numeros.charAt(tamanho - i) * pos--;
    	      if (pos < 2)
    	            pos = 9;
    	    }
    	    resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
    	    if (resultado != digitos.charAt(1))
    	          return false;
    	           
    	    return true;
    	    
    	}
  </script>    
  </body>
</html>