USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[Icms_content_GroupNoticeInformation_notice]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[Icms_content_GroupNoticeInformation_notice]
@contentid int,
@kid int
 AS 
 
 
 select (c.contentid-2147483647),title,content,createdatetime,author ,a.ishow
 from cms_content c
  left join ActicleState a on a.contentid=c.contentid   
 
 where (c.contentid-2147483647)=@contentid and [status]=2
 and siteid=@kid


GO
