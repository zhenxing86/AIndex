USE CommonFun
GO
/****** Object:  UserDefinedFunction [dbo].[f_split]    Script Date: 08/16/2013 16:58:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER   function   [dbo].[fn_MutiSplitTSQL_New]      
  (@s NVARCHAR(MAX), @rowseparator NVARCHAR(10) ,@colseparator NVARCHAR(10)= N',')
returns   @t   table(pos int, col1   varchar(100), col2   varchar(100), col3   varchar(100), col4   varchar(100), col5   varchar(100))   
as   
    begin   
  declare @t1  table(pos int, col   varchar(100))
  DECLARE @I INT = 0
      while(charindex(@rowseparator,@s)<>0)   
        begin  
					SET @I = @I + 1 
          insert   @t1(pos, col)   values   (@I, substring(@s,1,charindex(@rowseparator,@s)-1))   
        --  set   @s   =   stuff(@s,1,charindex(@rowseparator,@s),'')   
           set   @s   =   stuff(@s,1,charindex(@rowseparator,@s)+LEN(@rowseparator)-1,'')   
        end
      SET @I = @I + 1    
      insert   @t1(pos, col)   values   (@I,@s)   
      insert into @t(pos, col1)    
      select pos, case when charindex(@colseparator,col)<>0 then substring(col,1,charindex(@colseparator,col)-1) else col end
				from @t1

      update @t1 set col = stuff(col,1,charindex(@colseparator,col)+LEN(@colseparator)-1,'')
      UPDATE @t SET col2 = case when charindex(@colseparator,col)<>0 then substring(col,1,charindex(@colseparator,col)-1) else col end
      from @t t inner join @t1 t1 on t.pos = t1.pos      

      update @t1 set col = stuff(col,1,charindex(@colseparator,col)+LEN(@colseparator)-1,'')
      UPDATE @t SET col3 = case when charindex(@colseparator,col)<>0 then substring(col,1,charindex(@colseparator,col)-1) else col end
      from @t t inner join @t1 t1 on t.pos = t1.pos      


      update @t1 set col = stuff(col,1,charindex(@colseparator,col)+LEN(@colseparator)-1,'')
      UPDATE @t SET col4 = case when charindex(@colseparator,col)<>0 then substring(col,1,charindex(@colseparator,col)-1) else col end
      from @t t inner join @t1 t1 on t.pos = t1.pos

      update @t1 set col = stuff(col,1,charindex(@colseparator,col)+LEN(@colseparator)-1,'')
      UPDATE @t SET col5 = case when charindex(@colseparator,col)<>0 then substring(col,1,charindex(@colseparator,col)-1) else col end
      from @t t inner join @t1 t1 on t.pos = t1.pos


      
      return   
    end   
GO
--stuff(col,1,charindex(@colseparator,col)+LEN(@colseparator)-1,'') 
select *
	   from dbo.[fn_MutiSplitTSQL_New]('092-1350,099201-080901,12050720,2012-6-11$092-0970,099204-072301,12050734,2012-6-11','$',',')   
select *
	   from dbo.[fn_MutiSplitTSQL_New]('092-1350##&099201-080901##&12050720##&2012-6-11
	   $$&092-0970##&099204-072301##&12050734##&2012-6-11','$$&','##&')   
