USE [CardApp]
GO
/****** Object:  UserDefinedFunction [dbo].[AdjustFn_20130409]    Script Date: 06/15/2013 17:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AdjustFn_20130409](@s nvarchar(400))
returns nvarchar(400)
as
begin
;with cet as
(
select * 
from dbo.f_split(@s,'<br />')
where patindex(' [0-9][0-9]:[0-5][0-9]',col) > 0
)
select @s = replace(STUFF((SELECT N'$' + col
                    FROM (select  distinct(col) from cet) AS Y
                    FOR XML PATH('')), 1, 1, N''),'$','<br />')
return @s
end
GO
