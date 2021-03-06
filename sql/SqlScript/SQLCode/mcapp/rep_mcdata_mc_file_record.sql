USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_mc_file_record]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:yz
-- Create date:2014-10-19
-- Description:	晨检文件记录
--[mcapp].[dbo].[rep_mcdata_mc_file_record] 12511,'2014-10-28', '2014-10-28'
-- =============================================
CREATE PROCEDURE [dbo].[rep_mcdata_mc_file_record] 
  @kid int,
  @bgndate date,
  @enddate date
  
AS
BEGIN

	SET NOCOUNT ON;
  
  select * from mcapp..mc_file_record f
  where f.kid = @kid
    and f.crtdate >= CONVERT(VARCHAR(10),@bgndate,120)
    and f.crtdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
  
  
END

GO
