USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[Child_GetList]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Child_GetList] 
@kid int,
@cid int,
@uname varchar(100)
as 
select 
r.userid,[name] from  BasicData..user_class c 
inner join  BasicData..[user] r on  r.userid=c.userid 
where 
r.kid=@kid
and (cid=@cid or @cid =-1) and [name] like '%'+@uname+'%' and usertype=0 and deletetag=1

GO
