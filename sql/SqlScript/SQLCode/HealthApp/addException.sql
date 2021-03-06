USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[addException]    Script Date: 05/14/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addException]
@bid int,
@kid int,
@ryear int,
@rmonth int	
AS
 declare @checktime datetime
 declare @tw   varchar(50)
 declare @lbt  varchar(50)
 declare @hlfy  varchar(50)
 declare @ks  varchar(50)
 declare @fs  varchar(50)
 declare @hy  varchar(50)
 declare @szk  varchar(50)
 declare @fx  varchar(50)
 declare @pz  varchar(50)
 declare @jzj  varchar(50)
 declare @fytx  varchar(50)
 declare @go varchar(50)
 declare @count int
 declare @index int
 declare @theyear int
 declare @themonth int
 declare @h int
 declare @m int
 declare @s int
 declare @pchecktime varchar(500)
 declare @result varchar(100)
 declare @status int
 --set @theyear = YEAR(GETDATE())
 --set @themonth = MONTH(GETDATE())
 set @theyear = @ryear
 set @themonth = @rmonth
 
select @count = day(dateadd(mm,1,getdate())-day(getdate()))
-- set @count = 2
SET @index=1
 
WHILE @index<@count  
BEGIN  
  
   select @h =   cast( floor(rand()*24) as int)
   select @m = cast( floor(rand()*60) as int)
   select @s = cast( floor(rand()*60) as int)
   set @pchecktime = CAST(@theyear as varchar)+'-'+CAST(@themonth as varchar)+'-'+CAST(@index as varchar)+' '+cast(@h as varchar)+':'+cast(@m as varchar)+':'+cast(@s as varchar)
   set @tw = '48'
   set @lbt = cast( floor(rand()*2) as int)
   set @hlfy = cast( floor(rand()*2) as int)
   set @ks = cast( floor(rand()*2) as int)
   set @fs = cast( floor(rand()*2) as int)
   set @hy = cast( floor(rand()*2) as int)
   set @szk = cast( floor(rand()*2) as int)
   set @fx = cast( floor(rand()*2) as int)
   set @pz = cast( floor(rand()*2) as int)
   set @jzj = cast( floor(rand()*2) as int)
   set @fytx = cast( floor(rand()*2) as int)
   set @go = cast( floor(rand()*2) as int)
   set @status = cast( floor(rand()*2) as int)
   select @pchecktime
   select @result = cast( floor(rand()*12) as varchar)+','+cast( floor(rand()*12) as varchar)+','+cast( floor(rand()*12) as varchar)+','+cast( floor(rand()*12) as varchar)
       +','+cast( floor(rand()*12) as varchar)+','
INSERT INTO checkRecord (bid,kid,checktime,tw,lbt,hlfy,ks,fs,hy,szk,fx,pz,jzj,fytx,[go],result,status)  
VALUES (@bid,@kid,cast(@pchecktime as datetime),@tw,@lbt,@hlfy,@ks,@fs,@hy,@szk,@fx,@pz,@jzj,@fytx,@go,@result,@status)  
   
 SET @index=@index+1  
END
GO
