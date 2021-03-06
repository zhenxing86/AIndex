USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[faq_InfoGet]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-5-8
-- Description:	获取所有FAQ信息
-- =============================================
CREATE PROCEDURE [dbo].[faq_InfoGet]

AS
SELECT 
   RelationID,FAQ_Relation.Q_ID,FAQ_Relation.A_ID,Title,
   CreateDate,CreatePerson,IsIndex,FAQ_Answer.A_Content,
   FAQ_Question.Q_Content,TypeID,sac_User.username
FROM
   FAQ_Answer,FAQ_Question,FAQ_Relation,sac_User
WHERE
   FAQ_Answer.status=1
   AND FAQ_Question.status=1
   AND FAQ_Relation.status=1
   AND FAQ_Answer.A_ID=FAQ_Relation.A_ID
   AND FAQ_Question.Q_ID=FAQ_Relation.Q_ID
   AND sac_User.[user_id]=CreatePerson
ORDER BY CreateDate DESC


GO
