USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_lucidapapoose_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-22
-- Description:	获取学生数量

-- =============================================
CREATE PROCEDURE [dbo].[blog_lucidapapoose_GetCount]
@kid int
AS
BEGIN
	Declare @count int
	SELECT @count=count(1)	FROM blog_lucidaUser_log t1
    left join basicdata..[user] t2 on t2.userid=t1.appuserid
left join basicdata..user_class t4 on t2.userid=t4.userid
left join basicdata..leave_kindergarten l on t2.userid=l.userid
where siteid=@kid and t1.usertype=0 and t2.deletetag=1 and t4.cid>0 and l.id is null
	RETURN @count
END
GO
