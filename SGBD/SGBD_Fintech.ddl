-- Gerado por Oracle SQL Developer Data Modeler 21.4.2.059.0838
--   em:        2022-05-23 16:54:38 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE t_bairro (
    cd_bairro NUMBER(2) NOT NULL,
    ds_bairro VARCHAR2(25) NOT NULL
);

ALTER TABLE t_bairro ADD CONSTRAINT t_bairro_pk PRIMARY KEY ( cd_bairro );

CREATE TABLE t_beneficiario (
    cd_beneficiario NUMBER(2) NOT NULL,
    ds_beneficiario VARCHAR2(30) NOT NULL
);

ALTER TABLE t_beneficiario ADD CONSTRAINT t_beneficiario_pk PRIMARY KEY ( cd_beneficiario );

CREATE TABLE t_cidade (
    cd_cidade NUMBER(2) NOT NULL,
    ds_cidade VARCHAR2(30) NOT NULL,
    cd_cep    NUMBER(8)
);

ALTER TABLE t_cidade ADD CONSTRAINT t_cidade_pk PRIMARY KEY ( cd_cidade );

CREATE TABLE t_crypto (
    cd_crypto                                        NUMBER(3) NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    t_tipo_transacao_crypto_cd_tipo_transacao_crypto NUMBER(1) NOT NULL,
    t_usuario_ds_email                               VARCHAR2(30) NOT NULL,
    nr_quantidade                                    NUMBER(10, 3) NOT NULL,
    ds_data                                          DATE NOT NULL,
    ds_mes                                           unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    ds_ano                                           unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    ds_horario                                       DATE NOT NULL
);

ALTER TABLE t_crypto ADD CONSTRAINT t_crypto_pk PRIMARY KEY ( cd_crypto );

CREATE TABLE t_detalhe_transacao (
    ds_tipo_transacao VARCHAR2(10) NOT NULL,
    nm_origem         VARCHAR2(30) NOT NULL,
    nm_destino        VARCHAR2(30) NOT NULL
);

ALTER TABLE t_detalhe_transacao ADD CONSTRAINT t_detalhe_transacao_pk PRIMARY KEY ( ds_tipo_transacao );

CREATE TABLE t_empresa (
    nm_empresa         VARCHAR2(20) NOT NULL,
    t_usuario_ds_email VARCHAR2(30) NOT NULL
);

ALTER TABLE t_empresa ADD CONSTRAINT t_empresa_pk PRIMARY KEY ( nm_empresa );

CREATE TABLE t_estado (
    cd_estado NUMBER(2) NOT NULL,
    ds_estado VARCHAR2(25) NOT NULL
);

ALTER TABLE t_estado ADD CONSTRAINT t_estado_pk PRIMARY KEY ( cd_estado );

CREATE TABLE t_logradouro (
    cd_logradouro                 NUMBER(2) NOT NULL,
    t_cidade_cd_cidade            NUMBER(2) NOT NULL,
    t_bairro_cd_bairro            NUMBER(2) NOT NULL,
    t_numero_logradouro_cd_numero NUMBER(3) NOT NULL,
    t_estado_cd_estado            NUMBER(2) NOT NULL
);

ALTER TABLE t_logradouro ADD CONSTRAINT t_logradouro_pk PRIMARY KEY ( cd_logradouro );

CREATE TABLE t_numero_logradouro (
    cd_numero NUMBER(3) NOT NULL,
    ds_numero NUMBER(5) NOT NULL
);

ALTER TABLE t_numero_logradouro ADD CONSTRAINT t_numero_logradouro_pk PRIMARY KEY ( cd_numero );

CREATE TABLE t_tipo_transacao (
    cd_tipo_transacao NUMBER(1) NOT NULL,
    ds_tipo_transacao VARCHAR2(10) NOT NULL
);

ALTER TABLE t_tipo_transacao ADD CONSTRAINT t_tipo_transacao_pk PRIMARY KEY ( cd_tipo_transacao );

CREATE TABLE t_tipo_transacao_crypto (
    cd_tipo_transacao_crypto NUMBER(1) NOT NULL,
    ds_transacao             VARCHAR2(10) NOT NULL
);

ALTER TABLE t_tipo_transacao_crypto ADD CONSTRAINT t_tipo_transacao_crypto_pk PRIMARY KEY ( cd_tipo_transacao_crypto );

CREATE TABLE t_transacao_empresa (
    cd_transacao                          NUMBER(10) NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    t_detalhe_transacao_ds_tipo_transacao VARCHAR2(10) NOT NULL,
    t_empresa_nm_empresa                  VARCHAR2(20) NOT NULL,
    nr_quantidade                         NUMBER(7, 2) NOT NULL,
    ds_data                               DATE NOT NULL,
    ds_mes                                unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    ds_ano                                unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    ds_horario                            DATE NOT NULL,
    ds_tipo_transacao                     VARCHAR2(10) NOT NULL
);

