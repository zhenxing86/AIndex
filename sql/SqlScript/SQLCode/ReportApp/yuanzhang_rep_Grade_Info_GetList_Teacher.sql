USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[yuanzhang_rep_Grade_Info_GetList_Teacher]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[yuanzhang_rep_Grade_Info_GetList_Teacher] 
@kid int
as 

	select grade,gname,c.cid,cname,COUNT(u.userid) 
		from BasicData..class c 
			inner join BasicData..grade g 
				on c.grade=g.gid
			inner join BasicData..user_class uc
				on uc.cid=c.cid
			left join BasicData..[user] u
				on uc.userid=u.userid 
					and u.usertype=1 
					and u.deletetag=1 
					and u.kid=@kid
			where c.kid=@kid
				  and c.deletetag=1
			group by grade,gname,c.cid,cname,g.[order],c.[order]
			order by g.[order],c.[order] desc
				   
	



GO
