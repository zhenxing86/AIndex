USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_TrackAdd]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[custom_TrackAdd]
(
   @customID int,
   @tips bit,
   @announcement bit,
   @news bit,
   @weeklyRecipes bit,
   @happyHour bit,
   @childCardWord bit,
   @parkPersented bit,--10
   @parkAppearence bit,
   @gardenStyle bit,
   @featured bit,
   @admissions bit,
   @video bit,
   @other bit,
   @publish bit,
   @pay int,
   @completion int,
   @remark nvarchar(1000),
   @trackStatus int,
   @personID int--20
)
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
