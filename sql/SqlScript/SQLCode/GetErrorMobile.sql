USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[GetErrorMobile]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetErrorMobile]  
@status varchar(100)  
as  
Set Nocount On   

if(@status <> '')  
begin  
  Select kid, kname, status, name, userid, name, mobile, cname  
    From ossapp.dbo.error_mobile
    Where status=@status and Isnull(linkstate,'') <> '演示网站'
    Order by kid, userid  
end
else  
begin  
  Select kid, kname, status, name, userid, name, mobile, cname  
    From ossapp.dbo.error_mobile
    Where Isnull(linkstate,'') <> '演示网站'
    Order by kid, userid  
end  



GO
