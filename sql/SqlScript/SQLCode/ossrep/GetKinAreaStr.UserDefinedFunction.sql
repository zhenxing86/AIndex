USE [ossrep]
GO
/****** Object:  UserDefinedFunction [dbo].[GetKinAreaStr]    Script Date: 05/14/2013 14:55:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetKinAreaStr]
(

  @area int
  ,@level int

)
returns nvarchar(30)
as
begin



declare @areastr nvarchar(30),@sid int

if(@level=3)--获取本身
begin
select @areastr=Title from BasicData..Area where ID=@area
end

if(@level=2)--获取第2级别，如果是第2级别，则不需要
begin
select @areastr=Title,@area=ID,@level=[Level],@sid=Superior from BasicData..Area where ID=@area
if(@level=3)
begin
set @area=@sid
select @areastr=Title from BasicData..Area where ID=@area
end
end


if(@level=1)--获取第1级别，如果是第1级别，则不需要
begin
select @area=Superior,@level=[Level] from BasicData..Area where ID=@area

while(@level>2)
begin
select @area=Superior from BasicData..Area where ID=@area
set @level=@level-1
end
select @areastr=Title from BasicData..Area where ID=@area
end


if(@level=0)--获取第1级别，如果是第1级别，则不需要
begin
select @areastr=Title from BasicData..Area where ID=@area and @area<>0
end




return @areastr;
End
GO
