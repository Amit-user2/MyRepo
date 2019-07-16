USE [Test]
GO

/****** Object: Table [dbo].[DestinationTable] Script Date: 5/2/2019 4:36:49 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[statesales1] (
    [State]     VARCHAR (100) NULL,
    [Type]      VARCHAR(100) NULL,
	[Sales]     DECIMAL)
Go

CREATE TABLE [dbo].[statepopulation1] (
    [State]     VARCHAR (100) NULL,
    [City]      VARCHAR(100) NULL,
	[Population]     DECIMAL)
	drop table [dbo].[statepopulation]
	drop table  [dbo].[statesales]

INSERT INTO [dbo].[statesales1]
VALUES ('CA','Internet',60), ('CA','Store',80),('TX','Store',400), ('WA','Internet',150),('WA','Store',100)

INSERT INTO [dbo].[statepopulation1]
VALUES ('CA','Los Angeles',4), ('CA','San Fransisco',0.9),('NY','NEW YORK',8.5)	, ('WA','Seatt',0.7),('WA','Spokaen',0.2)


select * from  [dbo].[statepopulation1]
select * from  [dbo].[statesales1]


select * from saleslt.productdescription
select * from saleslt.product
select * from saleslt.productcategory
select * from [SalesLT].[ProductModelProductDescription]
select * from [SalesLT].[ProductModel]

	SELECT X.STATE, Y.TOTAL_POPULATION, Z.TOTAL_SALES
	FROM (
	SELECT [STATE]  FROM [DBO].[STATEPOPULATION1]
	UNION 
	SELECT [STATE] FROM [statesales1] ) X
	LEFT JOIN (select [state], sum([Population]) as total_population from [dbo].[statepopulation1] group by [state]) Y on x.State = y.State
	LEFT JOIN (select [state], sum([Sales])  as total_sales from [dbo].[statesales1] group by [state]) z on x.State = z.State

use AdventureWorksLT2012

select * from salesLT.Address

select * From  SalesLT.ProductCategory a

select case when b.Name is null then 'Parent' else b.name end
, a.name from SalesLT.ProductCategory a
left join SalesLT.ProductCategory  b on b.ProductCategoryID = a.ParentProductCategoryID

SELECT * FROM SALESLT.PRODUCTCATEGORY A

SELECT * FROM [SALESLT].[SALESORDERHEADER]

SELECT * FROM (
SELECT ROW_NUMBER() OVER (ORDER BY UNITPRICE DESC) AS RNK , * FROM [SALESLT].[SALESORDERDETAIL]) J
WHERE J.RNK = 2

SELECT TOP 1 *  FROM (
SELECT TOP 2* FROM [SALESLT].[SALESORDERDETAIL]
ORDER BY UNITPRICE DESC) J
ORDER BY UNITPRICE ASC

SELECT A.* FROM [SALESLT].[SALESORDERDETAIL] A
ORDER BY UNITPRICE DESC

SELECT * FROM [SALESLT].[SALESORDERDETAIL] A WHERE ROWID <>( SELECT MAX(ROWID) FROM [SALESLT].[SALESORDERDETAIL] B WHERE A.EMPLOYEE_NUM=B.EMPLOYEE_NUM);

;WITH CTE
AS
(
SELECT 0 AS B

UNION ALL

SELECT (B + 1) AS B 
FROM CTE WHERE B < 9
)

SELECT (T2.B * 10) +T1.B FROM CTE T1, CTE T2



CREATE TABLE StaffHours
   ( 
      StaffMember CHAR(1) , 
      EventDate DATE , 
      EventTime TIME , 
      EventType VARCHAR(5) 
   ); 
 
INSERT INTO StaffHours
   ( StaffMember, EventDate, EventTime, EventType ) 
VALUES 
   ( 'A', '2013-01-07', '08:00', 'Enter' ), 
   ( 'B', '2013-01-07', '08:10', 'Enter' ), 
   ( 'A', '2013-01-07', '11:30', 'Exit' ), 
   ( 'A', '2013-01-07', '11:35', 'Exit' ), 
   ( 'A', '2013-01-07', '12:45', 'Enter' ), 
   ( 'B', '2013-01-07', '16:45', 'Exit' ) ,
   ( 'A', '2013-01-07', '17:30', 'Exit' ),
   ( 'A', '2013-01-07', '1:00', 'Exit' ),
   ( 'C', '2013-01-07', '08:33', 'Enter' ), 
   ( 'C', '2013-01-07', '17:33', 'Exit' ), 
   ( 'C', '2013-01-07', '17:35', 'Exit' );

;WITH LEVEL1
AS
(
 SELECT A.*, ROW_NUMBER() OVER (PARTITION BY STAFFMEMBER ORDER BY EventDate, EVENTTIME) AS RNM, CAST(EVENTDATE AS DATETIME) + CAST(EVENTTIME AS DATETIME)  AS EVENTDATETIME FROM StaffHours A)
, 

LEVEL2
AS
(
SELECT A.* , COALESCE( B.EVENTTYPE, 'NA') AS  PREVEVENT,COALESCE(C.EVENTTYPE, 'NA') AS NEXTEVENT  FROM LEVEL1 A
LEFT JOIN LEVEL1 B ON A.RNM -1 =  B.RNM AND A.STAFFMEMBER = B.STAFFMEMBER
LEFT JOIN LEVEL1 C ON A.RNM +1 =  C.RNM AND A.STAFFMEMBER = C.STAFFMEMBER
)
,  LEVEL3
AS
(
SELECT * fROM LEVEL2
WHERE NOT (EVENTTYPE = 'Exit' and NEXTEVENT ='Exit')
      AND NOT (EVENTTYPE = 'Enter' and PREVEVENT ='Enter')
      and not (EVENTTYPE = 'Enter' and NEXTEVENT ='NA')
	  and not (EVENTTYPE = 'Exit' and PREVEVENT = 'NA')
)
,
LEVEL4
AS (SELECT *, row_number() over (partition by staffmember order by eventdatetime) as rnm1 fROM LEVEL3)

SELECT A.StaffMember,A.EVENTDATETIME, B.EVENTDATETIME,DATEDIFF(SECOND, A.EVENTDATETIME, B.EVENTDATETIME)/3600  FROM LEVEL4 A
LEFT JOIN LEVEL4  B
ON A.StaffMember = B.StaffMember AND A.RNM1 + 1 = B.RNM1
WHERE A.EventType = 'ENTER'


SELECT ISNULL(null,0)


SELECT *, REPLICATE('* ',t.A)
FROM (VALUES (1),(2),(3),(4)) AS T(A)


use test


select * into dbo.source_emp from [dbo].[emp]


insert into dbo.source_emp values (3,'d', 'd')

update dbo.source_emp
set f_name = 'Amit kuma'
where id =1

update dbo.emp
set active =1
where id =1


delete from dbo.emp
select * From dbo.emp
order by id


UPDATE dbo.emp 
SET active  =1


alter table dbo.emp
add constraint dflt default 0 for active 

Pk, FK, Default, CHECk,Unique, rebuild and reorganize.







