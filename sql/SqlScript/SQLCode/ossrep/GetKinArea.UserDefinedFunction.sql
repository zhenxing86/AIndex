USE [ossrep]
GO
/****** Object:  UserDefinedFunction [dbo].[GetKinArea]    Script Date: 05/14/2013 14:55:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetKinArea]
(
  @privince int
  ,@city int
  ,@area int
  ,@residence int

)
returns int
as
begin

declare @areaid int
if(ISNUMERIC(@privince)=1 and @privince>0)
begin
set @areaid=@privince
end
if(ISNUMERIC(@city)=1 and @city>0)
begin
set @areaid=@city
end
if(ISNUMERIC(@area)=1 and @area>0)
begin
set @areaid=@area
end
if(ISNUMERIC(@residence)=1 and @residence>0)
begin
set @areaid=@residence
end


return @areaid;
End
GO
