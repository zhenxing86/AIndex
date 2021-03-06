USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_GetModel]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-01-13
-- Description:	获取站点对象
--exec [site_GetModel1] 12511
-- =============================================
CREATE PROCEDURE [dbo].[site_GetModel]
	@siteid int
AS
BEGIN
	SET NOCOUNT ON
	declare @cblogincontent int, @cbloginmzsp int, @cbloginjcsp int, @cbmbqhqx int, 
					@cbyzdxfs int, @cbxsjhmh int, @chxsjhgg int, @cbxsjhkfzx int, @cbdqzdqlqx int
	
	create table #cet
	(
		right_id int,
		right_code varchar(100),
		right_name varchar(100)
	)
	
	insert into #cet(right_id,right_code,right_name)
		SELECT right_id, right_code, right_name 
			FROM KWebCMS_Right..sac_site_right ssr
				INNER JOIN KWebCMS_Right..sac_site_instance ssi  
					ON ssr.site_id = ssi.site_id 
					AND	(ssi.site_instance_id = ssr.site_instance_id or ssr.site_instance_id = 0)
				inner join [site] s 
					on s.org_id = ssi.org_id
		WHERE s.siteid = @siteid
    
   SELECT		@cblogincontent = COUNT(CASE WHEN right_code='YEYWZHT_LRLLQX' THEN 1 ELSE NULL END), 
						@cbloginmzsp = COUNT(CASE WHEN right_code='YEYWZHT_MZSPXZQX' THEN 1 ELSE NULL END), 
						@cbloginjcsp = COUNT(CASE WHEN right_code='YEYWZHT_SPLLQX' THEN 1 ELSE NULL END), 
						@cbmbqhqx = COUNT(CASE WHEN right_code='YEYWZHT_MBQH' THEN 1 ELSE NULL END), 
						@cbyzdxfs = COUNT(CASE WHEN right_code='YEYWZHT_YZDXFS' THEN 1 ELSE NULL END), 
						@cbxsjhmh = COUNT(CASE WHEN right_code='JH_SFXSJHMH' THEN 1 ELSE NULL END), 
						@chxsjhgg = COUNT(CASE WHEN right_code='JH_SFXSJHGG' THEN 1 ELSE NULL END), 
						@cbxsjhkfzx = COUNT(CASE WHEN right_code='JH_SFXSJHKF' THEN 1 ELSE NULL END), 
						@cbdqzdqlqx = COUNT(CASE WHEN right_code='YEYWZHT_ISGQQL' THEN 1 ELSE NULL END)    
    from #cet  

	SELECT	s.siteid, s.name, s.[description], s.[address], s.sitedns, s.provice, s.city,
					s.regdatetime, s.contractname, s.QQ, s.phone, s.accesscount, s.[status],
					t.shortname, t.code, t.memo, t.smsnum, t.ispublish, t.theme, t.isportalshow,
					s.email, t.kindesc,	t.copyright, t.guestopen, t.isnew, t.ptshotname, t.isvip,
					t.isvipcontrol, t.ispersonal, t.denycreateclass, t.classtheme, t.Kinlevel,
					t.KinImgpath, s.copyright as copyrightInfo, s.org_id, s.photowatermark, s.keyword,
					@cblogincontent, @cbloginmzsp, @cbloginjcsp, @cbmbqhqx, 
					@cbyzdxfs, @cbxsjhmh, @chxsjhgg, @cbxsjhkfzx, @cbdqzdqlqx
		FROM site s, site_config t
		WHERE s.siteid = t.siteid 
			AND s.siteid = @siteid
	
	drop table #cet
	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_GetModel', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
