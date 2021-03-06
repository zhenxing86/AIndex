USE [BasicData]
GO
/****** Object:  UserDefinedFunction [dbo].[f_split]    Script Date: 05/14/2013 14:36:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   function   [dbo].[f_split](@c   varchar(2000),@split   varchar(2))   
returns   @t   table(col   varchar(20))   
as   
    begin   
    
      while(charindex(@split,@c)<>0)   
        begin   
          insert   @t(col)   values   (substring(@c,1,charindex(@split,@c)-1))   
          set   @c   =   stuff(@c,1,charindex(@split,@c),'')   
        end   
      insert   @t(col)   values   (@c)   
      return   
    end
GO
