USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[init_stu_mc_day_raw_12511]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:		
*/
CREATE proc [dbo].[init_stu_mc_day_raw_12511]
as
begin
	set nocount on
	DECLARE @TOP INT, @cnt INT
	select @cnt = count(1)  
		from BasicData..User_Child uc
		where uc.kid = 12511 
		and exists(select * from cardinfo where userid = uc.userid)
					
	select @TOP = @cnt  - abs(checksum(newid()))%(15) 
	
	SELECT top(@TOP) c1.userid stuid,c1.cardno, getdate() cdate, 
			CommonFun.dbo.fn_randtemperature(abs(checksum(newid()))%100) tw,
			CommonFun.dbo.fn_randzz(
			abs(checksum(newid()))%1000,
			abs(checksum(newid()))%1000,
			abs(checksum(newid()))%1000,
			abs(checksum(newid()))%1000,
			abs(checksum(newid()))%1000,
			abs(checksum(newid()))%1000,
			abs(checksum(newid()))%1000,
			abs(checksum(newid()))%1000,
			abs(checksum(newid()))%1000,
			abs(checksum(newid()))%1000) zz,
			25.1 ta, 35.6 toe, '001251101' devid, '08' gunid, 12511 kid, 0 Staus, getdate() adate
			INTO #T
			FROM BasicData.dbo.user_class uc
				inner join BasicData.dbo.[user] u 
					on uc.userid = u.userid 
					and u.deletetag = 1
					and u.usertype = 0
					and u.kid = 12511
				INNER JOIN BasicData.dbo.class c
					on uc.cid = c.cid
					and grade <> 38	
					and c.deletetag = 1
				INNER JOIN mcapp.dbo.cardinfo c1
					on c1.userid = u.userid
				order by case when u.userid in (295765,295767) then 0 else 1 end, newid()	
	SET ROWCOUNT 0
	UPDATE #T SET tw = (370 + abs(checksum(newid()))%11)/10.0 WHERE CHARINDEX('1,',zz) > 0 or zz = '1'
	INSERT INTO stu_mc_day_raw(stuid, card, cdate, tw, zz, ta, toe, devid, gunid, kid, Status, adate)
		SELECT * FROM #T zz_dict
	
end



GO
