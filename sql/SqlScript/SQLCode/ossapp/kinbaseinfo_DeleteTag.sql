USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinbaseinfo_DeleteTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Deletetag
------------------------------------
CREATE PROCEDURE [dbo].[kinbaseinfo_DeleteTag]
@id int
 AS 
 
 begin transaction


	update  [kinbaseinfo] set deletetag=0
	 WHERE kid=@id 
	 
	 update BasicData..[user] set deletetag=0 
	 where kid=@id
	 
	update kwebcms..[site] set [status]=0 where siteid=@id

	update basicdata..kindergarten set deletetag=0 where kid=@id 

	if @@ERROR>0
    begin
      
        rollback transaction
    end
	else
    begin
        
        commit transaction
    end

GO
