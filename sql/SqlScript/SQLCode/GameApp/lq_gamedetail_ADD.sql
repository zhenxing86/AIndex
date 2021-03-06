USE [GameApp]
GO
/****** Object:  StoredProcedure [dbo].[lq_gamedetail_ADD]    Script Date: 2014/11/24 23:07:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[lq_gamedetail_ADD]
@userid int,
@subjectid int,
@subjecttype int,
@result int,
@usetime int,
@doindex int
as

delete [lq_gamedetail] where userid=@userid and subjectid=@subjectid

INSERT INTO [GameApp].[dbo].[lq_gamedetail]
           ([userid]
           ,[subjectid]
           ,[result]
           ,[usetime]
           ,[doindex]
           ,[actiontime])
     VALUES
           (@userid
           ,@subjectid
           ,@result
           ,@usetime
           ,@doindex
           ,getdate())
		
	IF(@@ERROR<>0)
		RETURN 0
	ELSE
		RETURN 1  


--select *  from lq_gamedetail
--
--select * from lq_gameresult
--
--update lq_gameresult set r2=0,r3=0,r4=0,r5=0,r6=0,r7=0,r8=0

GO
