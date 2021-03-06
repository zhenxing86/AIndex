USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetPortalSoruceReport]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-20>
-- Description:	<Description,,访问门户来源报表>
-- =============================================
CREATE PROCEDURE [dbo].[GetPortalSoruceReport] 
	@sd nvarchar(30),
	@ed nvarchar(30)
AS
BEGIN

	
	SET NOCOUNT ON;
	select ipaddress as IP地址, source as 来源, accessdatetime as 访问时间
 from portalaccesssource where 
	 accessdatetime between @sd and @ed
  order by id desc
END

GO
