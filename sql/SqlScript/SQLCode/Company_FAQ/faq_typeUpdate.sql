USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[faq_typeUpdate]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[faq_typeUpdate] 
        (
       @typeID int,
       @typeName nvarchar(50)
)
AS
DECLARE @fatherID int
SET @fatherID=(SELECT fatherID FROM faq_type WHERE typeID=@typeID)
IF EXISTS(SELECT * FROM faq_type 
 WHERE typeName=@typeName AND fatherID=@fatherID)
RETURN 0
ELSE
BEGIN
UPDATE 
   faq_type
SET
   typeName=@typeName
WHERE
   typeID=@typeID
RETURN @@ROWCOUNT
END


GO
