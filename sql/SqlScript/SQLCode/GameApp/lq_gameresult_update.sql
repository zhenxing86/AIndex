USE [GameApp]
GO
/****** Object:  StoredProcedure [dbo].[lq_gameresult_update]    Script Date: 2014/11/24 23:07:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[lq_gameresult_update]
@rindex int,
@subjecttype int
as
--if(@rindex=2 or @rindex=1)
--	update lq_gameresult set r2=r2+1 where subjecttypeid=@subjecttype
if (@rindex<=3)
	update lq_gameresult set r3=r3+1 where subjecttypeid=@subjecttype
else if (@rindex=4)
	update lq_gameresult set r4=r4+1 where subjecttypeid=@subjecttype
else if (@rindex=5)
	update lq_gameresult set r5=r5+1 where subjecttypeid=@subjecttype
else if (@rindex=6)
	update lq_gameresult set r6=r6+1 where subjecttypeid=@subjecttype
else if (@rindex=7)
	update lq_gameresult set r7=r7+1 where subjecttypeid=@subjecttype
else if (@rindex=8)
	update lq_gameresult set r8=r8+1 where subjecttypeid=@subjecttype

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
