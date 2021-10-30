CREATE DATABASE "Almacenes"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;



create table productos(
producto int primary key,
Nombre varchar(100) not null,
precio money not null

)
--nombre de cajeros
create table Cajeros(
Cajero int primary key,
NomApels varchar(255)
	
)

create table Maquinas_Registrados(
Maquina int primary key,
piso int
)

create table Venta(
	Cajero int  ,
	Maquina int,
	Producto int,
	foreign key (cajero) references Cajeros(cajero),
	foreign key (Maquina) references maquinas_registrados(maquina),
	foreign key (producto) references Productos(producto)
)
--Ensercion de Cajeros----
insert into Cajeros(Cajero ,NomApels) values (1, 'Brayan Enrique Ramirez')
insert into Cajeros(Cajero ,NomApels) values (2, 'Elena Urrea'),
insert into Cajeros(Cajero ,NomApels) values (3, 'Sixto Lazaro'),
insert into Cajeros(Cajero ,NomApels) values (4, 'Miguel Hernandez'),
insert into Cajeros(Cajero ,NomApels) values (5, 'Kepler Manuel'),
insert into Cajeros(Cajero ,NomApels) values (6, 'Juan Garcia'),
insert into Cajeros(Cajero ,NomApels) values (7, 'Ana Yereniz')
select * from Cajeros
---Productos-----
insert into Productos(Producto ,Nombre,Precio) values (1, 'laptop hp', 7000.60)
insert into Productos(Producto ,Nombre,Precio) values (2, 'pallets de audifonos', 26000.30)
insert into Productos(Producto ,Nombre,Precio) values (3, 'audifonos Bose', 6050.60)
insert into Productos(Producto ,Nombre,Precio) values (4, 'smart tv samsung', 56000.60)
insert into Productos(Producto ,Nombre,Precio) values (5, 'smartphone LG', 13000.00)
insert into Productos(Producto ,Nombre,Precio) values (6, 'Tablet gateway', 3000.60)
insert into Productos(Producto ,Nombre,Precio) values (7, 'smart watch ', 20000.60)

select * from productos



----maquinas registradas

insert into maquinas_registrados(Maquina,Piso) values (1,1)
insert into maquinas_registrados(Maquina,Piso) values (2,1)
insert into maquinas_registrados(Maquina,Piso) values (3,3)
insert into maquinas_registrados(Maquina,Piso) values (4,3)
insert into maquinas_registrados(Maquina,Piso) values (5,2)
insert into maquinas_registrados(Maquina,Piso) values (6,2)
insert into maquinas_registrados(Maquina,Piso) values (7,2)

select * from maquinas_registrados



---ventas-----
insert into Venta(Cajero ,Maquina,Producto) values (1, 2,2)
insert into Venta(Cajero ,Maquina,Producto) values (1, 3,1)
insert into Venta(Cajero ,Maquina,Producto) values (3, 2,7)
insert into Venta(Cajero ,Maquina,Producto) values (1, 3,4)
insert into Venta(Cajero ,Maquina,Producto) values (4, 1,2)
insert into Venta(Cajero ,Maquina,Producto) values (1, 2,5)
insert into Venta(Cajero ,Maquina,Producto) values (5, 1,6)
insert into Venta(Cajero ,Maquina,Producto) values (1, 2,4)
insert into Venta(Cajero ,Maquina,Producto) values (6, 1,2)
insert into Venta(Cajero ,Maquina,Producto) values (7, 7,3)

select * from venta


--2. Mostrar el número de ventas de cada producto, ordenado de más a menos ventas.
select p.nombre, sum(v.producto) cantidad from venta v inner join productos p on(p.producto=v.producto)
group by p.nombre order by  cantidad desc

--3. Obtener un informe completo de ventas, indicando el nombre del cajero que realizo la venta, nombre y precios
--de los productos vendidos, y el piso en el que se encuentra la máquina registradora donde se realizó la venta.

select c.nomapels, p.nombre,p.precio, mr.piso from venta v inner join productos p on(p.producto=v.producto)
inner join cajeros c on(c.cajero=v.cajero)  inner join maquinas_registrados mr 
on(mr.maquina=v.maquina) 

---4Obtener las ventas totales realizadas en cada piso.

select mr.piso, sum(p.precio)  from venta v inner join productos p on(p.producto=v.producto)
inner join cajeros c on(c.cajero=v.cajero)  inner join maquinas_registrados mr 
on(mr.maquina=v.maquina)  group by mr.piso

--5 Obtener el código y nombre de cada cajero junto con el importe total de sus ventas.
select c.cajero,c.nomapels,sum(p.precio) from venta v inner join productos p on(p.producto=v.producto)
inner join cajeros c on(c.cajero=v.cajero)  inner join maquinas_registrados mr 
on(mr.maquina=v.maquina)  group by c.cajero

--6 Obtener el código y nombre de cada cajero junto con el importe total de sus ventas.

select c.cajero,c.nomapels,mr.piso , sum(p.precio) as venta from venta v inner join productos p on(p.producto=v.producto)
inner join cajeros c on(c.cajero=v.cajero)  inner join maquinas_registrados mr 
on(mr.maquina=v.maquina)  group by c.cajero,mr.piso having sum(p.precio)::numeric<5000.00

