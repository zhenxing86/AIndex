USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinfollow_UpdateStatus_End]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[kinfollow_UpdateStatus_End]
@id int,
@fuid int
 AS 
	update  [kinfollow] set status='已结束',ctime=getdate()
	 WHERE ID=@id and uid=@fuid

	update [remindlog] set deletetag=0 where rid=@id and result='待结束'


GO
