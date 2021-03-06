USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[site_domain_Default]    Script Date: 05/14/2013 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter PROCEDURE [dbo].[site_domain_Default]
@siteid int,
@domain varchar(300)
as

declare @net_old varchar(100)  
select @net_old=netaddress from [kinbaseinfo] where kid=@siteid  
IF EXISTS(SELECT top 1 * FROM KWebCMS..site_domain WHERE domain=@net_old and siteid=@siteid)  
 BEGIN  
  update KWebCMS..[site_domain] set domain=@domain  
  WHERE siteid=@siteid and domain=@net_old  
 END   
 ELSE  
 BEGIN  
  insert into KWebCMS..[site_domain](siteid,domain)  
  values(@siteid,@domain)  
 end  
   
 update Kwebcms..[site] set  sitedns=@domain where siteid=@siteid
 
 update kinbaseinfo set netaddress=@domain where kid=@siteid  

GO
