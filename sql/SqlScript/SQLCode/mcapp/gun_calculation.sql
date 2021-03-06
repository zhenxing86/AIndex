USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[gun_calculation]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		yz
-- Create date: 2014-7-28
-- Description: 计算修正后的参数
-- =============================================
CREATE PROCEDURE [dbo].[gun_calculation]
@a float,
@b float,
@x1 float,
@y1 float,
@x2 float,
@y2 float,
@ta float,
@toe float

AS
BEGIN

	SET NOCOUNT ON;
select @ta ta,@toe toe,(@a - @b * cast(@ta as float) + cast(@toe as float))as toe1
  into #t 

select ta,
       toe,
       toe1,
       case when toe1 <= @y1 then toe1+@x1*(@y1-toe1) when toe1 >= @y2 then toe1+@x2*(@y2-toe1) else toe1 end as toe2
       into #p
       from #t

select ta,
       toe,
       toe1 AB修正后的toe,
       toe2 XY修正后的toe,
       CAST(-0.000125*POWER(toe2,6)
       +0.0283429488*POWER(toe2,5)
       -2.67004808*POWER(toe2,4)
       +133.762569*POWER(toe2,3)
       -3758.41829*POWER(toe2,2)
       +56155.4892*(toe2)
       -348548.755
       +toe2 as numeric(5,3))as tw
  
  from #p
  order by tw
  


  drop table #t,#p
END

GO
