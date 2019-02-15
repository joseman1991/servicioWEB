--create database sistemabasura;

drop table if exists eventos cascade;
drop table if exists estados cascade;
drop table if exists usuarios cascade;
drop table if exists perfiles cascade;

create table estados(
 idestado serial not null primary key,
 descripcion varchar(15)
);

 insert into estados values(1,'ENCENDIDO');
 insert into estados values(2,'APAGADO');
 insert into estados values(3,'VACIADO');

 create table eventos(
 idevento serial not null primary key,
 idestado int not null references estados on delete restrict on update cascade,
 fecha timestamp default current_timestamp
 );

 insert into eventos(idestado,fecha) values(1,'2019-02-10');
 insert into eventos(idestado,fecha) values(2,'2019-02-01');

 




create table perfiles(
 idperfil int not null primary key,
 descripcion varchar(15)
);

insert into perfiles values(1,'ADMIN');
insert into perfiles values(2,'USUARIO');

create table usuarios(
 idusuario serial not null primary key,
 nombreusuario varchar(15) not null unique,
 clave varchar(16) not null,
 nombres varchar(25),
 apellidos varchar(25),
 idperfil int not null references perfiles on update cascade on delete restrict
);

insert into usuarios values(default,'marjorie','1234','MARJORIE','ROSADO',1);
insert into usuarios values(default,'marj','1234','MARJORIE','ROSADO',2);



 

 select descripcion, count(*) from eventos ev inner join estados es on ev.idestado=es.idestado
 group by descripcion;

create or replace function obtenerFechaDomingo() returns timestamp as
$$
declare
 dato varchar;
 fech timestamp;
 dia int;
begin
 select to_char(fecha,'d'),fecha into dato,fech from eventos;
 dia:=dato::int-1;
 dato:=concat(dia,' days');
 fech:=fech - cast(dato as interval); 
 return fech;
end
$$
language plpgsql;
select obtenerFechaDomingo();

create or replace function obtenerFechaInicioMes() returns timestamp as
$$
declare
 dato varchar;
 fech timestamp;
 dia int;
begin
 select to_char(fecha,'dd'),fecha into dato,fech from eventos;
 dia:=dato::int-1;
 dato:=concat(dia,' days');
 fech:=fech - cast(dato as interval); 
 return fech;
end
$$
language plpgsql;
select obtenerFechaInicioMes();



drop type if exists tipo cascade;
create type tipo as (descripcion varchar(15), fecha varchar(15), hora varchar(15));

create or replace function obtenerRegistros(int) returns setof tipo
as
$$
declare
 registro tipo%rowtype;  
begin
 case  $1 
 --diario
 when 1 then
  for registro in (select descripcion, to_char(fecha,'dd mon yyyy') as fecha,to_char(fecha,'HH24:mi:ss') as hora
   from eventos ev inner join estados es on ev.idestado=es.idestado
   where to_char(fecha,'yyyy-mm-dd') = to_char(current_timestamp,'yyyy-mm-dd')) loop
   return next registro;
  end loop;

 --semanal
 when 2 then
   for registro in (select descripcion, to_char(fecha,'dd/mm/yyyy') as fecha,to_char(fecha,'HH24:mi:ss') as hora
    from eventos ev inner join estados es on ev.idestado=es.idestado
    where fecha::DATE between obtenerFechaDomingo()::DATE and current_timestamp::DATE) loop
    return next registro;
  end loop;

 --mensual
 when 3 then
   for registro in (select descripcion, to_char(fecha,'dd/mm/yyyy') as fecha,to_char(fecha,'HH24:mi:ss') as hora
    from eventos ev inner join estados es on ev.idestado=es.idestado
    where fecha::DATE between obtenerFechaInicioMes()::DATE and current_timestamp::DATE) loop
    return next registro;
  end loop;
 end case; 
end
$$
language plpgsql;

select * from obtenerRegistros(2);


create or replace function obtenerConteo(int) returns int
as
$$
declare
 conteo int; 
begin
 case  $1 
 --diario
 when 1 then
   select count(*) into conteo
    from eventos ev inner join estados es on ev.idestado=es.idestado
    where to_char(fecha,'yyyy-mm-dd') = to_char(current_timestamp,'yyyy-mm-dd') ;
   
 

 --semanal
 when 2 then
  select count(*) into conteo
    from eventos ev inner join estados es on ev.idestado=es.idestado
    where fecha::DATE between obtenerFechaDomingo()::DATE and current_timestamp::DATE;
   
  

 --mensual
 when 3 then
  select count(*) into conteo
    from eventos ev inner join estados es on ev.idestado=es.idestado
    where fecha::DATE between obtenerFechaInicioMes()::DATE and current_timestamp::DATE; 
 end case; 
 return conteo;
end
$$
language plpgsql;

select obtenerConteo(3);

