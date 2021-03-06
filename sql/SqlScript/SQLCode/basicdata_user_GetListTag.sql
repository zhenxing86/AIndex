USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[basicdata_user_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--select * from [basicdata_user]
--basicdata_user_GetListTag 1,100
------------------------------------
CREATE PROCEDURE [dbo].[basicdata_user_GetListTag]
 @page int
,@size int
 AS 
 
declare @pcount int 
select @pcount=COUNT(1) from ossapp..basicdata_user 

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
			SELECT  userid  FROM ossapp..basicdata_user


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,[userid]    ,[username] ,g.[kid],k.kname   ,[account]    ,[pwd]  			FROM 
				@tmptable AS tmptable		
			INNER JOIN ossapp..basicdata_user g
			ON  tmptable.tmptableid=g.userid
			inner join basicdata..kindergarten k 
			on g.kid =k.kid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT @pcount, [userid], [username], g.[kid],k.kname, [account], [pwd]  
 FROM ossapp..basicdata_user g
 inner join basicdata..kindergarten k 
 on g.kid =k.kid
end



GO
