USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[group_user_GetListByPage]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[group_user_GetListByPage]
@gid int
,@page int
,@size int
 AS 

declare @pcount int,@p int

SELECT @pcount=count(1) FROM [group_user] where deletetag=1 and gid=@gid

IF(@page>1)
	BEGIN
	
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint
		)

			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			SELECT  userid FROM [group_user] where deletetag=1 and gid=@gid


			SET ROWCOUNT @size
			SELECT 
				@pcount,userid,account,pwd,username,intime,deletetag,gid,did
,(select top 1 dname from [group_department] d where d.did=g.did)
,(select top 1 [name] from dbo.group_baseinfo b where b.gid=g.gid)
			FROM 
				@tmptable AS tmptable		
			INNER JOIN [group_user] g
			ON  tmptable.tmptableid=g.userid 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount,userid,account,pwd,username,intime,deletetag,gid,did
,(select top 1 dname from [group_department] d where d.did=g.did)
,(select top 1 [name] from dbo.group_baseinfo b where b.gid=g.gid)
	 FROM [group_user] g where deletetag=1 and gid=@gid
end


GO
