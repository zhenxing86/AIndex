USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[BasicDataAreaGetList]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BasicDataAreaGetList]
@kid int
 AS 
declare @privince int
select @privince=privince from BasicData..kindergarten where kid=@kid

select ID,Title,Superior,[level],Code from BasicData..Area where ID=@privince or @privince=-1 or Superior=@privince



GO
