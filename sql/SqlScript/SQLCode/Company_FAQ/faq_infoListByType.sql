USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[faq_infoListByType]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[faq_infoListByType]--10
@typeID int,
@page int,
@size int
 AS
IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size--20

		DECLARE @tmptable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			tmptableid bigint
		)

		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)--30
		SELECT RelationID
        FROM faq_relation 
        INNER JOIN 
            faq_question
        ON faq_question.Q_ID=faq_relation.Q_ID
        WHERE faq_question.status=1 AND faq_relation.status=1
              AND TypeID=@typeID 
        ORDER BY CreateDate DESC

		SET ROWCOUNT @size
		SELECT 
            RelationID,Title,CreateDate,CreatePerson,username
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			faq_relation t1 ON tmptable.tmptableid=t1.RelationID
        INNER JOIN
            sac_User ON sac_User.[user_id]=t1.CreatePerson
        INNER JOIN 
            faq_question
        ON faq_question.Q_ID=t1.Q_ID    
		WHERE 
			row >  @ignore AND t1.status=1 AND sac_User.status=1
            AND faq_question.status=1 AND TypeID=@typeID
        ORDER BY CreateDate DESC
	
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
        RelationID,Title,CreateDate,CreatePerson,username
		FROM 
           faq_relation
        INNER JOIN
           sac_User
        ON
           sac_User.[user_id]=faq_relation.CreatePerson
        INNER JOIN 
            faq_question
        ON faq_question.Q_ID=faq_relation.Q_ID  
        WHERE 
           faq_relation.status=1 AND sac_User.status=1
           AND faq_question.status=1 AND TypeID=@typeID
        ORDER BY CreateDate DESC
	END


GO
