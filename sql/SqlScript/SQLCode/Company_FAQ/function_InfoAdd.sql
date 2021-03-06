USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[function_InfoAdd]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-5-5
-- Description:	管理层填写修改功能的基本信息
-- =============================================
CREATE PROCEDURE [dbo].[function_InfoAdd]
   (
        @funContent text,  --修改功能描述
        @personID int, --主要负责人姓名
        @changeDate datetime,--项目修改启动时间
        @remark nvarchar(1000)--备注
  ) 
AS
INSERT INTO 
     functionChangeTracking
       (funContent,personID,changeDate,remark,trackStatus,status)
   VALUES
     (@funContent,@personID,@changeDate,@remark,0,1)
RETURN @@IDENTITY


GO
