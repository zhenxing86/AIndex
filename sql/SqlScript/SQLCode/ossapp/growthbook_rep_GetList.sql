USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[growthbook_rep_GetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[growthbook_rep_GetList]
@kid int
,@cid int
,@applytime1 datetime
,@applytime2 datetime
,@status int
,@page int
,@size int
AS

declare @pcount int

SELECT @pcount=count(1) FROM gbapp..archives_apply
			where kid=@kid
			and (cid=@cid or @cid=-1)
			and (applytime >=@applytime1 or @applytime1<'1950-1-1')
			and (applytime <=@applytime2 or @applytime2<'1950-1-1')
			and ([status]=@status or @status=-100)

IF(@page>1)
	BEGIN
	
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint
		)

			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			SELECT  archivesapplyid  FROM gbapp..archives_apply
			where kid=@kid
			and (cid=@cid or @cid=-1)
			and (applytime >=@applytime1 or @applytime1<'1950-1-1')
			and (applytime <=@applytime2 or @applytime2<'1950-1-1')
			and ([status]=@status or @status=-100)

			SET ROWCOUNT @size
			SELECT 
				@pcount ,userid,cname,username,applytime,[status],handletime
					FROM 
				@tmptable AS tmptable		
			INNER JOIN gbapp..archives_apply g
			ON  tmptable.tmptableid=g.archivesapplyid 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

select @pcount,userid,cname,username,applytime,[status],handletime from gbapp..archives_apply
where kid=@kid
and (cid=@cid or @cid=-1)
and (applytime >=@applytime1 or @applytime1<'1950-1-1')
and (applytime <=@applytime2 or @applytime2<'1950-1-1')
and ([status]=@status or @status=-100)
end




GO
