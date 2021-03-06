USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[payinfolog_DeleteTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--Deletetag
------------------------------------
CREATE PROCEDURE [dbo].[payinfolog_DeleteTag]
@id int
 AS 

begin tran

declare @paytype varchar(100),@kid int

select @paytype=paytype,@kid=kid from [payinfolog]  WHERE ID=@id 

if(@paytype='维护费')
begin
update  kinbaseinfo  set expiretime=dateadd(dd,15,regdatetime) where kid=@kid
end

update  [payinfolog] set deletetag=0
 WHERE ID=@id 

if @@error<>0 
begin 
rollback tran
end
else 
begin
commit tran
end



GO
