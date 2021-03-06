USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[faq_infoSingle]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[faq_infoSingle] 
      (
       @RelationID int
)
AS
SELECT 
          RelationID,faq_relation.Q_ID,faq_relation.A_ID,Title,
   CreateDate,CreatePerson,IsIndex,faq_answer.A_Content,
   faq_question.Q_Content,faq_question.TypeID,sac_User.username,typeName
  FROM
    faq_answer,faq_question,faq_relation,sac_User,faq_type
  WHERE
   faq_answer.status=1
   AND faq_question.status=1
   AND faq_relation.status=1
   AND faq_type.status=1
   AND faq_type.typeID=faq_question.TypeID
   AND faq_answer.A_ID=faq_relation.A_ID
   AND faq_question.Q_ID=faq_relation.Q_ID
   AND faq_relation.RelationID=@RelationID
   AND sac_User.[user_id]=CreatePerson
ORDER BY CreateDate DESC


GO
