CREATE TABLE atores (
    atr_id   INTEGER NOT NULL,
    atr_nome VARCHAR2(4000)
);

ALTER TABLE atores ADD CONSTRAINT PK_ATR PRIMARY KEY ( atr_id );

CREATE TABLE diretores (
    drt_id   INTEGER NOT NULL,
    drt_nome VARCHAR2(4000)
);

ALTER TABLE diretores ADD CONSTRAINT PK_DRT PRIMARY KEY ( drt_id );

CREATE TABLE elencos (
    elc_atr_id INTEGER NOT NULL,
    elc_ttl_id INTEGER NOT NULL
);

ALTER TABLE elencos ADD CONSTRAINT PK_ELC PRIMARY KEY ( elc_atr_id,
                                                            elc_ttl_id );

CREATE TABLE generos (
    gen_id   INTEGER NOT NULL,
    gen_nome VARCHAR2(4000)
);

ALTER TABLE generos ADD CONSTRAINT PK_GEN PRIMARY KEY ( gen_id );

CREATE TABLE generos_titulos (
    gnt_gen_id INTEGER NOT NULL,
    gnt_ttl_id INTEGER NOT NULL
);

ALTER TABLE generos_titulos ADD CONSTRAINT PK_GNT PRIMARY KEY ( gnt_gen_id,
                                                                            gnt_ttl_id );

CREATE TABLE paises (
    pse_id   INTEGER NOT NULL,
    pse_nome VARCHAR2(4000)
);

ALTER TABLE paises ADD CONSTRAINT PK_PSE PRIMARY KEY ( pse_id );

CREATE TABLE paises_titulos (
    pst_pse_id INTEGER NOT NULL,
    pst_ttl_id INTEGER NOT NULL
);

ALTER TABLE paises_titulos ADD CONSTRAINT PK_PST PRIMARY KEY ( pst_pse_id,
                                                                          pst_ttl_id );

CREATE TABLE produtores (
    prd_drt_id INTEGER NOT NULL,
    prd_ttl_id INTEGER NOT NULL
);

ALTER TABLE produtores ADD CONSTRAINT PK_PRD PRIMARY KEY ( prd_drt_id,
                                                                  prd_ttl_id );

CREATE TABLE tipos (
    tpo_id        INTEGER NOT NULL,
    tpo_descricao VARCHAR2(4000)
);

ALTER TABLE tipos ADD CONSTRAINT PK_TPO PRIMARY KEY ( tpo_id );

CREATE TABLE titulos (
    ttl_id             INTEGER NOT NULL,
    ttl_nome           VARCHAR2(4000) NOT NULL,
    ttl_dt_add         DATE,
    ttl_ano_lancamento DATE NOT NULL,
    ttl_class_etaria   VARCHAR2(300) NOT NULL,
    ttl_duracao        VARCHAR2(1000) NOT NULL,
    ttl_descricao      VARCHAR2(4000),
    ttl_aval_imdb      NUMBER(2, 4),
    ttl_aval_pop       INTEGER,
    ttl_tpo_id         INTEGER NOT NULL
);

ALTER TABLE titulos ADD CONSTRAINT PK_TTL PRIMARY KEY ( ttl_id );

ALTER TABLE elencos
    ADD CONSTRAINT FK_ELC_ATR FOREIGN KEY ( elc_atr_id )
        REFERENCES atores ( atr_id );

ALTER TABLE elencos
    ADD CONSTRAINT FK_ELC_TTL FOREIGN KEY ( elc_ttl_id )
        REFERENCES titulos ( ttl_id );

ALTER TABLE generos_titulos
    ADD CONSTRAINT FK_GNT_GEN FOREIGN KEY ( gnt_gen_id )
        REFERENCES generos ( gen_id );

ALTER TABLE generos_titulos
    ADD CONSTRAINT FK_GNT_TTL FOREIGN KEY ( gnt_ttl_id )
        REFERENCES titulos ( ttl_id );

ALTER TABLE produtores
    ADD CONSTRAINT FK_PRD_DRT FOREIGN KEY ( prd_drt_id )
        REFERENCES diretores ( drt_id );

ALTER TABLE produtores
    ADD CONSTRAINT FK_PRD_TTL FOREIGN KEY ( prd_ttl_id )
        REFERENCES titulos ( ttl_id );

ALTER TABLE paises_titulos
    ADD CONSTRAINT FK_PST_PSE FOREIGN KEY ( pst_pse_id )
        REFERENCES paises ( pse_id );

ALTER TABLE paises_titulos
    ADD CONSTRAINT FK_PST_TTL FOREIGN KEY ( pst_ttl_id )
        REFERENCES titulos ( ttl_id );

ALTER TABLE titulos
    ADD CONSTRAINT FK_TTL_TPO FOREIGN KEY ( ttl_tpo_id )
        REFERENCES tipos ( tpo_id );

-- SEQUENCES --
CREATE SEQUENCE SQ_ATR NOCACHE;
CREATE SEQUENCE SQ_DRT NOCACHE;
CREATE SEQUENCE SQ_GEN NOCACHE;
CREATE SEQUENCE SQ_PSE NOCACHE;
CREATE SEQUENCE SQ_TPO NOCACHE;
CREATE SEQUENCE SQ_TTL NOCACHE;

