USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[audit_SMS_Del]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[audit_SMS_Del] 
	@taskid int,
	@userid int
AS 
BEGIN

  Begin tran  
	BEGIN TRY  
	
		--获取用户权限
		declare @role int
		select @role=COUNT(1) from KWebCMS..site_user 
		inner join KWebCMS_Right..sac_user u on u.[user_id]=[UID]
		inner join KWebCMS_Right..sac_user_role r on r.[user_id]=u.[user_id]
		inner join KWebCMS_Right..sac_role l on l.role_id=r.role_id
		where appuserid in (@userid) and role_name in('管理员','园长')
	
		delete audit_sms_batch
			where taskid=@taskid
				and [state]=0
				and (@role=1 or sender=@userid)
	
		------------------------------------------------------------------------------------------
		
					
		SELECT 1 result             				
		Commit tran    
	End Try      
	Begin Catch      
		Rollback tran                          
		SELECT -1 result      
	end Catch 

END    

GO
