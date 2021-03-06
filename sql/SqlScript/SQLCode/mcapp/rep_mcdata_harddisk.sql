USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_harddisk]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rep_mcdata_harddisk] 
@kid int,  
@bgndate date,
@enddate date

AS     
begin 
 select logid,devid,gunid,logmsg,result,logtime,uploadtime,kid
 from
  mcapp..loginfo 
  where logtype = 16
  and kid = @kid
  and logtime >= CONVERT(VARCHAR(10),@bgndate,120)
  and logtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
 
end 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'一体机硬盘空间检测' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_mcdata_harddisk'
GO
