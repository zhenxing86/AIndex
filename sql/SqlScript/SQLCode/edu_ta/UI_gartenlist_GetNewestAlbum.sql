USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[UI_gartenlist_GetNewestAlbum]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：查询记录信息 
--项目名称：gartenlist
--[UI_gartenlist_GetNewestAlbum] 2,20
------------------------------------
CREATE PROCEDURE [dbo].[UI_gartenlist_GetNewestAlbum]
	@page int,
	@size int,
	@areaid int
	 AS
	 
	 declare @pcount int
	-- declare @size_ int
	
	
	--DECLARE @tp TABLE
	--(
	--	pc int
	--)

	--insert into @tp
	select  @pcount=count(CA.albumid) from [gartenphotos] ca 
left join dbo.PhotoState t3 on t3.contentid=CA.albumid
where areaid=@areaid and t3.ishow is null	
	--ORDER BY (select max(CP.uploaddatetime) from ClassApp..class_photos CP where CA.albumid=CP.albumid )desc
	--select @pcount=pc from @tp

	
	
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
			 select  CA.albumid from [gartenphotos] ca 
left join dbo.PhotoState t3 on t3.contentid=CA.albumid
where  areaid=@areaid and  t3.ishow is null	
ORDER BY ca.lastuploadtime desc
				 
			 SET ROWCOUNT @size
			 SELECT @pcount,ca.kname,CA.albumid,ca.title,ca.coverphoto,ca.coverphotodatetime,ca.net
				 	FROM  @tmptable a
					INNER JOIN [gartenphotos] ca  ON  a.tmptableid=ca.albumid 					
					WHERE row>@ignore 
	end
	else
	begin
	SET ROWCOUNT @size
	if(@pcount is null)
	begin
	set @pcount=0
	end
	
	select  @pcount,ca.kname,CA.albumid,ca.title,ca.coverphoto,ca.coverphotodatetime,ca.net  
	from [gartenphotos] ca 
left join dbo.PhotoState t3 on t3.contentid=CA.albumid
where  areaid=@areaid and  t3.ishow is null	
ORDER BY ca.lastuploadtime desc


	end
	RETURN 0


select * from [gartenphotos]



GO
