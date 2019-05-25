USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[rep_CurrentMonth_SMS_content]    Script Date: 09/25/2013 11:42:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		mh
-- Create date: 2013-07-01
-- Description:	
-- exec [audit_CurrentMonth_SMS_content] 1,100,0,0,'2009-06-01', '2014-06-14',12511,288556,0
-- =============================================

alter PROCEDURE [dbo].[audit_CurrentMonth_SMS_content]
	@page int,
	@size int,
	@issended bit, -- 0已发送，1待发送
	@isaudit bit, -- 0待审核，1已审核
	@bgndate datetime,
	@enddate datetime,
	@kid int,
	@userid int,-- 判断@usertype>1查询全部，否则查本班
	@type int = 0
	
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @usertype INT
	
	create table #result([state] int,name varchar(50),smscontent nvarchar(500),sendtime datetime,
	                     sendusercount int, sendsmscount int, sendtype int,taskid bigint,ID INT IDENTITY,userid int)
	
	IF @type = 0--查学生
	BEGIN
		 select @usertype=max(case role_name when '老师' then 1 when '管理员' then 98 when '园长' then 97 end)  
			from  KWebCMS..site_user stu 
			inner join KWebCMS_Right..sac_user_role sur on sur.[user_id]=stu.[UID]
			inner join KWebCMS_Right..sac_role sr on sr.role_id=sur.role_id
			where stu.appuserid=@userid

			if(@usertype is null)
			begin
			  select @usertype = usertype 
					  from BasicData.dbo.[user] 
					  where userid = @userid
			end
		  
		IF @usertype > 1 --查全部
			insert into #result 
		  select sb.[state],u.name, sb.smscontent, sb.sendtime, sum(sb.Sendusercount), 
	           SUM(sb.sendsmscount), sb.sendtype, MIN(sb.taskid),u.userid
	      from audit_sms_batch sb
	        inner join BasicData..[user] u
	        on sb.sender = u.userid
	      where sb.kid = @kid
	        and sb.sendtime >= CONVERT(VARCHAR(10),@bgndate,120)
	        and sb.sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
	        and CASE WHEN GETDATE() > sb.sendtime THEN 0 ELSE 1 end = @issended
	        and sb.cid <> 0
			GROUP BY sb.[state],u.name, sb.smscontent, sb.sendtime, sb.sendtype,u.userid    
	  ELSE  --查本班
	    insert into #result
		  select sb.[state],u.name, sb.smscontent, sb.sendtime, sum(sb.Sendusercount), 
	           SUM(sb.sendsmscount), sb.sendtype,  MIN(sb.taskid),u.userid
	      from audit_sms_batch sb
	        inner join BasicData..[user] u
	        on sb.sender = u.userid
	        inner join BasicData..user_class uc
	        on u.userid = uc.userid
	      where sb.kid = @kid
	        and sb.sendtime >= CONVERT(VARCHAR(10),@bgndate,120)
	        and sb.sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
	        and CASE WHEN GETDATE() > sb.sendtime THEN 0 ELSE 1 end = @issended
	        and uc.userid = @userid
	        and sb.cid = uc.cid
			GROUP BY sb.[state],u.name, sb.smscontent, sb.sendtime, sb.sendtype ,u.userid 
	        
  END
  ELSE --查老师
  BEGIN
    insert into #result
    select sb.[state],u.name, sb.smscontent, sb.sendtime, sb.Sendusercount, 
	         sb.sendsmscount, sb.sendtype, sb.taskid,sb.sender
	    from audit_sms_batch sb
	      inner join BasicData..[user] u
	      on sb.sender = u.userid
	    where sb.kid = @kid
	      and sb.sendtime >= CONVERT(VARCHAR(10),@bgndate,120)
	      and sb.sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
	      and CASE WHEN GETDATE() > sb.sendtime THEN 0 ELSE 1 end = @issended
	      and sb.cid = 0 
      
	END
	
	 declare @where varchar(100)
	
	set @where='[state]='+CONVERT(varchar,@isaudit)
	
	exec dbo.sp_GridViewByPager 

     @viewName = '#result',             --表名
     @fieldName  = 'name,smscontent,sendtime,sendusercount,sendsmscount,sendtype,taskid,state,userid',      --查询字段
     @keyName  = 'Id',       --索引字段
     @pageSize = @size,                 --每页记录数
     @pageNo = @page,                     --当前页
     @orderString = 'sendtime desc',          --排序条件
     @whereString = @where,  --WHERE条件
     @IsRecordTotal = 1,             --是否输出总记录条数
     @IsRowNo = 0										 --是否输出行号

	
END

GO

exec [audit_CurrentMonth_SMS_content] 1,100,0,0,'2009-06-01', '2014-06-14',12511,288556,0