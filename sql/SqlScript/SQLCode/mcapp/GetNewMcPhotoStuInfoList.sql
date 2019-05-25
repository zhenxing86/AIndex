USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[GetNewMcPhotoStuInfoList]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
--author: xie  
--date：2014-03-31
--dest:获取更新了晨检照片的学生列表
--memo:

exec GetNewMcPhotoStuInfoList 12511,'2013-08-21'
*/

create PROCEDURE [dbo].[GetNewMcPhotoStuInfoList]
@kid int,   
@l_update datetime  
 AS  
begin 
 set nocount on
 
 SELECT userid
  FROM BasicData..[user]  
  where kid =@kid and mc_photo_udate>=@l_update and deletetag=1  

end
  

GO
