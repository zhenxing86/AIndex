USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_KinMasterMessage_GetModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[kmp_KinMasterMessage_GetModel]
@id int
AS
BEGIN
    SELECT [id],[kid],[content],[title],[createdate],[ip],[status],[username],[e_mail],[contractphone],[address],[parentid],[userid]
    FROM kmp..KinMasterMessage
    WHERE ID=@id
END

GO
