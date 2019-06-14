USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetYSFCInterface]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,园所风采列表>
-- =============================================
CREATE PROCEDURE [dbo].[GetYSFCInterface] 
@typecode nvarchar(10)
AS
BEGIN
	SET NOCOUNT ON;

select top 100 'http://www.zgyey.com/pv'+rtrim(convert(char(10),photoid))+'.html' as url,descript as title,name,datecreated from v_YSFC 
where privince=245 and isportalshow=1 and typecode=@typecode 
order by datecreated desc

END

--exec [GetYSFCInterface] 'yezp'



GO
