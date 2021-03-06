USE [edu_jn]
GO
/****** Object:  UserDefinedFunction [dbo].[GetKinAreaStr_pid]    Script Date: 08/10/2013 10:16:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetKinAreaStr_pid]
(

  @area int
  ,@level int

)
returns int
as
begin

declare @areastr int,@sid int

if(@level=3)--获取本身
begin
select @areastr=ID from Area where ID=@area
end

if(@level=2)--获取第2级别，如果是第2级别，则不需要
begin
select @areastr=ID,@area=ID,@level=[Level],@sid=Superior from Area where ID=@area
if(@level=3)
begin
set @area=@sid
select @areastr=ID from Area where ID=@area
end
end


if(@level=1)--获取第1级别，如果是第1级别，则不需要
begin
select @area=Superior,@level=[Level] from Area where ID=@area

while(@level>2)
begin
select @area=Superior from Area where ID=@area
set @level=@level-1
end
select @areastr=ID from Area where ID=@area
end




return @areastr;
End
GO
