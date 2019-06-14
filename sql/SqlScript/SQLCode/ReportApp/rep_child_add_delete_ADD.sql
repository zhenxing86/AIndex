USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_child_add_delete_ADD]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：增加一条记录 
--项目名称：
--说明：
--时间：2011-8-25 11:30:41
------------------------------------
CREATE PROCEDURE [dbo].[rep_child_add_delete_ADD]
@userid int,
@username nvarchar(50),
@cid int,
@kid int,
@actionuserid int,
@actionusername nvarchar(50),
@actiontype int,
@memo nvarchar(50)
 AS 
--	if not exists(select 1 from [rep_child_add_delete] where userid=@userid and actiontype=@actiontype)
--	begin	
		INSERT INTO [rep_child_add_delete](
		[userid],[username],[cid],[kid],[actionuserid],[actionusername],[actiontype],[memo],[actiondatetime]
		)VALUES(
		@userid,@username,@cid,@kid,@actionuserid,@actionusername,@actiontype,@memo,getdate()
		)
	--end

if(@@error<>0)
begin
	return (-1)
end
else
begin
	return (1)
end

GO
