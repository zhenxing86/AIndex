USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[userinfo_getlist]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[userinfo_getlist]
@kid int 
as
begin

	select u.userid,u.kid,u.name
	from [user] u 
	where u.deletetag = 1 and kid= @kid
end
GO
