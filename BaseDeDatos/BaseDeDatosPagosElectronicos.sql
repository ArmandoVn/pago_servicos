
-- Company :        FI UNAM
-- Project :        Pagos electronicos UNICA
-- Author :         Sofía Colín
--                  Armando Valderrama
-- Date Created :   Friday, October 11, 2019 
-- Target DBMS :    PostgreSQL 8.0
--

-- 
-- TABLE: FORMA DE PAGO 
--+

CREATE SEQUENCE SEQ_FORMA_PAGO;

CREATE TABLE FORMA_PAGO(
	FORMA_PAGO_ID 	numeric(10, 0)  default nextval('SEQ_FORMA_PAGO'),
	FORMA_PAGO		varchar(40)		NOT NULL,
	DESCRICION 		varchar(40)		NOT NULL,
	CONSTRAINT PKFP PRIMARY KEY (FORMA_PAGO_ID)
);

-- 
-- TABLE: ESTADO CURSO 
--

CREATE SEQUENCE SEQ_ESTADO_CURSO;

CREATE TABLE ESTADO_CURSO(
	ESTADO_CURSO_ID 	numeric(10,0)	default nextval('SEQ_ESTADO_CURSO'),
	NOMBRE				varchar(40)		NOT NULL,
	DESCRIPCION			varchar(40)		NOT NULL,
	CONSTRAINT PKEC PRIMARY KEY (ESTADO_CURSO_ID)
);

-- 
-- TABLE: FACTURA
--

CREATE SEQUENCE SEQ_FACTURA;

CREATE TABLE FACTURA(
	FACTURA_ID 		numeric(30,0) 		default nextval('SEQ_FACTURA'),
	FACTURA 		numeric(4,2)		NOT NULL,
	CONSTRAINT PKF PRIMARY KEY (FACTURA_ID)
);

-- 
-- TABLE: CURSO
--

CREATE TABLE CURSO(
    CURSO_ID			numeric(4,0)	NOT NULL,
    NOMBRE				varchar(40)		NOT NULL,
    PRECIO				numeric(10,2)	NOT NULL,
    DURACION_SEMANAS	numeric(2)		NOT NULL,
    FECHA_INICIO		date			NOT NULL,
    FECHA_FIN			date			NOT NULL,
    CONSTRAINT PKC PRIMARY KEY (CURSO_ID)
);


-- 
-- TABLE: PERFIL_USUARIO
--

CREATE SEQUENCE SEQ_PERFIL_USUARIO;

CREATE TABLE PERFIL_USUARIO(
	PERFIL_USUARIO_ID 		numeric(8,0) 		default nextval('SEQ_PERFIL_USUARIO'),
	PERFIL_USUARIO     		varchar(40)			NOT NULL,
	DESCRIPCION			 	varchar(40)			NOT NULL,
	PORCIENTO_DESCUENTO		numeric(3,0)		NOT NULL,
	CONSTRAINT PKPU PRIMARY KEY (PERFIL_USUARIO_ID)
);

-- 
-- TABLE: TIPO_USUARIO
--

CREATE SEQUENCE SEQ_TIPO_USUARIO;

CREATE TABLE TIPO_USUARIO (
	TIPO_USUARIO_ID 	numeric(8,0)	default  nextval('SEQ_TIPO_USUARIO'),
	TIPO_USUARIO 		varchar(40)		NOT NULL,
	DESCRIPCION			varchar(40)		NOT NULL,
	CONSTRAINT PKT PRIMARY KEY (TIPO_USUARIO_ID)
);

-- 
-- TABLE: USUARIO
--

CREATE SEQUENCE SEQ_USUARIO;

