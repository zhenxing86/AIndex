USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_right_GetModelByContentID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		lx
-- Create date: 2010-12-3
-- Description:	获取内容实体
-- =============================================
create PROCEDURE [dbo].[cms_content_right_GetModelByContentID]
@contentid int
AS
BEGIN
 select * from cms_content_right where contentid=@contentid
END


GO
