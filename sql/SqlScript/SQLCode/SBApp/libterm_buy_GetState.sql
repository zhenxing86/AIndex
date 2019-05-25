USE [SBApp]
GO
/****** Object:  StoredProcedure [dbo].[user_buy_GetList]    Script Date: 08/24/2013 09:11:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



alter PROCEDURE [dbo].[libterm_buy_GetList]
 @userid int
 AS 

declare @vipstate int,@sbids varchar(1000)
set @vipstate=0
set @sbids=''
select @vipstate=a4 from ossapp..addservice
	where [uid]=@userid 
		and deletetag=1
		and describe='开通'
if(	@vipstate<>803)
begin	
select @sbids=@sbids+sbid+',' from dbo.my_book k
where userid=@userid 
end
select @vipstate,@sbids	
		
GO

[libterm_buy_GetList] 65858 
 select * from BasicData..[user] where userid=65858
--ossapp..dict where name='服务类型'

