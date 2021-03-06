USE [SqlAgentDB]
GO
/****** Object:  StoredProcedure [dbo].[Remove_JFFSRight]    Script Date: 2014/11/24 23:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      along
-- Create date: 2013-08-14
-- Description:	
-- Paradef: 
-- Memo:	exec [Remove_JFFSRight]
*/ 
CREATE PROCEDURE [dbo].[Remove_JFFSRight] 
AS
BEGIN

	delete srr from blogapp..permissionsetting p
		left join kwebcms..site s
			 on p.kid=s.siteid
		left join KWebCMS_Right..sac_org so 
			 on s.org_id=so.org_id
		left join KWebCMS_Right..sac_site_instance ssi
		     on so.org_id=ssi.org_id
		left join KWebCMS_Right..sac_role sr 
			 on ssi.site_instance_id=sr.site_instance_id
		left join KWebCMS_Right..sac_role_right srr 
		     on sr.role_id=srr.role_id
		left join KWebCMS_Right..sac_right srg 
		     on srr.right_id=srg.right_id
		where ptype=81
			and srg.right_name='缴费方式'	 									 					
			
	
	exec [UpdateTestUserInfo]
	
	update sc set sc.isvip=1
		from ossapp..kinbaseinfo kb,
		kwebcms..site_config sc where  kb.kid=sc.siteid
			and  kb.status='正常缴费'
		
END		
		
GO
