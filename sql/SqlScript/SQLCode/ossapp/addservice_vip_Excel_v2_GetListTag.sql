USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[addservice_vip_Excel_v2_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--addservice_vip_Excel_v2_GetListTag
------------------------------------
CREATE PROCEDURE [dbo].[addservice_vip_Excel_v2_GetListTag]
 @page int
,@size int
,@kid int
,@intime datetime
 AS 


select distinct 1,[ID] ,u.[kid],u.[cname],[cuname],[p1name],[ftime],[ltime],
	   [ispay],[isopen],[paytime],[isproxy],[uid],[intime],c.cname,
	   (
		   select COUNT(1)  
		   from BasicData..[user] ub 
				inner join BasicData..user_class uc on ub.userid=uc.userid 
				inner join BasicData..class c on c.cid=uc.cid 
			where ub.name=[cuname] and c.kid=u.kid and ub.kid=@kid
	   ),--名字存在
	   (
		   select COUNT(1) 
		   from BasicData..[user] ub 
				inner join BasicData..user_class uc on ub.userid=uc.userid 
				inner join BasicData..class c on c.cid=uc.cid 
			where ub.name=[cuname] and c.kid=u.kid and c.cname=u.[cname] and ub.kid=@kid
	   ) --同名同班
	   FROM [addservice_vip_Excel_v2] u 
	   outer apply (
	     select cname=cname 
				from BasicData..[user] b
				 inner join BasicData..user_class uc on b.userid=uc.userid 
				 inner join BasicData..class c on c.cid=uc.cid 
				 inner join BasicData..[user] r on r.userid=uc.userid 
				 where  
					 b.[name] =u.cuname 
					 and r.deletetag=1 
					 and r.usertype=0
					 and c.deletetag=1
					 and c.cname=u.[cname]
					 and b.kid=@kid
		) as c
	   where 
		   u.kid=@kid 
		   and convert(varchar(19),intime,120)= convert(varchar(19),@intime,120)
	   order by u.[cname],u.cuname asc
	 


	 

GO
