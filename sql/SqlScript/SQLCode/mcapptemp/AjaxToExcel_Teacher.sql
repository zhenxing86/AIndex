USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[AjaxToExcel_Teacher]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	教师IC卡绑定资料导出格式（按姓名排序）：姓名 ，IC卡号,班级
-- Memo:		[AjaxToExcel_Teacher] 12511
*/
CREATE PROCEDURE [dbo].[AjaxToExcel_Teacher]
	@kid int
as
BEGIN
	SET NOCOUNT ON
	create table #temp
	(
		name nvarchar(100),
		sex nvarchar(100),
		[card] nvarchar(100),
		cname nvarchar(100),
		cid int,
		userid int
	)

	insert into #temp(name,sex,[card],cname,cid, userid)
		select ut.name, ut.sex, ci.cardno, c.cname, c.cid, ut.userid 
		from BasicData..[User_Teacher] ut 
			left join cardinfo ci on ci.userid = ut.userid
			left join BasicData..user_class uc on ut.userid = uc.userid
			left join BasicData..class c on c.cid = uc.cid
		where ut.kid=@kid 
		order by cardno

	select	name, sex, [card],
					stuff((select ','+rtrim(cname) from #temp where k.userid = userid for xml path('')),1,1,'')
		from #temp k
		GROUP BY name, sex, [card], userid
		order by [card]

	drop table #temp
END

GO
