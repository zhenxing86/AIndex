USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[UI_gartenlist_GetGartenByArea]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：查询记录信息 
--项目名称：gartenlist
--[UI_gartenlist_GetGartenByArea] 1,101,756
------------------------------------
CREATE PROCEDURE [dbo].[UI_gartenlist_GetGartenByArea]
	@page int,
	@size int,
	@area int
	 AS
	 
	 declare @pcount int
	 declare @size_ int
	
	
	DECLARE @tp TABLE
	(
		pc int
	)


	if(@area=0)
	begin
		insert into @tp
	SELECT  count(1) from BasicData..Area t1 
		left join  BasicData..kindergarten t2 on t2.city = t1.id
		left join  kwebcms..site t3 on t3.siteid =   t2.kid     	
		where  t1.title = '肥城市'
	end
	else
	begin
		insert into @tp
	SELECT  count(1) from BasicData..Area t1 
		left join  gartenlist t2 on t2.areaid = t1.id
		left join  kwebcms..site t3 on t3.siteid =   t2.kid     	
		where  t1.id = @area
	end
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
			
			if(@area=0)
			begin
					SET ROWCOUNT @prep
					INSERT INTO @tmptable (tmptableid)
					select t2.kid from BasicData..Area t1 
					left join  BasicData..kindergarten t2 on t2.city = t1.id
					inner join 	gartenlist t4 on t4.kid=t2.kid
					where  t1.title = '肥城市'   order by orderby asc
			end
			else
			begin
					SET ROWCOUNT @prep
					INSERT INTO @tmptable (tmptableid)
					select t2.kid from BasicData..Area t1 
					left join  BasicData..kindergarten t2 on t2.city = t1.id
					inner join 	gartenlist t4 on t4.kid=t2.kid
					where   t4.areaid = @area  order by orderby asc
			
			end
	
			 
			 SET ROWCOUNT @size
				SELECT @pcount, t2.[kid],   t2.[kname],   t3.[sitedns] ,t2.[address] 	FROM  @tmptable a
					left join BasicData..kindergarten t2  ON  a.tmptableid=t2.kid   
					left join  kwebcms..site t3 on t3.siteid =   t2.kid     	
					WHERE row>@ignore 
	end
	else
	begin
	SET ROWCOUNT @size
	if(@pcount is null)
	begin
	set @pcount=0
	end
	
	if(@area=0)
	begin
		SELECT @pcount, t2.[kid],t2.[kname],t3.[sitedns],t2.[address] 	from BasicData..Area t1 
		left join  BasicData..kindergarten t2 on t2.city = t1.id
		left join  kwebcms..site t3 on t3.siteid =   t2.kid     
		inner join 	gartenlist t4 on t4.kid=t2.kid
		where  t1.title = '肥城市'  order by orderby asc
	end
	else
	begin
		SELECT @pcount, t2.[kid],t2.[kname],t3.[sitedns],t2.[address] 	from BasicData..Area t1 
		left join  BasicData..kindergarten t2 on t2.city = t1.id
		left join  kwebcms..site t3 on t3.siteid =   t2.kid     	
		inner join 	gartenlist t4 on t4.kid=t2.kid
		where  t4.areaid = @area order by orderby asc
	end
	
			
	
	end
	RETURN 0
	






GO
