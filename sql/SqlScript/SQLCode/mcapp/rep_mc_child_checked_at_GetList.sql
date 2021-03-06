USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mc_child_checked_at_GetList]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[rep_mc_child_checked_at_GetList] 
 @page int
,@size int
,@kid int
,@gradeid int
,@cid int
,@checktime1 datetime
,@checktime2 datetime
,@result nvarchar(30)
,@status int
,@uname nvarchar(50)
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM dbo.rep_mc_child_checked_detail
 where kid=@kid
 and dotime between @checktime1 and @checktime2
 and (result=@result or @result='')
 and (gradeid=@gradeid or @gradeid=-1)
 and (cid=@cid or @cid=-1)
 and ([status]=@status or @status=-1)
 and uname like @uname+'%'

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
			SELECT ID FROM dbo.rep_mc_child_checked_detail
 where kid=@kid
 and dotime between @checktime1 and @checktime2
 and (result=@result or @result='')
 and (gradeid=@gradeid or @gradeid=-1)
 and (cid=@cid or @cid=-1)
 and ([status]=@status or @status=-1)
 and uname like @uname+'%'
 order by classorder asc

			SET ROWCOUNT @size
			SELECT 
				@pcount,cname,userid,uname
,checktime,temperature,result,outtime 
 			FROM 
				@tmptable AS tmptable		
			INNER JOIN rep_mc_child_checked_detail g
			ON  tmptable.tmptableid=g.ID 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT @pcount,cname,userid,uname,checktime,temperature,result,outtime 
FROM dbo.rep_mc_child_checked_detail
 where kid=@kid
 and dotime between @checktime1 and @checktime2
 and (result=@result or @result='')
 and (gradeid=@gradeid or @gradeid=-1)
 and (cid=@cid or @cid=-1)
 and ([status]=@status or @status=-1)
 and uname like @uname+'%'
 order by classorder asc
end


GO
