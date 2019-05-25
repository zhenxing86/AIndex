USE [edu_jy]
GO
/****** Object:  StoredProcedure [dbo].[UI_gartenlist_GetGartenActivityList_State]    Script Date: 07/26/2013 16:23:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








------------------------------------
--用途：查询记录信息 
--项目名称：gartenlist
------------------------------------


------------------------------------
--用途：查询记录信息 
--项目名称：gartenlist
------------------------------------
ALTER PROCEDURE [dbo].[UI_gartenlist_GetGartenActivityList_State]

	@page int,
	@size int,
	@ishow int,
	@areaid int
	 AS
	 
	 declare @pcount int
	 declare @size_ int
	
	
	DECLARE @tp TABLE
	(
		pc int
	)


	SELECT  @pcount=count(1) FROM cms_content t1 right join
	[gartenlist] t2 on t1.siteid=t2.kid 
left join dbo.ActicleState t3 on t3.contentid=t1.contentid 
left join Area t4 on t4.ID=t2.areaid
	where (t1.categoryid=17095) and t1.title <> '幼儿园网站开通啦！欢迎家长们上网浏览！'
and (t3.ishow = @ishow or (@ishow=0  and t3.ishow is null ) or @ishow=-1)
and (t4.Superior=@areaid or t4.ID=@areaid)
	
	
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
left join Area t4 on t4.ID=t2.areaid
			where ( t1.categoryid=17095) and t1.title <> '幼儿园网站开通啦！欢迎家长们上网浏览！' 			 
and (t3.ishow = @ishow or (@ishow=0  and t3.ishow is null ) or @ishow=-1)
and (t4.Superior=@areaid or t4.ID=@areaid)
order by (case when t1.orderno is null then 0 else t1.orderno end)  desc,t1.createdatetime desc

			 SET ROWCOUNT @size
				SELECT  @pcount,t1.contentid,t1.title,t1.createdatetime,t2.kname ,t2.sitedns ,t3.ishow  	FROM  @tmptable a
					INNER JOIN  cms_content t1 on a.tmptableid = t1.contentid
					inner join [gartenlist] t2 on t1.siteid=t2.kid  
						left join dbo.ActicleState t3 on t3.contentid=t1.contentid    	
					WHERE row>@ignore 
	end
	else
	begin
	SET ROWCOUNT @size
	if(@pcount is null)
	begin
	set @pcount=0
	end
	
	select  @pcount,t1.contentid,t1.title,t1.createdatetime,t2.kname ,t2.sitedns,t3.ishow ,t1.orderno
	from cms_content t1 right join
	[gartenlist] t2 on t1.siteid=t2.kid
	left join Area t4 on t4.ID=t2.areaid
	left join dbo.ActicleState t3 on t3.contentid=t1.contentid
	where (t1.categoryid=17095) and t1.title <> '幼儿园网站开通啦！欢迎家长们上网浏览！' 
	and (t3.ishow = @ishow or (@ishow=0  and t3.ishow is null ) or @ishow=-1) 
	and (t4.Superior=@areaid or t4.ID=@areaid)
order by (case when t1.orderno is null then 0 else t1.orderno end)  desc,t1.createdatetime desc
	end
	RETURN 0

GO
[UI_gartenlist_GetGartenActivityList_State] 1,10,-1,722




--select * from cms_content



