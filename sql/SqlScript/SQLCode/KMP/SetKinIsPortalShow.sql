USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SetKinIsPortalShow]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,幼儿园是否在门户显示>
-- =============================================
CREATE PROCEDURE [dbo].[SetKinIsPortalShow] 
	@KID nvarchar(50)
AS
BEGIN
declare @status int
	select @status=isportalshow from t_kindergarten where id = @KID
if (@status=0)
begin
	update t_kindergarten set isportalshow = 1 where id = @KID
end
else if (@status=1)
begin
    update t_kindergarten set isportalshow = 0 where id = @KID
end
END

GO
