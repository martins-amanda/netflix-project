

-- USUARIO DE AUDITORIA --

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;


CREATE USER AUDITOR IDENTIFIED BY aud123 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;



-- TABELA DE AUDITORIA --
CREATE TABLE AUDITOR.AUDITORIA(
    aud_id INTEGER,
    AUD_TABELA VARCHAR(30),
    aud_linha_hist INTEGER,
        aud_data_hist DATE,
        aud_coluna VARCHAR(30),
        aud_valor_antigo VARCHAR(2000),
        aud_valor_novo VARCHAR(2000),
        aud_operacao CHAR(1),
        aud_data DATE,
        aud_usu_bd VARCHAR(30),
        aud_usu_so VARCHAR(200),
        CONSTRAINT PK_AUD PRIMARY KEY(aud_id)
);

CREATE SEQUENCE AUDITOR.SQ_AUD NOCACHE;




create or replace NONEDITIONABLE PROCEDURE PROC_INSERE
(
    PR_TABELA IN VARCHAR2, 
    PR_LINHA_HIST IN NUMBER,
    PR_DATA_HIST IN DATE,
    PR_COLUNA IN VARCHAR2,
    PR_VALOR_ANTIGO IN VARCHAR2,
    PR_VALOR_NOVO IN VARCHAR2,
    PR_OPERACAO IN VARCHAR2,
    PR_DATA IN DATE,
    PR_USU_BD IN VARCHAR2,
    PR_USU_SO IN VARCHAR2
) AS
BEGIN
  INSERT INTO AUDITOR.AUDITORIA VALUES (null, PR_TABELA, PR_LINHA_HIST, PR_DATA_HIST, PR_COLUNA, PR_VALOR_ANTIGO,PR_VALOR_NOVO, PR_OPERACAO, PR_DATA, PR_USU_BD, PR_USU_SO);
END PROC_INSERE;




CREATE OR REPLACE TRIGGER TG_IN
AFTER DELETE OR UPDATE ON h_atores
FOR EACH ROW
DECLARE 
    V_USU_BD VARCHAR(30) := sys_context('USERENV','CURRENT_USER');
    V_USU_SO VARCHAR(30):= sys_context('USERENV', 'OS_USER');
    V_TABELA VARCHAR(30) := 'h_atores';
    V_EVENTO CHAR(1);
BEGIN
    IF DELETING THEN
        V_EVENTO := 'D';
        AUDITOR.PROC_INSERE(V_TABELA, :OLD.hatr_id, :OLD.hatr_data_hora, NULL, NULL, NULL, V_EVENTO, SYSDATE, V_USU_BD, 		V_USU_SO);
    ELSE
        V_EVENTO := 'U';
        IF (:OLD.hatr_id <> :NEW.hatr_id) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.hatr_id, :OLD.hatr_data_hora, 'hatr_id', :OLD.hatr_id, :NEW.hatr_id, V_EVENTO, 				SYSDATE, V_USU_BD, V_USU_SO);
        END IF;
        IF (:OLD.hatr_nome <> :NEW.hatr_nome) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.hatr_id, :OLD.hatr_data_hora, 'hatr_nome', :OLD.hatr_nome, 						:NEW.hatr_nome, V_EVENTO, SYSDATE, V_USU_BD, V_USU_SO);
        END IF;       
        IF (:OLD.hatr_data_hora <> :NEW.hatr_data_hora) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.hatr_id, :OLD.hatr_data_hora, 'hatr_data_hora', :OLD.hatr_data_hora, 					:NEW.hatr_data_hora, V_EVENTO, SYSDATE, V_USU_BD, V_USU_SO);
        END IF;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER TG_IN
AFTER DELETE OR UPDATE ON h_diretores
FOR EACH ROW
DECLARE 
    V_USU_BD VARCHAR(30) := sys_context('USERENV','CURRENT_USER');
    V_USU_SO VARCHAR(30):= sys_context('USERENV', 'OS_USER');
    V_TABELA VARCHAR(30) := 'h_diretores';
    V_EVENTO CHAR(1);
BEGIN
    IF DELETING THEN
        V_EVENTO := 'D';
        AUDITOR.PROC_INSERE(V_TABELA, :OLD.hdrt_id, :OLD.hdrt_data_hora, NULL, NULL, NULL, V_EVENTO, SYSDATE, V_USU_BD, 		V_USU_SO);
    ELSE
        V_EVENTO := 'U';
        IF (:OLD.hdrt_id <> :NEW.hdrt_id) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.hdrt_id, :OLD.hdrt_data_hora, 'hdrt_id', :OLD.hdrt_id, :NEW.hdrt_id, V_EVENTO, 				SYSDATE, V_USU_BD, V_USU_SO);
        END IF;
        IF (:OLD.hdrt_nome <> :NEW.hdrt_nome) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.hdrt_id, :OLD.hdrt_data_hora, 'hdrt_nome', :OLD.hdrt_nome, 						:NEW.hdrt_nome, V_EVENTO, SYSDATE, V_USU_BD, V_USU_SO);
        END IF;       
        IF (:OLD.hdrt_data_hora <> :NEW.hdrt_data_hora) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.hdrt_id, :OLD.hdrt_data_hora, 'hdrt_data_hora', :OLD.hdrt_data_hora, 					:NEW.hdrt_data_hora, V_EVENTO, SYSDATE, V_USU_BD, V_USU_SO);
        END IF;
    END IF;
