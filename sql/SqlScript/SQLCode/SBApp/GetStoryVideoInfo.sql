USE [SBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetStoryVideoInfo]    Script Date: 2014/11/24 23:26:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetStoryVideoInfo]-- 57810, '78A93DF1-2DB5-4A1A-8FB3-40987435541B'  
@userid int,  
@sbid nvarchar(50)  
 AS   
  
declare @isvip_ysdw int 
declare @isvip_status int  
select @isvip_status=vipstatus from basicdata..child where userid=@userid  
select @isvip_ysdw =ptype from blogapp..permissionsetting t1 left join basicdata..[user] t2   
on t1.kid=t2.kid where t2.userid=@userid and t1.ptype=98  

declare @cdky int
select @cdky =ptype from blogapp..permissionsetting t1 left join basicdata..[user] t2
on t1.kid=t2.kid where t2.userid=@userid and t1.ptype=81

declare @isreadcard int  
  
 SELECT @isreadcard = userid  
  FROM [SBApp].[dbo].[readcard_pay]   
   where userid=@userid and  getdate() between paydate and enddate   
  
if((@isvip_status>0 and @isvip_ysdw=98) or @isreadcard>0 or @userid in(288556,479936,295767,567195,560725,466920) or @cdky>0)  
begin  
 select t1.[sbid],[catid],[book_title],[bean_price],sbd.video_url,[page_width],  
   [page_height],[cover],@userid,sbd.video_frame
  from sb_book t1    
   left join sb_book_detail sbd   
    on t1.sbid=sbd.sbid  
   where t1.sbid=@sbid  
end  
else  
begin  
 select t1.[sbid],[catid],[book_title],[bean_price],sbd.video_url,[page_width],
 [page_height],[cover],t2.userid  ,sbd.video_frame
  from sb_book t1   
   left join my_book t2   
    on t1.sbid=t2.sbid and t2.userid=@userid     
   left join sb_book_detail sbd   
    on t1.sbid=sbd.sbid           
   where t1.sbid=@sbid  
  
end
GO
