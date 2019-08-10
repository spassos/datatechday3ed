--liquibase formatted sql
-- Create the stored procedure in the specified schema
CREATE OR ALTER PROCEDURE dbo.spt_abre_conta
@p_agencia      int,
@p_numero_conta int,
@p_digito_conta int,
@p_pessoa_id    int,
@p_usuario      varchar(20),
@p_ip           varchar(15),
@p_retorno      varchar(1000) output
AS
    declare @v_data_atual datetime;
    set @v_data_atual = getdate();
    if @p_agencia is NULL or @p_numero_conta is null or @p_digito_conta is null
    begin
        INSERT INTO log (mensagem, data_log, usuario, ip)
                  VALUES('400 - (spt_abre_conta) - Favor informar os dados para a abertura da conta!', @v_data_atual, @p_usuario, @p_ip);
        set @p_retorno = '{codigo: 400, mensagem: "Favor informar os dados para a abertura da conta!", status: "ERRO"}';
    end

    if exists(select 1 from pessoa where id = @p_pessoa_id and id_sit = 'E')
    begin
        INSERT INTO log (mensagem, data_log, usuario, ip)
                  VALUES('400 - (spt_abre_conta) - Cadastro do cliente excluído!', @v_data_atual, @p_usuario, @p_ip);
        set @p_retorno = '{codigo: 400, mensagem: "Cadastro do cliente excluído!", status: "ERRO"}';
    end

begin TRY
    insert into  conta (   agencia,    numero_conta,    digito_conta, data_abertura,    pessoa_id) 
                values (@p_agencia, @p_numero_conta, @p_digito_conta, @v_data_atual, @p_pessoa_id);
    insert into  saldo (agencia, numero_conta, digito_conta,   data_saldo, vr_saldo)
                values (@p_agencia, @p_numero_conta, @p_digito_conta, @v_data_atual, 0.00);
    
    INSERT INTO log (mensagem, data_log, usuario, ip)
                  VALUES('100 - (spt_abre_conta) - Conta aberta com sucesso!', @v_data_atual, @p_usuario, @p_ip);
        set @p_retorno = '{codigo: 100, mensagem: "Conta aberta com sucesso!", status: "SUCESSO"}';
end TRY
begin CATCH
    INSERT INTO log (mensagem, data_log, usuario, ip)
                  VALUES('400 - (spt_abre_conta) - Erro interno!', @v_data_atual, @p_usuario, @p_ip);
        set @p_retorno = '{codigo: 400, mensagem: "Erro interno!", status: "ERRO"}';
end CATCH


select  pessoa.nome,        pessoa.cpf,     conta.agencia,      conta.numero_conta, 
        conta.digito_conta
from pessoa
join conta on   pessoa.id           = conta.pessoa_id
where   pessoa.id          = @p_pessoa_id     and conta.agencia =  @p_agencia 
    and conta.numero_conta = @p_numero_conta  and conta.digito_conta = @p_digito_conta
for json auto