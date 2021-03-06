USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[UpdateUserBaseInfoToEBook]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateUserBaseInfoToEBook] 
@userid int,
@username nvarchar(20),
@nickname  nvarchar(20),
@birthday nvarchar(10),
@gender nvarchar(10),
@fathername nvarchar(20),
@mathername nvarchar(20),
@favfood nvarchar(50),
@favgood nvarchar(50),
@farthing nvarchar(50),
@drugsallergy nvarchar(50)
AS


declare @gbid int


select top 1 @gbid=growthbookid from gb_growthbook where userid=@userid order by growthbookid desc

if(@gbid>0)
begin
UPDATE [ebook].[dbo].[HB_PersonalInfo]
   SET [username] = @username
		,[nickname]=@nickname
      ,[birthday] = @birthday     
      ,[gender] = @gender
      ,[fathername] = @fathername
      ,[mathername] = @mathername
      ,[favfood] = @favfood
      ,[favgood] = @favgood
      ,[farthing] = @farthing      
      ,[drugsallergy] = @drugsallergy
 WHERE [growthbookid]=@gbid
end

GO
