USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_gx_list]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rep_mcdata_gx_list]

as

;WITH CET AS
	(
		select distinct serial_no ,download_date,upload_date
			from mcapp..gun_para_xg where status=2
	)
	SELECT ca.kid, k.kname,ca.serial_no,ca.status ,ca.download_date,ca.upload_date
		FROM CET c 
			cross apply
				(select top(1)* 
					from mcapp..gun_para_xg 
					where serial_no = c.serial_no 
					ORDER BY adate DESC
				)ca
			inner join BasicData..kindergarten k 
				on ca.kid = k.kid
		ORDER BY ca.kid,ca.serial_no 
		
		
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'已修改参数的列表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_mcdata_gx_list'
GO
