USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinbaseinfo_actionlogs_Stat_List]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[kinbaseinfo_actionlogs_Stat_List]
@kid int,
@page int,
@size int,
@ftime varchar(100),
@ltime varchar(100)
 AS 
	
SET @ftime = CommonFun.dbo.FilterSQLInjection(@ftime)
SET @ltime = CommonFun.dbo.FilterSQLInjection(@ltime)
if ISNULL(@ftime,'') = '' SET @ftime='1900-1-1'
if ISNULL(@ltime,'') = '' SET @ltime='2900-1-1'


declare @pcount int

SELECT @pcount=count(1) 
	FROM KWebCMS..actionlogs a,KWebCMS..site_user s 
		WHERE 
		a.userid=s.userid 
		AND siteid=@kid 
		AND a.actiondatetime between @ftime and @ltime
	
	 
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
	SELECT a.id
		FROM KWebCMS..actionlogs a,
			 KWebCMS..site_user s 
		WHERE a.userid=s.userid 
			AND siteid=@kid
			AND a.actiondatetime between @ftime and @ltime
		ORDER BY a.id DESC


			SET ROWCOUNT @size
			SELECT 
				@pcount, a.id,a.actiondesc,a.actiondatetime FROM 
				@tmptable AS tmptable		
			INNER JOIN KWebCMS..actionlogs a
					ON tmptable.tmptableid=a.id
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

	SELECT @pcount,a.id,a.actiondesc,a.actiondatetime
	 FROM KWebCMS..actionlogs a,KWebCMS..site_user s 
			WHERE a.userid=s.userid 
				  AND siteid=@kid
				  AND a.actiondatetime between @ftime and @ltime
			ORDER BY a.id DESC

end
	


GO
