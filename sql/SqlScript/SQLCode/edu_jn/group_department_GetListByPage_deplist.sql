USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[group_department_GetListByPage_deplist]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[group_department_GetListByPage_deplist]
@gid int--获取列表，部门管理列表专用
,@page int
,@size int
 AS 


declare @depid int ,@areaid int
select @depid=depid,@areaid=areaid from group_user where userid=@gid


declare @pcount int,@p int

SELECT @pcount=count(1) FROM [group_department] where deletetag=1 
and superiorid=@depid and gid=@areaid
    
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
			SELECT  did FROM [group_department] where deletetag=1  
			and superiorid=@depid and gid=@areaid
		order by did asc


			SET ROWCOUNT @size
			SELECT 
				@pcount,did,dname,superiorid,gid,deletetag
,(select top 1 dname from [group_department] d where d.did=g.superiorid)
,''
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
,''
	 FROM [group_department] g where deletetag=1  
	 and superiorid=@depid and gid=@areaid
	 order by did asc
end




GO
