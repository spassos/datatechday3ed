--liquibase formatted sql
create table log
(
    id          INT NOT NULL IDENTITY,
    mensagem    VARCHAR(1000),
    data_log    DATETIME,
    usuario     VARCHAR(20),
    ip          VARCHAR(15)
);