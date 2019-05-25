USE SMS
go
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-02
-- Description:	返回充值历史
-- Memo:		exec smsapp_role_GetModel 0
*/
alter PROC smsapp_role_GetModel
	@kid int
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @bgndate datetime
	SELECT @bgndate = bgndate FROM CommonFun.[dbo].getTerm_bgn_end(GETDATE(),@kid)				
	select sc.siteid,ISNULL(op.termcount,0)termcount,-1 as termsendcount, CASE WHEN pid is null then -1 else ISNULL(autosmslimit - op1.autocnt,0)end cancount
		from KWebCMS.dbo.site_config sc 
			left join blogapp.dbo.permissionsetting ps 
				on sc.siteid = ps.kid   
				and  ps.ptype = 82
			OUTER APPLY
			(
				SELECT  sum(ncount)termcount 
					from ossapp.dbo.smsbase 
					where kid = sc.siteid
						and intime >= @bgndate)op
			OUTER APPLY
			(
				SELECT  sum(ncount)autocnt 
					from ossapp.dbo.smsbase 
					where remark in('自动冲短信','自助充值') 
					AND kid = sc.siteid)op1
		where sc.siteid  = @kid

end