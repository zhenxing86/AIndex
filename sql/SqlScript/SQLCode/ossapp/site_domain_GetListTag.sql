USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[site_domain_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[site_domain_GetListTag]
 @page int
,@size int
,@kid int
as




declare @pcount int

SELECT @pcount=count(1) from kwebcms.dbo.site_domain where siteid=@kid

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
			SELECT  ID  from kwebcms.dbo.site_domain where siteid=@kid


			SET ROWCOUNT @size
			SELECT 
				 @pcount,d.ID,d.siteid,domain
,case when d.domain=s.sitedns then 1 else 0 end isdefault
		FROM 
				@tmptable AS tmptable		
			INNER JOIN kwebcms.dbo.site_domain d
			ON  tmptable.tmptableid=d.ID 
	inner join Kwebcms..site s on d.siteid=s.siteid 
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

 select @pcount,d.ID,d.siteid,domain
,case when d.domain=s.sitedns then 1 else 0 end isdefault
 from kwebcms.dbo.site_domain d
inner join Kwebcms..site s on d.siteid=s.siteid 
where d.siteid=@kid


end










GO
