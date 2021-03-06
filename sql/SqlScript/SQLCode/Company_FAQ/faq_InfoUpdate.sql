USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[faq_InfoUpdate]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[faq_InfoUpdate]
   (
       @RelationID int,
       @Q_ID int,
       @Q_Content nvarchar(500),
       @A_ID int,
       @A_Content text,
       @Title nvarchar(50),
       @CreatePerson int
     )
AS
BEGIN
DECLARE @currentError int
     BEGIN TRANSACTION
 UPDATE FAQ_Relation
     SET Title=@Title,
         CreateDate=getdate(),
         CreatePerson=@CreatePerson
           WHERE RelationID=@RelationID
  SELECT @currentError=@@Error
IF @currentError!=0 
        BEGIN
          GOTO error_handler
        END
          UPDATE FAQ_Question
             SET Q_Content=@Q_Content
                WHERE Q_ID=@Q_ID
 SELECT @currentError=@@Error
    IF @currentError!=0
      BEGIN
         GOTO error_handler
      END
           UPDATE FAQ_Answer
              SET A_Content=@A_Content
                  WHERE A_ID=@A_ID 
 SELECT @currentError=@@Error
     
  COMMIT TRANSACTION
  RETURN 1
  error_handler:
     ROLLBACK TRANSACTION
     RETURN 0
END


GO
