USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_beforefollowremarkV0]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rep_beforefollowremarkV0]
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



select b.kid,kname,br.remark,br.remindtype,u.[name],br.intime
,dbo.[getAreabyId]([provice]) 
,dbo.[getAreabyId]([city]) 
,dbo.[getAreabyId]([area]) 
 from dbo.beforefollowremark br
inner join  dbo.beforefollow b on br.bf_Id=b.ID
inner join users u on u.ID=br.uid 
where br.deletetag=1
and br.intime between @intime1 and @intime2 
and (remindtype=@remindtype or  @remindtype='')
and (br.uid=@uid or @uid=-1) and u.bid=@abid
and (provice = @privince or @privince='-1')
and (city = @city or @city='')
and (area = @area or @area='')
order by kname asc ,br.intime desc





GO
