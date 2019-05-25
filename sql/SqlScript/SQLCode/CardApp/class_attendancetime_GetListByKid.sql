USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[class_attendancetime_GetListByKid]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途:幼儿园教师考勤时间
--项目名称：classhomepage
--说明：
--时间：2009-7-18 14:54:31
------------------------------------
CREATE PROCEDURE [dbo].[class_attendancetime_GetListByKid]
@kid int
AS
select a.did,a.dname, b.time1,b.time2,b.time3,b.time4,b.time5,b.time6,b.id as atsid 
from basicdata.dbo.department a
left join attendancetimeset b on a.did=b.departmentid
where a.deletetag=1 and a.kid=@kid-- and a.superior >0 order by [order]


GO
