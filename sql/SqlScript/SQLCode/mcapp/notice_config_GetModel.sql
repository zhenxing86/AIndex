USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[notice_config_GetModel]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[notice_config_GetModel]
@kid int
 AS 

select kid,contents,outtime from  notice_config
where kid=@kid 


GO
