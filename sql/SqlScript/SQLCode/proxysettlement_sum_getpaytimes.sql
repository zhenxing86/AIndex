USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[proxysettlement_sum_getpaytimes]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proxysettlement_sum_getpaytimes]
@abid int
 AS 
declare @p int
select @p=max(paytimes) from dbo.proxysettlement_sum where abid=@abid
if(@p is null)
begin
set @p=0
end

set @p=@p+1
select @p


GO
