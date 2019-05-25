USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[class_GetCardnoByNoUse]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：按园或卡号取可用的卡号
--项目名称：classhomepage
--说明：
--时间：2009-4-9 18:00:31
------------------------------------
CREATE PROCEDURE [dbo].[class_GetCardnoByNoUse]
	@kid int,	
	@cardno nvarchar(30),
	@userid int,
	@usertype int
 AS 
	IF(@usertype=0)
	BEGIN
		select cardno From cardlist where status=0 and KID=@kid and cardno like '%'+@cardno+'%' and subno=0
		 --and subno IN (SELECT t1.subno FROM basicdata.dbo.user_class t2 left join basicdata.dbo.class t1 ON t1.cid=t2.cid WHERE t2.userid=@userid)
	END
	ELSE
	BEGIN
		select cardno From cardlist where status=0 and KID=@kid and cardno like '%'+@cardno+'%' and subno=0
		-- and subno IN (SELECT t1.subno FROM KMP..t_staffer t2 Left join kmp..t_department t1 ON t1.id=t2.departmentid WHERE t2.userid=@userid )
	END




GO
