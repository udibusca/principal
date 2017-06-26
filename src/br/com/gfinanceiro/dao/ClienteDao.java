package br.com.gfinanceiro.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import com.google.gson.Gson;
import br.com.gfinanceiro.bd.DBUtil;
import br.com.gfinanceiro.model.Cliente;
import br.com.gfinanceiro.model.Endereco;

public class ClienteDao {

	private Connection connection;
	private int endereco_idendereco;

	public ClienteDao() {
		connection = DBUtil.getConnection();
	}
	// Todos selects da Classe cliente
	public String getAllCliente(int limit) {
		ClienteDao obj = new ClienteDao();
		String sql = "SELECT * FROM cliente where ativo = 1 ORDER BY idcliente limit " + limit;
		return obj.getAllCliente(sql);
	}
	public String buscaClientePorId(int idcliente) {
		ClienteDao obj = new ClienteDao();
		String sql = "select * from cliente cli inner join endereco end on (cli.endereco_idendereco = end.idendereco) where cli.idcliente ="+idcliente;
		return obj.buscaClientePorId(sql);
	}
	public String buscaClientePorCpf(String cpf) {
		ClienteDao obj = new ClienteDao();
		String sql = "select * from cliente cli inner join endereco end on (cli.endereco_idendereco = end.idendereco) where cli.cpf="+cpf;
		return obj.buscaClientePorId(sql);
	}
	public String buscaClientePorNome(String nome) {
		ClienteDao obj = new ClienteDao();
		String sql = "select * from cliente cli inner join endereco end on (cli.endereco_idendereco = end.idendereco) where cli.nome like = '%"+nome+"%'";
		return obj.buscaClientePorId(sql);
	}	
	// CRUD - addCliente / deleteCliente / updateCliente / buscaClientePorId
	public void addCliente(Cliente cliente) {
		try {
			java.sql.PreparedStatement prepare = connection
					.prepareStatement("INSERT INTO cliente (nome,cpf,ativo,saldo,endereco_idendereco) VALUES (?,?,?,?,?)");
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT MAX(e.idendereco) as id FROM endereco e");
			rs.next();
			endereco_idendereco = rs.getInt("id");
			prepare.setString(1, cliente.getNome());
			prepare.setString(2, cliente.getCpf());
			prepare.setInt(3, cliente.getAtivo());
			prepare.setString(4, cliente.getSaldo());
			prepare.setLong(5, endereco_idendereco);	
			prepare.executeUpdate();
			
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}
	public void deleteCliente(int idcliente) {
		try {
			java.sql.PreparedStatement prepare = connection.prepareStatement("UPDATE cliente set ativo = 0 WHERE idcliente = ?");
			prepare.setInt(1, idcliente);
			prepare.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}
	public void updateSaldo(int idcliente, String saldo) {
		try {
			java.sql.PreparedStatement prepare = connection.prepareStatement("UPDATE cliente set saldo = ? WHERE idcliente = ?");
			prepare.setString(1, saldo);
			prepare.setInt(2, idcliente);
			prepare.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}
	public void updateCliente(Cliente cliente) {
		try {
			java.sql.PreparedStatement prepare = connection.prepareStatement(
					"UPDATE cliente SET nome = ?, cpf = ?, ativo = ?, saldo=? WHERE idcliente = ?");
			prepare.setString(1, cliente.getNome());
			prepare.setString(2, cliente.getCpf());
			prepare.setInt(3, cliente.getAtivo());
			prepare.setString(4, cliente.getSaldo());
			prepare.setInt(5, cliente.getIdcliente());
			prepare.executeUpdate();
			
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}
	
	public String getAllCliente(String queryString) {
		ArrayList<Cliente> ArrayCliente = new ArrayList<Cliente>();
		String jsonClientes = "{}";

		try {
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(queryString);
			while (rs.next()) {
				Cliente cliente = new Cliente();
				
				cliente.setIdcliente(Integer.parseInt(rs.getString("idcliente")));
				cliente.setNome(rs.getString("nome"));
				cliente.setCpf(rs.getString("cpf"));
				cliente.setData_cadastro(rs.getString("data_cadastro"));
				cliente.setSaldo(rs.getString("saldo"));
				cliente.setAtivo(Integer.parseInt(rs.getString("ativo")));
				ArrayCliente.add(cliente);
			}

			stmt.close();
			jsonClientes = new Gson().toJson(ArrayCliente);
			return jsonClientes;

		} catch (SQLException ex) {
			System.out.println(ex.getMessage());
		}

		return jsonClientes;
	}
	public String buscaClientePorId(String queryString) {
		ArrayList<Cliente> ArrayCliente = new ArrayList<Cliente>();		
		String jsonCliente = "{}";

		try {
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(queryString);
			
			while (rs.next()) {
				Cliente cliente = new Cliente();
				Endereco endereco = new Endereco();
				
    			cliente.setIdcliente(Integer.parseInt(rs.getString("idcliente")));
				cliente.setNome(rs.getString("nome"));
				cliente.setCpf(rs.getString("cpf"));
				cliente.setData_cadastro(rs.getString("data_cadastro"));
				cliente.setSaldo(rs.getString("saldo"));
				cliente.setAtivo(Integer.parseInt(rs.getString("ativo")));
				cliente.setEndereco_idendereco(rs.getString("endereco_idendereco"));
				endereco.setCep(rs.getString("cep"));
				endereco.setEndereco(rs.getString("endereco"));
				endereco.setNumero(rs.getString("numero"));
				endereco.setComplemento(rs.getString("complemento"));
				endereco.setCidade(rs.getString("cidade"));
				endereco.setBairro(rs.getString("bairro"));
				cliente.setEndereco(endereco);
				
				ArrayCliente.add(cliente);
			}

			stmt.close();
			jsonCliente = new Gson().toJson(ArrayCliente);
			return jsonCliente;

		} catch (SQLException ex) {
			System.out.println(ex.getMessage());
		}

		return jsonCliente;
	}
}
