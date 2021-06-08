CREATE ROLE "postgresMin" WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:7dSM3s/1z/4Ke4ggZEPoqA==$fmklprgq0bxBS7MAU5PxdM+SFDBqzPy6jXoF/TER2mg=:9vrZDU9kqi+O7l6XcOftZSetf/ehNuBHsJYVlBMt/kI=';
  
  CREATE DATABASE "inventarioDb"
    WITH 
    OWNER = "postgresMin"
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Colombia.1252'
    LC_CTYPE = 'Spanish_Colombia.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
    
  
CREATE TABLE public.cargos
(
    id_cargo bigint NOT NULL,
    nombre_cargo character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT cargos_pkey PRIMARY KEY (id_cargo),
    CONSTRAINT uk_fs84da9fgnvg9agqmcbm4c0pk UNIQUE (nombre_cargo)
)

TABLESPACE pg_default;

ALTER TABLE public.cargos
    OWNER to "postgresMin";
    
    
CREATE TABLE public.productos
(
    id_producto bigint NOT NULL,
    cantidad integer NOT NULL,
    fecha_ingreso date,
    nombre_producto character varying(400) COLLATE pg_catalog."default" NOT NULL,
    id_usuario_reg bigint NOT NULL,
    CONSTRAINT productos_pkey PRIMARY KEY (id_producto),
    CONSTRAINT uk_kxtgmpvsxqq83g74abjm2e88y UNIQUE (nombre_producto),
    CONSTRAINT fk61ajmi1dv8oo7qp8nowivglp6 FOREIGN KEY (id_usuario_reg)
        REFERENCES public.usuarios (id_usuario) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT productos_cantidad_check CHECK (cantidad >= 0)
)

TABLESPACE pg_default;

ALTER TABLE public.productos
    OWNER to "postgresMin";
    
CREATE TABLE public.usuarios
(
    id_usuario bigint NOT NULL,
    apellidos character varying(50) COLLATE pg_catalog."default",
    edad integer NOT NULL,
    fecha_ingreso date,
    nombres character varying(50) COLLATE pg_catalog."default",
    usuario character varying(50) COLLATE pg_catalog."default" NOT NULL,
    id_cargo bigint NOT NULL,
    CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario),
    CONSTRAINT uk_3m5n1w5trapxlbo2s42ugwdmd UNIQUE (usuario),
    CONSTRAINT fkdedywmktm4yolcuws70emifbs FOREIGN KEY (id_cargo)
        REFERENCES public.cargos (id_cargo) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT usuarios_edad_check CHECK (edad >= 0 AND edad <= 200)
)

TABLESPACE pg_default;

ALTER TABLE public.usuarios
    OWNER to "postgresMin";
    
    CREATE TABLE public.actualizaciones
(
    id_actualizacion bigint NOT NULL,
    fecha_actualizacion date NOT NULL,
    id_producto_act bigint NOT NULL,
    id_usuario_act bigint NOT NULL,
    CONSTRAINT actualizaciones_pkey PRIMARY KEY (id_actualizacion),
    CONSTRAINT fk7gqae08tx3y0arl33exunmi7p FOREIGN KEY (id_usuario_act)
        REFERENCES public.usuarios (id_usuario) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fka76lfnyqairthdb0ad5yc1ld4 FOREIGN KEY (id_producto_act)
        REFERENCES public.productos (id_producto) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.actualizaciones
    OWNER to "postgresMin";