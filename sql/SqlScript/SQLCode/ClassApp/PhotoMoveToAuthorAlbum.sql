USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[PhotoMoveToAuthorAlbum]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		lx
-- Create date: 2010-7-7 
-- Description:	移动照片到本班其他相册
-- =============================================
CREATE PROCEDURE [dbo].[PhotoMoveToAuthorAlbum]
@photoid int,
@albumid int	
AS
BEGIN
  
  update class_photos set albumid=@albumid where photoid=@photoid
  
  update class_album set photocount=photocount+1 where albumid=@albumid
  
  IF(@@ERROR<>0)
  BEGIN
   RETURN 0
  END
  ELSE
  BEGIN
   RETURN 1
  END
    

END





GO
