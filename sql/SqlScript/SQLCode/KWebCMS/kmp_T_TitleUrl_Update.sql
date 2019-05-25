USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_T_TitleUrl_Update]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[kmp_T_TitleUrl_Update]
@ID int,
@Kid int,
@PhotoUrl nvarchar(200)='',
@Url nvarchar(200)='',
@Title nvarchar(200)='',
@Type int,
@OrderNo int,
@color varchar(20)='',
@addtime datetime
AS
BEGIN
    UPDATE zgyey_om..T_TitleUrl
    SET Kid=@Kid,PhotoUrl=@PhotoUrl,Url=@Url,Title=@Title,Type=@Type,OrderNo=@OrderNo,color=@color,createdate=@addtime
    WHERE ID=@ID

    IF @@ERROR <> 0
    BEGIN
        RETURN 0
    END
    ELSE
    BEGIN
        RETURN 1
    END
END



GO
