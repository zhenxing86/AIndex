USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[GetClassInfoBykid]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[GetClassInfoBykid]
@kid int
,@gid int
as 

select distinct cid,cname from 
dbo.rep_classinfo where 
kid=@kid and (@gid=-1 or gradeid=@gid) 






GO