CREATE TABLE USUARIO(
    USUARIO_ID			numeric(10, 0) 		default nextval('SEQ_USUARIO'),
    NOMBRE				varchar(40)			NOT NULL,
    AP_PATERNO			varchar(40)			NOT NULL,
    AP_MATERNO			varchar(40)			NULL,
    CORREO_ELECTRONICO	varchar(40)			NOT NULL,
    CONTRASEÑA			varchar(20)			NOT NULL,
    TELEFONO 			numeric(10,0)		NOT NULL,
    RFC					varchar(13)			NOT NULL,
    FECHA_REGISTRO		date				NOT NULL,
    FECHA_NACIMIENTO	date				NOT NULL,
    SEXO 				varchar(10)			NOT NULL,
    TIPO_USUARIO_ID		numeric(8,0)		NOT NULL,
    PERFIL_USUARIO_ID	numeric(8,0)		NOT NULL,
    CONSTRAINT PKU PRIMARY KEY (USUARIO_ID),
    CONSTRAINT USUARIO_SEXO_CHK check(SEXO in('Masculino','Femenino')),
    CONSTRAINT PERFIL_USUARIO_ID_FK FOREIGN KEY (PERFIL_USUARIO_ID) REFERENCES PERFIL_USUARIO (PERFIL_USUARIO_ID),
    CONSTRAINT TIPO_USUARIO_ID_FK FOREIGN KEY (TIPO_USUARIO_ID) REFERENCES TIPO_USUARIO (TIPO_USUARIO_ID)
);


-- 
-- TABLE: HISTORICO CURSO
--

CREATE SEQUENCE SEQ_HISTORICO_CURSO;

CREATE TABLE HISTORICO_CURSO(
	HISTORICO_CURSO_ID	numeric (10,0)	default nextval('SEQ_HISTORICO_CURSO'),
	FECHA_ESTADO		date			NOT NULL,
	ESTADO_CURSO_ID		numeric(10,0)	NOT NULL,
	CURSO_ID 			numeric(4,0)	NOT NULL,
	USUARIO_ID 			numeric(10,0)	NOT NULL,
	CONSTRAINT PKH PRIMARY KEY (HISTORICO_CURSO_ID),
	CONSTRAINT ESTADO_CURSO_ID_FK FOREIGN KEY (ESTADO_CURSO_ID) REFERENCES ESTADO_CURSO (ESTADO_CURSO_ID),
	CONSTRAINT CURSO_ID_FK FOREIGN KEY (CURSO_ID) REFERENCES CURSO (CURSO_ID),
	CONSTRAINT USUARIO_ID_FK FOREIGN KEY (USUARIO_ID) REFERENCES USUARIO (USUARIO_ID)
);


-- 
-- TABLE: CURSO - USUARIO 
--

CREATE SEQUENCE SEQ_CURSO_USUARIO;

CREATE TABLE CURSO_USUARIO(
    CURSO_USUARIO_ID		numeric(10,0)		default nextval('SEQ_CURSO_USUARIO'),
    ESTADO_ACTUAL			varchar(40)			NOT NULL,
    FECHA_ST_ACTUAL			date 				NOT NULL,
    CURSO_ID 				numeric(4,0)		NOT NULL,
    USUARIO_ID 				numeric(10,0)		NOT NULL,
    ESTADO_CURSO_ID 		numeric(10,0)		NOT NULL,
   	FORMA_PAGO_ID			numeric(10,0)		NOT NULL,
   	FACTURA_ID				numeric(30,0)		NOT NULL,
    CONSTRAINT PKCU PRIMARY KEY (CURSO_USUARIO_ID),
    CONSTRAINT CURSO_ID_FK2 FOREIGN KEY (CURSO_ID) REFERENCES CURSO (CURSO_ID),
    CONSTRAINT USUARIO_ID_FK FOREIGN KEY (USUARIO_ID) REFERENCES USUARIO (USUARIO_ID),
    CONSTRAINT ESTADO_CURSO_ID_FK2 FOREIGN KEY (ESTADO_CURSO_ID) REFERENCES ESTADO_CURSO (ESTADO_CURSO_ID),
    CONSTRAINT FORMA_PAGO_ID_FK FOREIGN KEY (FORMA_PAGO_ID) REFERENCES FORMA_PAGO (FORMA_PAGO_ID),
    CONSTRAINT FACTURA_ID_FK FOREIGN KEY (FACTURA_ID) REFERENCES FACTURA (FACTURA_ID)
);



