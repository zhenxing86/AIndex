USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[gartenlist_byxz_Update]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gartenlist_byxz_Update] 
@kid int
,@byxz nvarchar(300)
,@bylx nvarchar(300)
AS
BEGIN

update dbo.gartenlist set byxz=@byxz,bylx=@bylx where kid=@kid

END

GO
