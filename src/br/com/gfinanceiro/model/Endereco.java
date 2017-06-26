package br.com.gfinanceiro.model;
public class Endereco {
	private int idendereco;
	private String endereco;
	private String numero;
	private String complemento;
	private String cidade;
	private String bairro;
	private String cep;
	
	public Endereco(){
		// construtor de aridade 0
	}
	public Endereco(int idendereco){
		this.idendereco = idendereco;
	}
	
	public Endereco(int idendereco, String endereco, String numero, String complemento, String cidade, String bairro,String cep) {
		this.idendereco = idendereco;
		this.endereco = endereco;
		this.numero = numero;
		this.complemento = complemento;
		this.cidade = cidade;
		this.bairro = bairro;
		this.cep = cep;
	}
	public int getIdendereco() {
		return this.idendereco;
	}
	public void setIdendereco(int idendereco) {
		this.idendereco = idendereco;
	}
	public String getEndereco() {
		return this.endereco;
	}
	public void setEndereco(String endereco) {
		this.endereco = endereco;
	}
	public String getNumero() {
		return this.numero;
	}
	public void setNumero(String numero) {
		this.numero = numero;
	}
	public String getComplemento() {
		return this.complemento;
	}
	public void setComplemento(String complemento) {
		this.complemento = complemento;
	}
	public String getCidade() {
		return this.cidade;
	}
	public void setCidade(String cidade) {
		this.cidade = cidade;
	}
	public String getBairro() {
		return this.bairro;
	}
	public void setBairro(String bairro) {
		this.bairro = bairro;
	}
	public String getCep() {
		return this.cep;
	}
	public void setCep(String cep) {
		this.cep = cep;
	}
	public String toString() {
		return "Endereco [idendereco=" + this.idendereco + ", endereco=" + this.endereco + ", numero=" + this.numero + ", complemento="
				+ this.complemento + ", cidade=" + this.cidade + ", bairro=" + this.bairro + ", cep=" + this.cep + "]";
	}
}
