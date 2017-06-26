<%@page import="com.mysql.fabric.xmlrpc.base.Data"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html class="ls-theme-indigo">
<head>
<title>Movimentos | i9 Finanças</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="Sistema financeiro">
<link href="css/estiloGfinancas.css" rel="stylesheet" type="text/css">
<link rel="icon" sizes="192x192" href="images/ico-boilerplate.png">
<link rel="apple-touch-icon" href="images/ico-boilerplate.png">
</head>
<body>
	<div class="ls-topbar">

		<!-- Barra de Notificações -->
		<div class="ls-notification-topbar">

			<!-- Dropdown com detalhes da conta de usuário -->
			<div data-ls-module="dropdown" class="ls-dropdown ls-user-account">
				<a href="#" class="ls-ico-user"> Anônimo </a>
				<nav class="ls-dropdown-nav ls-user-menu">
					<ul>
						<li><a href="login.jsp">Voltar</a></li>
					</ul>
				</nav>
			</div>
		</div>

  <!-- Nome do produto/marca com sidebar -->
    <h1 class="ls-brand-name">
      <a href="home" class="ls-ico-lamp">
        <small>Modulo financeiro</small>
        i9 Finanças
      </a>
    </h1>
	</div>

	<%
		Date data = new Date();
	    SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	    String dataFormatada = formato.format(data);
		
	%>

	<main class="ls-main">
	<div class="container-fluid">

		<div class="ls-box ls-no-bg ls-box-error">
			<h1 class="ls-title-intro ls-ico-close">Página não encontrada</h1>
			<p>Você não tem acesso para acessar está página.</p>

			<p>
				<strong>Você pode:</strong>
			</p>
			<ol>
				<li>Verificar se digitou corretamente seu usuário e senha </li>
				<li>Retornar à <a href="login.jsp" class="ls-color-theme">página
						inicial.</a></li>
			</ol>
			<p>
				Se o problema persistir, entre em contato com o Administrador do sistema.
			</p>
		</div>

	</div>
	<footer class="ls-footer" role="contentinfo">

		<div class="ls-footer-info">
			<span class="last-access ls-ico-screen"><strong>
			Último acesso: </strong><% out.print(dataFormatada); %></span>
			<div class="set-ip">
				<strong>IP:</strong> <% out.print(request.getRemoteAddr() ); %>
			</div>
			<p class="ls-copy-right">Copyright © 2016-2016 i9 Finanças.</p>
		</div>
	</footer>
</main>
	<!-- We recommended use jQuery 1.10 or up -->
	<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script> -->
	<script src="javascripts/libs/jquery-2.1.0.min.js"
		type="text/javascript"></script>
	<script src="javascripts/locastyle.js" type="text/javascript"></script>
</body>
</html>