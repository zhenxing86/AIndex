USE [ossapp]
GO
/****** Object:  UserDefinedFunction [dbo].[isnullreturn]    Script Date: 05/14/2013 14:55:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[isnullreturn]
(
	@inobj varchar(max),
	@outobj varchar(500)
)
RETURNS varchar(max)
AS
BEGIN
	
if(@inobj is null or @inobj ='')
begin
set @inobj=@outobj
end
	RETURN @inobj

END
GO
