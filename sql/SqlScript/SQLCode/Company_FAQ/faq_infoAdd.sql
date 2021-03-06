USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[faq_infoAdd]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[faq_infoAdd]
   (
       @Title nvarchar(50),
       @TypeID int,
       @Q_Content nvarchar(500),
       @A_Content text,
       @CreatePerson int
     )
AS
BEGIN
DECLARE @currentError int
DECLARE @currentQID int
DECLARE @currentAID int
     BEGIN TRANSACTION
          INSERT INTO faq_question(TypeID,Q_Content,status)
             VALUES(@TypeID,@Q_Content,1)
 SELECT @currentQID=@@IDENTITY
 SELECT @currentError=@@Error
    IF @currentError!=0
      BEGIN
         GOTO error_handler
      END
       INSERT INTO faq_answer(A_Content,status) 
         VALUES
            (@A_Content,1)
 SELECT @currentAID=@@IDENTITY
 SELECT @currentError=@@Error
     IF @currentError!=0 
        BEGIN
          GOTO error_handler
        END
  INSERT INTO faq_relation(Q_ID,A_ID,Title,CreateDate,CreatePerson,IsIndex,status)
     VALUES
        (@currentQID,@currentAID,@Title,getdate(),@CreatePerson,0,1)
  SELECT @currentError=@@Error
  COMMIT TRANSACTION
  RETURN 1
  error_handler:
     ROLLBACK TRANSACTION
     RETURN 0
END


GO
