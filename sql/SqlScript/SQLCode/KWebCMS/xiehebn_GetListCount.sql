USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[xiehebn_GetListCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-03
-- Description:	分页获取
-- =============================================
create PROCEDURE [dbo].[xiehebn_GetListCount]
@sf nvarchar(50)
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) from xiehe_bn  where sf=@sf	
	RETURN @count

end





GO
