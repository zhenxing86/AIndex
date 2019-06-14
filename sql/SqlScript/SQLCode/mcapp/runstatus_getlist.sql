USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[runstatus_getlist]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		yz
-- Create date: 心跳监控
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[runstatus_getlist]
  @bgndate date,
  @enddate date,
  @kid int
AS
BEGIN
	SET NOCOUNT ON;
	select * from mcapp..runstatus
	where adate >= CONVERT(VARCHAR(10),@bgndate,120)  
    and adate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)  
    and kid = @kid
END

GO
