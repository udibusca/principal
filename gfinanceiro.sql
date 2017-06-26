-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 26-Jun-2017 às 06:23
-- Versão do servidor: 10.1.21-MariaDB
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gfinanceiro`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `categoria`
--

CREATE TABLE `categoria` (
  `idcategoria` int(11) NOT NULL,
  `nome` varchar(200) NOT NULL,
  `dtaCadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ativo` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `categoria`
--

INSERT INTO `categoria` (`idcategoria`, `nome`, `dtaCadastro`, `ativo`) VALUES
(1, 'Contas', '2016-12-13 19:10:15', 1),
(2, 'Vendas', '2016-12-13 19:10:19', 1),
(3, 'Pe&ccedilas', '2016-12-13 19:10:44', 1),
(4, 'Retiradas', '2016-12-13 19:12:28', 1),
(5, 'Salarios', '2016-12-13 19:12:43', 1),
(6, 'FlÃ¡viana', '2016-12-14 02:07:28', 0),
(7, 'Pagamento de bancos', '2017-05-24 00:06:47', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `cliente`
--

CREATE TABLE `cliente` (
  `idcliente` int(11) NOT NULL,
  `nome` varchar(200) DEFAULT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `data_cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ativo` int(11) NOT NULL DEFAULT '1',
  `saldo` decimal(7,2) DEFAULT NULL,
  `endereco_idendereco` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `cliente`
--

INSERT INTO `cliente` (`idcliente`, `nome`, `cpf`, `data_cadastro`, `ativo`, `saldo`, `endereco_idendereco`) VALUES
(1, 'Natasha Castro Alves', '08276821669', '2016-12-13 22:28:51', 1, '489.00', 1),
(2, 'Bruno Benicio Do Nascimento', '01886706611', '2016-12-13 22:28:51', 1, '86.04', 1),
(3, 'Carlos Eduardo Henry Gomes', '56253022270', '2016-12-18 20:55:43', 1, '415.79', 1),
(4, 'Joana Isabella Alves', '93214424726', '2016-12-18 20:56:56', 1, '800.91', 1),
(6, 'Carla Leticia', '39472771807', '2017-06-24 06:53:52', 1, '55.55', 92),
(7, 'Arthur Giovanni Bruno Barbosa', '09800821619', '2017-06-26 02:26:27', 1, '400.00', 96);

-- --------------------------------------------------------

--
-- Estrutura da tabela `endereco`
--

CREATE TABLE `endereco` (
  `idendereco` int(11) NOT NULL,
  `endereco` varchar(50) DEFAULT NULL,
  `numero` varchar(10) DEFAULT NULL,
  `complemento` varchar(30) DEFAULT NULL,
  `cidade` varchar(30) DEFAULT NULL,
  `bairro` varchar(30) DEFAULT NULL,
  `cep` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `endereco`
--

INSERT INTO `endereco` (`idendereco`, `endereco`, `numero`, `complemento`, `cidade`, `bairro`, `cep`) VALUES
(1, 'Travessa CanÃ¡polis', '137', 'Casa', 'Uberlandia', 'Osvaldo Resende', '38500000'),
(92, 'Rua 34', '5555', 'casa 1', 'Ubrlandia', 'Osvaldo', '555555'),
(94, 'Rua 22', '87', 'predio 2', 'Uberlandia', 'Centro', '98765'),
(95, 'Rua Dalva Tereza Moraes', '217', 'Predio', 'Juiz de Fora', 'Granjas GuarujÃ?Â¡', '36048-560'),
(96, 'Avenida Edgard de Oliveira Castro', '433', 'Casa', 'UberlÃ¢ndia', 'Conjunto Alvorada', '38407-048');

-- --------------------------------------------------------

--
-- Estrutura da tabela `fornecedor`
--

CREATE TABLE `fornecedor` (
  `idfornecedor` int(11) NOT NULL,
  `nome` varchar(200) DEFAULT NULL,
  `cnpj` varchar(18) DEFAULT NULL,
  `ativo` int(11) NOT NULL DEFAULT '1',
  `data_cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idendereco` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `fornecedor`
--

INSERT INTO `fornecedor` (`idfornecedor`, `nome`, `cnpj`, `ativo`, `data_cadastro`, `idendereco`) VALUES
(1, 'AMBEv LTDA', '07526557000100', 1, '2016-12-13 20:53:38', 1),
(2, 'Harman do brasil', '88315379000170', 1, '2016-12-13 22:30:44', 1),
(3, 'Pietra e Lara Marcenaria Ltda', '72719536000172', 1, '2016-12-18 20:52:24', 1),
(4, 'Antonella e Arthur Entulhos Ltda', '45220804000134', 1, '2016-12-18 20:52:59', 1),
(5, 'Nicolas e Juan Adega Ltda', '24134346000140', 1, '2016-12-18 20:53:15', 1),
(6, 'Isaac e Rafael Telecom ME', '88625575000140', 0, '2016-12-18 20:54:57', 1),
(7, 'Vendedor anonimo', '88315379000170', 0, '2017-06-24 07:23:44', 94),
(8, 'Theo e Olivia Lavanderia Ltda', '01737968000168', 1, '2017-06-26 02:24:03', 95);

-- --------------------------------------------------------

--
-- Estrutura da tabela `movimentacao`
--

CREATE TABLE `movimentacao` (
  `idmovimentacao` int(11) NOT NULL,
  `data_cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `valor` decimal(7,2) DEFAULT NULL,
  `tipo_movimentacao` int(11) NOT NULL COMMENT 'Exemplo: 1 para entrada 2 para saída',
  `dsc` text,
  `fornecedor_idfornecedor` int(11) DEFAULT NULL,
  `cliente_idcliente` int(11) DEFAULT NULL,
  `categoria_idcategoria` int(11) NOT NULL,
  `usuario_idusuario` int(11) NOT NULL,
  `ativo` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `movimentacao`
