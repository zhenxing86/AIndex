USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_offline_list]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rep_offline_list]
@offftime datetime
,@offltime datetime
,@kid int
,@kname varchar(100)
 AS 

select kid,'' kname,offtime,reason,remark from offline



GO
