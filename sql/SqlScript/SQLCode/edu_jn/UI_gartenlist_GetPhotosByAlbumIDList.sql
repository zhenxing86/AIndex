USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[UI_gartenlist_GetPhotosByAlbumIDList]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：查询记录信息 
--项目名称：gartenlist
------------------------------------
CREATE PROCEDURE [dbo].[UI_gartenlist_GetPhotosByAlbumIDList] 
	@page int,
	@size int,
	@albumid int
	 AS
	 
	 declare @pcount int
	 declare @size_ int
	
	
	DECLARE @tp TABLE
	(
		pc int
	)

	insert into @tp
	select count(1) from ClassApp..class_photos t1 where t1.albumid = @albumid
	
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
			 select photoid from ClassApp..class_photos t1 where t1.albumid = @albumid order by orderno desc 
			 
			SET ROWCOUNT @size
			SELECT @pcount,photoid,title,filepath,[filename],p.net,p.uploaddatetime
				 	FROM  @tmptable t
					INNER JOIN  ClassApp..class_photos p ON  t.tmptableid=p.photoid 
					WHERE row>@ignore 
	end
	else
	begin
	SET ROWCOUNT @size
	if(@pcount is null)
	begin
	set @pcount=0
	end
	
	select  @pcount,photoid,title,filepath,[filename],t1.net,t1.uploaddatetime
	from ClassApp..class_photos t1
	where albumid = @albumid order by orderno desc

	end
	RETURN 0





GO
