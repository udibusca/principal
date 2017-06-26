package br.com.gfinanceiro.model;
public class Cliente  {
	private int idcliente;
	private String nome;
	private String cpf;
	private int ativo;
	private String data_cadastro;
	private String saldo;
	private String endereco_idendereco;
	private Endereco endereco;
	
	public Cliente(){
		
	}
	public Cliente(String nome, String cpf, int ativo, String saldo,
			int idendereco, String endereco, String numero, String complemento, String cidade, String bairro,String cep) {
		this.nome = nome;
		this.cpf = cpf;
		this.ativo = ativo;
		this.saldo = saldo;
	    this.endereco = new Endereco (idendereco,endereco,numero,complemento,cidade, bairro,cep);
	}
	public String getSaldo() {
		return saldo;
	}
	public void setSaldo(String saldo) {
		this.saldo = saldo;
	}
	public int getIdcliente() {
		return idcliente;
	}
	public void setIdcliente(int idcliente) {
		this.idcliente = idcliente;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getCpf() {
		return cpf;
	}
	public void setCpf(String cpf) {
		this.cpf = cpf;
	}
	public int getAtivo() {
		return ativo;
	}
	public void setAtivo(int ativo) {
		this.ativo = ativo;
	}
	public String getData_cadastro() {
		return data_cadastro;
	}
	public void setData_cadastro(String data_cadastro) {
		this.data_cadastro = data_cadastro;
	}
	public Endereco getEndereco() {
		return endereco;
	}	
	public void setEndereco(Endereco endereco) {
		this.endereco = endereco;
	}
	public String getEndereco_idendereco() {
		return endereco_idendereco;
	}
	public void setEndereco_idendereco(String endereco_idendereco) {
		this.endereco_idendereco = endereco_idendereco;
	}
	
}
