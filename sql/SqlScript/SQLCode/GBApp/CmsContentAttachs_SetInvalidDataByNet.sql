USE [GBApp]
GO
/****** Object:  StoredProcedure [dbo].[CmsContentAttachs_SetInvalidDataByNet]    Script Date: 2014/11/24 23:07:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CmsContentAttachs_SetInvalidDataByNet] 
(
@net int
,@startTime DateTime
,@endTime DateTime
)
AS
BEGIN
  update video_temp set [status]=0   where --net=@net and
 not exists (select 1 from kwebcms..cms_contentattachs  v 
	where v.filepath ='VideoMusic/'+video_temp.filepath and v.[filename]=video_temp.[filename]
 and v.createdatetime between @startTime and @endTime and v.deletetag = 1
and categoryid in(17105,17098)  and contentid=0 and filename<>'' )
  
  IF @@ERROR <> 0 
  BEGIN 
	RETURN -1
  END
  ELSE
  BEGIN
	RETURN 1
  END

END

GO
