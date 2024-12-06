use Food_king_Restaurant
Create database Food_king_Restaurant
on
(
	name='FoodkingRestaurant_data_1',
	FileName='C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Food king Restaurant_data_1.mdf',
	Size=25mb,
	Maxsize=100mb,
	FileGrowth=5%
)
log on
(
	name='Food_king_Restaurant_log_1',
	FileName='C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Food_king_Restaurant_Log_1.Ldf',
	Size=2mb,
	Maxsize=25mb,
	FileGrowth=1%
)

select* from Menu
select* from Fooditem
select* from Customer
select * from Order_Info
select * from Payment
select *from Employee
select * from Monthly_Transaction

Create table Menu
(Menu_ID int Primary key,
Menu_Cat varchar(30),
Menu_Name varchar(191),
Preparing_time varchar(30)
);

create table Fooditem
(FoodItem_No int primary key,
FoodItem_Name varchar(50),
Menu_ID int references menu (Menu_ID),
Availabality varchar(50),
Price numeric(10,2)
);

create table Customer
(Customer_ID int primary key,
Customer_Name varchar(30),
Email varchar (30) null,
Phone_No int,
Payment_ID varchar(30),
Menu_ID int references menu(Menu_ID),
FoodItem_No int references FoodItem(Fooditem_No)
);
create table Order_Info
(Order_ID int primary key,
Order_Date varchar(30),
Customer_ID int references Customer(Customer_ID),
Order_Type varchar(30),
Quantity int,
Size varchar(30)
);
create table Payment
(Payment_ID int primary key,
Order_ID int references Order_Info(Order_ID),
Payment_Date varchar(30),
Amount int ,
Payment_Type varchar (30)
);

create table Employee
(Employee_ID int primary key,
Employee_Name varchar(50),
Designation varchar(50),
responsibility varchar(50),
Working_hour varchar(50),
Contact_Number varchar(50)
);

create table Monthly_Transaction
(Order_ID int references Order_Info(Order_ID),
Customer_ID int references Customer(customer_ID),
Menu_ID int references menu(Menu_ID),
FoodItem_no int references FoodItem(fooditem_No),
Payment_ID int references Payment(Payment_ID),
Employee_Id int references Employee(Employee_ID),
primary key(Order_ID,Customer_ID,Menu_ID,FoodItem_No,Payment_ID,Employee_Id),
);

------insert----
Go
Insert into  Menu
(Menu_ID,Menu_Cat,Menu_Name,Preparing_time) 
Values(1,'01','chicken','10 minutes'),
(2,'02','Nachos','20 minutes'),
(3,'03','pasta','30 minutes'),
(4,'04','Salad','5 minutes'),
(5,'05','Rice Bowl','35 minutes'),
(6,'06','Burger','30 minutes')
Go
insert into Fooditem(FoodItem_No,FoodItem_Name,Menu_ID,Availabality,Price)
values('1','Egg Fried rice','1','Lunch & Dinner','300'),
('2','Chinese pakoda','2',' Dinner','350'),
('3','Fireball','1',' Dinner','400'),
('4','Masala sandwich','6',' Breakfast','200'),
('5','Tender Beef','5',' Lunch','400')
Go
insert into Customer(Customer_ID,Customer_Name,Email,Phone_No,Payment_ID,Menu_ID,FoodItem_No)values('1','Fariha khan','farihakabirkhan@gmail.com','01630000000','100','1','1'),('2','Shyla Akter','shaylaakter@gmail.com','01730000000','101','2','2'),('3','Taslima khatun','taslima@gmail.com','01930000000','102','3','3'),('4','kamona akter','kamonaakter@gmail.com','01330000000','103','4','4');Goinsert into Order_Info(Order_ID,Order_Date,Customer_ID,Order_Type,Quantity,Size)
values(10,'1-1-2020 10.00:00',default,'Online',2,'large');insert into Order_Info(Order_ID,Order_Date,Customer_ID,Order_Type,Quantity,Size)values(11,'11-1-2020 11:10:00',default,'Online',3,'large'),(12,'11-1-2020 10:10:00',default,'Online',5,'large'),(13,'11-1-2020',default,'debit card',6,'small'),(14,'15-1-2020',default,'cash',2,'half'),(15,'16-1-2020',default,'credit card',6,'mini');
Go
insert into Payment(Payment_ID,Order_ID,Payment_Date,Amount,Payment_Type)
values(100,10,'1-1-2020',335,'cash'),
(101,11,'11-1-2020',500,'cash'),
(102,12,'11-1-2020',300,'credit card'),
(103,13,'17-1-2020',335,'debit card')
Go
insert into Employee(Employee_Id,Employee_Name,Designation,responsibility,Working_hour,contact_number)
values(1,'johirul karim','chef','preparing food','9AM to 3PM','01457894561'),(2,'jolil miya','chef','preparing food','3PM to 9PM','01457893661'),(3,'Kuddus uddin','Manager','','9AM to 9PM','01897894561'),(4,'reza karim','waiter','serving food','9AM to 3PM','01457832561'),
(5,'jobbar hok','waiter','dealing with customer service issues','8Am to 3PM ','01925465963')
Go
insert into Monthly_Transaction(Order_ID,Customer_ID,Menu_ID,FoodItem_no,Payment_ID,Employee_Id)
values(10,1,1,1,100,1),
(11,2,2,2,101,2),
(10,3,3,3,102,3),
(10,4,4,4,103,4)
Go
---------------join-----------
select M.Menu_ID,M.Menu_Cat,M.Menu_Name,M.Preparing_time,Fi.FoodItem_Name,Fi.Availabality,Fi.Price,
c.Customer_ID,C.Phone_No,O.Order_Date,O.Order_Type,O.Size,P.Amount,E.Employee_Name,E.Designation,E.Working_hour
from Monthly_Transaction MT
join Menu M on MT.Menu_ID = M.Menu_ID
join Fooditem Fi on MT.FoodItem_no = Fi.FoodItem_No
join Customer C on MT.Customer_ID = C.Customer_ID
join Order_Info O on MT.Order_ID = O.Order_ID
join Payment P on MT.Payment_ID = P.Payment_ID
join Employee E on MT.Employee_Id = E.Employee_ID


