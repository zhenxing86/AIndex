USE [CommonFun]
GO
/****** Object:  UserDefinedFunction [dbo].[f_split]    Script Date: 08/19/2013 10:08:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER   function   [dbo].[f_split](@c   varchar(max),@split   varchar(2))   
returns   @t   table(pos int,col   varchar(20))   
as   
    begin   
    declare @pos int
    set @pos = 0 
      while(charindex(@split,@c)<>0)   
        begin
					set @pos +=  1     
          insert   @t(pos,col)   values   (@pos,substring(@c,1,charindex(@split,@c)-1))   
          set   @c   =   stuff(@c,1,charindex(@split,@c),'')   
        end
      set @pos +=  1       
      insert   @t(pos,col)   values   (@pos,@c)   
      return   
    end   

