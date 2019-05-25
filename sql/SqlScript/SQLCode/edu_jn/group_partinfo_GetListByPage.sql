USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[group_partinfo_GetListByPage]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012/2/6 10:39:26
------------------------------------
CREATE PROCEDURE [dbo].[group_partinfo_GetListByPage]
@g_kid int
,@page int
,@size int
 AS 

declare @pcount int,@p int
select @pcount=count(pid) from [group_partinfo] where deletetag=1 and (g_kid=@g_kid or @g_kid=-1)

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
			SELECT  pid FROM [group_partinfo] where deletetag=1 and (g_kid=@g_kid or @g_kid=-1)


			SET ROWCOUNT @size
			SELECT 
				pid,gid,g_kid,p_kid,name,nickname,descript,logopic,mastername,inuserid,intime,[order],deletetag,@pcount,(select count(1) from group_notice n where n.g_kid=t1.g_kid and t1.p_kid like '%'+n.p_kid+'%')
			FROM 
				@tmptable AS tmptable		
			INNER JOIN [group_partinfo] t1
			ON  tmptable.tmptableid=t1.pid 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

	SELECT 
	pid,gid,g_kid,p_kid,name,nickname,descript,logopic,mastername,inuserid,intime,[order],deletetag,@pcount,(select count(1) from group_notice n where n.g_kid=p.g_kid and p.p_kid like '%'+n.p_kid+'%')
	 FROM [group_partinfo] p where deletetag=1 and (g_kid=@g_kid or @g_kid=-1)
end










GO
