USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_InfoUpdate]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[custom_InfoUpdate] 
(
     @customID int,
     @customName nvarchar(100),
     @chargePerson nvarchar(20),
     @tel nvarchar(20),
     @email nvarchar(250),
     @QQ nvarchar(12),
     @address nvarchar(500),
     @provice int,
     @city int,
     @url nvarchar(100),
     @regDateTime datetime,
     @synchro int
)
AS
UPDATE
    custom_data
SET 
   customName=@customName,
   chargePerson=@chargePerson,
   tel=@tel,
   email=@email,
   QQ=@QQ,
   address=@address,
   provice=@provice,
   city=@city,
   url=@url
WHERE
   customID=@customID
RETURN @@ROWCOUNT


GO
