USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[GetAllClassByKid]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllClassByKid]
@kid int
AS
BEGIN
select cid,cname from basicdata..class where kid=@kid
END







GO
