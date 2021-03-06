USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_lucidateacher_GetCount_where]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-22
-- Description:	获取学生数量
-- =============================================
CREATE PROCEDURE [dbo].[blog_lucidateacher_GetCount_where]
@kid int,
@Name varchar(50),
@cid int
AS
BEGIN
	Declare @count int
	DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint,
			tmptableid2 bigint
		)
	if(@cid>0)
	begin 
		SELECT @count=count(1)
		 FROM 	  BasicData..user_bloguser ub
				 INNER join basicdata..[user] t3
					 on t3.userid=ub.userid
		 WHERE t3.kid=@kid and t3.usertype<>0 and t3.deletetag=1 and  t3.[name] like '%'+@Name+'%' 
		 and  exists(select 1 from  basicdata..user_class t4 where t3.userid=t4.userid and t4.cid=@cid)
	end
	else 
	begin
		 SELECT @count=count(1)
		 FROM 	 BasicData..user_bloguser ub
				 INNER join basicdata..[user] t3
					 on t3.userid=ub.userid
		 WHERE t3.kid=@kid and t3.usertype<>0 and t3.deletetag=1  and  t3.[name] like '%'+@Name+'%' 
	end 
	RETURN @count
END

GO
