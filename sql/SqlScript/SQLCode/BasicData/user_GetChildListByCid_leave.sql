USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetChildListByCid_leave]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-08-01  
-- Description:  得到幼儿列表 
-- Memo:  
[user_GetChildListByCid_leave] 46144,1,10
*/
CREATE PROCEDURE [dbo].[user_GetChildListByCid_leave]
	@cid int,
	@page int,
	@size int
AS 
BEGIN
	SET NOCOUNT ON
	DECLARE @beginRow INT
	DECLARE @endRow INT
	DECLARE @pcount INT
	SET @beginRow = (@page - 1) * @size    + 1 
	SET @endRow = @page * @size	

	SELECT  userid, account, name, gender, mobile,leavereason  
		FROM 
		(
			SELECT	ROW_NUMBER() OVER(order by u.regdatetime desc) AS rows, 
							u.userid,u.account,u.name,u.gender,u.mobile,lk.leavereason 
				FROM [user] u 
					left join leave_kindergarten lk on u.userid = lk.userid  
					left join leave_user_class luc on u.userid = luc.userid
				WHERE	u.usertype = 0 
					and luc.cid = @cid
					and luc.userid is not null
					and u.deletetag=1
		) AS main_temp 
		WHERE rows BETWEEN @beginRow AND @endRow
END

GO
