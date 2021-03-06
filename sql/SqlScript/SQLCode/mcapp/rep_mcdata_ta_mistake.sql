USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_ta_mistake]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：晨检枪测出ta为0
--项目名称：rep_mcdata_ta_mistake
--时间：2013-11-23
--作者：yz
------------------------------------

--exec [mcapp].[dbo].[rep_mcdata_ta_mistake]

create PROCEDURE [dbo].[rep_mcdata_ta_mistake]

AS 
BEGIN

select r.kid,k.kname as 名称 from mcapp..stu_mc_day_raw r
   inner join BasicData..kindergarten k
      on r.kid = k.kid
 where ISNUMERIC(ta) = 1
   and ISNUMERIC(toe) = 1 
   and CAST(ta as numeric(6,2))= 0
   and CAST(toe as numeric(6,2))> 0
   
 group by r.kid,k.kname
 
end
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'环境温度出错统计' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_mcdata_ta_mistake'
GO
