USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[OrgJudge]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[OrgJudge]
@org_name nvarchar(30)
as
begin
declare @result int
     select @result=org_id from sac_org 
       where org_name=@org_name
if @result>0
return @result
else
return -1
end



GO