END;
/



CREATE OR REPLACE TRIGGER TG_IN
AFTER DELETE OR UPDATE ON h_generos
FOR EACH ROW
DECLARE 
    V_USU_BD VARCHAR(30) := sys_context('USERENV','CURRENT_USER');
    V_USU_SO VARCHAR(30):= sys_context('USERENV', 'OS_USER');
    V_TABELA VARCHAR(30) := 'h_generos';
    V_EVENTO CHAR(1);
BEGIN
    IF DELETING THEN
        V_EVENTO := 'D';
        AUDITOR.PROC_INSERE(V_TABELA, :OLD.hgen_id, :OLD.hgen_data_hora, NULL, NULL, NULL, V_EVENTO, SYSDATE, V_USU_BD, 		V_USU_SO);
    ELSE
        V_EVENTO := 'U';
        IF (:OLD.hgen_id <> :NEW.hgen_id) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.hgen_id, :OLD.hgen_data_hora, 'hgen_id', :OLD.hgen_id, :NEW.hgen_id, V_EVENTO, 				SYSDATE, V_USU_BD, V_USU_SO);
        END IF;
        IF (:OLD.hgen_nome <> :NEW.hgen_nome) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.hgen_id, :OLD.hgen_data_hora, 'hgen_nome', :OLD.hgen_nome, 						:NEW.hgen_nome, V_EVENTO, SYSDATE, V_USU_BD, V_USU_SO);
        END IF;       
        IF (:OLD.hgen_data_hora <> :NEW.hgen_data_hora) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.hgen_id, :OLD.hgen_data_hora, 'hgen_data_hora', :OLD.hgen_data_hora, 					:NEW.hgen_data_hora, V_EVENTO, SYSDATE, V_USU_BD, V_USU_SO);
        END IF;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER TG_IN
AFTER DELETE OR UPDATE ON h_paises
FOR EACH ROW
DECLARE 
    V_USU_BD VARCHAR(30) := sys_context('USERENV','CURRENT_USER');
    V_USU_SO VARCHAR(30):= sys_context('USERENV', 'OS_USER');
    V_TABELA VARCHAR(30) := 'h_paises';
    V_EVENTO CHAR(1);
BEGIN
    IF DELETING THEN
        V_EVENTO := 'D';
        AUDITOR.PROC_INSERE(V_TABELA, :OLD.hpse_id, :OLD.hpse_data_hora, NULL, NULL, NULL, V_EVENTO, SYSDATE, V_USU_BD, 		V_USU_SO);
    ELSE
        V_EVENTO := 'U';
        IF (:OLD.hpse_id <> :NEW.hpse_id) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.hpse_id, :OLD.hpse_data_hora, 'hpse_id', :OLD.hpse_id, :NEW.hpse_id, V_EVENTO, 				SYSDATE, V_USU_BD, V_USU_SO);
        END IF;
        IF (:OLD.hpse_nome <> :NEW.hpse_nome) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.hpse_id, :OLD.hpse_data_hora, 'hpse_nome', :OLD.hpse_nome, 						:NEW.hpse_nome, V_EVENTO, SYSDATE, V_USU_BD, V_USU_SO);
        END IF;       
        IF (:OLD.hpse_data_hora <> :NEW.hpse_data_hora) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.hpse_id, :OLD.hpse_data_hora, 'hpse_data_hora', :OLD.hpse_data_hora, 					:NEW.hpse_data_hora, V_EVENTO, SYSDATE, V_USU_BD, V_USU_SO);
        END IF;
    END IF;
END;
/ 


CREATE OR REPLACE TRIGGER TG_IN
AFTER DELETE OR UPDATE ON h_tipos
FOR EACH ROW
DECLARE 
    V_USU_BD VARCHAR(30) := sys_context('USERENV','CURRENT_USER');
    V_USU_SO VARCHAR(30):= sys_context('USERENV', 'OS_USER');
    V_TABELA VARCHAR(30) := 'h_tipos';
    V_EVENTO CHAR(1);
BEGIN
    IF DELETING THEN
        V_EVENTO := 'D';
        AUDITOR.PROC_INSERE(V_TABELA, :OLD.htpo_id, :OLD.htpo_data_hora, NULL, NULL, NULL, V_EVENTO, SYSDATE, V_USU_BD, 		V_USU_SO);
    ELSE
        V_EVENTO := 'U';
        IF (:OLD.htpo_id <> :NEW.htpo_id) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.htpo_id, :OLD.htpo_data_hora, 'htpo_id', :OLD.htpo_id, :NEW.htpo_id, V_EVENTO, 				SYSDATE, V_USU_BD, V_USU_SO);
        END IF;
        IF (:OLD.htpo_nome <> :NEW.htpo_nome) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.htpo_id, :OLD.htpo_data_hora, 'htpo_nome', :OLD.htpo_nome, 						:NEW.htpo_nome, V_EVENTO, SYSDATE, V_USU_BD, V_USU_SO);
        END IF;       
        IF (:OLD.htpo_data_hora <> :NEW.htpo_data_hora) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.htpo_id, :OLD.htpo_data_hora, 'htpo_data_hora', :OLD.htpo_data_hora, 					:NEW.htpo_data_hora, V_EVENTO, SYSDATE, V_USU_BD, V_USU_SO);
        END IF;
    END IF;
