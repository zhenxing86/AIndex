USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[GetFriendSendSMSByPage]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      于璋
-- Create date: 2014-03-12    
-- Description: 用于网页读取发送的消息  
-- Memo:exec GetFriendSMSByPage 653615, 1,10  
*/   

CREATE PROC [dbo].[GetFriendSendSMSByPage]
 @Userid int, 
 @page int,  
 @size int  
AS  
BEGIN  
 SET NOCOUNT ON    
exec	sp_MutiGridViewByPager
		@fromstring = 'FriendSMS fs  
   inner join [user] u   
    on fs.touserid = u.userid  
   inner join BasicData..user_bloguser ub
    on fs.touserid = ub.userid
  where fs.Userid = @D1 ',      --数据集
		@selectstring = 
		'fs.ID, u.name, u.Userid, u.Headpic, u.HeadpicUpdate, fs.msgtype, fs.msgcon, fs.CrtDate,fs.IsRead, ub.bloguserid',      --查询字段
		@returnstring = 
		'ID, name, Userid, Headpic, HeadpicUpdate, msgtype, msgcon, CrtDate, IsRead,bloguserid',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' fs.CrtDate desc',          --排序条件
		@IsRecordTotal = 1,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @Userid
END  
GO
