USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_ygx_list]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[rep_mcdata_ygx_list]
--exec [mcapp].[dbo].[rep_mcdata_ygx_list]
as

;WITH CET AS
	(
		select distinct serial_no ,download_date,upload_date
			from mcapp..gun_para_xg where status=2
	)
	SELECT ca.kid, k.kname
		FROM CET c 
			cross apply
				(select top(1)* 
					from mcapp..gun_para_xg 
					where serial_no = c.serial_no 
					ORDER BY adate DESC
				)ca
			inner join BasicData..kindergarten k 
				on ca.kid = k.kid
		group by ca.kid,k.kname
		ORDER BY ca.kid
GO
