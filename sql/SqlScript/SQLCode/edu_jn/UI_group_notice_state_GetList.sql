USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[UI_group_notice_state_GetList]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：查询记录信息 
--项目名称：group_notice_state
------------------------------------
CREATE PROCEDURE [dbo].[UI_group_notice_state_GetList]
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
	SELECT  count(1) FROM [group_notice_state]
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
			 SELECT   [id]              FROM [group_notice_state] 
			 
			 SET ROWCOUNT @size
				SELECT @pcount, [id],   [nid],   [p_kid],   [isread],   [deletefag]  	FROM  @tmptable a
					INNER JOIN [group_notice_state] g ON  a.tmptableid=g.  [id]              	
					WHERE row>@ignore 
	end
	else
	begin
	SET ROWCOUNT @size
	if(@pcount is null)
	begin
	set @pcount=0
	end
	
	SELECT @pcount, [id],   [nid],   [p_kid],   [isread],   [deletefag]   FROM [group_notice_state] 
	
	end
	RETURN 0






GO
