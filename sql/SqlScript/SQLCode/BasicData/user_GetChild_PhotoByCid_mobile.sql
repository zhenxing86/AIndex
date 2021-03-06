USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetChild_PhotoByCid_mobile]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-08-01  
-- Description:  得到幼儿列表 
-- Memo:  
user_GetChild_PhotoByCid_mobile 10
*/
CREATE PROCEDURE [dbo].[user_GetChild_PhotoByCid_mobile]
	@hbid int
AS
BEGIN
	SET NOCOUNT ON 	
	select gb.userid, u.name, u.headpic, u.headpicupdate, gb.gbid, u.mobile 
		from GBApp..GrowthBook gb
			Inner JOIN [user] u on gb.userid = u.userid 
		where gb.hbid = @hbid
		ORDER BY gb.userid asc
END

GO
