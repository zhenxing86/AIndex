USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[actionlogs_Stat_GetLoginListByDate]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-09-18
-- Description:	用户登录日志
-- =============================================
CREATE PROCEDURE [dbo].[actionlogs_Stat_GetLoginListByDate]
@startdatetime datetime,
@enddatetime datetime,
@page int,
@size int
AS
BEGIN
	IF(@page>0)
	BEGIN
		DECLARE @count int
		DECLARE @ignore int
	
		SET @count=@page*@size
		SET @ignore=@count-@size

		DECLARE @tempTable TABLE
		(
			row int primary key identity(1,1),
			tempuserid int,
			logincount int
		)

		INSERT INTO @tempTable 
		SELECT userid,'logincount'=count(userid) FROM actionlogs_history 
		WHERE  actionmodul=-1 AND actiondatetime BETWEEN @startdatetime AND @enddatetime
		GROUP BY userid ORDER BY logincount DESC 

--		DECLARE @tempTable TABLE
--		(
--			row int primary key identity(1,1),
--			tempaccount nvarchar(50),
--			logincount int,
--			tempuserid int
--		)

--		INSERT INTO @tempTable 
--		SELECT 'Account'=substring(actiondesc,charindex(' ',actiondesc)+1,charindex('在',actiondesc)-charindex('员',actiondesc)-3),
--		'LoginCount'=count(substring(actiondesc,charindex(' ',actiondesc)+1,charindex('在',actiondesc)-charindex('员',actiondesc)-3)),
--		userid 
--		FROM actionlogs WHERE actionmodul=-1 --AND actiondatetime BETWEEN @startdatetime AND @enddatetime
--		GROUP BY substring(actiondesc,charindex(' ',actiondesc)+1,charindex('在',actiondesc)-charindex('员',actiondesc)-3),userid
--		ORDER BY LoginCount DESC
--
--		SELECT tempaccount,logincount,t2.siteid,t3.name,t3.sitedns 
--		FROM @tempTable t1,site_user t2,site t3
--		WHERE t1.tempaccount=t2.account AND t2.siteid=t3.siteid

		SET ROWCOUNT @size
		SELECT logincount,userid,t2.account,t3.siteid,t3.name,t3.sitedns
		FROM @tempTable t1,site_user t2,site t3
		WHERE t1.tempuserid=t2.userid AND t2.siteid=t3.siteid AND row>@ignore
		ORDER BY logincount DESC
	END
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'actionlogs_Stat_GetLoginListByDate', @level2type=N'PARAMETER',@level2name=N'@page'
GO
