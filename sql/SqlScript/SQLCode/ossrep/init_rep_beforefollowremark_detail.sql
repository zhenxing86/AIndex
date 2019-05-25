USE [ossrep]
GO
/****** Object:  StoredProcedure [dbo].[init_rep_beforefollowremark_detail]    Script Date: 2014/11/24 23:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[init_rep_beforefollowremark_detail]
 AS 

delete rep_beforefollowremark_detail

insert into rep_beforefollowremark_detail(bf_Id,kid,remindtime,remindtype,[uid],bid,intime)
select bf_Id,kid,remindtime,remindtype,[uid],bid,intime from ossapp..beforefollowremark b
left join ossapp..users u on u.ID=b.[uid] where b.deletetag=1



GO
