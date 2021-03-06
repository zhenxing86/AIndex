USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[beforefollow_DeleteTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--Deletetag
------------------------------------
CREATE PROCEDURE [dbo].[beforefollow_DeleteTag]
@id int
 AS 
begin transaction

	update  [beforefollow] set deletetag=0
	 WHERE ID=@id 

declare @kid int
select @kid=kid from [beforefollow] WHERE ID=@id 
if(@kid>0)
begin
update dbo.kinbaseinfo set status='待删除' where kid=@kid
end


if @@error>0
    begin
        rollback transaction
    end
else
    begin
        commit transaction
    end



GO
