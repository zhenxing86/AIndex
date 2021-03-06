USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[CancleVIPStatus]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




--SELECT * FROM zgyey_om..VIPDetails WHERE IsCurrent=1 and enddate<=getdate()

CREATE PROCEDURE [dbo].[CancleVIPStatus]
AS
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

--  毕业班状态同步
update t4 set t4.iscurrent=0 from basicdata..child t1
inner join basicdata..user_class t2 on t1.userid=t2.userid
left join basicdata..class t3 on t2.cid=t3.cid
left join zgyey_om..vipdetails t4 on t1.userid=t4.userid 
where t4.iscurrent=1 
and t3.grade=38
--  毕业班状态同步
update t1 set t1.vipstatus=0 from basicdata..child t1
inner join basicdata..user_class t2 on t1.userid=t2.userid
left join basicdata..class t3 on t2.cid=t3.cid
left join zgyey_om..vipdetails t4 on t1.userid=t4.userid 
where t4.iscurrent=1 
and t3.grade=38
--到期时间同步
update t1 set t1.vipstatus=0 from basicdata..child t1 left join zgyey_om..vipdetails t2 on t1.userid=t2.userid 
where t2.iscurrent=1 and t2.enddate<convert(varchar(12) , getdate(), 23)+' 23:59:59'


--	UPDATE basicdata..child set VIPStatus=0 WHERE userid in (SELECT userid FROM zgyey_om..VIPDetails WHERE IsCurrent=1 and enddate<=convert(varchar(12) , getdate(), 23)+' 23:59:59')
    UPDATE zgyey_om..VIPDetails SET IsCurrent=0 WHERE IsCurrent=1 and enddate<convert(varchar(12) , getdate(), 23)+' 23:59:59'


INSERT INTO [ZGYEY_OM].[dbo].[VIPDetails_history]
           ([UserID]
           ,[IsCurrent]
           ,[StartDate]
           ,[EndDate]
           ,[FeeAmount])
     SELECT [UserID]
      ,[IsCurrent]
      ,[StartDate]
      ,[EndDate]
      ,[FeeAmount]
  FROM [ZGYEY_OM].[dbo].[VIPDetails]
where iscurrent=0

delete FROM [ZGYEY_OM].[dbo].[VIPDetails]
where  iscurrent=0



	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK TRANSACTION
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	END

GO
