USE [SBApp]
GO
/****** Object:  StoredProcedure [dbo].[user_buy_GetList]    Script Date: 2014/11/24 23:26:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[user_buy_GetList]
 @uid int
 AS 

declare @sbids varchar(max),@p int
set @sbids=''

SELECT @p=count(1) FROM [SBApp].[dbo].[readcard_pay]
  where userid=@uid and getdate() between paydate and enddate

if(@p>0)
begin
select @sbids=@sbids+sbid+',' from dbo.sb_book

end
else
begin

select @sbids=@sbids+sbid+',' from dbo.my_book k
where userid=@uid 

end



select @sbids



GO
