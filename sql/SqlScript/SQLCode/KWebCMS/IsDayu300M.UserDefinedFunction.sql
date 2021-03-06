USE [KWebCMS]
GO
/****** Object:  UserDefinedFunction [dbo].[IsDayu300M]    Script Date: 05/14/2013 14:43:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  liaoxin
-- Create date: 2010-8-5
-- Description:	判断空间大小是否大于300M 
-- =============================================
create FUNCTION [dbo].[IsDayu300M] 
(
	@size bigint
)
RETURNS bigint
AS
BEGIN 
     declare @return bigint
   
	 if(@size>300*1024*1024)
      select @return=300*1024*1024
     else
       select @return=@size
   return @return

END
GO
