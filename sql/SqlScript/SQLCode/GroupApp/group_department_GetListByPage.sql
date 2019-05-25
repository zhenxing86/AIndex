USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[group_department_GetListByPage]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[group_department_GetListByPage]
@gid int
,@page int
,@size int
 AS 

declare @pcount int,@p int

SELECT @pcount=count(1) FROM [group_department] where deletetag=1 and gid=@gid

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
			SELECT  did FROM [group_department] where deletetag=1 and gid=@gid order by did desc


			SET ROWCOUNT @size
			SELECT 
				@pcount,did,dname,superiorid,gid,deletetag
,(select top 1 dname from [group_department] d where d.did=g.superiorid)
,(select top 1 [name] from dbo.group_baseinfo b where b.gid=g.gid)
			FROM 
				@tmptable AS tmptable		
			INNER JOIN [group_department] g
			ON  tmptable.tmptableid=g.did 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	
	@pcount,did,dname,superiorid,gid,deletetag
,(select top 1 dname from [group_department] d where d.did=g.superiorid)
,(select top 1 [name] from dbo.group_baseinfo b where b.gid=g.gid)
	 FROM [group_department] g where deletetag=1 and gid=@gid order by did desc,superiorid asc
end



GO
