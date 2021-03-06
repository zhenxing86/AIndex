USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[faq_infoDel]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[faq_infoDel] 
      (
       @RelationID int
)
AS
BEGIN
DECLARE @currentError int
DECLARE @AID int
DECLARE @QID int
SET @AID=ISNULL((SELECT A_ID FROM faq_relation WHERE RelationID=@RelationID),0)
SET @QID=ISNULL((SELECT Q_ID FROM faq_relation WHERE RelationID=@RelationID),0)
     BEGIN TRANSACTION
        DELETE FROM faq_relation
           WHERE RelationID=@RelationID
 SELECT @currentError=@@Error    
    IF @currentError!=0
    IF @currentError!=0
      BEGIN
         GOTO error_handler
      END
      IF @AID>0
         DELETE FROM faq_answer
                  WHERE A_ID=@AID 
 SELECT @currentError=@@Error
     IF @currentError!=0 
         IF @currentError!=0
      BEGIN
         GOTO error_handler
      END
         IF @QID>0
            DELETE FROM faq_question
                WHERE Q_ID=@QID
  SELECT @currentError=@@Error
  COMMIT TRANSACTION
  RETURN 1
  error_handler:
     ROLLBACK TRANSACTION
     RETURN 0
END


GO
