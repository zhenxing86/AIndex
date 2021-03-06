USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[UI_gartenlist_GetGartenNewestAlbum_State]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：查询记录信息 
--项目名称：gartenlist
------------------------------------
CREATE PROCEDURE [dbo].[UI_gartenlist_GetGartenNewestAlbum_State]
	@page int,
	@size int,
	@ishow int,
	@areaid int
	
	 AS
	 
	 declare @pcount int
	
	select  @pcount=count(CA.albumid) from gartenlist g
	inner join ClassApp..class_album ca on g.kid=ca.kid and [status] =1 and ca.coverphoto is not null
	left join dbo.PhotoState t3 on t3.contentid=ca.albumID			
where 	(t3.ishow = @ishow or (@ishow=0  and t3.ishow is null ) or @ishow=-1)
 and g.areaid=@areaid
	
	
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
			 select  CA.albumid from gartenlist g
			 inner join ClassApp..class_album ca on g.kid=ca.kid and [status] =1 and ca.coverphoto is not null
	left join dbo.PhotoState t3 on t3.contentid=ca.albumID			
where 	(t3.ishow = @ishow or (@ishow=0  and t3.ishow is null ) or @ishow=-1)
 and g.areaid=@areaid			 ORDER BY ca.lastuploadtime desc

		
			 
			 SET ROWCOUNT @size
			 SELECT @pcount,kname,CA.albumid,ca.title,ca.coverphoto,ca.coverphotodatetime,ca.net,t3.ishow
				 	FROM  @tmptable a
					INNER JOIN ClassApp..class_album ca ON  a.tmptableid=ca.albumid 
					inner join gartenlist g  on g.kid=ca.kid
					left join dbo.ActicleState t3 on t3.contentid=ca.albumID
					WHERE row>@ignore 
	end
	else
	begin
	SET ROWCOUNT @size
	if(@pcount is null)
	begin
	set @pcount=0
	end
	
	select  @pcount,g.kname,CA.albumid,ca.title,ca.coverphoto,ca.coverphotodatetime,ca.net,t3.ishow  from gartenlist g
	inner join ClassApp..class_album ca on g.kid=ca.kid and [status] =1 and ca.coverphoto is not null
	left join dbo.PhotoState t3 on t3.contentid=ca.albumID
	where (t3.ishow = @ishow or (@ishow=0  and t3.ishow is null ) or @ishow=-1) and g.areaid=@areaid
	ORDER BY ca.lastuploadtime desc


	end
	RETURN 0







GO
