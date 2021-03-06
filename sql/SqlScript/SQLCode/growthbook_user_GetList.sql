USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[growthbook_user_GetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[growthbook_user_GetList]
 @page int
,@size int
,@kid int
,@term varchar(20)
,@cid int
,@txtname nvarchar(50)
AS

declare @pcount int
SELECT @pcount=count(1) from ReportApp..rep_growthbook r
where r.kid=@kid and term=@term and cid=@cid and uname like @txtname+'%'


IF(@page>1)
	BEGIN
	
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		if(@pcount<@ignore)
		begin
			set @page=@pcount/@size
			if(@pcount%@size<>0)
			begin
				set @page=@page+1
			end
			SET @prep=@size*@page
			SET @ignore=@prep-@size
		end
		
		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint
		)

			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			select r.[uid] from ReportApp..rep_growthbook r where r.kid=@kid and term=@term and cid=@cid and uname like @txtname+'%'

			SET ROWCOUNT @size
			SELECT 
				@pcount ,r.cid,r.cname,r.[uid],r.uname,lifecount,workcount,videocount,cbookcount,r.gbid,g.remark,g.ID
				FROM 
				@tmptable AS tmptable		
			INNER JOIN ReportApp..rep_growthbook r
			ON  tmptable.tmptableid=r.[uid] 	
			left join dbo.rep_growthbook_user_checked g on g.kid=r.kid and g.cid=r.cid and g.term=r.term and g.[uid]=r.[uid]
			WHERE
				row>@ignore and r.kid=@kid and r.term=@term and r.cid=@cid and uname like @txtname+'%'

end
else
begin
SET ROWCOUNT @size

select @pcount,r.cid,r.cname,r.[uid],r.uname,lifecount,workcount,videocount,cbookcount ,r.gbid,g.remark,g.ID
from ReportApp..rep_growthbook r
left join dbo.rep_growthbook_user_checked g on g.kid=r.kid and g.cid=r.cid and g.term=r.term and g.[uid]=r.[uid]
where r.kid=@kid and r.term=@term and r.cid=@cid and uname like @txtname+'%'

end







GO
