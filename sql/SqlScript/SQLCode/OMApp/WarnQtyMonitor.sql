USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[WarnQtyMonitor]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-11-13
-- Description:	库存预警	对库存量少于指定值的物品提醒预警，提早采购准备
-- Memo:	
WarnQtyMonitor 12511
*/
--
CREATE PROC [dbo].[WarnQtyMonitor]
	@kid int
as
BEGIN
	SET NOCOUNT ON
	SELECT o.BarCode, o.Name, s.Title, ss.Title SubTitle, o.Qty, o.WarnQty 
		FROM Object_M o 
			inner join Sort s 
				on s.kid = o.kid 
				and s.SortCode = o.SortCode
			inner join SortSub ss
				on ss.kid = o.kid 
				and ss.SortCode = o.SortCode 
				and ss.SortSubCode = o.SortSubCode 
		where	o.kid = @kid
			and o.Qty < ISNULL(o.WarnQty,-1)
		order by o.BarCode

END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'库存监控报表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'WarnQtyMonitor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'WarnQtyMonitor', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
