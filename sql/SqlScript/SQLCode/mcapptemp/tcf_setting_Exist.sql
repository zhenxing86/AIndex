USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[tcf_setting_Exist]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		xzx
-- Project: com.zgyey.ossapp
-- Create date: 2013-07-22
-- Description: 判断是否已经存在晨检枪参数设备信息实体
-- =============================================
CREATE PROCEDURE [dbo].[tcf_setting_Exist]
@id int
,@serialno	varchar(50)
AS
BEGIN

if exists (
	SELECT 1
	  FROM [mcapp].[dbo].[tcf_setting]
	  where serialno =@serialno and id <>@id
	  )
	  begin
		select '1'
	  end
	  else
	  begin
		select '0'
	  end

END




GO
