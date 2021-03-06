USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetChildListByCid]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-08-01  
-- Description:  得到幼儿列表 
-- Memo:  
[user_GetChildListByCid] 46144,1,10
*/
CREATE PROCEDURE [dbo].[user_GetChildListByCid]
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

	SELECT  userid, account, name, gender, mobile,cardno
		FROM 
		(
			SELECT	ROW_NUMBER() OVER( order by uc.userid desc) AS rows, 
							uc.userid, uc.account, uc.name, uc.gender, uc.mobile,MAX(c.cardno)cardno
		FROM User_Child uc 
			left join leave_kindergarten lk 
				on uc.userid = lk.userid
			left join mcapp..cardinfo c 
				on uc.userid=c.userid 
				and c.usest=1
		WHERE	uc.cid = @cid 
			and lk.userid is null
		group by uc.userid, uc.account, uc.name, uc.gender, uc.mobile
		) AS main_temp 
		WHERE rows BETWEEN @beginRow AND @endRow
		
END

GO