END;
/ 


CREATE OR REPLACE TRIGGER TG_IN
AFTER DELETE OR UPDATE ON h_titulos
FOR EACH ROW
DECLARE 
    V_USU_BD VARCHAR(30) := sys_context('USERENV','CURRENT_USER');
    V_USU_SO VARCHAR(30):= sys_context('USERENV', 'OS_USER');
    V_TABELA VARCHAR(30) := 'h_titulos';
    V_EVENTO CHAR(1);
BEGIN
    IF DELETING THEN
        V_EVENTO := 'D';
        AUDITOR.PROC_INSERE(V_TABELA, :OLD.httl_id, :OLD.httl_data_hora, NULL, NULL, NULL, V_EVENTO, SYSDATE, V_USU_BD, 		V_USU_SO);
    ELSE
        V_EVENTO := 'U';
        IF (:OLD.httl_id <> :NEW.httl_id) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.httl_id, :OLD.httl_data_hora, 'httl_id', :OLD.httl_id, :NEW.httl_id, V_EVENTO, 				SYSDATE, V_USU_BD, V_USU_SO);
        END IF;
        IF (:OLD.httl_nome <> :NEW.httl_nome) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.httl_id, :OLD.httl_data_hora, 'httl_nome', :OLD.httl_nome, 						:NEW.httl_nome, V_EVENTO, SYSDATE, V_USU_BD, V_USU_SO);
        END IF;    
   
	IF (:OLD.httl_dt_add <> :NEW.httl_dt_add) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.httl_id, :OLD.httl_data_hora, 'httl_dt_add', :OLD.httl_dt_add, 						:NEW.httl_dt_add, V_EVENTO, SYSDATE, V_USU_BD, V_USU_SO);
        END IF;   
	IF (:OLD.httl_ano_lancamento <> :NEW.httl_ano_lancamento) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.httl_id, :OLD.httl_data_hora, 'httl_ano_lancamento', :OLD.httl_ano_lancamento, 						:NEW.httl_ano_lancamento, V_EVENTO, SYSDATE, V_USU_BD, V_USU_SO);
        END IF;   
	IF (:OLD.httl_class_etaria <> :NEW.httl_class_etaria) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.httl_id, :OLD.httl_data_hora, 'httl_class_etaria', :OLD.httl_class_etaria, 						:NEW.httl_class_etaria, V_EVENTO, SYSDATE, V_USU_BD, V_USU_SO);
        END IF;   
	IF (:OLD.httl_duracao <> :NEW.httl_duracao) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.httl_id, :OLD.httl_data_hora, 'httl_duracao', :OLD.httl_duracao, 						:NEW.httl_duracao, V_EVENTO, SYSDATE, V_USU_BD, V_USU_SO);
        END IF;   
	IF (:OLD.httl_descricao <> :NEW.httl_descricao) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.httl_id, :OLD.httl_data_hora, 'httl_descricao', :OLD.httl_descricao, 						:NEW.httl_descricao, V_EVENTO, SYSDATE, V_USU_BD, V_USU_SO);
        END IF;   
	IF (:OLD.httl_aval_imdb <> :NEW.httl_aval_imdb) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.httl_id, :OLD.httl_data_hora, 'httl_aval_imdb', :OLD.httl_aval_imdb, 						:NEW.httl_aval_imdb, V_EVENTO, SYSDATE, V_USU_BD, V_USU_SO);
        END IF;   
	IF (:OLD.httl_aval_pop <> :NEW.httl_aval_pop) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.httl_id, :OLD.httl_data_hora, 'httl_aval_pop', :OLD.httl_aval_pop, 						:NEW.httl_aval_pop, V_EVENTO, SYSDATE, V_USU_BD, V_USU_SO);
        END IF;   
	IF (:OLD.httl_tpo_id <> :NEW.httl_tpo_id) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.httl_id, :OLD.httl_data_hora, 'httl_tpo_id', :OLD.httl_tpo_id, 						:NEW.httl_tpo_id, V_EVENTO, SYSDATE, V_USU_BD, V_USU_SO);
        END IF;   	
        IF (:OLD.httl_data_hora <> :NEW.httl_data_hora) THEN
            AUDITOR.PROC_INSERE(V_TABELA, :OLD.httl_id, :OLD.httl_data_hora, 'httl_data_hora', :OLD.httl_data_hora, 					:NEW.httl_data_hora, V_EVENTO, SYSDATE, V_USU_BD, V_USU_SO);
        END IF;
    END IF;
END;
/ 