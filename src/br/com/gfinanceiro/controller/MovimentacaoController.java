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
import br.com.gfinanceiro.dao.FornecedorDao;
import br.com.gfinanceiro.dao.MovimentacaoDao;
import br.com.gfinanceiro.model.Movimentacao;

@WebServlet("/movimentacao")
public class MovimentacaoController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		MovimentacaoDao dao = new MovimentacaoDao();

		if (request.getParameter("metodo") != null) {
			
			List<Movimentacao> lstMovimentacao = new ArrayList<Movimentacao>();
			String acao = (String) request.getParameter("metodo");
			Gson gson = new Gson();
			response.setContentType("application/json");

			if (acao.equals("listar")) {
				
				try {
					response.getWriter().append(dao.getAllMovimentacoes(DBUtil.LIMIT));
				} catch (Exception ex) {
					String error = "{\"Result\":\"ERROR\",\"Message\":" + ex.getMessage() + "}";
					response.getWriter().print(error);
					ex.printStackTrace();
				}
				
			}else if (acao.equals("atualiza")) {
				
				Movimentacao movimentacao = new Movimentacao();				
				
				if (request.getParameter("id") != null) {
					String id = (String) request.getParameter("id");
					movimentacao.setId(Integer.valueOf(id));
				}
				if (request.getParameter("dsc") != null) {
					String dsc = (String) request.getParameter("dsc");
					movimentacao.setDsc(dsc);
				}
				
				try {
					dao.updateMovimentacao(movimentacao);
					String json = gson.toJson(movimentacao);
					String listData = "{\"Result\":\"OK\",\"Record\":" + json + "}";
					response.getWriter().print(listData);
					
				} catch (Exception ex) {
					String error = "{\"Result\":\"ERROR\",\"Message\":" + ex.getStackTrace().toString() + "}";
					response.getWriter().print(error);
				}
				
			}else if(acao.equals("editar")){
				if (request.getParameter("id") != null) {
					int idmovimentacao = Integer.parseInt(request.getParameter("id"));
					response.getWriter().append(dao.getMovimentacaoPorId(idmovimentacao));
				}
			}else if(acao.equals("cancelar")){
				try {
					if (request.getParameter("id") != null) {
						String idmovimentacao = (String) request.getParameter("id");
						dao.cancelarMovimentacao(Integer.parseInt(idmovimentacao));
						String listData = "{\"result\":\"OK\"}";
						response.getWriter().print(listData);
					}
				} catch (Exception ex) {
					String error = "{\"result\":\"ERROR\",\"message\":" + ex.getStackTrace().toString() + "}";
					response.getWriter().print(error);
				}
			}else if (acao.equals("cadastrar")) {
				
				Movimentacao movimentacao = new Movimentacao();
				
				if (request.getParameter("idcategoria") != null) {
					String idcategoria = request.getParameter("idcategoria");
					movimentacao.setCategoria_idcategoria(Integer.valueOf(idcategoria));
					
				}
				if (request.getParameter("tipo_mov") != null) {
					String tipo_movimentacao = (String) request.getParameter("tipo_mov");
					movimentacao.setTipo_movimentacao(tipo_movimentacao);
				}
				if (request.getParameter("valor") != null) {
					double valor = Double.parseDouble(request.getParameter("valor"));
					movimentacao.setValor(valor);
					
				}
				if (request.getParameter("dsc") != null) {
					String dsc = (String) request.getParameter("dsc");
					movimentacao.setDsc(dsc);
				}
				if (request.getParameter("idfornecedor") != null) {
					String idfornecedor = (String) request.getParameter("idfornecedor");
					movimentacao.setFornecedor_idfornecedor(Integer.valueOf(idfornecedor));
				}
				if (request.getParameter("idcliente") != null) {
					String idcliente = (String) request.getParameter("idcliente");
					movimentacao.setCliente_idcliente(Integer.valueOf(idcliente));
					
					// se for uma movimentação provinda de um cliente atualiza o saldo do mesmo
					if (request.getParameter("usarSaldo") != null && request.getParameter("saldo") != null) {
						//String saldo = (String) request.getParameter("saldo");
						ClienteDao objClienteDao = new ClienteDao();
						objClienteDao.updateSaldo(Integer.valueOf(idcliente), request.getParameter("saldo"));
					}
				}
				if (request.getParameter("usuario_idusuario") != null) {
					String usuario_idusuario = (String) request.getParameter("usuario_idusuario");
					movimentacao.setUsuario_idusuario(Integer.valueOf(usuario_idusuario));
				}				
				
				try {
					dao.addMovimentacao(movimentacao);
					lstMovimentacao.add(movimentacao);
					String json = gson.toJson(movimentacao);
					String listData = "{\"Result\":\"OK\",\"Record\":" + json + "}";
					response.getWriter().print(listData);
					
				} catch (Exception ex) {
					String error = "{\"Result\":\"ERROR\",\"Message\":" + ex.getStackTrace().toString() + "}";
					response.getWriter().print(error);
				}
				
			}else if(acao.equals("getidcliente_fornecedor")){
				if (request.getParameter("cpf_cnpj") != null) {
					String cpf_cnpj = (String) request.getParameter("cpf_cnpj");
					
					//aqui faz a consulta no cliente ou fornecedor e pega o id dele
					ClienteDao objDaoCliente = new ClienteDao();
					FornecedorDao objDaoFornecedor = new FornecedorDao();
					
					if( cpf_cnpj.length() == 11 ){
						
						String arrayJsonRetornoCliente = objDaoCliente.buscaClientePorCpf(cpf_cnpj);
						response.getWriter().print(arrayJsonRetornoCliente);
						
						
					}else if( cpf_cnpj.length() == 14 ){
						
						String arrayJsonRetornoFornecedor = objDaoFornecedor.buscaFornecedorPorCnpj(cpf_cnpj);
						response.getWriter().print(arrayJsonRetornoFornecedor);
						
					}else{
						response.getWriter().print("[]");
					}
				}
			}
			else if(acao.equals("getTotais")){
				String jsonRetornoTotais = dao.getTotais();
				response.getWriter().print(jsonRetornoTotais);
			}
			else if(acao.equals("getTotaisCurrentMonth")){
				String jsonRetornoTotais = dao.getTotaisCurrentMonth();
				response.getWriter().print(jsonRetornoTotais);
			}
			else if(acao.equals("filtrar")){
				String periodo = (String) request.getParameter("periodo");
				
				switch(periodo){
				case "1":
					response.getWriter().print(dao.filtrarMovimentacoes("AND date_format(mov.data_cadastro, '%d')=date_format(now(), '%d')"));
					break;
				case "2":
					response.getWriter().print(dao.filtrarMovimentacoes("AND date_format(mov.data_cadastro, '%d') = date_format(subdate(now(), 1), '%d')"));
					break;
				case "3":
					response.getWriter().print(dao.filtrarMovimentacoes("BETWEEN subdate(now(), 7) AND now()"));
					break;
				case "4":
					response.getWriter().print(dao.filtrarMovimentacoes("BETWEEN subdate(now(), 30) AND now()"));
					break;
				case "5":
					response.getWriter().print(dao.filtrarMovimentacoes("BETWEEN subdate(now(), 6), '%m')"));
					break;
				case "6":
					response.getWriter().print(dao.filtrarMovimentacoes("date_format(mov.data_cadastro, '%m') = date_format(subdate(now(), 12), '%m')"));
					break;
				case "7":
					response.getWriter().print(dao.filtrarMovimentacoes("date_format(mov.data_cadastro, '%m') = date_format(subdate(now(), 6), '%m')"));
					break;
				}
			}
		}
	}

}
