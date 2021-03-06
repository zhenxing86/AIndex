USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[app_userpay_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------  
  --[app_userpay_GetModel] 781691,804,1
------------------------------------  
CREATE PROCEDURE [dbo].[app_userpay_GetModel]  
@userid int,  
@xid int,  
@termtype int=0  
 AS   
   
 select u.name,fee.ID feeid,case when a.id>0 then 1 else 0 end isopen  
 ,ROUND(fee.proxyprice,2) proxyprice from basicdata..[user] u 
 left join ossapp..addservice a on u.userid=a.[uid] and a.describe='开通' and a.deletetag=1
  outer apply   
  (select top 1 ID,proxyprice from   
   ossapp..feestandard f  
     where isproxy=1 and deletetag=1 and f.kid=u.kid)  
     as fee  
  where u.deletetag=1   
   and u.usertype=0   
   and u.userid=@userid   
   
GO
