USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[ExtUserRuleId]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ExtUserRuleId]
 @cuid int
,@rname varchar(300)
 AS 

declare @pcount int

select @pcount=count(1) from  users u
inner join [role] r on r.ID=u.roleid
inner join rules rs on rs.ID=rs.roleid
where u.ID=@cuid and rs.[name]=@rname

return @pcount


GO
