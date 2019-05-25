USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[faq_typeAdd]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[faq_typeAdd] 
     (
       @typeName nvarchar(50),
       @fatherID int
)
AS
IF EXISTS(SELECT * FROM faq_type WHERE typeName=@typeName AND fatherID=@fatherID)
RETURN 0
ELSE
BEGIN
INSERT INTO 
      faq_type(typeName,fatherID,status)
VALUES
     (@typeName,@fatherID,1)
RETURN @@IDENTITY
END


GO
