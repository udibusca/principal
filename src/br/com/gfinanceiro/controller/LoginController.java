package br.com.gfinanceiro.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import br.com.gfinanceiro.dao.LoginDao;

@WebServlet("/login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String erro;
		String email = request.getParameter("email");
		String senha = request.getParameter("senha");
		HttpSession session = request.getSession();
		LoginDao dao = new LoginDao();

		String nomeUsuario = dao.verificaUsuario(email, senha);

		if (nomeUsuario == null) {
			erro = "Usuário e/ou senha incorretos!";
			session.setAttribute("erro", erro);
			response.sendRedirect("login.jsp");
		} else {
			session.setAttribute("usuario", nomeUsuario);
			response.sendRedirect("index.jsp");
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if ("logout".equalsIgnoreCase(request.getParameter("param"))) {
			HttpSession session = request.getSession();
			session.removeAttribute("usuario");
			session.invalidate();
			response.sendRedirect("login.jsp");
		}
	}
}
