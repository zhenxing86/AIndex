USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[faq_infoCheck]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[faq_infoCheck]
@page int,
@size int,
@typeID int,
@title nvarchar(50),
@Q_Content nvarchar(500)
AS
IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int--10
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size

		DECLARE @tmptable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			tmptableid bigint
		)--20

		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
		SELECT RelationID
        FROM faq_relation
        INNER JOIN--30
           faq_question
        ON
           faq_question.Q_ID=faq_relation.Q_ID
        INNER JOIN
           faq_type
        ON
           faq_type.typeID=faq_question.TypeID
        WHERE 
        faq_type.typeID=CASE @typeID WHEN -1 THEN faq_type.typeID ELSE @typeID END
        AND Title LIKE '%'+@title+'%'
        AND Q_Content LIKE '%'+@Q_Content+'%'
        ORDER BY CreateDate DESC

		SET ROWCOUNT @size--40
		SELECT 
            RelationID,Title,CreateDate,CreatePerson,username,Q_Content
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			faq_relation t1 ON tmptable.tmptableid=t1.RelationID
        INNER JOIN
           faq_question
        ON
           faq_question.Q_ID=t1.Q_ID
        INNER JOIN
           faq_type
        ON
           faq_type.typeID=faq_question.TypeID
        INNER JOIN
           sac_User
        ON
           sac_User.[user_id]=t1.CreatePerson
		WHERE 
			row >@ignore
        ORDER BY CreateDate DESC
	
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
        SELECT 
        RelationID,Title,CreateDate,CreatePerson,username,Q_Content
		FROM 
           faq_relation
        INNER JOIN
           sac_User
        ON
           sac_User.[user_id]=faq_relation.CreatePerson
        INNER JOIN
           faq_question
        ON
           faq_question.Q_ID=faq_relation.Q_ID
        INNER JOIN
           faq_type
        ON
           faq_type.typeID=faq_question.TypeID
        WHERE 
        faq_type.typeID=CASE @typeID WHEN -1 THEN faq_type.typeID ELSE @typeID END
        AND Title LIKE '%'+@title+'%'
        AND Q_Content LIKE '%'+@Q_Content+'%'
        ORDER BY CreateDate DESC
	END

GO
