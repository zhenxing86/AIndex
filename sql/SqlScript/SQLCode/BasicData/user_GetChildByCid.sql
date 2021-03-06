USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetChildByCid]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-08-01  
-- Description:  得到幼儿列表 
-- Memo:  
user_GetChildByCid 88
*/
CREATE PROCEDURE [dbo].[user_GetChildByCid]
	@cid int
AS
BEGIN 
	SET NOCOUNT ON	
	SELECT uc.userid, uc.account, uc.name, uc.gender, uc.mobile,MAX(c.cardno)
		FROM User_Child uc 
			left join leave_kindergarten lk 
				on uc.userid = lk.userid
			left join mcapp..cardinfo c 
				on uc.userid=c.userid 
				and c.usest=1
		WHERE	uc.cid = @cid 
			and lk.userid is null
		group by uc.userid, uc.account, uc.name, uc.gender, uc.mobile
		ORDER BY uc.userid DESC 
END

GO
