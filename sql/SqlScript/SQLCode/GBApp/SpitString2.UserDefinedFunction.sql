USE [GBApp]
GO
/****** Object:  UserDefinedFunction [dbo].[SpitString2]    Script Date: 05/14/2013 14:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SpitString2] 
( 
@string1 varchar(max),--被分的字符串1
@string2 varchar(max),--被分的字符串2
@sp nvarchar(100) --分隔符
) 
RETURNS 
@_strings TABLE 
( 
id int, 
string1 varchar(max),
string2 varchar(max),
inx int
) 
AS
BEGIN 
declare @count int --计数
set @count=0 
declare @index int 
declare @index2 int
declare @one varchar(max)--取下来的一节
declare @two varchar(max)--取下来的一节
set @index=Charindex(@sp,@string1) 
set @index2=Charindex(@sp,@string2)
while(@index>0) 
begin 
	set @one=left(@string1,@index-1) 
	set @two=left(@string2,@index2-1)		
	set @count=@count+1	
	insert into @_strings (id,string1,string2,inx) values(@count,@one,@two,@index) 
	set @string1=right(@string1,len(@string1)-@index) 
	set @string2=right(@string2,len(@string2)-@index2) 
	set @index=Charindex(@sp,@string1) 
	set @index2=Charindex(@sp,@string2)
end 
	insert into @_strings (id,string1,string2,inx) values(@count+1,@string1,@string2,@index) 
RETURN 
END
GO
