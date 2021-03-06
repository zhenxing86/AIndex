USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[addservice_vip_Excel_v2_GetListTag_out]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addservice_vip_Excel_v2_GetListTag_out]
 @page int
,@size int
,@kid int
,@intime datetime
 AS 


SELECT 
	u.[kid]    ,u.[cname],c.cname    ,[cuname]    ,[p1name]    ,[ftime]    ,[ltime]    ,replace(replace([ispay],'0','未'),'1','已')+'缴费'  [ispay]  ,replace(replace(isopen,'0','未'),'1','已')+'开通'  [isopen]    ,[paytime]    
    ,[intime]  
	 FROM [addservice_vip_Excel_v2] u 
	 inner join BasicData..[user] b on b.[name] =u.cuname 
	 inner join BasicData..user_class uc on b.userid=uc.userid
	 inner join BasicData..class c on c.cid=uc.cid
	where u.kid=@kid and convert(varchar(19),intime,120)= convert(varchar(19),@intime,120)
	and (u.cname<>c.cname or c.cname is null)
	 order by u.[cname] asc

GO
