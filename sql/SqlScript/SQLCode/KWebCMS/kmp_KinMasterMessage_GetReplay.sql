USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_KinMasterMessage_GetReplay]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
-- =============================================  
-- Author:  xie
-- Create date: 2013-11-01  
-- Description: 查询园长信息回复  
/*
memo: 
exec kmp_KinMasterMessage_GetReplay 23421,123
*/
-- =============================================  
CREATE PROCEDURE [dbo].[kmp_KinMasterMessage_GetReplay]  
 @parentid int,@userid int  
AS  
BEGIN  
select * from kmp..KinMasterMessage where parentid=@parentid and userid=@userid  
END  

GO
