USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_InfoAdd]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[custom_InfoAdd]
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
IF EXISTS(SELECT * FROM custom_data WHERE customID=@customID)
RETURN 0
INSERT INTO
    custom_data
(customID,customName,chargePerson,tel,email,QQ,address,
 provice,city,url,regDateTime,synchro)
VALUES
(@customID,@customName,@chargePerson,@tel,@email,@QQ,@address,
 @provice,@city,@url,@regDateTime,@synchro)
RETURN @@ROWCOUNT


GO
