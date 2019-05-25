USE SMS 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-02
-- Description:	
-- Paradef: 
-- Memo: EXEC smsapp_smsbase_Add 0,12511,100 
*/ 
CREATE PROCEDURE [dbo].smsapp_smsbase_Add 
	@userid int,
	@kid int,
	@smscount int
AS
BEGIN
	SET NOCOUNT ON
	
	if exists
	(
		select *
		from KWebCMS.dbo.site_config sc 
			inner join blogapp.dbo.permissionsetting ps 
				on sc.siteid = ps.kid   
				and  ps.ptype = 82
			OUTER APPLY
				(
				SELECT  sum(ncount)cnt 
					from ossapp.dbo.smsbase 
					where remark IN ('自动冲短信','自助充值') 
					AND kid = sc.siteid)op
		where isnull(cnt,0) + @smscount <= sc.autosmslimit
			and sc.siteid = @kid
	)
	BEGIN

		Begin tran   
		BEGIN TRY  
			UPDATE sc 
				SET smsnum = ISNULL(sc.smsnum,0) + @smscount
				from KWebCMS.dbo.site_config sc 
				WHERE sc.siteid = @kid
					
			INSERT INTO ossapp.dbo.smsbase
						(kid, ncount, uid, info, remark, tigcount, intype, deletetag, intime )
				select @kid, @smscount, @userid, '', '自助充值', 0, '', 1, getdate() 
				
			Commit tran                              
		End Try      
		Begin Catch      
			Rollback tran
			SELECT 0 result   
			Return        
		end Catch     
	END
	else
	BEGIN
		SELECT 0 result
		Return
	END
	SELECT 1 result		
END		
		