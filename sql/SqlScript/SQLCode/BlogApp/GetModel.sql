USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[GetModel]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      Master谭    
-- Create date: 2014-01-13    
-- Description:     
-- Memo:  GetModel 629244,'Video_Categories'    
*/    
CREATE PROC [dbo].[GetModel]    
 @ID Bigint,    
 @TbName varchar(50)    
AS    
BEGIN    
 SET NOCOUNT ON    
 IF @TbName = 'Honours'     
 SELECT userid, kid, hName, hOwner, hRank, hGrade, hOrgan, hTime, hType, hUnit, hTeacher, hPic, rylei,hid    
  FROM Honours     
  where hid = @ID    
 ELSE IF @TbName = 'Videos'      
 SELECT VideoID ,VideoNet, VideoUrl, VideoUpdateTime, Title    
  FROM Videos     
  where VideoID = @ID    
 ELSE IF @TbName = 'Video_Categories'      
 SELECT vc.Categoriesid,vc.userid, vc.Title, ISNULL(vv.cnt,0)VideoCNT, vc.CoverPic, vc.PicUpdateTime, vc.PicNet, vc.Is_Public,vc.CrtDate    
  FROM Video_Categories vc     
    left join Videos_ViewSum vv     
     on vc.Categoriesid = vv.Categoriesid     
   WHERE vc.DeleteTag = 1 AND vc.Categoriesid = @ID    
     
END 
GO
