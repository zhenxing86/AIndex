USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_lucidapapoose_GetCount_where]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-22
-- Description:	获取学生数量
-- =============================================
CREATE PROCEDURE [dbo].[blog_lucidapapoose_GetCount_where]
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
			FROM basicdata..[user] t2
		left join basicdata..user_class t4 on t2.userid=t4.userid
		where t2.kid=@kid and t2.usertype=0 and t2.deletetag=1 and t4.cid=@cid  and  t2.[name] like '%'+@Name+'%' 
	end
	else 
	begin
		SELECT @count=count(1)	
		FROM basicdata..[user] t2
		left join basicdata..user_class t4 on t2.userid=t4.userid
		where t2.kid=@kid and t2.usertype=0 and t2.deletetag=1 and t4.cid>0  and t2.[name] like '%'+@Name+'%' 
	end 
	RETURN @count
END

GO
