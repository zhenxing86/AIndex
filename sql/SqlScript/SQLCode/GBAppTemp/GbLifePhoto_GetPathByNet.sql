USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[GbLifePhoto_GetPathByNet]    Script Date: 2014/11/24 23:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		xie
-- Create date: 2012-12-20
-- Description:	获取指定服务器上的视频路径列表 
--exec GbLifePhoto_GetPathByNet 191598
-- =============================================
CREATE PROCEDURE [dbo].[GbLifePhoto_GetPathByNet]
@net int
AS
BEGIN
	--SELECT distinct m_path from GbLifePhoto  where net=@net and updatetime>='2012-10-14'
select distinct gl.m_path from gblifephoto gl left join growthbook t0 on gl.gbid=t0.gbid left join  homebook t1 on t0.hbid=t1.hbid  left join basicdata..class t2 on t1.classid=t2.cid 
where 
t2.kid in(select kid from tmpdb..jn_kid) and gl.net=39 and gl.updatetime>='2012-10-14'-- gl.updatetime>='2012-10-14'

--SELECT distinct m_path from GbLifePhoto  where net=39 and updatetime<='2012-10-15'
END






GO
