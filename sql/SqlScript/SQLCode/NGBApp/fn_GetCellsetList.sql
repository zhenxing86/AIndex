USE NGBApp
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-10-08  
-- Description: 函数用于返回幼儿表现的序号与周次（月份）对照表  
-- Paradef:   
-- Memo: 
SELECT * FROM [dbo].fn_GetCellsetList('2013-1',12511)  
*/   
ALTER function [dbo].fn_GetCellsetList(@term as varchar(6),@kid int)   
returns   @t   table(pos int, title varchar(20))     
as  
BEGIN  
	declare @celltype int, @cellset varchar(100), @maxpos int
	select @celltype = celltype, @cellset = cellset from dbo.fn_ModuleSet(@kid,@term)
	declare @temp table (pos int, col varchar(10))
	insert into @temp
	select * from  CommonFun..f_split(@cellset,',')
	select TOP(1) @maxpos = pos from @temp ORDER BY CAST(col AS INT) DESC
	insert into @t   
	select ROW_NUMBER()OVER(ORDER BY pos) - 1 as Pos,
			case when @celltype = 4 then CASE WHEN CAST(pos AS int) > @maxpos
					then CAST(CAST(LEFT(@term,4) AS INT) + 1 AS VARCHAR(10)) else LEFT(@term,4) end + '年' 
					ELSE '第' END 
		+ col 
		+ case when @celltype = 4 then '月' ELSE '周' END
	from @temp
	--where pos >= case when @celltype = 4 And right(@term,1)= '1' then 7 else 1 end  
	--and pos < case when @celltype = 4 And right(@term,1)= '0' then 7 else 99 end
 return  
END
GO
