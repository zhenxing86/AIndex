USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[initData]    Script Date: 05/14/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	初始化基础数据表
-- =============================================
CREATE PROCEDURE [dbo].[initData]
@uid int	
AS
   declare @userId int
   declare @theTerm varchar(100)
   declare @year int
   declare @month int
   declare @p int
   declare @paramId int
   declare @utype int
  set @userId = @uid
 
  select @utype=u.usertype from BasicData..[user] u where u.userid = @userId
  select @utype
  
  if(@utype=0)
  begin
     --初始化BaseInfo表
       select '你好'
  exec initBaseInfo @userId
  
--初始化ExcepitonCount表
   
 set @year = YEAR(GETDATE())
   set @month = MONTH(GETDATE())
   --当前学期
   set @month = dbo.getTerm(GETDATE())
  
   set @theTerm = convert(varchar(50),@year)+'-'+convert(varchar(50),@month)
   select @paramId=id from HealthApp..BaseInfo where uid=@uid and term=@theTerm
   exec initExceptionCount_v2 @uid,@paramId
  end
GO
