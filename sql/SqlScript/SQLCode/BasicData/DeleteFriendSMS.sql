USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[DeleteFriendSMS]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      于璋
-- Create date: 2014-03-13   
-- Description: 用于删除单条消息
*/   

CREATE PROC [dbo].[DeleteFriendSMS]
 @Userid int,
 @ID int
AS  
BEGIN  
 SET NOCOUNT ON    
 update BasicData..FriendSMS
 set deletetag = 0
 where Touserid = @Userid
   and ID = @ID
END  


GO
