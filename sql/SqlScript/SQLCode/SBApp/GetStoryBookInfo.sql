USE [SBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetStoryBookInfo]    Script Date: 04/16/2014 11:07:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--[GetStoryBookInfo] 669726, '5CCAC41E-1B42-4BE7-A1FD-B78D203B50E4'  
ALTER PROCEDURE [dbo].[GetStoryBookInfo]-- 669726, '78A93DF1-2DB5-4A1A-8FB3-40987435541B'  
@userid int,  
@sbid nvarchar(50)  
 AS   

--写日志  
INSERT INTO [SBAppLog].[dbo].[ViewLogs]  
           ([userid]  
           ,[viewdatetime]  
           ,[sbid])  
     VALUES  
           (@userid  
           ,getdate()  
           ,@sbid)  
  
declare @isvip_ysdw int  
declare @isvip_status int  

--获取是否VIP
set @isvip_status=ossapp.dbo.addservice_vip_GetRule(@userid,803)


  
 
declare @cdky int  
select @cdky=(case when count(distinct pid)=2 then 1 else 0 end)
from blogapp..permissionsetting t1 
left join basicdata..[user] t2  
		on t1.kid=t2.kid 
		where t2.userid=@userid 
		and t1.ptype in (81,65) 
		and t2.usertype>0
		 
  
declare @isreadcard int  
  
SELECT @isreadcard = userid  
  FROM [SBApp].[dbo].[readcard_pay]  
  where userid=@userid and  getdate() between paydate and enddate   

--加入阅读计划就让他看  
declare @readright int=0
set @readright=ossapp.dbo.addservice_vip_GetRule(@userid,809)

--老师可以免费阅读数字图书
declare @teacherreadright int =0
select @teacherreadright=ReadRight from basicdata..[user] u where userid=@userid

  
if((@isvip_status>0) or @isreadcard>0 or @readright>0 or
	 @userid in(288556,479936,295767,567195,560725,466920) or @cdky>0 or @teacherreadright=63 )    
begin  
 select t1.[sbid],[catid],[book_title],[bean_price],[xmlfile_temp],[page_width],[page_height],[cover],@userid  
 from sb_book t1           
 where t1.sbid=@sbid  
end  
else  
begin  
 select t1.[sbid],[catid],[book_title],[bean_price],[xmlfile_temp],[page_width],[page_height],[cover],t2.userid  
 from sb_book t1 left join my_book t2 on t1.sbid=t2.sbid and t2.userid=@userid              
 where t1.sbid=@sbid  
  
end  
  

