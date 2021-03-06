USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_vipdetails_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[kmp_vipdetails_Add]
@userids nvarchar(500),
@startdate datetime,
@enddate datetime,
@vipstatus int,
@operator int
AS
BEGIN
BEGIN TRANSACTION
	DECLARE @userid int
	DECLARE @index int
	DECLARE @count int
	SET @count=0

	WHILE(LEN(@userids)>0)
	BEGIN
		SET @count=@count+1
		IF @count>99
		BEGIN
			BREAK--循环99次后退出
		END

		SET @index=CHARINDEX(',',@userids)

		IF @index=0
		BEGIN
			SET @userid=CONVERT(int,@userids)
			SET @index=LEN(@userids)+1
			--BREAK--循环完毕,退出
		END
		ELSE
		BEGIN
			SET @userid=CONVERT(int,LEFT(@userids,@index-1))
		END

		UPDATE basicdata.dbo.child SET vipstatus=@vipstatus WHERE userid=@userid
		--DELETE kmp..vipdetails WHERE userid=@userid AND iscurrent=0
		UPDATE zgyey_om..vipdetails SET iscurrent=0 WHERE userid=@userid
		INSERT INTO zgyey_om..vipdetails VALUES(@userid,1,@startdate,@enddate,0)

		EXEC vipsetlog_Add @userid,@startdate,@enddate,@vipstatus,@operator

		SET @userids=STUFF(@userids,1,@index,'')
	END

	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 1
	END
END



GO
