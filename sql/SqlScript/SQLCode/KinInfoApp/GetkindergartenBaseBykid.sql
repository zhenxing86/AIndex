USE [KinInfoApp]
GO
/****** Object:  StoredProcedure [dbo].[GetkindergartenBaseBykid]    Script Date: 2014/11/24 23:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[GetkindergartenBaseBykid]
@kid int
as

select k.kname, k.area ,residence,citytype ,opentype,kintype,[address] ,
c.ID,c.kid,area1,area2,area3,area4,book,econtent,inuserid,intime,unitcode,postcode,officetel,email,inputmail,inputname,fixtel,master
,(select Caption from BasicData..Dict where ID=kintype)
from BasicData..kindergarten k
left join kindergarten_condition c on c.kid=k.kid where k.kid=@kid


GO
