USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[config_manage_Update]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--GetList
------------------------------------
CREATE PROCEDURE [dbo].[config_manage_Update]
@id int,
@syn int
 AS 
 update [config_manage] set [syn]=@syn where id=@id







GO
