USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mc_child_update]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:yz	
-- Create date: 2014-9-13
-- Description:晨检报表数据上传报告
--[mcapp].[dbo].[rep_mc_child_update] 14210,'2014-10-21'
-- =============================================
CREATE PROCEDURE [dbo].[rep_mc_child_update]
  @kid int,
  @cdate date
AS
BEGIN
	SET NOCOUNT ON;
	declare @sum int = (select COUNT(distinct serialno) from mcapp..tcf_setting where kid = @kid)
	
	
	--是否提示
	if  exists( select ID from mcapp..stu_mc_day
               where kid = @kid
	               and cdate < CONVERT(VARCHAR(10),@cdate,120)
	               and adate >= CONVERT(VARCHAR(10),@cdate,120)
                 and adate < CONVERT(VARCHAR(10),DATEADD(DD,1,@cdate),120))
                 
   begin
      select '温馨提示：今日晨检数据中，存在往日未及时上传的数据。为了提供更准确的晨检报表，请您及时上传晨检数据。'tip
   end
	
	 else
	 
	 begin
      select ''tip
   end
	 
	
	--本园共有gun_sum只晨检枪，本日有gun_update只晨检枪上传了数据
	select @sum as gun_sum,  
	       COUNT(distinct r.gunid) as gun_update
	  from mcapp..stu_mc_day r
	  where r.kid = @kid
	    and r.adate >= CONVERT(VARCHAR(10),@cdate,120)
      and r.adate < CONVERT(VARCHAR(10),DATEADD(DD,1,@cdate),120)
      and r.gunid not in ('00','')
      
  
  
END

GO
