USE [CardApp]
GO
/****** Object:  UserDefinedFunction [dbo].[f_split]    Script Date: 06/15/2013 17:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[f_split]
(
@s     varchar(8000),  --待分拆的字符串
@split varchar(10)     --数据分隔符
)returns table
as
 return
 (
  select Row_number()over(order by Number) rn ,
  substring(@s,number,charindex(@split,@s+@split,number)-number)as col
  from master..spt_values
  where type='p' and number<=len(@s+'a') 
  and charindex(@split,@split+@s,number)=number
  )
GO
