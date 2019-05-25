USE CommonFun
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-04
-- Description:
函数用于将字符串拆分成表
 *参数说明：@string: 需要拆分的字符串
                格式为: 列1数据 @colseparator 列2数据 @colseparator ...列5数据 @rowseparator[...]
                特别说明：字符串的头和尾不要包含 @rowseparator 
 *          @rowseparator: 行分隔符
 *          @colseparator： 列分隔符
 *返回值：
    返数返回表结构(col1 varchar(), col2 varchar(), col3 varchar(), col4 varchar(), col5 varchar())
    各列长度以实际参数为准
 *限制：本函数仅支持最多5列，如果列数超出，则多出的列数据丢失
-- Memo:
  1: select col1,col2,col3,col4
	   from dbo.fn_MutiSplitTSQL('092-1350,099201-080901,12050720,2012-6-11$092-0970,099204-072301,12050734,2012-6-11','$',',')   
  2: select *
	   from dbo.fn_MutiSplitTSQL('092-1350,099201-080901,12050720,2012-6-11,ab,cd$092-0970,099204-072301,12050734,2012-6-11','$',',')   
*/
ALTER FUNCTION [dbo].[fn_MutiSplitTSQL]      
  (@string NVARCHAR(MAX), @rowseparator NvarCHAR(10) ,@colseparator NVARCHAR(10)= N',') RETURNS TABLE      
AS 
     
RETURN    
  select * 
    from (SELECT d.pos ,'col'+ cast( (n - LEN(REPLACE(LEFT(col, n), @colseparator, '')))/LEN(@colseparator) + 1 as varchar(10)) AS attribute,      
                 SUBSTRING(col, n, CHARINDEX(@colseparator, col + @colseparator, n) - n) AS value      
            FROM (select Row_number()over(order by n) pos ,  
                         substring(@string, n, charindex(@rowseparator,@string+@rowseparator,n)-n)as col  
                    from Nums1w  
                    where n<=len(@string+'a') and charindex(@rowseparator,@rowseparator+@string,n)=n  
                 ) AS D      
           JOIN Nums1w a ON  n<=len(col+'a') and charindex(@colseparator,@colseparator+col,n)=n   
          ) as d    
    PIVOT(max(value) FOR attribute     
      IN(col1,col2 ,col3,col4,col5 )) AS P      
      

GO


select *
	   from dbo.fn_MutiSplitTSQL('092-1350,099201-080901,12050720,2012-6-11$092-0970,099204-072301,12050734,2012-6-11','$',',')   
select *
	   from dbo.fn_MutiSplitTSQL('092-1350##&099201-080901##&12050720##&2012-6-11$&$&092-0970##&099204-072301##&12050734##&2012-6-11','$&$&','##&')   
GO