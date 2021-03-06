USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_dntuser_ADD]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：注册论坛
--项目名称：zgyeyblog
--说明：
--时间：2010-02-16 22:56:46
--作者：along
------------------------------------
create PROCEDURE [dbo].[blog_dntuser_ADD]
@kid int,
@kmpuserid int,
@dntuserid int
 AS 

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION
	declare @usercount int
	select @usercount=count(*) from blog_dntuser
	where kmpuserid=@kmpuserid

	if(@usercount=0)
	begin
		--论坛用户关系表
		INSERT INTO blog_dntuser(
		[kid],[kmpuserid],[dntuserid]
		)VALUES(
		@kid,@kmpuserid,@dntuserid
		)	
	end
	
	IF @@ERROR <> 0 
	BEGIN	
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION	
		RETURN(1)	   
	END





GO
