USE [ClassApp]
GO
/****** Object:  UserDefinedFunction [dbo].[Get_StrArrayLength]    Script Date: 06/15/2013 15:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Get_StrArrayLength]
(
  @str varchar(5000),  --要分割的字符串
  @split varchar(10)  --分隔符号
)
returns int
as
begin

  declare @location int
  declare @start int
  declare @length int

  set @str=ltrim(rtrim(@str))
  set @location=charindex(@split,@str)
  set @length=1
  while @location<>0
  begin
    set @start=@location+1
    set @location=charindex(@split,@str,@start)
	set @length=@length+1
  end
  return @length
end
GO
