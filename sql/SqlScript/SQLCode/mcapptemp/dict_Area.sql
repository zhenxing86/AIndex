USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[dict_Area]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
-- Author:      xie
-- Create date: 
-- Description:	
-- Memo:		
dict_Area 0

*/
create PROCEDURE [dbo].[dict_Area]
 @superior int
 AS 
 
begin
	select 0,ID,Title,Code,Superior,[Level],1 
		from basicdata..area
		where Superior=@superior
end
	



GO
