package br.com.gfinanceiro.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.google.gson.Gson;

import br.com.gfinanceiro.bd.DBUtil;
import br.com.gfinanceiro.model.Endereco;
import br.com.gfinanceiro.model.Fornecedor;

public class FornecedorDao {

	private Connection connection;
	private int id_endereco;

	public FornecedorDao() {
		connection = DBUtil.getConnection();
	}

	// Todos selects da Classe fornecedor
	public String getAllFornecedor(int limit) {
		FornecedorDao obj = new FornecedorDao();
		String sql = "SELECT * FROM fornecedor where ativo = 1 ORDER BY idfornecedor limit " + limit;
		return obj.getAllFornecedor(sql);
	}
	
	public String buscaFornecedorPorId(int idfornecedor) {
		FornecedorDao obj = new FornecedorDao();
		String sql = "select * from fornecedor forn inner join endereco end on (forn.idendereco = end.idendereco) where forn.idfornecedor ="+idfornecedor;		
		return obj.buscaFornecedorPorId(sql);
	}
	
	public String buscaFornecedorPorCnpj(String cnpj) {
		FornecedorDao obj = new FornecedorDao();
		String sql = "select * from fornecedor forn inner join endereco end on (forn.idendereco = end.idendereco) where forn.cnpj="+cnpj;
		return obj.buscaFornecedorPorId(sql);
	}

	// CRUD - addFornecedor / deleteFornecedor / updateFornecedor / getFornecedorById
	public void addFornecedor(Fornecedor fornecedor) {
		try {
			java.sql.PreparedStatement prepare = connection
					.prepareStatement("INSERT INTO fornecedor (nome,cnpj,ativo,idendereco) VALUES (?,?,?,?)");
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT MAX(e.idendereco) as id FROM endereco e");
			rs.next();
			id_endereco = rs.getInt("id");			
			prepare.setString(1, fornecedor.getNome());
			prepare.setString(2, fornecedor.getCnpj());
			prepare.setInt(3, fornecedor.getAtivo());
			prepare.setInt(4,id_endereco);
			prepare.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void deleteFornecedor(int idfornecedor) {
		try {
			java.sql.PreparedStatement prepare = connection.prepareStatement("UPDATE fornecedor set ativo = 0  WHERE idfornecedor = ?");
			prepare.setInt(1, idfornecedor);
			prepare.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void updateFornecedor(Fornecedor fornecedor) {
		try {
			java.sql.PreparedStatement prepare = connection.prepareStatement(
					"UPDATE fornecedor SET nome = ?, cnpj = ?,ativo = ? WHERE idfornecedor = ?");
			prepare.setString(1, fornecedor.getNome());
			prepare.setString(2, fornecedor.getCnpj());
			prepare.setInt(3, fornecedor.getAtivo());
			prepare.setInt(4, fornecedor.getIdfornecedor());
			prepare.executeUpdate();

		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public String getAllFornecedor(String queryString) {

		ArrayList<Fornecedor> ArrayFornecedor = new ArrayList<Fornecedor>();
		String jsonFornecedors = "{}";

		try {
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(queryString);
			while (rs.next()) {
				String idfornecedor = rs.getString("idfornecedor");
				String nome = rs.getString("nome");
				String cnpj = rs.getString("cnpj");
				String data_cadastro	= rs.getString("data_cadastro");
				String ativo = rs.getString("ativo");

				Fornecedor myClass = new Fornecedor();
				myClass.setIdfornecedor(Integer.parseInt(idfornecedor));
				myClass.setNome(nome);
				myClass.setCnpj(cnpj);
				myClass.setData_cadastro(data_cadastro);
				myClass.setAtivo(Integer.parseInt(ativo));
				ArrayFornecedor.add(myClass);
			}

			stmt.close();
			jsonFornecedors = new Gson().toJson(ArrayFornecedor);
			return jsonFornecedors;

		} catch (SQLException ex) {
			System.out.println(ex.getMessage());
		}

		return jsonFornecedors;
	}

	public String buscaFornecedorPorId(String queryString) {
		ArrayList<Fornecedor> ArrayFornecedor = new ArrayList<Fornecedor>();
		String jsonFornecedor = "{}";
		try {
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(queryString);
			while (rs.next()) {
				Fornecedor fornecedor = new Fornecedor();
				Endereco endereco = new Endereco();
				
				fornecedor.setIdfornecedor(Integer.parseInt(rs.getString("idfornecedor")));
				fornecedor.setNome(rs.getString("nome"));
				fornecedor.setCnpj(rs.getString("cnpj"));
				fornecedor.setAtivo(Integer.parseInt(rs.getString("ativo")));
				fornecedor.setIdendereco(rs.getString("idendereco"));
				endereco.setCep(rs.getString("cep"));
				endereco.setEndereco(rs.getString("endereco"));
				endereco.setNumero(rs.getString("numero"));
				endereco.setComplemento(rs.getString("complemento"));
				endereco.setCidade(rs.getString("cidade"));
				endereco.setBairro(rs.getString("bairro"));
				fornecedor.setEndereco(endereco);
				
				ArrayFornecedor.add(fornecedor);
			}

			stmt.close();
			jsonFornecedor = new Gson().toJson(ArrayFornecedor);
			return jsonFornecedor;

		} catch (SQLException ex) {
			System.out.println(ex.getMessage());
		}

		return jsonFornecedor;
	}	
	
	
}
