USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[gun_para_Status_Monitor]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-10-11
-- Description:	过程用于监控晨检枪参数更新情况
-- Memo:		
*/
CREATE PROC [dbo].[gun_para_Status_Monitor]
AS
BEGIN
	SET NOCOUNT ON
	;WITH CET AS
	(
		select distinct serial_no 
			from gun_para_xg
	)
	SELECT ca.kid, k.kname,ca.serial_no,ca.status 
		FROM CET c 
			cross apply
				(select top(1)* 
					from gun_para_xg 
					where serial_no = c.serial_no 
					ORDER BY adate DESC
				)ca
			inner join BasicData..kindergarten k 
				on ca.kid = k.kid
		ORDER BY ca.kid,ca.serial_no
END

GO
