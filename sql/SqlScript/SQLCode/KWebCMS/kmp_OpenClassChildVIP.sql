USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_OpenClassChildVIP]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--------------------------------------
--用途：全班开通vip
--项目名称：classhomepage
--说明：
--时间：-01-20 14:54:31
------------------------------------
CREATE PROCEDURE [dbo].[kmp_OpenClassChildVIP]
@classid int,
@begintime datetime,
@endtime datetime,
@status int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION
	IF(@status=1)
	BEGIN
		update t1 SET  t1.iscurrent=0  
       FROM ZGYEY_OM.dbo.vipdetails t1 inner join basicdata.dbo.child t2 on t1.userid=t2.userid
       inner join basicdata.dbo.user_class t3 on t2.userid=t3.userid
       inner join basicdata.dbo.[user] t4 on t3.userid=t4.userid
        where t3.cid=@classid and t4.deletetag=1
		
		update t1 SET t1.vipstatus=1 FROM basicdata.dbo.child t1 
		INNER JOIN basicdata.dbo.user_class t3 on t1.userid=t3.userid
		inner join basicdata.dbo.[user] t4 on t1.userid=t4.userid
		INNER JOIN  basicdata.dbo.class t2 on t3.cid=t2.cid
	    WHERE t3.cid=@classid and t4.deletetag=1 and t2.grade<>38

		insert into ZGYEY_OM.dbo.VIPDetails(userid,iscurrent,startdate,enddate) 
		   select t1.userid,1,@begintime,@endtime 
		FROM basicdata.dbo.child t1 
		INNER JOIN basicdata.dbo.user_class t3 on t1.userid=t3.userid
		inner join basicdata.dbo.[user] t4 on t1.userid=t4.userid
		INNER JOIN  basicdata.dbo.class t2 on t3.cid=t2.cid
	    WHERE t3.cid=@classid and t4.deletetag=1 and t2.grade<>38

		INSERT INTO vipsetlog([userid],[startdate],[enddate],[actiondatetime],[dredgeStatus])
		select t1.userid,@begintime as startdate,@endtime as enddate,GETDATE() as actiondatetime,1 as dredgestatus 
		FROM basicdata.dbo.child t1 
		INNER JOIN basicdata.dbo.user_class t3 on t1.userid=t3.userid
		inner join basicdata.dbo.[user] t4 on t1.userid=t4.userid
		INNER JOIN  basicdata.dbo.class t2 on t3.cid=t2.cid
	    WHERE t3.cid=@classid and t4.deletetag=1 and t2.grade<>38
	END
	ELSE
	BEGIN
	   update t1 SET t1.iscurrent=0  
       FROM ZGYEY_OM.dbo.vipdetails t1 inner join basicdata.dbo.child t2 on t1.userid=t2.userid
       inner join basicdata.dbo.user_class t3 on t2.userid=t3.userid
       inner join basicdata.dbo.[user] t4 on t3.userid=t4.userid
        where t3.cid=@classid and t4.deletetag=1

		update t1 SET t1.vipstatus=0 FROM basicdata.dbo.child t1 
		inner join basicdata.dbo.[user] t4 on t1.userid=t4.userid
		inner join basicdata.dbo.user_class t5 on t1.userid=t5.userid
	    WHERE t5.cid=@classid and t4.deletetag=1 

		INSERT INTO vipsetlog([userid],[startdate],[enddate],[actiondatetime],[dredgeStatus])
		select t1.userid,@begintime as startdate,@endtime as enddate,GETDATE() as actiondatetime,0 as dredgestatus 
		FROM basicdata.dbo.child t1 
		inner join basicdata.dbo.[user] t4 on t1.userid=t4.userid
		inner join basicdata.dbo.user_class t5 on t1.userid=t5.userid
	    WHERE t5.cid=@classid and t4.deletetag=1
	END

	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN (1)
	END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_OpenClassChildVIP', @level2type=N'PARAMETER',@level2name=N'@classid'
GO
