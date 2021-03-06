USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hc_month_GetList]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
-- =============================================    
-- Author:  <Author,,Name>    
-- Create date: <Create Date,,>    
-- Description: <Description,,>    
-- =============================================    
CREATE PROCEDURE [dbo].[hc_month_GetList]   
 @userid int,    
 @indate datetime    
AS    
     
SET NOCOUNT ON;  
   
Select CONVERT(varchar(10), checktime, 120) dotime, temperature, result, DATEPART(dd, checktime) dd,  
      ROW_NUMBER() Over(partition by CONVERT(varchar(10), checktime, 120) order by id) Row, Cast('' as Varchar(50)) reasoncode  
  Into #Temp   
  From mcapp.dbo.rep_mc_child_checked_detail   
  Where userid = @userid and CONVERT(varchar(7), checktime, 120) = CONVERT(varchar(7), @indate, 120)  
   
 if Not Exists (Select * From #Temp)  
   Insert Into #Temp(dotime, temperature, result, dd, Row, reasoncode)  
     Select CONVERT(varchar(10), @indate, 120), '', '', DATEPART(dd, @indate), 1, reasoncode  
       From mcapp.dbo.stu_in_out_time s
         left join basicdata..dict_xml d 
          on s.reasoncode = d.Code and d.Catalog='缺勤原因'
       Where adddate = CONVERT(varchar(10), @indate, 120) and userid = @userid  
  
select temperature tw, Case When CHARINDEX(',11,', ',' + result) > 0 Then 2 Else 1 End chuqin, result statedesc, reasoncode  
  From #Temp  
  Where dotime = CONVERT(varchar(10), @indate, 120)  
  
Select dd [day], Case When result <> '' Then 1 Else 0 End daystate From #Temp  
  
drop table #Temp  


select *from basicdata..dict_xml d 
          where d.Catalog='缺勤原因'
  
GO
