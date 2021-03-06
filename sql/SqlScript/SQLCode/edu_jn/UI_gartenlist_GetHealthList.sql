USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[UI_gartenlist_GetHealthList]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UI_gartenlist_GetHealthList]
	@page int,
	@size int,
    @areaid int
	
	 AS
	 
	 declare @pcount int
	 declare @size_ int
	
	
	DECLARE @tp TABLE
	(
		pc int
	)

	insert into @tp
	select count(1)
	from KWebCMS..cms_content t1 inner join
	[gartenlist] t2 on t1.siteid=t2.kid 
	and t1.categoryid =85972 and t2.areaid=@areaid and t1.deletetag = 1

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

			insert into @tmptable
			select t1.contentid
			from KWebCMS..cms_content t1 inner join
			[gartenlist] t2 on t1.siteid=t2.kid 
			and t1.categoryid =85972 and t2.areaid=@areaid 
      Where t1.deletetag = 1 
      order by createdatetime desc
			 
			 SET ROWCOUNT @size
				SELECT @pcount, t1.contentid,t1.title,t1.createdatetime,t2.kname ,t2.sitedns 
		    	FROM  @tmptable a
		    	inner join KWebCMS..cms_content t1 on t1.contentid = a.tmptableid
				inner join [gartenlist] t2 on t1.siteid=t2.kid          	
					WHERE row>@ignore and t1.deletetag = 1
	end
	else
	begin
	SET ROWCOUNT @size
	if(@pcount is null)
	begin
	set @pcount=0
	end
	
	select @pcount,t1.contentid,t1.title,t1.createdatetime,t2.kname,t2.sitedns 
	from KWebCMS..cms_content t1
	 inner join [gartenlist] t2 on t1.siteid=t2.kid 
		and t1.categoryid =85972 and t2.areaid=@areaid 
  Where t1.deletetag = 1 
  order by createdatetime desc

	
	end
	RETURN 0

GO
