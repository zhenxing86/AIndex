USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_TrackImport]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-7-17
-- Description:	实现数据导入
-- =============================================
CREATE PROCEDURE [dbo].[custom_TrackImport]
   @customID int,
   @tips int,
   @announcement int,
   @news int,
   @weeklyRecipes int,
   @happyHour int,
   @childCardWord int,
   @parkPersented int,--10
   @parkAppearence int,
   @gardenStyle int,
   @featured int,
   @admissions int,
   @video int,
   @other int,
   @publish int,
   @pay int,
   @completion int,
   @remark nvarchar(1000),
   @trackStatus int,
   @personID int--20
AS
IF EXISTS(SELECT * FROM custom_siteUseTracking WHERE customID=@customID)
RETURN 0
ELSE
BEGIN
INSERT INTO
      custom_siteUseTracking
(
 customID,tips,announcement,news,weeklyRecipes,happyHour,childCardWord,--30
 parkPersented,parkAppearence,gardenStyle,featured,admissions,video,
 other,publish,pay,
completion,
remark,
trackStatus,
status,
personID
)
VALUES
(@customID,@tips,@announcement,@news,@weeklyRecipes,
   @happyHour,
   @childCardWord,
   @parkPersented,
   @parkAppearence,
   @gardenStyle,
   @featured,--40
   @admissions,
   @video,
   @other,
   @publish,@pay,
   @completion,
   @remark,
   @trackStatus,
   1,
   @personID
)
RETURN @@ROWCOUNT--50
END


GO
