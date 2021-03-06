USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinbaseinfo_ReDelete]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Deletetag
------------------------------------
CREATE PROCEDURE [dbo].[kinbaseinfo_ReDelete]
@id int
 AS 
 begin transaction


	update  [kinbaseinfo] set deletetag=1
	 WHERE kid=@id 

 update BasicData..[user] set deletetag=1 
	 where kid=@id


update kwebcms..[site] set [status]=1 where siteid=@id

update basicdata..kindergarten set deletetag=1 where kid=@id 


if @@ERROR>0
    begin
      
        rollback transaction
    end
else
    begin
        
        commit transaction
    end

GO
