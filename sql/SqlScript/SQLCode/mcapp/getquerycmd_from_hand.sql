USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[getquerycmd_from_hand]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
--delete [querycmd] where querytag=20  
------------------------------------  
--用途：查询记录信息   
--项目名称：  
/*  
SELECT * FROM [mcapp].[dbo].[querycmd] where  kid=12511 and devid='001251100' order by adatetime desc  
SELECT * FROM [mcapp].[dbo].[querycmd] where  kid=12511 and devid='001251101' order by adatetime desc  
SELECT * FROM [mcapp].[dbo].[querycmd] where  kid=12511 and devid='001251103'   
and status=1  
order by adatetime desc  
SELECT * FROM [mcapp].[dbo].[querycmd] where  kid=8812 and devid='000881201' order by adatetime desc  
*/  
--delete querycmd where querytag=6 and status=1  
--说明：  
--   
--时间：2012-10-16 21:55:38  
--[getquerycmd_from_hand] 12511,'001251102'  
--select convert(varchar(10),GETDATE(),120)  
------------------------------------  
alter PROCEDURE [dbo].[getquerycmd_from_hand]  
@kid int,  
@devid varchar(20)  
 AS    
  
declare @querytag int  
  
 SELECT top 1 @querytag=querytag  
  FROM [mcapp].[dbo].[querycmd]  
   where kid=@kid and devid=@devid and status=1 and querytag not in(10,20,2000,2200)  
    and adatetime>=convert(varchar(10),GETDATE(),120)  
    order by adatetime desc  
  
if(@querytag>0)  
begin  
 if(@querytag in (1,2,3,4,6,9,11,12,13,14,15,16,17,18,19,21,23))  
 begin  
  update [mcapp].[dbo].[querycmd] set status=0,syndatetime=GETDATE()  
   where kid=@kid and devid=@devid and status=1 and querytag=@querytag  
 end   
   
 select @querytag  
end  
else  
begin  
 select 0  
end  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

















GO
