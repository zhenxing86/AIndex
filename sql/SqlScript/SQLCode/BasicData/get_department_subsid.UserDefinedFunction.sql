USE [BasicData]
GO
/****** Object:  UserDefinedFunction [dbo].[get_department_subsid]    Script Date: 05/14/2013 14:36:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[get_department_subsid]( @did int )    returns  @tb table (did int)as begin    insert into @tb    select did from department where superior = @did    while @@Rowcount >0  --只要有下级节点就循环    begin        insert into @tb        select a.did from department as a inner join @tb as b on a.superior = b.did and a.did not in(select did from @tb)    end        insert into @tb (did) values (@did)     returnend
GO
