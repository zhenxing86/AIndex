USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[cardinfo_GetList_ByCard]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      xie      
-- Create date: 2013-11-05      
-- Description:   根据卡号精确查询卡号    
-- Memo:        
exec cardinfo_GetList_ByCard '1303001616'      
*/      
CREATE PROCEDURE [dbo].[cardinfo_GetList_ByCard]             
@cardno nvarchar(50)
 AS       
begin      
 select top 100 g.[cardno],udate,usest,cardtype,u.kid,k.kname,c.cname,u.name,  g.memo
 from [cardinfo] g       
 left join basicdata..[user] u 
	on u.userid=g.userid 
	and u.deletetag=1  
 left join basicdata..user_class uc
	on u.userid = uc.userid
left join basicdata..class c
	on uc.cid = c.cid
	and c.deletetag = 1
 left join BasicData..kindergarten k on k.kid=u.kid     
 where g.[cardno] = @cardno       
    
end 
GO
