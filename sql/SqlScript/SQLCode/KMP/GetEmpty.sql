USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetEmpty]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,最新加入幼儿园报表>
-- =============================================
create PROCEDURE [dbo].[GetEmpty] 
	@sd nvarchar(30),
	@ed nvarchar(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select '找不到所需要的报表,请联系管理员' as 提示
END
GO
