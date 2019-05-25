USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetThemeUse]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-09-07>
-- Description:	<Description,,模板使用统计>
-- =============================================
CREATE PROCEDURE [dbo].[GetThemeUse] 
	@sd nvarchar(30),
	@ed nvarchar(30)
AS
BEGIN
	SET NOCOUNT ON;
select 
	(select count(id) from t_kindergarten where theme = 'm1' and status =1 )as m1,
	(select count(id) from t_kindergarten where theme = 'm2' and status =1 )as m2,
	(select count(id) from t_kindergarten where theme = 'm3' and status =1) as m3,
	(select count(id) from t_kindergarten where theme = 'm4' and status =1) as m4,
	(select count(id) from t_kindergarten where theme = 'm5' and status =1) as m5,
	(select count(id) from t_kindergarten where theme = 'm6' and status =1) as m6,
	(select count(id) from t_kindergarten where theme = 'm7' and status =1) as m7,
	(select count(id) from t_kindergarten where theme = 'm8' and status =1) as m8,
	(select count(id) from t_kindergarten where theme = 'm9' and status =1) as m9,
	(select count(id) from t_kindergarten where theme = 'm10' and status =1) as m10,
	(select count(id) from t_kindergarten where theme = 'm11' and status =1) as m11,
	(select count(id) from t_kindergarten where theme = 'm12' and status =1) as m12,
	(select count(id) from t_kindergarten where theme = 'm13' and status =1) as m13,
(select count(id) from t_kindergarten where theme = 'm14' and status =1) as m14,
(select count(id) from t_kindergarten where theme = 'm15' and status =1) as m15,
(select count(id) from t_kindergarten where theme = 'm16' and status =1) as m16,
(select count(id) from t_kindergarten where theme = 'm17' and status =1) as m17,
(select count(id) from t_kindergarten where theme = 'm18' and status =1) as m18,
(select count(id) from t_kindergarten where theme = 'm19' and status =1) as m19,
(select count(id) from t_kindergarten where theme = 'm20' and status =1) as m20,
(select count(id) from t_kindergarten where theme = 'm21' and status =1) as m21,
(select count(id) from t_kindergarten where theme = 'm22' and status =1) as m22,
(select count(id) from t_kindergarten where theme = 'm23' and status =1) as m23,
(select count(id) from t_kindergarten where theme = 'm24' and status =1) as m24,
(select count(id) from t_kindergarten where theme = 'm25' and status =1) as m25,
(select count(id) from t_kindergarten where theme = 'm26' and status =1) as m26,
(select count(id) from t_kindergarten where theme = 'm27' and status =1) as m27,
(select count(id) from t_kindergarten where theme = 'm28' and status =1) as m28,
(select count(id) from t_kindergarten where theme = 'm29' and status =1) as m29,
(select count(id) from t_kindergarten where theme = 'm30' and status =1) as m30,
(select count(id) from t_kindergarten where theme = 'm31' and status =1) as m31,
(select count(id) from t_kindergarten where theme = 'm32' and status =1) as m32
END






GO
