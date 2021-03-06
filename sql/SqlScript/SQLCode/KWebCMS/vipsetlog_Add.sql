USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[vipsetlog_Add]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[vipsetlog_Add]
@userid int,
@startdate datetime,
@enddate datetime,
@dredgeStatus bit,
@operator int
AS
BEGIN
    INSERT INTO vipsetlog([userid],[startdate],[enddate],[actiondatetime],[dredgeStatus],operator)
    VALUES(@userid,@startdate,@enddate,GETDATE(),@dredgeStatus,@operator) 

    IF @@ERROR <> 0
    BEGIN
        RETURN 0
    END
    ELSE
    BEGIN
        RETURN @@IDENTITY
    END
END

GO
