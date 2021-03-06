USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[teainfo_GetModel]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[teainfo_GetModel]
	@id int
 AS 
BEGIN
	SELECT	1,u.userid teaid, c.cardno card, u.name, u.tts, 
					CASE WHEN u.gender = 2 then '女' ELSE '男' END sex, 
					u.mobile tel, u.headpic tpic, CAST(NULL AS INT)syntag
	   FROM BasicData..[user] u
			left join cardinfo c
				on u.userid = c.userid
	 WHERE u.userid=@id
END

GO
