use NGBApp
go
/*      
-- Author:      Master谭      
-- Create date: 2013-10-08      
-- Description: 函数用于返回幼儿表现的序号与周次（月份）对照表      
-- Paradef:       
-- Memo:     
SELECT * FROM [dbo].fn_GetMonAdvList('2014-0',14468)      
*/       
alter function [dbo].fn_GetMonAdvList(@term as varchar(6),@kid int)       
returns   @t   table(pos int, title varchar(20), Years int, Months int)         
as      
BEGIN      
 declare @MonAdv varchar(100), @maxpos int    
 select  @MonAdv = Monadvset from dbo.fn_ModuleSet(@kid,@term)  --'3,4,5,6,7,8,9,10,11,12,1,2'   
 declare @temp table(pos int, col varchar(10))    
 insert into @temp    
 select * from  CommonFun..f_split(@MonAdv,',')    
 select TOP(1) @maxpos = pos from @temp ORDER BY CAST(col AS INT) DESC 
    
 --insert into @t       
 --select ROW_NUMBER()OVER(ORDER BY pos) - 1 as Pos,    
 --  CASE WHEN CAST(pos AS int) > @maxpos    
 --    then CAST(CAST(LEFT(@term,4) AS INT) + 1 AS VARCHAR(10)) else LEFT(@term,4) end + '年'     
     
 -- + col + '月', CASE WHEN CAST(pos AS int) > @maxpos    
 --    then CAST(CAST(LEFT(@term,4) AS INT) + 1 AS VARCHAR(10)) else LEFT(@term,4) end, col   
 --from @temp    
 --where pos >= case when right(@term,1)= '1' then 7 else 1 end      
 --and pos < case when right(@term,1)= '0' then 7 else 99 end 
  
  insert into @t  
  select ROW_NUMBER()OVER(ORDER BY pos) - 1 as Pos,    
   CASE WHEN CAST(pos AS int) > @maxpos    
     then CAST(CAST(LEFT(@term,4) AS INT) + 1 AS VARCHAR(10)) else LEFT(@term,4) end + '年'     
     
  + col + '月', CASE WHEN CAST(pos AS int) > @maxpos    
     then CAST(CAST(LEFT(@term,4) AS INT) + 1 AS VARCHAR(10)) else LEFT(@term,4) end, col   
 from @temp 
 where (col >= case when right(@term,1)= '1' then 9 else 1 end or col <= case when right(@term,1)= '1' then 2 else 1 end ) 
 and (col < case when right(@term,1)= '0' then 9 else 99 end and col > case when right(@term,1)= '0' then 2 else 0 end ) 
 return      
END 