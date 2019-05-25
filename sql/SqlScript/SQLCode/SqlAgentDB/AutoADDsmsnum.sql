USE SqlAgentDB 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-06-14
-- Description:	
-- Paradef: 
-- Memo:	EXEC AutoADDsmsnum
*/ 
ALTER PROCEDURE [dbo].AutoADDsmsnum 
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @T TABLE(kid int)

	select DISTINCT sc.siteid 
		into #site 
		from KWebCMS.dbo.site_config sc 
			inner join blogapp.dbo.permissionsetting ps 
				on sc.siteid = ps.kid   
				and  ps.ptype = 84
				and ISNULL(sc.smsnum,0) < 1000
			OUTER APPLY
				(
				SELECT  sum(ncount)cnt 
					from ossapp.dbo.smsbase 
					where remark in('自动冲短信','自助充值') 
					AND kid = sc.siteid)op
		where isnull(cnt,0) < sc.autosmslimit
	IF NOT EXISTS(SELECT * FROM #site) RETURN
	Begin tran   
	BEGIN TRY  
		UPDATE sc 
			SET smsnum = ISNULL(sc.smsnum,0) + 2000
			output inserted.siteid
			into @T
			from KWebCMS.dbo.site_config sc 
				inner join #site s 
					on sc.siteid = s.siteid   
				
		INSERT INTO ossapp.dbo.smsbase
					(kid, ncount, uid, info, remark, tigcount, intype, deletetag, intime )
			select kid, 2000, 1, '', '自动冲短信', 0, '', 1, getdate() 
				from @T  
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return        
	end Catch     

		
END		
		