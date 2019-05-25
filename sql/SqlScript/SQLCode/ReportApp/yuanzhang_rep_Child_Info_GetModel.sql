USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[yuanzhang_rep_Child_Info_GetModel]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[yuanzhang_rep_Child_Info_GetModel] 12511,295765
CREATE PROCEDURE [dbo].[yuanzhang_rep_Child_Info_GetModel] 
@kid int,
@userid int
as 

	select u.userid,u.[name],u.gender,u.mobile,commonfun.dbo.fn_age(u.birthday),CONVERT(varchar(10),u.birthday,120) from BasicData..class c
			inner join BasicData..user_class uc 
				on uc.cid=c.cid
			inner join BasicData..[user] u 
				on u.userid=uc.userid 
			where c.kid=@kid 
				and uc.userid=@userid
				and c.deletetag=1
				and u.deletetag=1
		


GO