-- TRIGGERS --
CREATE TRIGGER TG_SQ_ATR
BEFORE INSERT ON atores
FOR EACH ROW
BEGIN
  :NEW.atr_id := SQ_ATR.NEXTVAL;
END;
/

CREATE TRIGGER TG_SQ_DRT
BEFORE INSERT ON diretores
FOR EACH ROW
BEGIN
  :NEW.drt_id := SQ_DRT.NEXTVAL;
END;
/

CREATE TRIGGER TG_SQ_GEN
BEFORE INSERT ON generos
FOR EACH ROW
BEGIN
  :NEW.gen_id := SQ_GEN.NEXTVAL;
END;
/

CREATE TRIGGER TG_SQ_PSE
BEFORE INSERT ON paises
FOR EACH ROW
BEGIN
  :NEW.pse_id := SQ_PSE.NEXTVAL;
END;
/

CREATE TRIGGER TG_SQ_TPO
BEFORE INSERT ON tipos
FOR EACH ROW
BEGIN
  :NEW.tpo_id := SQ_TPO.NEXTVAL;
END;
/

CREATE TRIGGER TG_SQ_TTL
BEFORE INSERT ON titulos
FOR EACH ROW
BEGIN
  :NEW.ttl_id := SQ_TTL.NEXTVAL;
END;
/

-- TABEL�O DE INSER��O --
CREATE TABLE tabelao(    
    "type" VARCHAR2(4000 BYTE),
    "title" VARCHAR2(4000 BYTE),
    "director" VARCHAR2(4000 BYTE),
    "cast" VARCHAR2(4000 BYTE),
    "country" VARCHAR2(4000 BYTE),
    "date_added" VARCHAR2(4000 BYTE),
    "release_year" NUMBER(38,0),
    "rating" VARCHAR2(4000 BYTE),
    "duration" VARCHAR2(4000 BYTE),
    "listed_in" VARCHAR2(4000 BYTE),
    "description" VARCHAR2(4000 BYTE),
    "imdb_rating" NUMBER(2,4),
    "imdb_voting" INTEGER
);

INSERT INTO diretores(drt_nome) VALUES(
    SELECT DISTINCT "director" FROM tabelao
);

-- TABELAS DE HISTORIAMENTO --
CREATE TABLE h_atores(
    hatr_id INTEGER,
    hatr_nome VARCHAR(4000),
    hatr_data_hora DATE
);

CREATE TABLE h_diretores(
    hdrt_id INTEGER,
    hdrt_nome VARCHAR(4000),
    hdrt_data_hora DATE
);

CREATE TABLE h_generos(
    hgen_id INTEGER,
    hgen_nome VARCHAR(4000),
    hgen_data_hora DATE
);

CREATE TABLE h_paises(
    hpse_id INTEGER,
    hpse_nome VARCHAR(4000),
    hpse_data_hora DATE
);

CREATE TABLE h_tipos(
    htpo_id INTEGER,
    htpo_descricao VARCHAR(4000),
    htpo_data_hora DATE
);

CREATE TABLE h_titulos(
    httl_id INTEGER,
    httl_nome VARCHAR(4000),
    httl_dt_add DATE,
    httl_ano_lancamento DATE,
    httl_class_etaria VARCHAR(300),
    httl_duracao VARCHAR(4000),
    httl_descricao VARCHAR(4000),
    httl_aval_imdb NUMBER(2,4),
    httl_aval_pop INTEGER,
    httl_tpo_id INTEGER,
    httl_data_hora DATE
);

-- TRIGGERS TABELAS DE HISTORIAMENTO --
CREATE TRIGGER TG_HATR
BEFORE UPDATE OR DELETE ON atores
FOR EACH ROW
BEGIN
  INSERT INTO h_atores VALUES (:old.atr_id, :old.atr_nome, sysdate);
END;
/

CREATE TRIGGER TG_HDRT
BEFORE UPDATE OR DELETE ON diretores
FOR EACH ROW
BEGIN
  INSERT INTO h_diretores VALUES (:old.drt_id, :old.drt_nome, sysdate);
END;
/

CREATE TRIGGER TG_HGEN
BEFORE UPDATE OR DELETE ON generos
FOR EACH ROW
BEGIN
  INSERT INTO h_generos VALUES (:old.gen_id, :old.gen_nome, sysdate);
END;
/

CREATE TRIGGER TG_HPSE
BEFORE UPDATE OR DELETE ON paises
FOR EACH ROW
BEGIN
  INSERT INTO h_paises VALUES (:old.pse_id, :old.pse_nome, sysdate);
END;
/

CREATE TRIGGER TG_HTPO
BEFORE UPDATE OR DELETE ON tipos
FOR EACH ROW
BEGIN
  INSERT INTO h_tipos VALUES (:old.tpo_id, :old.tpo_descricao, sysdate);
END;
/

CREATE TRIGGER TG_HTTL
BEFORE UPDATE OR DELETE ON titulos
FOR EACH ROW
BEGIN
  INSERT INTO h_titulos VALUES (:old.ttl_id, :old.ttl_nome, :old.ttl_dt_add, :old.ttl_ano_lancamento, 
              :old.ttl_class_etaria, :old.ttl_duracao, :old.ttl_descricao, :old.ttl_aval_imdb, :old.ttl_aval_pop, 
              :old.ttl_tpo_id, sysdate);
END; 
/
