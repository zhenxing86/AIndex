USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_payinfo_uid]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rep_payinfo_uid]
@uid int,
@ftime varchar(20),
@ltime varchar(20)
as

select k.kid,k.kname,p.paytype,[money],paytime,p.remark from dbo.kinbaseinfo k
inner join dbo.payinfolog p on k.kid=p.kid
where k.developer=@uid and p.deletetag=1
and (paytime >= @ftime or @ftime='')
and (paytime <= @ltime or @ltime='')
order by paytime desc,k.kname asc,paytype asc

GO
