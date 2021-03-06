USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[group_notice_state_GetList]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







--[group_notice_state_GetList] -2,82,1,'','','','','',''
------------------------------------
--用途：查询记录信息 
--项目名称：group_notice_state
------------------------------------
CREATE PROCEDURE [dbo].[group_notice_state_GetList]
 @g_kid int
,@p_kid int
,@istype int
,@page int
,@size int
,@firsttime datetime
,@lasttime datetime
,@title varchar(100)
,@isread int = 1
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


		select @pcount=count(1) 
			FROM 
				[group_notice] t1
			left join group_notice_state a on a.nid = t1.nid and a.p_kid=@p_kid 
			 where (','+t1.p_kid+',' like '%,'+convert(varchar,@p_kid)+',%') and t1.deletetag=1
			  and (a.deletefag=1 or a.deletefag is null)
			 
	

	


IF(@page>1)
	BEGIN
	
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		
			SET ROWCOUNT @prep
			
			DECLARE @tmptable TABLE
			(
					row int IDENTITY(1,1),
					tmptableid bigint
			)
			INSERT INTO @tmptable(tmptableid)
			SELECT  t1.nid 
			FROM 
				[group_notice] t1
			left join group_notice_state a on a.nid = t1.nid and a.p_kid=@p_kid and a.p_kid = @p_kid
		where (','+t1.p_kid+',' like '%,'+convert(varchar,@p_kid)+',%') and t1.deletetag=1
			  and (a.deletefag=1 or a.deletefag is null)
			 
		
			SELECT 
				@pcount,t1.nid,title,content,istype,inuserid,t1.intime,g_kid,t1.p_kid,(select count(1) from group_noticeattachs a where a.nid=t1.nid),p_kname
				,case when isread is null then 0 else isread end,t1.username
			FROM 
				@tmptable AS tmptable		
			INNER JOIN [group_notice] t1
			ON  tmptable.tmptableid=t1.nid 	
			left join group_notice_state a 
			on a.nid = t1.nid  and a.p_kid=@p_kid
			left join group_user u on u.userid=inuserid
			WHERE
				row>@ignore 
				order by isread,t1.intime desc
	end
else
begin
SET ROWCOUNT @size
SELECT 
			@pcount,t1.nid,title,content,istype,inuserid,t1.intime,g_kid,t1.p_kid,(select count(1) from group_noticeattachs a where a.nid=t1.nid),p_kname
			,case when isread is null then 0 else isread end as isread,t1.username
			FROM 
				[group_notice] t1
			left join group_notice_state a on a.nid = t1.nid  and  a.p_kid = @p_kid
			left join group_user u on u.userid=inuserid
			 where  (','+t1.p_kid+',' like '%,'+convert(varchar,@p_kid)+',%') and t1.deletetag=1 
			  and (a.deletefag=1 or a.deletefag is null)
			order by isread,t1.intime desc
end




GO
