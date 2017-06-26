<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="ls-theme-indigo">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<title>Tela de Login | i9 Finanças</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<link href="css/estiloGfinancas.css" rel="stylesheet" type="text/css"/>
<link rel="icon" sizes="192x192" href="images/ico-boilerplate.png">
<link rel="apple-touch-icon" href="images/ico-boilerplate.png">
</head>
<body>
	<div class="ls-login-parent">
		<div class="ls-login-inner">
			<div class="ls-login-container">			
				<div class="ls-login-box">
				   <div class="ls-alert-danger">${erro}</div>
					<h1 class="ls-login-logo">
						<img title="Logo login" src="images/logo.jpg" width="100px"; height="100px"/>
					</h1>
					<form  method="POST" action="login" class="ls-form ls-login-form">
						<fieldset>
							<label class="ls-label"> <b
								class="ls-label-text ls-hidden-accessible">E-mail</b> <input
								class="ls-login-bg-user ls-field-lg" type="email" name="email"
								placeholder="Digite seu E-mail" value="alpmidia@gmail.com" required autofocus>
							</label> <label class="ls-label"> <b
								class="ls-label-text ls-hidden-accessible">Senha</b>
								<div class="ls-prefix-group">  <!--type="password"-->
									<input id="password_field" class="ls-login-bg-password ls-field-lg" value="123"
										placeholder="Senha" name="senha"> <a class="ls-label-text-prefix ls-toggle-pass ls-ico-eye"
										data-toggle-class="ls-ico-eye, ls-ico-eye-blocked"
										data-target="#password_field"></a>
								</div>
							</label>
							<input type="submit" value="Entrar" class="ls-btn-primary ls-btn-block ls-btn-lg">
							
							<p class="ls-txt-center"><a class="ls-login-forgot" href="esqueci-minha-senha.jsp">Esqueci minha senha</a></p>
						</fieldset>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script src="javascripts/libs/jquery-2.1.0.min.js" type="text/javascript"></script>
	<script src="javascripts/locastyle.js" type="text/javascript"></script>
</body>
</html>