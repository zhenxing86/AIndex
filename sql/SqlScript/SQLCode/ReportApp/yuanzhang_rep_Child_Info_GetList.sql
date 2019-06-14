USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[yuanzhang_rep_Child_Info_GetList]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[yuanzhang_rep_Child_Info_GetList] 12511,46144
CREATE PROCEDURE [dbo].[yuanzhang_rep_Child_Info_GetList] 
@kid int,
@cid int
as 

	select u.userid,u.[name],u.gender,u.mobile,commonfun.dbo.fn_age(u.birthday),CONVERT(varchar(10),u.birthday,120)
	,u.headpic, u.headpicupdate
	 from BasicData..class c
			inner join BasicData..user_class uc 
				on uc.cid=c.cid
			inner join BasicData..[user] u 
				on u.userid=uc.userid 
			where u.kid=@kid 
				and c.cid=@cid
				and c.deletetag=1
				and u.deletetag=1
				and u.usertype=0
		


GO
