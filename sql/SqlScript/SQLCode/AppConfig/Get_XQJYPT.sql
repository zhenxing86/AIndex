CREATE  PROCEDURE [dbo].[Get_XQJYPT]
@kid int
 AS 

	declare @returnvalue int
	
	select @returnvalue = COUNT(1) 
		from dbo.admin_app 
			where appid=45 and kid=@kid
	
	
	return @returnvalue
GO