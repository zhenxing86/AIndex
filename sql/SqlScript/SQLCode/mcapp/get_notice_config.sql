USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[get_notice_config]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[get_notice_config]
@kid int
 AS 

select contents,outtime from  notice_config
where kid=@kid and outtime>=getdate()


GO
