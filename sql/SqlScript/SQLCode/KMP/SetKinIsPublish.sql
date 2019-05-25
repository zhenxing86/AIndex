USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SetKinIsPublish]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,幼儿园发布>
-- =============================================
CREATE PROCEDURE [dbo].[SetKinIsPublish] 
	@KID nvarchar(50)
AS
BEGIN
declare @status int
	select @status=ispublish from t_kindergarten where id = @KID
if (@status=0)
begin
	update t_kindergarten set ispublish = 1 where id = @KID
end
else if (@status=1)
begin
    update t_kindergarten set ispublish = 0 where id = @KID
end
END

GO
