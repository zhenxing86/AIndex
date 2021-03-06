USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[UI_gartenlist_GetNewest]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：查询记录信息 
--项目名称：gartenlist
------------------------------------
create PROCEDURE [dbo].[UI_gartenlist_GetNewest]
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
	SELECT  count(1) FROM [gartenlist]
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
			 select  CA.albumid from gartenlist g
			inner join ClassApp..class_album ca on g.kid=ca.kid
			ORDER BY (select max(CP.uploaddatetime) from ClassApp..class_photos CP where CA.albumid=CP.albumid )desc

			 
			 SET ROWCOUNT @size
			SELECT @pcount,kname,CA.albumid,ca.title,ca.coverphoto,ca.coverphotodatetime 
				 	FROM  @tmptable a
					INNER JOIN ClassApp..class_album ca ON  a.tmptableid=ca.albumid 
					inner join gartenlist g  on g.kid=ca.kid
					WHERE row>@ignore 
	end
	else
	begin
	SET ROWCOUNT @size
	if(@pcount is null)
	begin
	set @pcount=0
	end
	
	select  CA.albumid,ca.title,ca.coverphoto,ca.coverphotodatetime from fchyjdj118..gartenlist g
	inner join ClassApp..class_album ca on g.kid=ca.kid and [status] =1
	ORDER BY (select max(CP.uploaddatetime) from ClassApp..class_photos CP where CA.albumid=CP.albumid )desc


	end
	RETURN 0





GO
