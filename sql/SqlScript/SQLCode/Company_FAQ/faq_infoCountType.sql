USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[faq_infoCountType]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[faq_infoCountType] 
(
    @typeID int
)
AS
DECLARE @RESULT INT
   SET @RESULT=ISNULL((SELECT COUNT(*) FROM 
        faq_relation INNER JOIN faq_question ON faq_question.Q_ID=faq_relation.Q_ID WHERE faq_relation.status=1 AND faq_question.status=1 AND TypeID=@typeID),0)
RETURN @RESULT


GO
