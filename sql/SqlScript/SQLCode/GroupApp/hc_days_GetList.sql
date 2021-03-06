USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hc_days_GetList]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
-- =============================================    
-- Author:  <Author,,Name>    
-- Create date: <Create Date,,>    
-- Description: <Description,,>    
-- =============================================    
CREATE PROCEDURE [dbo].[hc_days_GetList]  
 @userid int,    
 @indate datetime    
AS    
BEGIN    
     
 SET NOCOUNT ON;    
   
 Declare @intime datetime, @outtime datetime  
 Select @intime = intime, @outtime = outtime  
   From mcapp.dbo.stu_in_out_time   
   Where userid = @userid and adddate = convert(varchar(10), @indate, 120)  
   
 Select top 1 @intime intime, @outtime outtime, temperature tw,   
        Case When CHARINDEX(',11,', ',' + result) > 0 Then 2 Else 1 End chuqin, result zzdesc,  
        Case When (','+result like '%,1,%') Or (','+result like '%,2,%') Or (','+result like '%,3,%') Or  
                  (','+result like '%,4,%') Or (','+result like '%,5,%') Or (','+result like '%,6,%') Or  
                  (','+result like '%,7,%') Or (','+result like '%,8,%') Or (','+result like '%,10,%') Or 
                  Case When ISNUMERIC(temperature) = 1 THen CAST(temperature as Float) Else 0 End >= 37.8
             Then Case When (','+result like '%,11,%') Then uname + '小朋友，今天身体不舒服，不适宜入园，请爸爸妈妈在家要好好照顾他（/她）哟'   
                       Else uname + '小朋友，今天身体不太好，一定要注意哦，有什么事情一定要告诉老师哟”。' End   
             Else uname + '小朋友，今天身体很棒，一定要好好学习哦”。' End content  
   From mcapp.dbo.rep_mc_child_checked_detail   
   Where userid = @userid and CONVERT(varchar(10), checktime, 120) = CONVERT(varchar(10), @indate, 120)  
   order by ID  
END    
   
  
GO
