USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[getcardupdatelist]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--author: xie
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012-10-16 21:55:38
--[getcardupdatelist] 8812,'000881201'
--[getcardupdatelist] 18795,'001879500',0,'2013-07-01'
------------------------------------
CREATE PROCEDURE [dbo].[getcardupdatelist]
@kid int,
@devid varchar(10),
@cnt int,
@l_update datetime
 AS

	if(@cnt=0)
	begin
	SELECT c.[id],c.[kid],c.[cardno],c.[udate],c.[usest],c.[CardType],c.[userid],
	case when u.usertype is null then -1 when u.usertype>0 then 1 else 0 end,c.EnrolNum
		FROM [mcapp].[dbo].[cardinfo] c
		left join BasicData..[user] u on c.userid = u.userid
		where c.kid =@kid
	end
	else
	begin

	SELECT c.[id],c.[kid],c.[cardno] ,c.[udate],c.[usest],c.[CardType],c.[userid],
		case when u.usertype is null then -1 when u.usertype>0 then 1 else 0 end,c.EnrolNum
		FROM [mcapp].[dbo].[cardinfo] c
		left join BasicData..[user] u on c.userid = u.userid
		where c.kid =@kid and c.[udate]>=@l_update 
		
	end


GO
