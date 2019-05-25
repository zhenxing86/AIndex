USE NGBApp
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-21
-- Description:	函数用于获取班级老师列表字串
-- Memo:		
SELECT dbo.GetHomeBookTercher(46144)
*/
ALTER FUNCTION dbo.GetHomeBookTercher(@cid int)
returns varchar(200)
as
BEGIN
	DECLARE @S varchar(200)
	;WITH CET AS
	(
		select TOP(4) u.name,t.title,u.mobile,
		ROW_NUMBER()OVER(order by case t.title when '主班老师' then 0 when '副班老师' then 1 when '保育员' then 2 when '医生' then 3 end)rowno
			from BasicData..teacher t 
				inner join BasicData..[user] u 
					on t.userid = u.userid 
					and u.deletetag = 1 
				inner join BasicData..user_class uc
					on uc.userid = u.userid
			where uc.cid = @cid
				and t.title in('主班老师','副班老师','保育员','医生')
			order by case t.title when '主班老师' then 0 when '副班老师' then 1 when '保育员' then 2 when '医生' then 3 end 

	)
	select @S = STUFF(CommonFun.dbo.sp_GetSumStr('#'+ISNULL(name,'')+','+ISNULL(title,'')+','+ISNULL(mobile,'')),1,1,'')
		from CommonFun..Nums100 n LEFT JOIN CET c on c.rowno = n.n
		WHERE n.n <=4
	RETURN @S
END
GO