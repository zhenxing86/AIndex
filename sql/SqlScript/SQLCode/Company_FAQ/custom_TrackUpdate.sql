USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_TrackUpdate]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[custom_TrackUpdate]
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
   @pay int,
   @publish bit,
   @completion int,
   @remark nvarchar(1000),
   @trackStatus int,
   @personID int
)
AS
UPDATE
   custom_siteUseTracking
SET
 customID=@customID,tips=@tips,announcement=@announcement,
 news=@news,weeklyRecipes=@weeklyRecipes,happyHour=@happyHour,
 childCardWord=@childCardWord,parkPersented=@parkPersented,
 parkAppearence=@parkAppearence,gardenStyle=@gardenStyle,
 featured=@featured,admissions=@admissions,video=@video,
 other=@other,pay=@pay,publish=@publish,
 completion=@completion,remark=@remark,
 trackStatus=@trackStatus,status=1,personID=@personID,createDate=getdate()
WHERE
  customID=@customID
RETURN @@ROWCOUNT


GO
