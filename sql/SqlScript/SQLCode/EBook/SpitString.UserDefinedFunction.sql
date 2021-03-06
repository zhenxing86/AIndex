USE [EBook]
GO
/****** Object:  UserDefinedFunction [dbo].[SpitString]    Script Date: 05/14/2013 14:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SpitString] 
( 
@string nvarchar(4000),--被分的字符串
@sp nvarchar(100) --分隔符
) 
RETURNS 
@_strings TABLE 
( 
id int, 
string nvarchar(500),
inx int
) 
AS 
BEGIN 
declare @count int --计数
set @count=0 
declare @index int 
declare @one nvarchar(500)--取下来的一节
set @index=Charindex(@sp,@string) 
while(@index>0) 
begin 
set @one=left(@string,@index-1) 
set @count=@count+1
insert into @_strings (id,string,inx) values(@count,@one,@index) 
set @string=right(@string,len(@string)-@index) 
set @index=Charindex(@sp,@string) 
end 
insert into @_strings (id,string,inx) values(@count+1,@string,@index) 
RETURN 
END
GO
