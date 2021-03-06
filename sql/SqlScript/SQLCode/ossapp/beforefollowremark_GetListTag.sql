USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[beforefollowremark_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--GetListTag
------------------------------------
CREATE PROCEDURE [dbo].[beforefollowremark_GetListTag]
 @page int
,@size int
,@kfid int
 AS 

--declare @pcount int
--
--SELECT @pcount=count(1) FROM [beforefollowremark]
--
-- where deletetag=1 and bf_Id=@kfid
--
--IF(@page>1)
--	BEGIN
--	
--		DECLARE @prep int,@ignore int
--
--		SET @prep=@size*@page
--		SET @ignore=@prep-@size
--
--		if(@pcount<@ignore)
--		begin
--			set @page=@pcount/@size
--			if(@pcount%@size<>0)
--			begin
--				set @page=@page+1
--			end
--			SET @prep=@size*@page
--			SET @ignore=@prep-@size
--		end
--		
--		DECLARE @tmptable TABLE
--		(
--			row int IDENTITY(1,1),
--			tmptableid bigint
--		)
--
--			SET ROWCOUNT @prep
--			INSERT INTO @tmptable(tmptableid)
--			SELECT  ID  FROM [beforefollowremark] where deletetag=1 and bf_Id=@kfid order by [ID] desc
--
--
--			SET ROWCOUNT @size
--			SELECT 
--				@pcount      ,g.[ID]    ,[bf_Id]    ,g.[remark]    ,[remindtime]    ,g.[uid]    ,g.[intime]  ,g.deletetag,u.[name],remindtype,r.ID		
--	FROM 
--				@tmptable AS tmptable		
--			INNER JOIN [beforefollowremark] g
--			ON  tmptable.tmptableid=g.ID 	
--inner join users u on u.ID=g.uid
--left join remindlog r on r.rid=g.ID and r.deletetag=1 and result='待'+remindtype
--			WHERE
--				row>@ignore 
--
--end
--else
--begin
--SET ROWCOUNT @size

SELECT 
	@size      ,g.[ID]    ,[bf_Id]    ,g.[remark]    ,[remindtime]    
,g.[uid]    ,g.[intime]  ,g.deletetag,u.[name],g.remindtype,r.ID,g.lv
	 FROM [beforefollowremark] g
inner join users u on u.ID=g.uid
left join remindlog r on r.rid=g.ID and r.deletetag=1 and result='待'+remindtype
  where g.deletetag=1  and bf_Id=@kfid order by g.[ID] desc
--end



GO
