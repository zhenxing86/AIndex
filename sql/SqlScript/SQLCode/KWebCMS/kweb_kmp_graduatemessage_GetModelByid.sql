USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_kmp_graduatemessage_GetModelByid]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		lx
-- Create date: 10-8-27
-- Description:	创建
-- =============================================
CREATE PROCEDURE [dbo].[kweb_kmp_graduatemessage_GetModelByid]
@id int
as
BEGIN
   select * from  kmp..GraduateMessage where id=@id
END

GO
