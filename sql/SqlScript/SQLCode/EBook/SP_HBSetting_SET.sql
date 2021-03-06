USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[SP_HBSetting_SET]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<along>
-- Create date: <2011-06-23>
-- Description:	<hbsetting>
-- Example:SP_HBSetting_SET 58,1,'1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25' --按周
-- Example:SP_HBSetting_SET 961,2,'1,2,3,4,5,6,7,8,9,10,11,12' --按y
-- select * from hb_setting
-- =============================================
CREATE PROCEDURE [dbo].[SP_HBSetting_SET]
@kid int,
@celltype int,
@cellsetting nvarchar(100)
AS
BEGIN
	
	IF EXISTS(SELECT kid  FROM [HB_Setting] WHERE kid=@kid)
   BEGIN 
	
		UPDATE HB_Setting SET remarkcelltype=@celltype,remarkcellsetting=@cellsetting where kid=@kid
	
	END
	ELSE
	BEGIN
		INSERT INTO HB_Setting(kid,remarkcelltype,remarkcellsetting) values(@kid,@celltype,@cellsetting)
	END
END



GO
