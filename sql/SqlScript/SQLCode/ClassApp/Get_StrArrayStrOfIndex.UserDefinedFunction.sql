USE [ClassApp]
GO
/****** Object:  UserDefinedFunction [dbo].[Get_StrArrayStrOfIndex]    Script Date: 06/15/2013 15:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Get_StrArrayStrOfIndex]
(
  @str varchar(5000),  --要分割的字符串
  @split varchar(10),  --分隔符号
  @index int --取第几个元素
)
returns varchar(5000)
as
begin
  declare @location int
  declare @start int
  declare @next int
  declare @seed int

  set @str=ltrim(rtrim(@str))
  set @start=1
  set @next=1
  set @seed=len(@split)
 
  set @location=charindex(@split,@str)
  while @location<>0 and @index>@next
  begin
    set @start=@location+@seed
    set @location=charindex(@split,@str,@start)
    set @next=@next+1
  end
  if @location =0 select @location =len(@str)+1
 --这儿存在两种情况：1、字符串不存在分隔符号 2、字符串中存在分隔符号，跳出while循环后，@location为0，那默认为字符串后边有一个分隔符号。
  return substring(@str,@start,@location-@start)
end
GO
