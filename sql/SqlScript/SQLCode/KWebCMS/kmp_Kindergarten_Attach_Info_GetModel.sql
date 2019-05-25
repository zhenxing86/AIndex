USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_Kindergarten_Attach_Info_GetModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[kmp_Kindergarten_Attach_Info_GetModel]
@kid int
AS
BEGIN
    SELECT [attach_info_id],[kid],[contractstatus],[customer_desc],[content_desc],[register_source],[real_source],[agent_desc],[reg_domain_datetime],[domain_price],[updatetime],[kinstatus]
    FROM ZGYEY_OM..Kindergarten_Attach_Info
    WHERE kid=@kid
END





GO
