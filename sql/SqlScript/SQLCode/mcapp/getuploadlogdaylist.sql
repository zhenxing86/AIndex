USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[getuploadlogdaylist]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--[getuploadlogdaylist] 12511,'001251101'
CREATE PROCEDURE [dbo].[getuploadlogdaylist]
@kid int
,@devid varchar(10)
 AS 
 
 
select distinct logdate from [mc_applylog_date]  
where kid=@kid and devid=@devid and status=0


GO
