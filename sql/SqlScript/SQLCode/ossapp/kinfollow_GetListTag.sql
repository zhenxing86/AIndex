USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinfollow_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetListTag
------------------------------------
CREATE PROCEDURE [dbo].[kinfollow_GetListTag]
 @page int
,@size int
,@kid int
,@fcontent varchar(100)
,@fstatus varchar(100)
,@fusers int
,@ftypes int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [kinfollow] where deletetag=1 and kid=@kid 
and (@fusers=-1 or @fusers=fuid)
and (@ftypes=-1 or @ftypes=followtype)
and (@fstatus='-1' or status=@fstatus)
and information like '%'+@fcontent+'%'

IF(@page>1)
	BEGIN
	
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		if(@pcount<@ignore)
		begin
			set @page=@pcount/@size
			if(@pcount%@size<>0)
			begin
				set @page=@page+1
			end
			SET @prep=@size*@page
			SET @ignore=@prep-@size
		end
		
		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint
		)

			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			SELECT  ID  FROM [kinfollow] where deletetag=1 and kid=@kid
and (@fusers=-1 or @fusers=fuid)
and (@ftypes=-1 or @ftypes=followtype)
and (@fstatus='-1' or status=@fstatus)
and information like '%'+@fcontent+'%'

			SET ROWCOUNT @size
			SELECT 
				@pcount      ,[ID]    ,[kid]    ,[followtype]    ,[fuid]    ,[uid]    ,[status]    ,[information]    ,[intime]    ,[kf_id]    ,[isremind]    ,[stime]    ,[etime]    ,[ctime]    ,[deletetag] 
,(select top 1 info from dict where ID=[followtype]) 
,(select top 1 [name] from users where ID=[fuid]) 
,(select top 1 [name] from users where ID=[uid])
 			FROM 
				@tmptable AS tmptable		
			INNER JOIN [kinfollow] g
			ON  tmptable.tmptableid=g.ID 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,[ID]    ,[kid]    ,[followtype]    ,[fuid]    ,[uid]    ,[status]    ,[information]    ,[intime]    ,[kf_id]    ,[isremind]    ,[stime]    ,[etime]    ,[ctime]    ,[deletetag] 
,(select top 1 info from dict where ID=[followtype]) 
,(select top 1 [name] from users where ID=[fuid]) 
,(select top 1 [name] from users where ID=[uid]) 	
 FROM [kinfollow]  where deletetag=1  and kid=@kid
and (@fusers=-1 or @fusers=fuid)
and (@ftypes=-1 or @ftypes=followtype)
and (@fstatus='-1' or status=@fstatus)
and information like '%'+@fcontent+'%'
end


GO
