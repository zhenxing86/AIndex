USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_Img]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[cms_content_Img]
@catid int,
@gid int
as 
declare @pcount int 


select @pcount=count(1) from cms_content where catid=@catid and gid=@gid and url is not null and len(url)>10
if(@pcount>6)
begin
set @pcount=6
end


select top 6 @pcount ,contentid ,catid ,title    ,[content]    ,inuserid    ,intime    ,deletetag    ,gid ,url  from cms_content where catid=@catid and gid=@gid and url is not null and len(url)>10 order by intime desc








GO
