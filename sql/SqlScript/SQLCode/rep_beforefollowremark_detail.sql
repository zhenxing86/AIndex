USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_beforefollowremark_detail]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rep_beforefollowremark_detail]
 @page int
,@size int
,@intime1 datetime
,@intime2 datetime
,@remindtype varchar(100)
,@uid int
,@abid int
,@privince varchar(100)
,@city varchar(100)
,@area varchar(100)
as


declare @pcount int

select @pcount=count(1)
 from dbo.beforefollowremark br
inner join users u on u.ID=br.uid 
inner join [beforefollow] b on b.ID=br.bf_Id
where br.deletetag=1 and b.kid<>0 
and br.intime between @intime1 and @intime2 
and (remindtype=@remindtype or  @remindtype='')
and (u.bid=@uid or (@uid=-1 and u.bid>0))
--and (provice = @privince or @privince='-1')
--and (city = @city or @city='')
--and (area = @area or @area='')



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
			SELECT  br.ID  FROM 
beforefollowremark br 
inner join  dbo.beforefollow b on br.bf_Id=b.ID
inner join users u on u.ID=br.uid 
where br.deletetag=1 and b.kid<>0
and br.intime between @intime1 and @intime2 
and (br.remindtype=@remindtype or  @remindtype='')
and (u.bid=@uid or (@uid=-1 and u.bid>0))
--and (provice = @privince or @privince='-1')
--and (city = @city or @city='')
--and (area = @area or @area='')
 order by br.intime desc


			SET ROWCOUNT @size
			
select @pcount,br.ID,b.ID,b.kid,kname,br.remark,br.remindtype,br.uid,u.[name],u.bid,br.intime
,dbo.[getAreabyId]([provice]) 
,dbo.[getAreabyId]([city]) 
,dbo.[getAreabyId]([area]) 
	FROM 
				@tmptable AS tmptable		
			INNER JOIN beforefollowremark br
			ON  tmptable.tmptableid=br.ID 
	inner join  dbo.beforefollow b on br.bf_Id=b.ID
inner join users u on u.ID=br.uid 
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size


select @pcount,br.ID,b.ID,b.kid,kname,br.remark,br.remindtype,br.uid,u.[name],u.bid,br.intime
,dbo.[getAreabyId]([provice]) 
,dbo.[getAreabyId]([city]) 
,dbo.[getAreabyId]([area]) 
 from dbo.beforefollowremark br
inner join  dbo.beforefollow b on br.bf_Id=b.ID
inner join users u on u.ID=br.uid 
where br.deletetag=1 and b.kid<>0
and br.intime between @intime1 and @intime2 
and (remindtype=@remindtype or  @remindtype='')
and (u.bid=@uid or (@uid=-1 and u.bid>0))
--and (provice = @privince or @privince='-1')
--and (city = @city or @city='')
--and (area = @area or @area='')
order by br.intime desc

end



GO
