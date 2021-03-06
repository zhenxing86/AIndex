USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[function_InfoGetListByPage]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-5-14
-- Description:	系统功能修改列表分页
-- =============================================
CREATE PROCEDURE [dbo].[function_InfoGetListByPage]--10
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
		SELECT funChangeTrackID
        FROM FunctionChangeTracking 
        WHERE status=1 
        ORDER BY finishDate DESC

		SET ROWCOUNT @size
		SELECT 
            funChangeTrackID,funContent,changeDate,currentDes,finishDate,
            remark,feedback,trackStatus,username
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			FunctionChangeTracking t1 ON tmptable.tmptableid=t1.funChangeTrackID
        INNER JOIN
            sac_User ON sac_User.[user_id]=t1.personID
		WHERE 
			row >  @ignore AND t1.status=1 AND sac_User.status=1
        ORDER BY finishDate DESC
	
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
            funChangeTrackID,funContent,changeDate,currentDes,finishDate,
            remark,feedback,trackStatus,username
		FROM 
           FunctionChangeTracking
        INNER JOIN
           sac_User
        ON
           sac_User.[user_id]=FunctionChangeTracking.personID
        WHERE 
           FunctionChangeTracking.status=1 AND sac_User.status=1
        ORDER BY finishDate DESC
	END


GO
