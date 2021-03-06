USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[stuinfo_GetList]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-02
-- Description:	
-- Memo:		
exec mcapp..stuinfo_GetList 1,10,'',-1,19536,''
exec mcapp..stuinfo_GetList 2,10,'',-1,19536,''
exec stuinfo_GetList 1,10,'张博翔',-1,19731,'1308011598'
exec stuinfo_GetList 1,10,'张博翔',-1,19731,''
*/
-- 
CREATE PROCEDURE [dbo].[stuinfo_GetList] 
 @page int,
 @size int,
 @uname nvarchar(30),
 @cid int,
 @kid int,
 @cardno varchar(100)
 AS
BEGIN
	SET NOCOUNT ON 
	set @uname=CommonFun.dbo.FilterSQLInjection(@uname)
	set @cardno=CommonFun.dbo.FilterSQLInjection(@cardno)
	declare @userid int
	if @cardno <> '' select @userid = userid from cardinfo where cardno = @cardno
	select userid, cardno,ROW_NUMBER()OVER(PARTITION BY userid order by cardno) rowno
		into #cardinfo
		from cardinfo 
		where kid = @kid 
			and userid is not null
	DECLARE @fromstring NVARCHAR(2000)
	SET @fromstring = 
	' BasicData..user_Child uc
			left join #cardinfo c1 on uc.userid = c1.userid and c1.rowno = 1
			left join #cardinfo c2 on uc.userid = c2.userid and c2.rowno = 2
			left join #cardinfo c3 on uc.userid = c3.userid and c3.rowno = 3
			left join #cardinfo c4 on uc.userid = c4.userid and c4.rowno = 4
		where uc.kid = @D2 
			and uc.grade <> 38 '
	 IF @uname <> '' SET @fromstring = @fromstring + ' AND uc.name like @S1 + ''%'''   
	 IF @cid <> -1 SET @fromstring = @fromstring + ' AND uc.cid = @D1'	
	 IF @cardno <> '' SET @fromstring = @fromstring + ' AND  (c1.userid = @D3 or c2.userid = @D3 or c3.userid = @D3 or c4.userid = @D3)'     				 
	--分页查询
	exec	sp_MutiGridViewByPager
		@fromstring = @fromstring,      --数据集
		@selectstring = 
		' uc.userid, c1.cardno card1, c2.cardno card2, c3.cardno card3, c4.cardno card4, uc.name, uc.tts, uc.sex , 
				uc.cname, CONVERT(VARCHAR(10),uc.birthday,120) birth, CAST(NULL AS NVARCHAR(10))fname, CAST(NULL AS NVARCHAR(20))ftel, 
				CAST(NULL AS NVARCHAR(10))mname, CAST(NULL AS NVARCHAR(20))mtel, CAST(NULL AS NVARCHAR(100))ppic1, 
				CAST(NULL AS NVARCHAR(100))ppic2, CAST(NULL AS NVARCHAR(100))ppic3, CAST(NULL AS NVARCHAR(100))ppic4, 
				CAST(NULL AS NVARCHAR(100))spic1, CAST(NULL AS NVARCHAR(100))spic2, CAST(NULL AS INT) syntag',      --查询字段
		@returnstring = 
		' userid, card1, card2, card3, card4, name, tts, sex , 
				cname, birth, fname, ftel, mname, mtel, ppic1, 
				ppic2, ppic3, ppic4, spic1, spic2, syntag',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' uc.cid ',          --排序条件
		@IsRecordTotal = 1,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@S1 = @uname,											 
		@D1 = @cid,										
		@D2 = @kid,										
		@D3 = @userid
		
end

GO
