USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[GetCustomer_SelectList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[GetCustomer_SelectList]
(@id int)
as
begin
declare @sql varchar(max)
set @sql=' select * from dbo.CustomerService ';
if(@id=-1)
begin
SET	@sql=' select distinct Category from dbo.CustomerService ';
end

if(@id>0)
set @sql=@sql+' where ID= '+cast(@id as varchar(50))
exec (@sql)
end


GO
