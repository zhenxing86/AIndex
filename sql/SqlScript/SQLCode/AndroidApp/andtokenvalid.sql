USE [AndroidApp]
GO
/****** Object:  StoredProcedure [dbo].[AppConfig_AppList_GetListByKidAndUserType]    Script Date: 05/14/2013 14:59:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter PROCEDURE [dbo].[and_token_valid] 
@token varchar(100)
AS

if(exists(select top 1 * from AppLogs..mobile_user_tokens where token=@token and expiredatatime>GETDATE()))
begin
select 1
end
else
begin
select 0 
end
	
GO
[and_token_valid] '4CB4979A-07BE-489D-AEEF-B2ECAC651214'


select top 20 * from AppLogs..mobile_user_tokens where expiredatatime>GETDATE()
order by expiredatatime desc