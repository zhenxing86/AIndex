USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[getquerycmd]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






--delete [querycmd] where querytag=20
------------------------------------
--用途：查询记录信息 
--项目名称：
/*
SELECT * FROM [mcapp].[dbo].[querycmd] where querytag=10 and kid=12511 and devid='001251101' order by adatetime desc
SELECT * FROM [mcapp].[dbo].[querycmd] where querytag=10 and kid=12511 and devid='001251100' order by adatetime desc
SELECT * FROM [mcapp].[dbo].[querycmd] where querytag=10 and kid=8812 and devid='000881201' order by adatetime desc
*/
--delete querycmd where querytag=6 and status=1
--说明：
-- 
--时间：2012-10-16 21:55:38
--[getquerycmd] 12511,'001251102'
------------------------------------
CREATE PROCEDURE [dbo].[getquerycmd]
@kid int,
@devid varchar(20)
 AS 	

declare @querytag int

	SELECT top 1 @querytag=querytag
		FROM [mcapp].[dbo].[querycmd]
			where kid=@kid and devid=@devid 
					and status=1 and querytag in(10,20,2000,2200)
				order by adatetime desc

if(@querytag>0)
begin
	
	update [mcapp].[dbo].[querycmd] set status=0,syndatetime=GETDATE()
		where kid=@kid and devid=@devid and status=1 and querytag=@querytag	
	
	select @querytag
end
else
begin
	select 0
end


















GO
