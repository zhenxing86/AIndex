USE CommonFun
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-10-18
-- Description:	获取EAN-13码的检验位
-- Memo:		EAN-13商品条码中的校验符的作用是检验前面12个数字是否正确，在条码机每次读入数据时，都会计算一次数据符的校验并与校验符进行比对。
    校验符的计算方法：
    将12个数据符从左起将所有的奇数位相加得出一个数a，
    将所有的偶数位相加得出一个数b，
    然后将数b乘以3再与a相加得到数c，
    用10减去数c的个位数，
    如果结果不为10则检验符为结果本身，如果为10则检验符为0
*/
create function EAN13(@s char(12))  
returns varchar(1)  
as  
begin  
  return (10-(  
  (cast(substring(@s,2,1) as int)+substring(@s,4,1)+substring(@s,6,1)  
   +substring(@s,8,1)+substring(@s,10,1)+substring(@s,12,1)  
   )*3  
  +substring(@s,1,1)+substring(@s,3,1)+substring(@s,5,1)  
  +substring(@s,7,1)+substring(@s,9,1)+substring(@s,11,1)  
  )%10)%10    
end  
go  
  
  
--select dbo.ean13('690102807501')  
