USE [GBApp]
GO
/****** Object:  StoredProcedure [dbo].[ArchivesApply_ADD]    Script Date: 2014/11/24 23:07:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：提交成长档案申请，并做相应的扣费ZZZ
--项目名称：com.zgyey.ArchivesApply
--说明：
--时间：2013-1-4 10:43:20
------------------------------------
CREATE PROCEDURE [dbo].[ArchivesApply_ADD]
@gbId int,
@gId int,
@gName nvarchar(150),
@cId int,
@cName nvarchar(150),
@kId int,
@kName nvarchar(150),
@userId int,
@userName nvarchar(150),
@applyTime datetime,
@handleTime datetime,
@telephone nvarchar(50),
@modules nvarchar(150),
@term nvarchar(50),
@status int,
@deleteTag int,
@url nvarchar(150),
@beanCount int,
@flag int =0
 AS 
  SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION
	declare @objectid int
	select @objectid = count(1) FROM [GBAPP]..[archives_apply] 
	WHERE gbid=@gbId and userid =@userId and [status] =0 and deletetag =1
	if @objectid <=0
	begin
	  
		INSERT INTO [GBAPP]..[archives_apply]
			   ([gbid]
			   ,[gid]
		   ,[gname]
			   ,[cid]
		   ,[cname]
			   ,[kid]
			   ,[kname]
			   ,[userid]
			   ,[username]
			   ,[applytime]
			   ,[handletime]
			   ,[telephone]
			   ,[modules]
		   ,[term]
			   ,[status]
			   ,[deletetag]
		   ,[url],flag)
		 VALUES
			   (@gbId,@gId,@gName,@cId,@cName,@kId,@kName,@userId,@userName,@applyTime,@handleTime,@telephone,@modules,@term,@status,@deleteTag,@url,@flag)

		if @beanCount>0
		begin
		UPDATE PAYAPP..user_pay_account SET re_beancount=re_beancount-@beanCount where userid =@userId
		end 

		set @objectid=@@IDENTITY
	end
	
	IF @@ERROR <> 0 
	BEGIN 		
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN	
		COMMIT TRANSACTION
	   RETURN (@objectid)
	END

GO