--

INSERT INTO `movimentacao` (`idmovimentacao`, `data_cadastro`, `valor`, `tipo_movimentacao`, `dsc`, `fornecedor_idfornecedor`, `cliente_idcliente`, `categoria_idcategoria`, `usuario_idusuario`, `ativo`) VALUES
(1, '2016-12-13 22:29:25', '45.99', 1, 'Venda de fone 00900', NULL, 1, 2, 17, 1),
(2, '2016-12-13 22:31:10', '-10.50', 2, 'Compra de fone para venda', 2, NULL, 3, 17, 1),
(3, '2016-12-18 20:58:08', '100.00', 1, 'Venda de produto', NULL, 3, 2, 18, 1),
(4, '2016-12-18 20:59:13', '-300.45', 2, 'Compras estoque', 4, NULL, 3, 20, 1),
(6, '2017-05-13 05:04:20', '1.00', 1, 'teste', NULL, 1, 1, 17, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL,
  `nome` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `usuario` varchar(100) DEFAULT NULL,
  `senha` varchar(100) DEFAULT NULL,
  `ativo` varchar(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nome`, `email`, `usuario`, `senha`, `ativo`) VALUES
(17, 'Andre Luiz', 'alpmidia@gmail.com', 'andre', '123', '1'),
(18, 'Natasha', 'natasha@gmail.com', 'nat', '222', '1'),
(19, 'Bruno', 'bbn_d7@hotmail.com.br', 'bbn_d7@hotmail.com.br', '123', '0'),
(20, 'Maria do Carmo', 'maria@gmail', 'maria', '123', '0');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idcategoria`);

--
-- Indexes for table `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`idcliente`),
  ADD KEY `fk_cliente_endereco` (`endereco_idendereco`);

--
-- Indexes for table `endereco`
--
ALTER TABLE `endereco`
  ADD PRIMARY KEY (`idendereco`);

--
-- Indexes for table `fornecedor`
--
ALTER TABLE `fornecedor`
  ADD PRIMARY KEY (`idfornecedor`),
  ADD KEY `fk_fornecedor_endereco` (`idendereco`);

--
-- Indexes for table `movimentacao`
--
ALTER TABLE `movimentacao`
  ADD PRIMARY KEY (`idmovimentacao`),
  ADD KEY `fk_movimentacao_fornecedor_idx` (`fornecedor_idfornecedor`),
  ADD KEY `fk_movimentacao_cliente1_idx` (`cliente_idcliente`),
  ADD KEY `fk_movimentacao_categoria1_idx` (`categoria_idcategoria`),
  ADD KEY `fk_movimentacao_usuario` (`usuario_idusuario`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `cliente`
--
ALTER TABLE `cliente`
  MODIFY `idcliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `endereco`
--
ALTER TABLE `endereco`
  MODIFY `idendereco` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;
--
-- AUTO_INCREMENT for table `fornecedor`
--
ALTER TABLE `fornecedor`
  MODIFY `idfornecedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `movimentacao`
--
ALTER TABLE `movimentacao`
  MODIFY `idmovimentacao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `fk_cliente_endereco` FOREIGN KEY (`endereco_idendereco`) REFERENCES `endereco` (`idendereco`);

--
-- Limitadores para a tabela `fornecedor`
--
ALTER TABLE `fornecedor`
  ADD CONSTRAINT `fk_fornecedor_endereco` FOREIGN KEY (`idendereco`) REFERENCES `endereco` (`idendereco`);

--
-- Limitadores para a tabela `movimentacao`
--
ALTER TABLE `movimentacao`
  ADD CONSTRAINT `fk_movimentacao_categoria1` FOREIGN KEY (`categoria_idcategoria`) REFERENCES `categoria` (`idcategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_movimentacao_cliente1` FOREIGN KEY (`cliente_idcliente`) REFERENCES `cliente` (`idcliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_movimentacao_fornecedor` FOREIGN KEY (`fornecedor_idfornecedor`) REFERENCES `fornecedor` (`idfornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_movimentacao_usuario` FOREIGN KEY (`usuario_idusuario`) REFERENCES `usuario` (`idusuario`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
