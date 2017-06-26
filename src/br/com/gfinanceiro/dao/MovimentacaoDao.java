package br.com.gfinanceiro.dao;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import com.google.gson.Gson;
import br.com.gfinanceiro.bd.DBUtil;
import br.com.gfinanceiro.model.Movimentacao;
public class MovimentacaoDao {

	private Connection connection;

	public MovimentacaoDao() {
		connection = DBUtil.getConnection();
	}

	public String getAllMovimentacoes(int limit) {
		MovimentacaoDao obj = new MovimentacaoDao();
		String sql = "SELECT mov.idmovimentacao as id, mov.dsc, cat.nome as nome_categoria, COALESCE(c.nome,f.nome, 'Outros') as 'cliente_fornecedor', CASE mov.tipo_movimentacao WHEN '0' THEN 'Outros' WHEN '1' THEN 'Cliente' ELSE 'Fornecedor'	END AS 'tipo_movimentacao',  mov.valor,  mov.data_cadastro FROM movimentacao mov LEFT JOIN cliente c on c.idcliente = mov.cliente_idcliente LEFT JOIN fornecedor f on f.idfornecedor = mov.fornecedor_idfornecedor INNER JOIN categoria cat on cat.idcategoria = mov.categoria_idcategoria WHERE mov.ativo != 0 LIMIT " + limit;
		return obj.getAllMovimentacoes(sql);
	}
	
	public String filtrarMovimentacoes(String where) {
		MovimentacaoDao obj = new MovimentacaoDao();
		String sql = "SELECT mov.idmovimentacao as id, mov.dsc, cat.nome as nome_categoria, COALESCE(c.nome,f.nome, 'Outros') as 'cliente_fornecedor', CASE mov.tipo_movimentacao WHEN '0' THEN 'Outros' WHEN '1' THEN 'Cliente' ELSE 'Fornecedor'	END AS 'tipo_movimentacao',  mov.valor,  mov.data_cadastro FROM movimentacao mov LEFT JOIN cliente c on c.idcliente = mov.cliente_idcliente LEFT JOIN fornecedor f on f.idfornecedor = mov.fornecedor_idfornecedor INNER JOIN categoria cat on cat.idcategoria = mov.categoria_idcategoria WHERE mov.ativo != 0 "+where;
		return obj.getAllMovimentacoes(sql);
	}
	
	public String getMovimentacaoPorId(int idmovimentacao) {
		MovimentacaoDao obj = new MovimentacaoDao();
		String sql = "SELECT mov.idmovimentacao as id, mov.dsc, cat.nome as nome_categoria, COALESCE(c.nome,f.nome, 'Outros') as 'cliente_fornecedor', CASE mov.tipo_movimentacao WHEN '0' THEN 'Outros' WHEN '1' THEN 'Cliente' ELSE 'Fornecedor'	END AS 'tipo_movimentacao',  mov.valor,  mov.data_cadastro FROM movimentacao mov LEFT JOIN cliente c on c.idcliente = mov.cliente_idcliente LEFT JOIN fornecedor f on f.idfornecedor = mov.fornecedor_idfornecedor INNER JOIN categoria cat on cat.idcategoria = mov.categoria_idcategoria where mov.idmovimentacao="+idmovimentacao;
		return obj.getMovimentacaoPorId(sql);
	}
	
	public String getTotais(){
		MovimentacaoDao obj = new MovimentacaoDao();
		String sql = "SELECT CASE WHEN valor > 0 THEN valor ELSE 0 END AS entradas, CASE WHEN valor < 0 THEN (valor * -1) ELSE 0 END AS saidas FROM movimentacao WHERE ativo != 0";
		return obj.getTotais(sql);
	}
	
	public String getTotaisCurrentMonth(){
		MovimentacaoDao obj = new MovimentacaoDao();
		String sql = "SELECT CASE WHEN valor > 0 THEN valor ELSE 0 END AS entradas, CASE WHEN valor < 0 THEN (valor * -1) ELSE 0 END AS saidas FROM movimentacao WHERE ativo != 0 AND date_format(data_cadastro, '%Y-%m')=date_format(now(), '%Y-%m')";
		return obj.getTotais(sql);
	}
	
