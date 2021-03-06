USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[group_baseinfo_GetListByPage]    Script Date: 2014/11/24 23:09:23 ******/
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
CREATE PROCEDURE [dbo].[group_baseinfo_GetListByPage]
@page int
,@size int
 AS
declare @pcount int,@p int
select @pcount=count(gid) from [group_baseinfo] where deletetag=1

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
			SELECT  gid FROM [group_baseinfo] where deletetag=1

			SET ROWCOUNT @size
			SELECT 
				@pcount,gid,kid,[name],nickname,descript,logopic,mastename,inuserid,intime,[order],deletetag
			FROM 
				@tmptable AS tmptable		
			INNER JOIN [group_baseinfo] t1
			ON  tmptable.tmptableid=t1.gid 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT  @pcount,gid,kid,[name],nickname,descript,logopic,mastename,inuserid,intime,[order],deletetag
	 FROM [group_baseinfo] where deletetag=1
end


GO
