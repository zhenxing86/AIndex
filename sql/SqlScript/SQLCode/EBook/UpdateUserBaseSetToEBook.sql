USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[UpdateUserBaseSetToEBook]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateUserBaseSetToEBook] 
@userid int,
@personalsign nvarchar(50)
AS


declare @gbid int


select top 1 @gbid=growthbookid from gb_growthbook where userid=@userid order by growthbookid desc

if(@gbid>0)
begin

UPDATE [ebook].[dbo].[HB_PersonalInfo]
   SET personalsign=@personalsign
 WHERE [growthbookid]=@gbid

end

GO
