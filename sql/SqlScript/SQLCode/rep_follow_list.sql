USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_follow_list]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rep_follow_list]
@followftime datetime
,@followltime datetime
,@follower varchar(100)
 AS 

select '' 每月跟进幼儿园数,'' 幼儿园收费数,'' 明确拒绝数,'' 联系不上数,'' 待跟进数


GO
