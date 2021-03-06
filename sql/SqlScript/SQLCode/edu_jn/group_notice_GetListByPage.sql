USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[group_notice_GetListByPage]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012/2/6 11:47:05
------------------------------------

CREATE PROCEDURE [dbo].[group_notice_GetListByPage]
@g_kid int
,@p_kid int--userid
,@istype int
,@page int
,@size int
,@firsttime datetime
,@lasttime datetime
,@title varchar(100)

 AS

if(@firsttime = '')
BEGIN
set @firsttime=convert(datetime,'1900-01-01')
End


if(@lasttime = '')
BEGIN
set @lasttime=convert(datetime,'2090-01-01')
End

set @lasttime=dateadd(day,1,@lasttime)

declare @pcount int,@p int



select @pcount=count(nid) from [group_notice] 
where deletetag=1  
and inuserid=@p_kid--(','+p_kid+',' like '%,'+convert(varchar,@p_kid)+',%' or inuserid=@p_kid) 
and intime >@firsttime and intime <= @lasttime	and title like '%'+@title+'%'
 and g_kid=@g_kid




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
			SELECT nid FROM [group_notice] where deletetag=1  
and inuserid=@p_kid--(','+p_kid+',' like '%,'+convert(varchar,@p_kid)+',%' or inuserid=@p_kid) 
and intime >@firsttime and intime <= @lasttime	and title like '%'+@title+'%'
 and g_kid=@g_kid
order by intime desc



			SET ROWCOUNT @size

			SELECT 
				@pcount,nid,title,content,istype,inuserid,intime,g_kid,p_kid,(select count(1) from kininfoapp..group_noticeattachs a where a.nid=t1.nid),p_kname
			FROM 
				@tmptable AS tmptable		
			INNER JOIN [group_notice] t1
			ON  tmptable.tmptableid=t1.nid 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

	SELECT 
	@pcount,nid,title,content,istype,inuserid,intime,g_kid,convert(varchar,p_kid),(select count(1) from group_noticeattachs a where a.nid=n.nid),p_kname
	 FROM [group_notice] n where deletetag=1  
and inuserid=@p_kid --and (','+p_kid+',' like '%,'+convert(varchar,@p_kid)+',%' or inuserid=@p_kid) 
and intime >@firsttime and intime <= @lasttime	and title like '%'+@title+'%'
 and g_kid=@g_kid
order by intime desc

end



GO
