USE [GroupApp]
GO
/****** Object:  UserDefinedFunction [dbo].[FUN_GetAge]    Script Date: 08/10/2013 09:54:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    function [dbo].[FUN_GetAge]
(
   @birthday datetime  --出生日期
)
returns int
as
begin

declare @today datetime
set @today=getdate()

    if @birthday > @today
    begin
        return 0;
    end    
    
    declare @age int
    
    select @age = datediff(year, @birthday, @today)--年份差值

    if datepart(month, @today) > datepart(month, @birthday)--月份超过
    begin
        select  @age = @age + 1
    end

    if datepart(month, @today) = datepart(month, @birthday)--月份一样
    begin
        if datepart(day, @today) >= datepart(day, @birthday)--日超过
        begin
            select  @age = @age + 1
        end
    end
	if(@age is null or @age>100)
begin 
set @age=0
end
    return @age ;
End
GO
