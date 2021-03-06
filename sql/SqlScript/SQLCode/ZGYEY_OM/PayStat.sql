USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[PayStat]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--[PayStat] '2011-10-01','2011-12-10',1
------------------------------------
CREATE PROCEDURE [dbo].[PayStat]
@size int,
@page int
 AS 

IF(@page>1)
	BEGIN
		DECLARE @count int
		DECLARE @ignore int
		SET @count=@page*@size
		SET @ignore=@count-@size

		DECLARE @temptable TABLE
		(
			row int identity(1,1) primary key,
			tempid int
		)

		INSERT INTO @temptable
		SELECT 
		kid from t_paystat
		ORDER BY plusamount DESC
		
		SET ROWCOUNT @size
		select 
		kmp.dbo.areacaptionfromid(t1.privince),kmp.dbo.areacaptionfromid(t1.city),t1.kname,t1.plusamount
		from t_paystat t1 
		left join @temptable s on t1.kid=s.tempid		
		where row>@ignore 
		order by t1.plusamount desc
				
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		select kmp.dbo.areacaptionfromid(t1.privince),kmp.dbo.areacaptionfromid(t1.city),t1.kname,t1.plusamount
		from t_paystat t1		
		order by plusamount desc

	END






GO
