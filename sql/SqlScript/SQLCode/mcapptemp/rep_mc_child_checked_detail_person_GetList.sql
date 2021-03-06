USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mc_child_checked_detail_person_GetList]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[rep_mc_child_checked_detail_person_GetList] 
 @page int
,@size int
,@kid int
,@uid int
,@checktime1 datetime
,@checktime2 datetime

 AS 

declare @pcount int

SELECT @pcount=count(1) FROM dbo.rep_mc_child_checked_detail
 where kid=@kid
 and checktime between @checktime1 and @checktime2
 and userid=@uid


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
 and checktime between @checktime1 and @checktime2
 and userid=@uid
 order by checktime asc

			SET ROWCOUNT @size
			SELECT 
				@pcount,checktime,temperature,result,gradename,cname,uname
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

SELECT @pcount,checktime,temperature,result,gradename,cname,uname 
FROM dbo.rep_mc_child_checked_detail
 where kid=@kid
 and checktime between @checktime1 and @checktime2
 and userid=@uid
 order by checktime asc
end


GO
