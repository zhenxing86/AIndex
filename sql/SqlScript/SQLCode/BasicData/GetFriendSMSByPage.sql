USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[GetFriendSMSByPage]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      Master谭    
-- Create date: 2014-02-11    
-- Description: 用于网页读取好友消息  
-- Memo:exec GetFriendSMSByPage 653615, 1,10  
--select * from [user] where account in('jz1','jz2')   
*/   
CREATE PROC [dbo].[GetFriendSMSByPage]
 @touserid int, 
 @page int,  
 @size int  
AS  
BEGIN  
 SET NOCOUNT ON    
--exec	sp_MutiGridViewByPager
--		@fromstring = 'FriendSMS fs  
--   inner join [user] u   
--    on fs.userid = u.userid 
--   inner join BasicData..user_bloguser ub
--    on fs.userid = ub.userid
--  where fs.touserid = @D1
--    and fs.deletetag = 1 ',      --数据集
--		@selectstring = 
--		'fs.ID, u.name, u.Userid, u.Headpic, u.HeadpicUpdate, fs.msgtype, fs.msgcon, fs.CrtDate,fs.IsRead, ub.bloguserid',      --查询字段
--		@returnstring = 
--		'ID, name, Userid, Headpic, HeadpicUpdate, msgtype, msgcon, CrtDate, IsRead,bloguserid',      --返回字段
--		@pageSize = @Size,                 --每页记录数
--		@pageNo = @page,                     --当前页
--		@orderString = ' fs.CrtDate desc',          --排序条件
--		@IsRecordTotal = 1,             --是否输出总记录条数
--		@IsRowNo = 0,										 --是否输出行号
--		@D1 = @touserid 

;With data1 as (
Select fs.ID, u.name, u.Userid, u.Headpic, u.HeadpicUpdate, fs.msgtype, fs.msgcon, fs.CrtDate, fs.IsRead, ub.bloguserid, 'FriendSMS' tb
  From FriendSMS fs, [user] u, BasicData..user_bloguser ub
  Where fs.userid = u.userid and fs.userid = ub.userid and fs.touserid = @touserid and fs.deletetag = 1 
Union all
Select a.messageboxid, c.name, c.Userid, c.Headpic, c.HeadpicUpdate, 1 msgtype, a.msgcontent, a.sendtime, Cast(a.viewstatus as bit), b.bloguserid, 'blog_messagebox' tb
  From msgapp..blog_messagebox a, basicdata..user_bloguser b, [user] c
  Where a.fromuserid = b.userid and b.userid = c.userid and a.touserid = @touserid and a.msgtitle Like '%寄来了贺卡'
), data2 as (
Select Count(*) Over() pcount, *, Row_number() Over(Order by CrtDate desc) RowNo
  From data1
)
Select pcount, ID, name, Userid, Headpic, HeadpicUpdate, msgtype, msgcon, CrtDate, IsRead, bloguserid, tb
  Into #Result
  From data2 
  Where RowNo > @size * (@page - 1) and RowNo <= @size * @page

Update a Set IsRead = 1
  From FriendSMS a, #Result b
  Where a.ID = b.ID and Isnull(a.IsRead, 0) <> 1 and b.tb = 'FriendSMS'

Update a Set viewstatus = 1
  From msgapp..blog_messagebox a, #Result b
  Where a.messageboxid = b.ID and Isnull(a.viewstatus, 0) <> 1 and b.tb = 'blog_messagebox'

Select pcount, ID, name, Userid, Headpic, HeadpicUpdate, msgtype, msgcon, CrtDate, IsRead, bloguserid From #Result
END  


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'<div>
	获取好友消息（网页用）
</div>' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetFriendSMSByPage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发送目标ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetFriendSMSByPage', @level2type=N'PARAMETER',@level2name=N'@touserid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'&nbsp;' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetFriendSMSByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'&nbsp;' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetFriendSMSByPage', @level2type=N'PARAMETER',@level2name=N'@size'
GO
