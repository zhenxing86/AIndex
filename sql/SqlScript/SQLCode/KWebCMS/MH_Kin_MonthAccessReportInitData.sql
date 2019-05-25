USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_Kin_MonthAccessReportInitData]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		along
-- Create date: 2010-08-23
-- Description:	initdata
--exec [MH_Kin_MonthAccessReportInitData]
-- =============================================
CREATE PROCEDURE [dbo].[MH_Kin_MonthAccessReportInitData]
AS
BEGIN

	delete site_monthaccesstable

--	insert into site_monthaccesstable select top 12 t1.siteid,count(t2.siteid) as accesscount From site_accessdetail t1
--	left join site t2 on t1.siteid=t2.siteid
--	where accessdatetime>=getdate()-30 and t1.siteid <>216
--	group by t1.siteid
--	order by accesscount desc
insert into site_monthaccesstable
select top 12 siteid,accesscount From site order by accesscount desc

END






GO
