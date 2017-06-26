/*package br.com.gfinanceiro.model;

import br.com.gfinanceiro.model.Categoria;
import br.com.gfinanceiro.model.Cliente;
import br.com.gfinanceiro.model.Fornecedor;
import br.com.gfinanceiro.model.Usuario;

public class Movimentacao {
	
	private int id;
	private String dsc;
	private String cliente_fornecedor;
	private double valor;
	private String tipo_movimentacao;
	private String data_cadastro;
	private String nome_categoria;
	private double entrada;
	private double saida;

	private Cliente cliente;
	private Fornecedor fornecedor;
	private Categoria categoria;
	private Usuario usuario;
	
	public Movimentacao(){
		// Aridade 0
	}

	public Movimentacao(String dsc, String cliente_fornecedor, double valor, String tipo_movimentacao,
			String nome_categoria, double entrada, double saida, Cliente cliente,
			Fornecedor fornecedor, Categoria categoria, Usuario usuario) {
		this.dsc = dsc;
		this.cliente_fornecedor = cliente_fornecedor;
		this.valor = valor;
		this.tipo_movimentacao = tipo_movimentacao;
		this.nome_categoria = nome_categoria;
		this.entrada = entrada;
		this.saida = saida;
		this.cliente = cliente;
		this.fornecedor = fornecedor;
		this.categoria = categoria;
		this.usuario = usuario;
	}



	public int getId() {
		return this.id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDsc() {
		return this.dsc;
	}
	public void setDsc(String dsc) {
		this.dsc = dsc;
	}
	public String getCliente_fornecedor() {
		return this.cliente_fornecedor;
	}
	public void setCliente_fornecedor(String cliente_fornecedor) {
		this.cliente_fornecedor = cliente_fornecedor;
	}
	public double getValor() {
		return this.valor;
	}
	public void setValor(double valor) {
		this.valor = valor;
	}
	public String getTipo_movimentacao() {
		return this.tipo_movimentacao;
	}
	public void setTipo_movimentacao(String tipo_movimentacao) {
		this.tipo_movimentacao = tipo_movimentacao;
	}
	public String getData_cadastro() {
		return this.data_cadastro;
	}
	public void setData_cadastro(String data_cadastro) {
		this.data_cadastro = data_cadastro;
	}
	public String getNome_categoria() {
		return this.nome_categoria;
	}
	public void setNome_categoria(String nome_categoria) {
		this.nome_categoria = nome_categoria;
	}
	public double getEntrada() {
		return this.entrada;
	}
	public void setEntrada(double entrada) {
		this.entrada = entrada;
	}
	public double getSaida() {
		return this.saida;
	}
	public void setSaida(double saida) {
		this.saida = saida;
	}
	public Cliente getCliente() {
		return this.cliente;
	}
	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}
	public Fornecedor getFornecedor() {
		return this.fornecedor;
	}
	public void setFornecedor(Fornecedor fornecedor) {
		this.fornecedor = fornecedor;
	}
	public Categoria getCategoria() {
		return this.categoria;
	}
	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
	}
	public Usuario getUsuario() {
		return this.usuario;
	}
	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}
	
	
	
	@Override
	public String toString() {
		return "Movimentacao [id=" + id + ", dsc=" + dsc + ", cliente_fornecedor=" + cliente_fornecedor + ", valor="
				+ valor + ", tipo_movimentacao=" + tipo_movimentacao + ", data_cadastro=" + data_cadastro
				+ ", nome_categoria=" + nome_categoria + ", entrada=" + entrada + ", saida=" + saida + ", cliente="
				+ cliente + ", fornecedor=" + fornecedor + ", categoria=" + categoria + ", usuario=" + usuario + "]";
	}

	
}
*/