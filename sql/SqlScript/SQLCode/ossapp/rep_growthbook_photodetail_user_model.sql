USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_growthbook_photodetail_user_model]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE  PROCEDURE [dbo].[rep_growthbook_photodetail_user_model]
@remarkid int
as
select remark from rep_growthbook_user_checked where ID=@remarkid



GO
