package br.com.gfinanceiro.model;
public class Fornecedor {
	private int idfornecedor;
	private String nome;
	private String cnpj;
	private int ativo;
	private String data_cadastro;
	private String idendereco;
	private Endereco endereco;
	public Fornecedor() {

	}	
	public Fornecedor(String nome, String cnpj, int ativo,
			int idendereco, String endereco, String numero, String complemento, String cidade, String bairro,String cep) {
		this.nome = nome;
		this.cnpj = cnpj;
		this.ativo = ativo;
		this.endereco = new Endereco (idendereco,endereco,numero,complemento,cidade, bairro,cep);
	}	
	public int getIdfornecedor() {
		return idfornecedor;
	}

	public void setIdfornecedor(int idfornecedor) {
		this.idfornecedor = idfornecedor;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCnpj() {
		return cnpj;
	}

	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
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
	public String getIdendereco() {
		return idendereco;
	}
	public void setIdendereco(String idendereco) {
		this.idendereco = idendereco;
	}
	
}
