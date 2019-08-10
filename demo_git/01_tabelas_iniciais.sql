--liquibase formatted sql
CREATE TABLE pessoa
(
  id      INT NOT NULL IDENTITY ,
  nome   VARCHAR(100)           ,
  cpf    VARCHAR(11)            ,
  id_sit CHAR(1)                ,
  PRIMARY KEY(id)
);
GO
CREATE TABLE pfisica
(
  pessoa_id         INT     NOT NULL,
  sexo              CHAR(1) NOT NULL,
  data_aniversario  DATE            ,
  estado_civil      VARCHAR(20)     ,
  PRIMARY KEY(pessoa_id)            ,
  FOREIGN KEY(pessoa_id)
    REFERENCES pessoa(id)
);
GO
CREATE INDEX fk_pfisica ON pfisica (pessoa_id);
GO
CREATE TABLE conta
(
  agencia           INT NOT NULL ,
  numero_conta      INT NOT NULL ,
  digito_conta      INT NOT NULL ,
  data_abertura     DATE         ,   
  data_encerramento DATE         ,
  pessoa_id         INT NOT NULL ,
  PRIMARY KEY(agencia, numero_conta, digito_conta)  ,
  FOREIGN KEY(pessoa_id)
    REFERENCES pessoa(id)
);
GO
CREATE INDEX fk_conta ON conta (pessoa_id);
GO
CREATE TABLE saldo
(
  agencia        INT NOT NULL    ,
  numero_conta   INT NOT NULL    ,
  digito_conta   INT NOT NULL    ,
  data_saldo     DATE            ,
  vr_saldo       NUMERIC(18,2)   ,
  PRIMARY KEY(agencia, numero_conta, digito_conta)  ,
  FOREIGN KEY(agencia, numero_conta, digito_conta)
    REFERENCES conta(agencia, numero_conta, digito_conta)
);
GO
CREATE INDEX fk_saldo ON saldo (agencia, numero_conta, digito_conta);
GO