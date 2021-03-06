USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_expiretime]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rep_expiretime]
 @page int
,@size int
,@uptime1 datetime
,@uptime2 datetime
,@infofrom varchar(100)
,@uid int
,@abid int
,@kid varchar(100)
,@kname varchar(100)
as



declare @pcount int


select @pcount=count(1)
 from  dbo.Log_UpKinTime l
inner join dbo.kinbaseinfo k on k.kid=l.kid
inner join users u on u.ID=l.uid 
 where 
l.uptime between @uptime1 and @uptime2 
and (l.infofrom=@infofrom or @infofrom='')
and (l.uid=@uid or @uid=-1) and u.bid=@abid 
and (l.kid=@kid or @kid='-1' or @kid='')
--and  k.kname like '%'+@kname+'%' 


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
			SELECT  l.ID  FROM 
dbo.Log_UpKinTime l
inner join dbo.kinbaseinfo k on k.kid=l.kid
inner join users u on u.ID=l.uid 
 where 
l.uptime between @uptime1 and @uptime2 
and (l.infofrom=@infofrom or @infofrom='')
and (l.uid=@uid or @uid=-1) and u.bid=@abid 
and (l.kid=@kid or @kid='-1' or @kid='')
--and  k.kname like '%'+@kname+'%' 
order by l.uptime desc

			SET ROWCOUNT @size
			
select
 @pcount,l.ID,l.kid,k.kname,l.old_time,l.new_time,l.remark,l.infofrom,l.uid,u.[name],u.bid,l.uptime
	FROM 
				@tmptable AS tmptable		
			INNER JOIN dbo.Log_UpKinTime l
			ON  tmptable.tmptableid=l.ID 
inner join dbo.kinbaseinfo k on k.kid=l.kid
inner join users u on u.ID=l.uid 

			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

select @pcount,l.ID,l.kid,k.kname,convert(varchar(10),l.old_time,120),convert(varchar(10),l.new_time,120),l.remark,l.infofrom,l.uid,u.[name],u.bid,convert(varchar(10),l.uptime,120)
 from  dbo.Log_UpKinTime l
inner join dbo.kinbaseinfo k on k.kid=l.kid
inner join users u on u.ID=l.uid 
 where 
l.uptime between @uptime1 and @uptime2 
and (l.infofrom=@infofrom or @infofrom='')
and (l.uid=@uid or @uid=-1) and u.bid=@abid
and (l.kid=@kid or @kid='-1' or @kid='')
--and  k.kname like '%'+@kname+'%' 
order by l.uptime desc

end


GO
