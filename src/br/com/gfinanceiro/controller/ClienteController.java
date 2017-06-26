package br.com.gfinanceiro.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import br.com.gfinanceiro.bd.DBUtil;
import br.com.gfinanceiro.dao.ClienteDao;
import br.com.gfinanceiro.dao.EnderecoDao;
import br.com.gfinanceiro.model.Cliente;
import br.com.gfinanceiro.model.Endereco;

@WebServlet("/cliente")
public class ClienteController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
    }		
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ClienteDao dao = new ClienteDao();
		EnderecoDao daoendereco = new EnderecoDao();

		if (request.getParameter("metodo") != null) {

			List<Endereco> lstEndereco = new ArrayList<Endereco>();
			List<Cliente> lstCliente = new ArrayList<Cliente>();
			
			String acao = (String) request.getParameter("metodo");
			Gson gson = new Gson();
			response.setContentType("application/json");

			if (acao.equals("listar")) {
				try {
					response.getWriter().append(dao.getAllCliente(DBUtil.LIMIT));
				} catch (Exception ex) {
					String error = "{\"Result\":\"ERROR\",\"Message\":" + ex.getMessage() + "}";
					response.getWriter().print(error);
					ex.printStackTrace();
				}
			} else if (acao.equals("cadastrar")) {
				Cliente cliente = new Cliente();
				Endereco endereco = new Endereco();
				
				if (request.getParameter("cep") != null) {
					String cep = request.getParameter("cep");
					endereco.setCep(cep);
				}
				if (request.getParameter("endereco") != null) {
					String end = request.getParameter("endereco");
					endereco.setEndereco(end);
				}
				if (request.getParameter("numero") != null) {
					String numero = request.getParameter("numero");
					endereco.setNumero(numero);
				}
				if (request.getParameter("complemento") != null) {
					String complemento = request.getParameter("complemento");
					endereco.setComplemento(complemento);
				}
				if (request.getParameter("cidade") != null) {
					String cidade = request.getParameter("cidade");
					endereco.setCidade(cidade);
				}
				if (request.getParameter("bairro") != null) {
					String bairro = request.getParameter("bairro");
					endereco.setBairro(bairro);
				}
				if (request.getParameter("nome") != null) {
					String nome = (String) request.getParameter("nome");
					cliente.setNome(nome);
				}
				if (request.getParameter("cpf") != null) {
					String cpf = request.getParameter("cpf");
					cliente.setCpf(cpf);
				}				
				if (request.getParameter("saldo") != null) {
					String saldo = request.getParameter("saldo");
					cliente.setSaldo(saldo);
				}
				if (request.getParameter("ativo") != null) {
					String ativo = request.getParameter("ativo");
					cliente.setAtivo(Integer.parseInt(ativo));
				}
				
				try {
					daoendereco.addEndereco(endereco);
					lstEndereco.add(endereco);
					dao.addCliente(cliente);
					lstCliente.add(cliente);
					
					String json = gson.toJson(cliente);
					String listData = "{\"Result\":\"OK\",\"Record\":" + json + "}";
					response.getWriter().print(listData);

				} catch (Exception ex) {
					String error = "{\"Result\":\"ERROR\",\"Message\":" + ex.getStackTrace().toString() + "}";
					response.getWriter().print(error);
				}
			} else if (acao.equals("excluir")) {
				try {
					if (request.getParameter("idcliente") != null) {
						String idcliente = (String) request.getParameter("idcliente");
						dao.deleteCliente(Integer.parseInt(idcliente));
						String listData = "{\"Result\":\"OK\"}";
						response.getWriter().print(listData);
					}
				} catch (Exception ex) {
					String error = "{\"Result\":\"ERROR\",\"Message\":" + ex.getStackTrace().toString() + "}";
					response.getWriter().print(error);
				}
			} else if (acao.equals("editar")){				
				if (request.getParameter("idcliente") != null) {
					int idcliente = Integer.parseInt(request.getParameter("idcliente"));
					response.getWriter().append(dao.buscaClientePorId(idcliente));
					
				}
			}else if (acao.equals("atualiza")) {
				Cliente cliente = new Cliente();
				Endereco endereco = new Endereco();
				
				if (request.getParameter("idcliente") != null) {
					int idcliente = Integer.parseInt(request.getParameter("idcliente"));
					cliente.setIdcliente(idcliente);
				}				
				if (request.getParameter("cep") != null) {
					String cep = request.getParameter("cep");
					endereco.setCep(cep);
				}
				if (request.getParameter("endereco") != null) {
					String end = request.getParameter("endereco");
					endereco.setEndereco(end);
				}
				if (request.getParameter("numero") != null) {
					String numero = request.getParameter("numero");
					endereco.setNumero(numero);
				}
				if (request.getParameter("complemento") != null) {
					String complemento = request.getParameter("complemento");
					endereco.setComplemento(complemento);
				}
				if (request.getParameter("cidade") != null) {
					String cidade = request.getParameter("cidade");
					endereco.setCidade(cidade);
				}
				if (request.getParameter("bairro") != null) {
					String bairro = request.getParameter("bairro");
					endereco.setBairro(bairro);
				}				
				if (request.getParameter("nome") != null) {
					String nome = (String) request.getParameter("nome");
					cliente.setNome(nome);
				}
				if (request.getParameter("cpf") != null) {
					String cpf = request.getParameter("cpf");
					cliente.setCpf(cpf);
				}
				if (request.getParameter("ativo") != null) {
					String ativo = request.getParameter("ativo");
					cliente.setAtivo(Integer.parseInt(ativo));
				}
				if (request.getParameter("saldo") != null) {
					String saldo = request.getParameter("saldo");
					cliente.setSaldo(saldo);
				}
				if (request.getParameter("endereco_idendereco") != null) {
					cliente.setEndereco_idendereco(request.getParameter("endereco_idendereco"));
				}				
				cliente.setEndereco(endereco);
				try {
					daoendereco.updateEndereco(cliente,endereco);
					dao.updateCliente(cliente);
					String json = gson.toJson(cliente);
					String listData = "{\"Result\":\"OK\",\"Record\":" + json + "}";
					response.getWriter().print(listData);
				} catch (Exception ex) {
					String error = "{\"Result\":\"ERROR\",\"Message\":" + ex.getStackTrace().toString() + "}";
					response.getWriter().print(error);
				}
			}else if (acao.equals("buscacliente")) {
				try {
					if (request.getParameter("buscaQ") != null) {
						String buscaQ = request.getParameter("buscaQ");
						response.getWriter().append(dao.buscaClientePorNome(buscaQ));						
					}
				} catch (Exception ex) {
					String error = "{\"Result\":\"ERROR\",\"Message\":" + ex.getMessage() + "}";
					response.getWriter().print(error);
					ex.printStackTrace();
				}				
			}
		}
	}

}

