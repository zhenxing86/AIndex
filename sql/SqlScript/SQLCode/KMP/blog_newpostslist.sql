USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[blog_newpostslist]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,取博客最新>
-- =============================================
create PROCEDURE [dbo].[blog_newpostslist] 

AS
BEGIN
	exec blog..blog_newpost

END





GO
