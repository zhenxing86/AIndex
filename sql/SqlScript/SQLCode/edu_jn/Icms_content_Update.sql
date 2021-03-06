USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[Icms_content_Update]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[Icms_content_Update] 
@contentid int,  
@title nvarchar(max),  
@content varchar(max),  
@siteid int
 AS   
BEGIN  

SET NOCOUNT ON

update cms_content 
		set title=@title,
			content=@content
		where siteid=@siteid
			and (contentid-2147483647)=@contentid 
			and [status]=2
END  
  

GO
