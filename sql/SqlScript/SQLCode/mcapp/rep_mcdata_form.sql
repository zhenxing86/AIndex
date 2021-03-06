USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_form]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：参数修改公式
--项目名称：rep_mcdata_form
--时间：2013-11-23
--作者：yz
------------------------------------

CREATE PROCEDURE [dbo].[rep_mcdata_form]
--exec [mcapp].[dbo].[rep_mcdata_form] 34.90,26.40,0.22
@toe float,
@ta float,
@b float

AS
BEGIN 

set @toe = @toe + 25*@b +0.7 - @b*@ta

select -0.000125*POWER(@toe,6)
       +0.0283429488*POWER(@toe,5)
       -2.67004808*POWER(@toe,4)
       +133.762569*POWER(@toe,3)
       -3758.41829*POWER(@toe,2)
       +56155.4892*@toe
       -348548.755
       +@toe as ta
       
END
       
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'参数计算用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_mcdata_form'
GO
