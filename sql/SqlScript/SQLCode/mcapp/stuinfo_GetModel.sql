USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[stuinfo_GetModel]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[stuinfo_GetModel]
@id int
 AS 
 
 	select userid, cardno,ROW_NUMBER()OVER(PARTITION BY userid order by cardno) rowno
		into #cardinfo
		from cardinfo 
		where userid = @id
	SELECT	1, uc.userid stuid,  c1.cardno card1, c2.cardno card2, c3.cardno card3, 
					c4.cardno card4, uc.name, uc.tts, uc.sex, '', CONVERT(VARCHAR(10),uc.birthday,120) birth,
					CAST(NULL AS NVARCHAR(10))fname, CAST(NULL AS NVARCHAR(20))ftel, 
					CAST(NULL AS NVARCHAR(10))mname, CAST(NULL AS NVARCHAR(20))mtel, 
					CAST(NULL AS NVARCHAR(100))ppic1, CAST(NULL AS NVARCHAR(100))ppic2, 
					CAST(NULL AS NVARCHAR(100))ppic3, CAST(NULL AS NVARCHAR(100))ppic4, 
					CAST(NULL AS NVARCHAR(100))spic1, CAST(NULL AS NVARCHAR(100))spic2, 
					CAST(NULL AS INT) syntag,
					case when a.ftime<=GETDATE() And a.ltime>=GETDATE() then a.a8 else 0 end 
	  FROM BasicData..User_Child uc
			left join #cardinfo c1 on uc.userid = c1.userid and c1.rowno = 1
			left join #cardinfo c2 on uc.userid = c2.userid and c2.rowno = 2
			left join #cardinfo c3 on uc.userid = c3.userid and c3.rowno = 3
			left join #cardinfo c4 on uc.userid = c4.userid and c4.rowno = 4
			left join ossapp..addservice a on a.deletetag=1 and uc.userid=a.[uid] and a.describe='开通'  
	 WHERE uc.userid=@id

GO
