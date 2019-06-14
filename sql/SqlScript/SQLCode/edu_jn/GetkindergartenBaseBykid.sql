USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[GetkindergartenBaseBykid]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[GetkindergartenBaseBykid]
@kid int
as



select k.kname,[dbo].[GetKinAreaStr_pid](areaid,3) area 
,[dbo].[GetKinAreaStr_pid](areaid,3) residence
,[dbo].[GetKinAreaStr_pid](areaid,2) citytype 
,opentype,kintype,[address] ,
c.ID,c.kid,area1,area2,area3,area4,book,econtent,inuserid,intime,unitcode,postcode,officetel,email,inputmail,inputname,fixtel,[master]
,(select Caption from Dict where ID=kintype)
,[dbo].[GetKinAreaStr](areaid,3) areastr
from gartenlist k
left join kininfoapp..kindergarten_condition c on c.kid=k.kid where k.kid=@kid




GO
