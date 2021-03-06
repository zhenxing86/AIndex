USE [DrawApp]
GO
/****** Object:  StoredProcedure [dbo].[queryUser]    Script Date: 2014/11/24 23:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[queryUser] 
@uid int
AS

declare @usertype int

select @usertype=usertype from basicdata..[user] where userid=@uid

if(@usertype=0)
begin
  select b.[name],c.cname,c.kid from basicdata..user_class uc
inner join basicdata..class c on uc.cid=c.cid 
inner join basicdata..[user] b on b.userid=uc.userid 
where b.userid =@uid
end
else if(@usertype>0)
begin
select b.[name] as [name],'' as cname,b.kid 
from basicdata..[user] b 
where b.userid =@uid
end

GO