ALTER TABLE t_transacao_empresa ADD CONSTRAINT t_transacao_empresa_pk PRIMARY KEY ( cd_transacao );

CREATE TABLE t_transacao_usuario (
    cd_transacao_usuario               NUMBER(10) NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    t_tipo_transacao_cd_tipo_transacao NUMBER(1) NOT NULL,
    t_beneficiario_cd_beneficiario     NUMBER(2) NOT NULL,
    t_usuario_ds_email                 VARCHAR2(30) NOT NULL,
    nr_quantidade                      NUMBER(7, 2) NOT NULL,
    ds_data                            DATE NOT NULL,
    ds_mes                             unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    ds_ano                             unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    ds_horario                         DATE NOT NULL
);

ALTER TABLE t_transacao_usuario ADD CONSTRAINT t_transacao_usuario_pk PRIMARY KEY ( cd_transacao_usuario );

CREATE TABLE t_usuario (
    ds_email   VARCHAR2(30) NOT NULL,
    ds_senha   VARCHAR2(30) NOT NULL,
    nm_usuario VARCHAR2(30) NOT NULL
);

ALTER TABLE t_usuario ADD CONSTRAINT t_usuario_pk PRIMARY KEY ( ds_email );

CREATE TABLE t_usuario_logradouro (
    t_usuario_ds_email         VARCHAR2(30) NOT NULL,
    t_logradouro_cd_logradouro NUMBER(2) NOT NULL
);

ALTER TABLE t_usuario_logradouro ADD CONSTRAINT t_usuario_logradouro_pk PRIMARY KEY ( t_usuario_ds_email,
                                                                                      t_logradouro_cd_logradouro );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_crypto
    ADD CONSTRAINT t_crypto_t_tipo_transacao_crypto_fk FOREIGN KEY ( t_tipo_transacao_crypto_cd_tipo_transacao_crypto )
        REFERENCES t_tipo_transacao_crypto ( cd_tipo_transacao_crypto );

ALTER TABLE t_crypto
    ADD CONSTRAINT t_crypto_t_usuario_fk FOREIGN KEY ( t_usuario_ds_email )
        REFERENCES t_usuario ( ds_email );

ALTER TABLE t_empresa
    ADD CONSTRAINT t_empresa_t_usuario_fk FOREIGN KEY ( t_usuario_ds_email )
        REFERENCES t_usuario ( ds_email );

ALTER TABLE t_logradouro
    ADD CONSTRAINT t_logradouro_t_bairro_fk FOREIGN KEY ( t_bairro_cd_bairro )
        REFERENCES t_bairro ( cd_bairro );

ALTER TABLE t_logradouro
    ADD CONSTRAINT t_logradouro_t_cidade_fk FOREIGN KEY ( t_cidade_cd_cidade )
        REFERENCES t_cidade ( cd_cidade );

ALTER TABLE t_logradouro
    ADD CONSTRAINT t_logradouro_t_estado_fk FOREIGN KEY ( t_estado_cd_estado )
        REFERENCES t_estado ( cd_estado );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_logradouro
    ADD CONSTRAINT t_logradouro_t_numero_logradouro_fk FOREIGN KEY ( t_numero_logradouro_cd_numero )
        REFERENCES t_numero_logradouro ( cd_numero );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_transacao_empresa
    ADD CONSTRAINT t_transacao_empresa_t_detalhe_transacao_fk FOREIGN KEY ( t_detalhe_transacao_ds_tipo_transacao )
        REFERENCES t_detalhe_transacao ( ds_tipo_transacao );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_transacao_empresa
    ADD CONSTRAINT t_transacao_empresa_t_empresa_fk FOREIGN KEY ( t_empresa_nm_empresa )
        REFERENCES t_empresa ( nm_empresa );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_transacao_usuario
    ADD CONSTRAINT t_transacao_usuario_t_beneficiario_fk FOREIGN KEY ( t_beneficiario_cd_beneficiario )
        REFERENCES t_beneficiario ( cd_beneficiario );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_transacao_usuario
    ADD CONSTRAINT t_transacao_usuario_t_tipo_transacao_fk FOREIGN KEY ( t_tipo_transacao_cd_tipo_transacao )
        REFERENCES t_tipo_transacao ( cd_tipo_transacao );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_transacao_usuario
    ADD CONSTRAINT t_transacao_usuario_t_usuario_fk FOREIGN KEY ( t_usuario_ds_email )
        REFERENCES t_usuario ( ds_email );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_usuario_logradouro
    ADD CONSTRAINT t_usuario_logradouro_t_logradouro_fk FOREIGN KEY ( t_logradouro_cd_logradouro )
        REFERENCES t_logradouro ( cd_logradouro );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_usuario_logradouro
    ADD CONSTRAINT t_usuario_logradouro_t_usuario_fk FOREIGN KEY ( t_usuario_ds_email )
        REFERENCES t_usuario ( ds_email );



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            15
-- CREATE INDEX                             0
-- ALTER TABLE                             29
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                  18
-- WARNINGS                                 0