-----------group by----------
Select Menu.Menu_Name, Count (Menu_Name) As NoOfManu
From Menu JOIN Monthly_Transaction
On Menu.Menu_ID=Monthly_Transaction.Menu_ID
Where Menu_Name IN (Select Menu_Name from Menu)
Group by Menu.Menu_Name

--------------sub query--------
select * from Payment
where Payment_ID in (select Payment_ID from Payment where Amount>100);
-------group by------
select COUNT (Payment_ID) as PayID ,Amount from Payment group by Amount

select * from Payment
-------having------

select COUNT (Payment_ID) as PayID ,Amount from Payment group by Amount 
HAVING COUNT(Amount) < 335
------------case----------
select Fooditem.FoodItem_Name,
case
when Fooditem.FoodItem_Name='Fireball' then 'Delicious Food'
when Fooditem.FoodItem_Name='Masala sandwich' then 'Normal Food'
else 'Regular Food'
end as Status
from Monthly_Transaction 
join Fooditem  on Monthly_Transaction.FoodItem_no = Fooditem.FoodItem_No
GO

-------view------
create view View_Table as
select M.Menu_ID,M.Menu_Cat,M.Menu_Name,M.Preparing_time,Fi.FoodItem_Name,Fi.Availabality,Fi.Price,
c.Customer_ID,C.Phone_No,O.Order_Date,O.Order_Type,O.Size,P.Amount,E.Employee_Name,E.Designation,E.Working_hour
from Monthly_Transaction MT
join Menu M on MT.Menu_ID = M.Menu_ID
join Fooditem Fi on MT.FoodItem_no = Fi.FoodItem_No
join Customer C on MT.Customer_ID = C.Customer_ID
join Order_Info O on MT.Order_ID = O.Order_ID
join Payment P on MT.Payment_ID = P.Payment_ID
join Employee E on MT.Employee_Id = E.Employee_ID
GO
select* from View_Table
-----create triger------
Create Trigger TrPayment
On Payment
After Insert, Update
As
Insert Into Backup_Payment_Details(Payment_ID,Order_ID,Payment_Date,Amount,Payment_Type)
Select 
i.Payment_ID,i.Order_ID,i.Payment_Date,i.Amount,i.Payment_Type From inserted i;
Go
create table Backup_Payment_Details
(Payment_ID int primary key,
Order_ID int references Order_Info(Order_ID),
Payment_Date varchar(30),
Amount int ,
Payment_Type varchar (30)
);
GO
select* from Backup_Payment_Details
drop table Monthly_Transaction
drop table Payment


------NONCLUSTERED INDEX
create NONCLUSTERED INDEX Monthly_Transaction on Monthly_Transaction(Payment_ID)

---------CTE---------
Go
WITH Customer_CTE (Cust_Name,Cust_ID)
AS
(SELECT
        Customer_Name,
		Customer_ID
 FROM   Customer)
SELECT Cust_Name,
		Cust_ID
FROM   Customer_CTE
Go
--------Marge-------

create table Menu_Merge(
Menu_ID int Primary key,
Menu_Cat varchar(30),
Menu_Name varchar(191),
Preparing_time varchar(30)
);
	GO
	merge into dbo.Menu_Merge as MM
	using dbo.Menu as M
	on MM.Menu_ID = M.Menu_ID
	when matched then 
	update set MM.Menu_Name = M.Menu_Name
	when NOT matched then
	insert (Menu_ID,Menu_Cat,Menu_Name,Preparing_Time)
	values(M.Menu_ID,M.Menu_Name,M.Menu_Cat,M.Preparing_Time);
	GO
	select * from Menu_Merge

-----function--------
Go
create function Function_Info
()
returns table
return
(select M.Menu_ID,M.Menu_Cat,M.Menu_Name,M.Preparing_time,Fi.FoodItem_Name,Fi.Availabality,Fi.Price,
c.Customer_ID,C.Phone_No,O.Order_Date,O.Order_Type,O.Size,P.Amount,E.Employee_Name,E.Designation,E.Working_hour
from Monthly_Transaction MT
join Menu M on MT.Menu_ID = M.Menu_ID
join Fooditem Fi on MT.FoodItem_no = Fi.FoodItem_No
join Customer C on MT.Customer_ID = C.Customer_ID
join Order_Info O on MT.Order_ID = O.Order_ID
join Payment P on MT.Payment_ID = P.Payment_ID
join Employee E on MT.Employee_Id = E.Employee_ID)
GO

select * from Function_Info();

/*
1.Trigger 
2.Stored Procedure
3.Create table
4.3NF
5.Index Create(Claster/non)
6.Function
7.View
8.Insert/Update/Delete,Drop
9.Query,SubQuery,Join,Union,Marge Table,CTE,CASE
10.Having,GroupBy,Order By,Exist,Roll up,
11.Show all table
12.aggregate function*/

*/