USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[faq_typeDelete]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[faq_typeDelete] 
     (
       @typeID int
   )
AS
IF EXISTS(SELECT * FROM faq_type WHERE fatherID=@typeID)
RETURN 0
IF EXISTS(SELECT * FROM faq_question WHERE TypeID=@typeID)
RETURN -1
ELSE
BEGIN
DELETE 
   FROM
     faq_type
WHERE 
   typeID=@typeID
RETURN @@ROWCOUNT
END


GO
