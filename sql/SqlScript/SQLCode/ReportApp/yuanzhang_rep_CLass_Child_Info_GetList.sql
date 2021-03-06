USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[yuanzhang_rep_CLass_Child_Info_GetList]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[yuanzhang_rep_CLass_Child_Info_GetList]
@kid int,
@userid int=0
as 



    if(CommonFun.dbo.[fn_KWebCMS_Right_max](@userid)<=2)
    begin
    
    select cid into #cids from BasicData..user_class where userid=@userid
    
    
    select c.cname,u.userid,u.[name],u.gender,u.mobile,commonfun.dbo.fn_age(u.birthday) age,c.cid,CONVERT(varchar(10),u.birthday,120)
	 from BasicData..class c
			inner join BasicData..user_class uc 
				on uc.cid=c.cid
			inner join #cids s on s.cid=c.cid
			inner join BasicData..grade g
				on g.gid=c.grade
			inner join BasicData..[user] u 
				on u.userid=uc.userid 
			where u.kid=@kid 
				and c.deletetag=1
				and u.deletetag=1
				and u.usertype=0
				order by g.[order] asc,c.[order] desc
    
    
    drop table #cids
    end
    else
    begin
    
	select c.cname,u.userid,u.[name],u.gender,u.mobile,commonfun.dbo.fn_age(u.birthday) age,c.cid,CONVERT(varchar(10),u.birthday,120)
	 from BasicData..class c
			inner join BasicData..user_class uc 
				on uc.cid=c.cid
			inner join BasicData..grade g
				on g.gid=c.grade
			inner join BasicData..[user] u 
				on u.userid=uc.userid 
			where u.kid=@kid 
				and c.deletetag=1
				and u.deletetag=1
				and u.usertype=0
				order by g.[order] asc,c.[order] desc
    
    end




		


GO
