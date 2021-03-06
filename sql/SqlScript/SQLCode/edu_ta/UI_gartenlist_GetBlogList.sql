USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[UI_gartenlist_GetBlogList]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








------------------------------------
--用途：查询记录信息 
--项目名称：gartenlist
--[UI_gartenlist_GetBlogList] 1,10,1
------------------------------------
CREATE PROCEDURE [dbo].[UI_gartenlist_GetBlogList]
	@page int,
	@size int,
	@usertype int,
	@areaid int
	 AS
	 
	 declare @pcount int
	 declare @size_ int
	
	
	DECLARE @tp TABLE
	(
		pc int
	)

	insert into @tp
	select  count(postid) from
	[bloglist]
     where usertype=@usertype and areaid=@areaid

	select @pcount=pc from @tp
	
	IF(@page>1)
		BEGIN
			DECLARE @prep int,@ignore int
			SET @prep=@size*@page
			SET @ignore =@prep-@size
			DECLARE @tmptable TABLE
			(
				row int IDENTITY(1,1),
				tmptableid bigint,
				kname varchar(100),
				sitedns varchar(100),
				postdatetime datetime
			)
			 SET ROWCOUNT @prep
			 INSERT INTO @tmptable (tmptableid,kname,sitedns,postdatetime)
			select  postid,kname,sitedns,postdatetime			
	from [bloglist] where usertype=@usertype and areaid=@areaid
	order by postid desc  
			 
			 SET ROWCOUNT @size
				SELECT @pcount,t1.postid,t1.userid,t1.title,t1.author,a.kname,a.sitedns,a.postdatetime 
				FROM  @tmptable a
			    inner join [bloglist] t1 on a.tmptableid = t1.postid			    
				WHERE row>@ignore 
	end
	else
	begin
	SET ROWCOUNT @size
	if(@pcount is null)
	begin
	set @pcount=0
	end
	

select  @pcount,postid,userid,title,author,kname,sitedns,postdatetime
	from [bloglist] where usertype=@usertype and areaid=@areaid
	order by postid desc 
	
	end
	RETURN 0










GO
