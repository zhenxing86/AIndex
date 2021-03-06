USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[faq_infoCheckCount]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[faq_infoCheckCount]
@typeID int,
@title nvarchar(50),
@Q_Content nvarchar(500)
AS
DECLARE @RESULT INT
   SET @RESULT=ISNULL((SELECT COUNT(*) 
      FROM faq_relation t1
      INNER JOIN faq_question t2 ON t1.Q_ID=t2.Q_ID
      INNER JOIN faq_type t3 ON t2.TypeID=t3.typeID
      WHERE 
      t3.typeID=CASE @typeID WHEN 0 THEN t3.typeID ELSE @typeID END
      AND Title LIKE '%'+@title+'%'
      AND Q_Content LIKE '%'+@Q_Content+'%'
    ),0)
RETURN @RESULT


GO
