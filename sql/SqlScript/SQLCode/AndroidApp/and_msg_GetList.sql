USE [AndroidApp]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 
-- Description: 
-- Memo:
*/ 
alter PROCEDURE [dbo].[and_msg_GetList] 
	@page int,
	@size int,
	@userid int
AS
BEGIN
	SELECT	m.ID,m.title, m.contents, m.push_type, m.msg_type, 
					m.sent_time, d.userid, d.tag, m.msg_code, m.sender, m.send_status, 
					m.intime, m.[param], d.readstate,0 senderuid
		INTO #T  
		FROM [AndroidApp].[dbo].[and_msg] m  
			inner join 	[AndroidApp].dbo.and_msg_detail d 
				on d.sms_id = m.ID
		where	m.sent_time < GETDATE()
			and d.userid = @userid  
			and d.deletetag = 1 	
			and m.send_status = 1	
			and m.msg_type <> 0	
			and m.msg_code <> '402'
  
  INSERT INTO #T(
					ID, title, contents, push_type, msg_type, 
					sent_time, userid, tag, msg_code, sender, send_status, 
					intime, [param], readstate,senderuid)  
		select	f.ID, '好友消息', f.msgcon, 1, 1, f.CrtDate, f.Touserid, 
						0, 402, u.name, 1, f.CrtDate, CONVERT(VARCHAR(10),f.CrtDate,120) +'A402a', f.IsRead,u.userid senderuid  
			FROM basicdata..FriendSMS f
				inner join BasicData..[user] u on f.Userid = u.userid
			where Touserid = @userid
  
   exec sp_GridViewByPager      
    @viewName = '#T',             --表名      
    @fieldName = 'ID,title,contents,sent_time,userid,msg_code,sender,param,readstate,senderuid',      --查询字段      
    @keyName = 'ID',       --索引字段      
    @pageSize = @size,                 --每页记录数      
    @pageNo = @page,                     --当前页      
    @orderString = '  sent_time desc  ',          --排序条件      
    @whereString = ' 1 = 1  ' ,  --WHERE条件      
    @IsRecordTotal = 1,             --是否输出总记录条数      
    @IsRowNo = 0    
   
END
GO
[and_msg_GetList] 1,10,288556

