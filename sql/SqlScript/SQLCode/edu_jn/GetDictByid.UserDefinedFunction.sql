USE [edu_jn]
GO
/****** Object:  UserDefinedFunction [dbo].[GetDictByid]    Script Date: 08/10/2013 10:16:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    function [dbo].[GetDictByid]
(
   @id int  --出生日期
)
returns varchar(max)
as
begin

declare @str varchar(1000)

select @str=Caption from BasicData..Dict where ID=@id

return @str;

End
GO
