package br.com.gfinanceiro.dao;

import java.sql.Connection;
import java.sql.SQLException;

import br.com.gfinanceiro.bd.DBUtil;
import br.com.gfinanceiro.model.Cliente;
import br.com.gfinanceiro.model.Endereco;
import br.com.gfinanceiro.model.Fornecedor;

public class EnderecoDao {
	private Connection connection;

	public EnderecoDao() {
		connection = DBUtil.getConnection();
	}
	public void addEndereco(Endereco endereco){
		try {
			java.sql.PreparedStatement prepare = connection
					.prepareStatement("INSERT INTO endereco (endereco,numero,complemento,cidade,bairro,cep) VALUES (?,?,?,?,?,?)");
			prepare.setString(1,endereco.getEndereco());
			prepare.setString(2,endereco.getNumero());
			prepare.setString(3,endereco.getComplemento());
			prepare.setString(4,endereco.getCidade());
			prepare.setString(5,endereco.getBairro());
			prepare.setString(6,endereco.getCep());
			prepare.executeUpdate();
			
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}		
	}
	public void updateEndereco(Object cliente_fornecedor,Endereco endereco) {
		try {		
			java.sql.PreparedStatement prepare = connection.prepareStatement(
			"UPDATE endereco SET endereco=?,numero=?,complemento=?,cidade=?,bairro=?,cep=? WHERE idendereco = ?");
			prepare.setString(1, endereco.getEndereco());
			prepare.setString(2, endereco.getNumero());
			prepare.setString(3, endereco.getComplemento());
			prepare.setString(4, endereco.getCidade());
			prepare.setString(5, endereco.getBairro());
			prepare.setString(6, endereco.getCep());
		     if(cliente_fornecedor instanceof Cliente){
		    	  Cliente temp = (Cliente) cliente_fornecedor;
		    	  int idendereco = Integer.parseInt(temp.getEndereco_idendereco());
				  prepare.setInt(7, idendereco);
		      }else if(cliente_fornecedor instanceof Fornecedor) {
		    	  Fornecedor temp = (Fornecedor) cliente_fornecedor;
		    	  int idendereco = Integer.parseInt(temp.getIdendereco());
				  prepare.setInt(7, idendereco);
		      }		
			prepare.executeUpdate();
			
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}	
}
