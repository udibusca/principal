package br.com.gfinanceiro.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import br.com.gfinanceiro.bd.DBUtil;
import br.com.gfinanceiro.dao.UsuarioDao;
import br.com.gfinanceiro.model.Usuario;

@WebServlet("/usuario")
public class UsuarioController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		UsuarioDao dao = new UsuarioDao();

		if (request.getParameter("metodo") != null) {
			String acao = (String) request.getParameter("metodo");
			Gson gson = new Gson();
			response.setContentType("application/json");

			if (acao.equals("listar")) {
				try {
					response.getWriter().append(dao.getAllUsuario(DBUtil.LIMIT));
				} catch (Exception ex) {
					String error = "{\"Result\":\"ERROR\",\"Message\":" + ex.getMessage() + "}";
					response.getWriter().print(error);
					ex.printStackTrace();
				}
			} else if (acao.equals("cadastrar")) {
				Usuario usuario = new Usuario();

				if (request.getParameter("nome") != null) {
					String nome = (String) request.getParameter("nome");
					usuario.setNome(nome);
				}
				if (request.getParameter("email") != null) {
					String email = (String) request.getParameter("email");
					usuario.setEmail(email);
				}
				if (request.getParameter("usuario") != null) {
					String usr = (String) request.getParameter("usuario");
					usuario.setUsuario(usr);
				}
				if (request.getParameter("senha") != null) {
					String senha = (String) request.getParameter("senha");
					usuario.setSenha(senha);
				}
				if (request.getParameter("ativo") != null) {
					String ativo = request.getParameter("ativo");
					usuario.setAtivo(Integer.parseInt(ativo));
				}
				try {
					dao.addUsuario(usuario);
					String json = gson.toJson(usuario);
					String listData = "{\"Result\":\"OK\",\"Record\":" + json + "}";
					response.getWriter().print(listData);

				} catch (Exception ex) {
					String error = "{\"Result\":\"ERROR\",\"Message\":" + ex.getStackTrace().toString() + "}";
					response.getWriter().print(error);
				}
			} else if (acao.equals("excluir")) {
				try {
					if (request.getParameter("idusuario") != null) {
						String idusuario = (String) request.getParameter("idusuario");
						dao.deleteUsuario(Integer.parseInt(idusuario));
						String listData = "{\"Result\":\"OK\"}";
						response.getWriter().print(listData);
					}
				} catch (Exception ex) {
					String error = "{\"Result\":\"ERROR\",\"Message\":" + ex.getStackTrace().toString() + "}";
					response.getWriter().print(error);
				}
			} else if (acao.equals("editar")) {
				if (request.getParameter("idusuario") != null) {
					int idusuario = Integer.parseInt(request.getParameter("idusuario"));
					response.getWriter().append(dao.getUsuarioPorId(idusuario));
				}
			} else if (acao.equals("atualiza")) {
				Usuario usuario = new Usuario();
				if (request.getParameter("idusuario") != null) {
					int idusuario = Integer.parseInt(request.getParameter("idusuario"));
					usuario.setIdusuario(idusuario);
				}
				if (request.getParameter("nome") != null) {
					String nome = (String) request.getParameter("nome");
					usuario.setNome(nome);
				}
				if (request.getParameter("email") != null) {
					String email = (String) request.getParameter("email");
					usuario.setEmail(email);
				}
				if (request.getParameter("usuario") != null) {
					String usr = (String) request.getParameter("usuario");
					usuario.setUsuario(usr);
				}
				if (request.getParameter("senha") != null) {
					String senha = (String) request.getParameter("senha");
					usuario.setSenha(senha);
				}
				if (request.getParameter("ativo") != null) {
					String ativo = request.getParameter("ativo");
					usuario.setAtivo(Integer.parseInt(ativo));
				}
				try {
					dao.updateUsuario(usuario);

					String json = gson.toJson(usuario);
					String listData = "{\"Result\":\"OK\",\"Record\":" + json + "}";
					response.getWriter().print(listData);
				} catch (Exception ex) {
					String error = "{\"Result\":\"ERROR\",\"Message\":" + ex.getStackTrace().toString() + "}";
					response.getWriter().print(error);
				}
			}
		}
	}

}
