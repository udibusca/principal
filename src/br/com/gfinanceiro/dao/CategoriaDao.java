package br.com.gfinanceiro.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.google.gson.Gson;

import br.com.gfinanceiro.bd.DBUtil;
import br.com.gfinanceiro.model.Categoria;

public class CategoriaDao {

	private Connection connection;

	public CategoriaDao() {
		connection = DBUtil.getConnection();
	}

	// Todos selects da Classe categoria
	public String getAllCategoria(int limit) {
		CategoriaDao obj = new CategoriaDao();
		String sql = "SELECT * FROM categoria where ativo = 1 ORDER BY idcategoria limit " + limit;
		return obj.getAllCategoria(sql);
	}
	
	public String getCategoriaPorId(int idcategoria) {
		CategoriaDao obj = new CategoriaDao();
		String sql = "select * from categoria where idcategoria="+idcategoria;
		return obj.getCategoriaPorId(sql);
	}

	// CRUD - addCategoria / deleteCategoria / updateCategoria / getCategoriaById
	public void addCategoria(Categoria categoria) {
		try {
			java.sql.PreparedStatement prepare = connection
					.prepareStatement("INSERT INTO categoria (nome,ativo) VALUES (?,?)");
			prepare.setString(1, categoria.getNome());
			prepare.setInt(2, categoria.getAtivo());
			prepare.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void deleteCategoria(int idcategoria) {
		try {
			java.sql.PreparedStatement prepare = connection.prepareStatement("UPDATE categoria set ativo = 0 WHERE idcategoria = ?");
			prepare.setInt(1, idcategoria);
			prepare.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void updateCategoria(Categoria categoria) {
		try {
			java.sql.PreparedStatement prepare = connection.prepareStatement(
					"UPDATE categoria SET nome = ?,ativo = ? WHERE idcategoria = ?");
			prepare.setString(1, categoria.getNome());
			prepare.setInt(2, categoria.getAtivo());
			prepare.setInt(3, categoria.getIdcategoria());
			prepare.executeUpdate();

		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public String getAllCategoria(String queryString) {

		ArrayList<Categoria> ArrayCategoria = new ArrayList<Categoria>();
		String jsonCategorias = "{}";

		try {
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(queryString);
			while (rs.next()) {
				String idcategoria = rs.getString("idcategoria");
				String nome = rs.getString("nome");
				String dtaCadastro	= rs.getString("dtaCadastro");
				String ativo = rs.getString("ativo");

				Categoria myClass = new Categoria();
				myClass.setIdcategoria(Integer.parseInt(idcategoria));
				myClass.setNome(nome);
				myClass.setDtaCadastro(dtaCadastro);
				myClass.setAtivo(Integer.parseInt(ativo));
				ArrayCategoria.add(myClass);
			}

			stmt.close();
			jsonCategorias = new Gson().toJson(ArrayCategoria);
			return jsonCategorias;

		} catch (SQLException ex) {
			System.out.println(ex.getMessage());
		}

		return jsonCategorias;
	}

	public String getCategoriaPorId(String queryString) {
		ArrayList<Categoria> ArrayCategoria = new ArrayList<Categoria>();
		String jsonCategoria = "{}";
		// Integer.valueOf(request.getParameter("idcategoria"))
		try {
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(queryString);
			while (rs.next()) {
				String idcategoria = rs.getString("idcategoria");
				String nome = rs.getString("nome");
				String ativo = rs.getString("ativo");

				Categoria myClass = new Categoria();
				myClass.setIdcategoria(Integer.parseInt(idcategoria));
				myClass.setNome(nome);
				myClass.setAtivo(Integer.parseInt(ativo));
				ArrayCategoria.add(myClass);
			}

			stmt.close();
			jsonCategoria = new Gson().toJson(ArrayCategoria);
			return jsonCategoria;

		} catch (SQLException ex) {
			System.out.println(ex.getMessage());
		}

		return jsonCategoria;
	}	
	
	
}
