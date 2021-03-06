USE [KWebCMS]
GO
/****** Object:  UserDefinedFunction [dbo].[SpitString]    Script Date: 05/14/2013 14:43:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[SpitString] 
( 
@string nvarchar(500),--被分的字符串
@sp nvarchar(100) --分隔符
) 
RETURNS 
@_strings TABLE 
( 
id int, 
string int,
inx int,
str1 nvarchar(65) 
) 
AS 
BEGIN 
declare @count int --计数
set @count=0 
declare @index int 
declare @one nvarchar(64)--取下来的一节
set @index=Charindex(@sp,@string) 
while(@index>0) 
begin 
set @one=left(@string,@index-1) 
set @count=@count+1
insert into @_strings (id,string,inx,str1) values(@count,@one,@index,@string) 
set @string=right(@string,len(@string)-@index) 
set @index=Charindex(@sp,@string) 
end 
insert into @_strings (id,string,inx,str1) values(@count+1,@string,@index,@one) 
RETURN 
END
GO
