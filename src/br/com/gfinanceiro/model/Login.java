package br.com.gfinanceiro.model;
public class Login {

	private String email;
	private String senha;
	private int ativo;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSenha() {
		return senha;
	}
	public void setSenha(String senha) {
		this.senha = senha;
	}
	public int getAtivo() {
		return ativo;
	}
	public void setAtivo(int ativo) {
		this.ativo = ativo;
	}	
	
	@Override
	public String toString() {
		return "Login [email="+email+", senha="+senha+", ativo="+ativo+"]";
	}
	
	
}