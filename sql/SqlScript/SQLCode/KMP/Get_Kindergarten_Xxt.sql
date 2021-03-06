USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[Get_Kindergarten_Xxt]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<wuzy>
-- Create date: <2010-09-20>
-- Description:	<判断幼儿园是否是校讯通园>
-- =============================================
CREATE PROCEDURE [dbo].[Get_Kindergarten_Xxt]
@kid int
AS
	IF EXISTS(select * from T_Kindergarten where id=@kid AND (memo like '%校讯通%' or memo like '%园讯通%'))
	BEGIN
		RETURN (1)
	END
	ELSE
	BEGIN
		RETURN (0)
	END
GO
