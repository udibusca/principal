<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="ls-theme-indigo">
  <head>
    <title>Dashboard | i9 Finanças</title>

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
 <aside class="ls-sidebar">

  <div class="ls-sidebar-inner">
      <a href="javascript:history.back()"  class="ls-go-prev"><span class="ls-text">Voltar</span></a>

      <nav class="ls-menu">
        <ul>
           <li><a href="index.jsp" class="ls-ico-dashboard" title="Dashboard">Dashboard</a></li>
           <li><a href="movimentos.jsp" class="ls-ico-trophy" title="Movimentos">Movimentos</a></li>
           <li><a href="#" class="ls-ico-stats" title="Relatórios da revenda">Relatório mensal</a></li>
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
        <h1 class="ls-title-intro ls-ico-stats">Relatório mensal</h1>
		<p></p>
<!-- Conteudo dash -->
<div class="ls-box ls-board-box">
  <header class="ls-info-header">
    <h2 class="ls-title-3">Balanço Mês Atual</h2>
  </header>
  <div id="sending-stats" class="row">
    <div class="col-sm-6 col-md-12" style="height:300px;">
      <div class="ls-box">
      <div class="ls-box-head">
      	<h6 class="ls-title-4">Gasto por categoria</h6>
      </div>
		<div id="gpc" style="width:100%;height:100%"></div>
      </div>
    </div>
    <div class="col-sm-6 col-md-12" style="height:300px;">
      <div class="ls-box">
	  <div class="ls-box-head">
      	<h6 class="ls-title-4">Entradas e Saidas</h6>
      </div>
		<div id="ees" style="width:100%;height:100%"></div>
      </div>
    </div>
    <div class="col-sm-6 col-md-12" style="height:300px;">
      <div class="ls-box">
	  <div class="ls-box-head">
      	<h6 class="ls-title-4">Entradas por categoria</h6>
      </div>
		<div id="epc" style="width:100%;height:100%"></div>
      </div>
    </div>
  </div>
</div>
<!-- Conteudo dash -->	
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
    <script src="javascripts/flot/jquery.flot.js"></script>
    <script src="javascripts/bbnloading.js" type="text/javascript"></script>
    <script>
    	var configAdc = {
            series: {
                bars: {
                    show: true,
                }
            }
        }
    	 
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
    				document.getElementById('gpc').appendChild(node);
    			}
    			else{
    				var dataset = [
    		        ];
    				
    				var groupedData = {};

    				for (var it = 0; it < dados.length; it++) {
    				  var item = dados[it];
    				  if(item.valor < 0){
	    				  if (!groupedData[item.nome_categoria]){
	    				    groupedData[item.nome_categoria] = [];
	    				  }
	    				  item.valor = item.valor * -1;
	    				  groupedData[item.nome_categoria].push(item);
    				  }
    				}
    				
    				for(i in groupedData){
    					for(j in groupedData[i]){
    						var thatTotal = groupedData[i][j].valor;
    					}
    					dataset.push({ label: i, data: [[j, thatTotal]]});
    				}
    				
    		    	$.plot($("#gpc"), dataset, configAdc);
    			}
        				
    		} 
    	});
    	
    	//Pega os totais do gráfico de balanço geral
    	var urlTotais = "http://localhost:8080/app/movimentacao?metodo=getTotais";
    	$.ajax({
    	type: "GET",
    		url: urlTotais,
    		success: function(data){
    			if(data.length <= 0){
    				//manipulação do dom para 
    				var node = document.createElement("p");
    				var textnode = document.createTextNode("Não há dados para serem listados");
    				node.appendChild(textnode); 
    				document.getElementById('ees').appendChild(node);
    			}else{
	    		   	var entradas = 0;
					var saidas = 0;
					var total = 0;
	    			for(i in data){
	    				entradas += data[i].entrada;
	    				saidas += data[i].saida;
	    		   	}
	
	    			entradas = entradas.toFixed(2);
	    			saidas = saidas.toFixed(2);
	    			var dataset = [
	    				{ label: "Entradas", data: [[1, entradas]], color:"#2ecc71"},
	    				{ label: "Saídas", data: [[2, saidas]], color:"#e74c3c"}
	    			];
	    			$.plot($("#ees"), dataset, configAdc);
    			}
    		}
    	});
    	
    	//popula o gráfico de entradas por categoria
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
    				document.getElementById('epc').appendChild(node);
    			}
    			else{
    				var dataset = [
    		        ];
    				
    				var groupedData = {};

    				for (var it = 0; it < dados.length; it++) {
    				  var item = dados[it];
    				  if(item.valor > 0){
	    				  if (!groupedData[item.nome_categoria]){
	    				    groupedData[item.nome_categoria] = [];
	    				  }
	    				  groupedData[item.nome_categoria].push(item);
    				  }
    				}
    				
    				for(i in groupedData){
    					for(j in groupedData[i]){
    						var thatTotal = groupedData[i][j].valor;
    					}
    					dataset.push({ label: i, data: [[j, thatTotal]]});
    				}
    				
    		    	$.plot($("#epc"), dataset, configAdc);
    			}
        				
    		} 
    	});
    </script>
  </body>
</html>