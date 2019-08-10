--liquibase formatted sql
INSERT INTO pessoa (nome,   cpf,           id_sit) 
            VALUES ('João', '41807998045', 'A');
GO
INSERT INTO pessoa (nome,   cpf,           id_sit) 
            VALUES ('Maria', '29892473000', 'A');
GO
INSERT INTO pessoa (nome,   cpf,           id_sit) 
            VALUES ('José', '44549122030', 'E');
GO
INSERT INTO pfisica(pessoa_id, sexo, data_aniversario, estado_civil) 
            VALUES (1,          'M',     '1982-05-22',   'SOLTEIRO');
GO
INSERT INTO pfisica(pessoa_id, sexo, data_aniversario, estado_civil) 
            VALUES (2,          'F',     '1991-12-05',     'CASADO');
GO
INSERT INTO pfisica(pessoa_id, sexo, data_aniversario, estado_civil) 
            VALUES (3,          'M',     '1987-04-01',   'SOLTEIRO');
GO
INSERT INTO conta(agencia, numero_conta, digito_conta, data_abertura, data_encerramento, pessoa_id) 
          VALUES (1,              32434, 1,  '2005-06-03', null, 1);
GO
INSERT INTO conta(agencia, numero_conta, digito_conta, data_abertura, data_encerramento, pessoa_id) 
          VALUES (1,              39818, 0,  '2018-09-04', null, 2);
GO
INSERT INTO conta(agencia, numero_conta, digito_conta, data_abertura, data_encerramento, pessoa_id) 
          VALUES (1,              36168, 8,  '2019-01-02', '2019-08-09', 3);
GO
INSERT INTO saldo(agencia, numero_conta, digito_conta,   data_saldo, vr_saldo)
          VALUES (1      ,        32434,            1, '2019-08-01', 1000.00);
INSERT INTO saldo(agencia, numero_conta, digito_conta,   data_saldo, vr_saldo)
          VALUES (1      ,        39818,            0, '2019-08-01', 500.00);
INSERT INTO saldo(agencia, numero_conta, digito_conta,   data_saldo, vr_saldo)
          VALUES (1      ,        36168,            8, '2019-08-09',  0.00);