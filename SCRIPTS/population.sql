-- NEW VERSION TABELAO

CREATE TABLE tabelao(
    "id" NUMBER(*,0),     
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
    "imdb_rating" NUMBER,
    "imdb_voting" INTEGER
);

-- NEW TITULOS 

  CREATE TABLE "APP"."TITULOS" 
   (	"TTL_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"TTL_NOME" VARCHAR2(4000 BYTE) COLLATE "USING_NLS_COMP" NOT NULL ENABLE, 
	"TTL_DT_ADD" DATE, 
	"TTL_ANO_LANCAMENTO" DATE NOT NULL ENABLE, 
	"TTL_CLASS_ETARIA" VARCHAR2(300 BYTE) COLLATE "USING_NLS_COMP" NOT NULL ENABLE, 
	"TTL_DURACAO" VARCHAR2(1000 BYTE) COLLATE "USING_NLS_COMP" NOT NULL ENABLE, 
	"TTL_DESCRICAO" VARCHAR2(4000 BYTE) COLLATE "USING_NLS_COMP", 
	"TTL_AVAL_IMDB" NUMBER(*,4), 
	"TTL_AVAL_POP" NUMBER(*,0), 
	"TTL_TPO_ID" NUMBER(*,0) NOT NULL ENABLE, 
	)


  -- NEW H_TITULOS

  
  CREATE TABLE "APP"."H_TITULOS" 
   (	"HTTL_ID" NUMBER(*,0), 
	"HTTL_NOME" VARCHAR2(4000 BYTE), 
	"HTTL_DT_ADD" DATE, 
	"HTTL_ANO_LANCAMENTO" DATE, 
	"HTTL_CLASS_ETARIA" VARCHAR2(300 BYTE), 
	"HTTL_DURACAO" VARCHAR2(4000 BYTE), 
	"HTTL_DESCRICAO" VARCHAR2(4000 BYTE) , 
	"HTTL_AVAL_IMDB" NUMBER(*,4), 
	"HTTL_AVAL_POP" NUMBER(*,0), 
	"HTTL_TPO_ID" NUMBER(*,0), 
	"HTTL_DATA_HORA" DATE)



--------------------------------------
-- INSERÇÃO NO BANCO
--------------------------------------

-- TIPOS 

INSERT INTO tipos (tpo_descricao)(
    select distinct tabelao."type" from tabelao
);

update tabelao
set tabelao."type" = (
  select tpo_id
  from tipos
  where tabelao."type" = tipos.tpo_descricao
);

--------------------------------------
-- MULTIVALORADOS 
--------------------------------------
-- DIRETORES 


CREATE TABLE diretores2 (
    drt_id2  INTEGER NOT NULL,
    drt_nome2 VARCHAR2(4000)
);

insert into DIRETORES2
(
      select DISTINCT
            tabelao."id",
            trim(
                regexp_substr (
                   tabelao."director",
                   '[^,]+',
                   1,
                   level
                 ) 
            ) value
      from   tabelao
      connect by level <= 
        length (  tabelao."director" ) - 
        length ( replace (  tabelao."director", ',' ) ) + 1
);

insert into DIRETORES (drt_nome)
(
      select DISTINCT drt_nome2 from diretores2 
       
);

-- PAISES

CREATE TABLE paises2 (
    pse_id2   INTEGER NOT NULL,
    pse_nome2 VARCHAR2(4000)
);
insert into PAISES2
(
      select DISTINCT
            tabelao."id",
            trim(
                regexp_substr (
                   tabelao."country",
                   '[^,]+',
                   1,
                   level
                 ) 
            ) value
      from   tabelao
      connect by level <= 
        length (  tabelao."country" ) - 
        length ( replace (  tabelao."country", ',' ) ) + 1
);

insert into PAISES (pse_nome)
(
      select DISTINCT pse_nome2 from paises2 
       
);

-- GENEROS 


CREATE TABLE generos2 (
    gen_id2  INTEGER NOT NULL,
    gen_nome2 VARCHAR2(4000)
);

-- CSV IMPORT 

insert into GENEROS (gen_nome)
(
      select DISTINCT gen_nome2 from GENEROS2 
       
);

-- ATORES

CREATE TABLE atores2 (
    atr_id2   INTEGER NOT NULL,
    atr_nome2 VARCHAR2(4000)
);

-- CSV IMPORT 

insert into ATORES (atr_nome)
(
      select DISTINCT atr_nome2 from ATORES2 
       
);


-- TITULOS
INSERT INTO TITULOS(
   SELECT
       TABELAO."id",
        TABELAO."title",
        TO_DATE(tabelao."date_added", 'dd/mm/yyyy'),
        TO_DATE(tabelao."release_year",'yyyy'),
        tabelao."rating",
        tabelao."duration",
        tabelao."description",
        tabelao."imdb_rating",
        tabelao."imdb_voting",
        tabelao."type"
    FROM
        TABELAO
);

-- TABELAS DE RELACIONAMENTOS 

-- PAISES_TITULOS

INSERT INTO PAISES_TITULOS(
    SELECT paises.pse_id, paises2.pse_id2 FROM PAISES, PAISES2 
    WHERE paises.pse_nome = paises2.pse_nome2
        
);

--QUERY DE TESTE 
 /*

SELECT titulos.ttl_id,titulos.ttl_nome, paises.pse_nome FROM titulos
INNER JOIN paises_titulos  ON paises_titulos.pst_ttl_id = titulos.ttl_id
INNER JOIN paises on paises_titulos.pst_pse_id = paises.pse_id
WHERE titulos.ttl_id =8; 

*/

-- PRODUTORES 
INSERT INTO PRODUTORES(
    SELECT diretores.drt_id, diretores2.drt_id2 FROM diretores, diretores2 
    WHERE diretores.drt_nome = diretores2.drt_nome2
);

--QUERY DE TESTE 
 /*
SELECT titulos.ttl_id,titulos.ttl_nome, diretores.drt_nome FROM titulos
INNER JOIN Produtores  ON produtores.prd_ttl_id = titulos.ttl_id
INNER JOIN diretores on diretores.drt_id = produtores.prd_drt_id
WHERE titulos.ttl_id =32; 
*/
-- GENEROS 
INSERT INTO generos_titulos(
    SELECT generos.gen_id, generos2.gen_id2 FROM generos, generos2 
    WHERE generos.gen_nome = generos2.gen_nome2
);

--QUERY DE TESTE 

SELECT * FROM titulos
--INNER JOIN generos_titulos  ON generos_titulos.gnt_ttl_id = titulos.ttl_id
--INNER JOIN generos on generos.gen_id = generos_titulos.gnt_gen_id
WHERE titulos.ttl_nome= 'Osmosis Jones'; 

-- elencos 

INSERT INTO ELENCOS (
    SELECT ATORES.ATR_id, atores2.atr_id2 FROM ATORES, ATORES2
    WHERE atores.atr_nome = atores2.atr_nome2
);

-- DROP TABLES AUXILIARES
drop table tabelao;
drop table atores2;
drop table diretores2;
drop table generos2;
drop table paises2;

