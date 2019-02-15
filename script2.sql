
drop table if exists usuarios;
drop table if exists perfiles;

create table perfiles(
 idperfil int not null primary key,
 descripcion varchar(15)
);

insert into perfiles values(1,'ADMIN');
insert into perfiles values(2,'USUARIO');

create table usuarios(
 idusuario serial not null primary key,
 nombreusuario varchar(15) not null,
 clave varchar(16) not null,
 nombres varchar(25),
 apellidos varchar(25),
 idperfil int not null references perfiles on update cascade on delete restrict
);

insert into usuarios values(default,'marjorie','1234','MARJORIE','ROSADO',1);
insert into usuarios values(default,'marj','1234','MARJORIE','ROSADO',2);