	// CRUD - 
	public void addMovimentacao(Movimentacao movimentacao) {
		try {
			String sql;
			if(movimentacao.getFornecedor_idfornecedor() <= 0 && movimentacao.getCliente_idcliente() > 0){
				sql = "INSERT INTO movimentacao (valor, tipo_movimentacao, dsc, cliente_idcliente, categoria_idcategoria,usuario_idusuario) VALUES (?,?,?,?,?,?)";
			}else if(movimentacao.getFornecedor_idfornecedor() > 0 && movimentacao.getCliente_idcliente() <= 0){
				sql = "INSERT INTO movimentacao (valor, tipo_movimentacao, dsc, fornecedor_idfornecedor, categoria_idcategoria,usuario_idusuario) VALUES (?,?,?,?,?,?)";
			}else{
				sql = "INSERT INTO movimentacao (valor, tipo_movimentacao, dsc, categoria_idcategoria,usuario_idusuario) VALUES (?,?,?,?,?)";
			}
			java.sql.PreparedStatement prepare = connection.prepareStatement(sql);
			prepare.setDouble(1, movimentacao.getValor());
			prepare.setString(2, movimentacao.getTipo_movimentacao());
			prepare.setString(3, movimentacao.getDsc());
			
			if(movimentacao.getFornecedor_idfornecedor() <= 0 && movimentacao.getCliente_idcliente() > 0){
				prepare.setInt(4, movimentacao.getCliente_idcliente());
				prepare.setInt(5, movimentacao.getCategoria_idcategoria());
				prepare.setInt(6, movimentacao.getUsuario_idusuario());
			}
			else if(movimentacao.getFornecedor_idfornecedor() > 0 && movimentacao.getCliente_idcliente() <= 0){
				prepare.setInt(4, movimentacao.getFornecedor_idfornecedor());
				prepare.setInt(5, movimentacao.getCategoria_idcategoria());
				prepare.setInt(6, movimentacao.getUsuario_idusuario());
			}
			else{ 
				   prepare.setInt(4, movimentacao.getCategoria_idcategoria());
				   prepare.setInt(5, movimentacao.getUsuario_idusuario());
				}
			prepare.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void updateMovimentacao(Movimentacao movimentacao) {
		try {
			java.sql.PreparedStatement prepare = connection.prepareStatement(
					"UPDATE movimentacao set dsc = ? where idmovimentacao = ?");
			prepare.setString(1, movimentacao.getDsc());
			prepare.setInt(2, movimentacao.getId());
			prepare.executeUpdate();
			
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public String getAllMovimentacoes(String queryString) {

		ArrayList<Movimentacao> ArrayUsuario = new ArrayList<Movimentacao>();
		String jsonMovimentacao = "{}";

		try {
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(queryString);
			while (rs.next()) {
				String dsc = rs.getString("dsc");
				String cliente_fornecedor = rs.getString("cliente_fornecedor");
				double valor = Double.parseDouble(rs.getString("valor"));
				String tipo_movimentacao = rs.getString("tipo_movimentacao");
				String data_cadastro = rs.getString("data_cadastro");
				String nome_categoria = rs.getString("nome_categoria");
				int id = rs.getInt("id");

				Movimentacao myClass = new Movimentacao();
				myClass.setDsc(dsc);
				myClass.setCliente_fornecedor(cliente_fornecedor);
				myClass.setValor(valor);
				myClass.setTipo_movimentacao(tipo_movimentacao);
				myClass.setData_cadastro(data_cadastro);
				myClass.setNome_categoria(nome_categoria);
				myClass.setId(id);
				
				ArrayUsuario.add(myClass);
			}

			stmt.close();
			jsonMovimentacao = new Gson().toJson(ArrayUsuario);
			return jsonMovimentacao;

		} catch (SQLException ex) {
			System.out.println(ex.getMessage());
		}

		return jsonMovimentacao;
	}

	public void cancelarMovimentacao(int id) {
		try {
			java.sql.PreparedStatement prepare = connection.prepareStatement("UPDATE movimentacao set ativo = 0 WHERE idmovimentacao = ?");
			prepare.setInt(1, id);
			prepare.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public String getMovimentacaoPorId(String queryString) {

		ArrayList<Movimentacao> arrayMovimentacao = new ArrayList<Movimentacao>();
		String jsonMovimentacao = "{}";

		try {
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(queryString);
			while (rs.next()) {
				String dsc = rs.getString("dsc");
				String cliente_fornecedor = rs.getString("cliente_fornecedor");
				double valor = Double.parseDouble(rs.getString("valor"));
				String tipo_movimentacao = rs.getString("tipo_movimentacao");
				String data_cadastro = rs.getString("data_cadastro");
				String nome_categoria = rs.getString("nome_categoria");
				int id = rs.getInt("id");

				Movimentacao myClass = new Movimentacao();
				myClass.setDsc(dsc);
				myClass.setCliente_fornecedor(cliente_fornecedor);
				myClass.setValor(valor);
				myClass.setTipo_movimentacao(tipo_movimentacao);
				myClass.setData_cadastro(data_cadastro);
				myClass.setNome_categoria(nome_categoria);
				myClass.setId(id);
				
				arrayMovimentacao.add(myClass);
			}

			stmt.close();
			jsonMovimentacao = new Gson().toJson(arrayMovimentacao);
			return jsonMovimentacao;

		} catch (SQLException ex) {
			System.out.println(ex.getMessage());
		}

		return jsonMovimentacao;
	}	
	
	public String getTotais(String queryString) {

		ArrayList<Movimentacao> totais = new ArrayList<Movimentacao>();
		String jsonMovimentacao = "{}";

		try {
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(queryString);
			while (rs.next()) {
				String entradas = rs.getString("entradas");
				String saidas = rs.getString("saidas");

				Movimentacao objMov = new Movimentacao();
				objMov.setEntrada(Double.valueOf(entradas));
				objMov.setSaida(Double.valueOf(saidas));
				
				totais.add(objMov);
			}

			stmt.close();
			jsonMovimentacao = new Gson().toJson(totais);
			return jsonMovimentacao;

		} catch (SQLException ex) {
			System.out.println(ex.getMessage());
		}

		return jsonMovimentacao;
	}
}
