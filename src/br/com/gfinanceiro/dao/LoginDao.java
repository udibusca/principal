package br.com.gfinanceiro.dao;

import java.sql.Connection;
import java.sql.ResultSet;

import br.com.gfinanceiro.bd.DBUtil;

public class LoginDao {

	private Connection connection;
	private String SQL_SELECT = "SELECT * FROM usuario WHERE email = ? AND senha = ?";

	public LoginDao() {
		connection = DBUtil.getConnection();
	}

	public String verificaUsuario(String email, String senha) {
		String nomeUsuario =  null;//"Admin";
		try {
			java.sql.PreparedStatement prepare = connection.prepareStatement(SQL_SELECT);
			prepare.setString(1, email);
			prepare.setString(2, senha);
			ResultSet rs = prepare.executeQuery();
			while (rs.next()) {
				nomeUsuario = rs.getString("nome");
			}
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return nomeUsuario;
	}
}