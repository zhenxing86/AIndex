USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[DeleteFriendSMSAll]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      于璋
-- Create date: 2014-03-13   
-- Description: 用于清空消息收件箱
-- Memo:exec GetFriendSMSByPage 653615, 1,10  
*/   

create PROC [dbo].[DeleteFriendSMSAll]
 @Userid int
AS  
BEGIN  
 SET NOCOUNT ON    
 update BasicData..FriendSMS
 set deletetag = 0
 where Touserid = @Userid
END  


GO
