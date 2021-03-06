USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_GetEndDate]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  hanbin  
-- ALTER date: 2009-06-12  
-- Description: 获取网站截止日期  
-- =============================================  
CREATE PROCEDURE [dbo].[site_GetEndDate]  
@siteid int,  
@typeid int  
AS  
BEGIN  
 SELECT 'SiteID'=k.KID,'TypeID'=fee_type_id,Price,'EndDate'=k.expiretime,ActionDate,Comments   
 FROM  ossapp..kinbaseinfo k left join ZGYEY_OM..kindergarten_fee_detail  d on k.kid=d.kid and Fee_Type_ID=@typeid
 WHERE k.KID=@siteid  and k.deletetag=1
END  
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_GetEndDate', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
