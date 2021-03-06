USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[UI_gartenlist_GetGartenActivityList]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：查询记录信息 
--项目名称：gartenlist
------------------------------------
CREATE PROCEDURE [dbo].[UI_gartenlist_GetGartenActivityList]
	@page int,
	@size int
	
	 AS
	 
	 declare @pcount int
	 declare @size_ int
	
	
	DECLARE @tp TABLE
	(
		pc int
	)

	insert into @tp
	SELECT  count(1) FROM cms_content t1 right join
	[gartenlist] t2 on t1.siteid=t2.kid
left join dbo.ActicleState t3 on t3.contentid=t1.contentid
	where (t1.categoryid=17095) and t1.title <> '幼儿园网站开通啦！欢迎家长们上网浏览！'
and t3.ishow is null

	select @pcount=pc from @tp 
	
	IF(@page>1)
		BEGIN
			DECLARE @prep int,@ignore int
			SET @prep=@size*@page
			SET @ignore =@prep-@size
			DECLARE @tmptable TABLE
			(
				row int IDENTITY(1,1),
				tmptableid bigint
			)
			 SET ROWCOUNT @prep
			 INSERT INTO @tmptable (tmptableid)
			 SELECT     t1.contentid      FROM cms_content t1 right join
			[gartenlist] t2 on t1.siteid=t2.kid
left join dbo.ActicleState t3 on t3.contentid=t1.contentid
			where (t1.categoryid=17095) and t1.title <> '幼儿园网站开通啦！欢迎家长们上网浏览！' 
	and t3.ishow is null
		 
order by contentid desc
			 

SET ROWCOUNT @size
				SELECT  @pcount,t1.contentid,t1.title,t1.createdatetime,t2.kname ,t2.sitedns   	FROM  @tmptable a
					INNER JOIN  cms_content t1 on a.tmptableid = t1.contentid
					inner join [gartenlist] t2 on t1.siteid=t2.kid      	
					WHERE row>@ignore 
	end
	else
	begin
	SET ROWCOUNT @size
	if(@pcount is null)
	begin
	set @pcount=0
	end
	
	select  @pcount,t1.contentid,t1.title,t1.createdatetime,t2.kname ,t2.sitedns 
	from cms_content t1 right join
	[gartenlist] t2 on t1.siteid=t2.kid
left join dbo.ActicleState t3 on t3.contentid=t1.contentid
	where (t1.categoryid=17095) and t1.title <> '幼儿园网站开通啦！欢迎家长们上网浏览！' 
and t3.ishow is null

	order by t1.contentid desc
	end
	RETURN 0
	
	


GO
