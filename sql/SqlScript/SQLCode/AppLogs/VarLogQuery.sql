USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[VarLogQuery]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*        
-- Author:      Master谭        
-- Create date:         
-- Description:         
-- Memo: 
exec VarLogQuery	
	@DbName  = 'BasicData',
	@TbName  = 'user', 
	@Item  = 'kid', 
	@value  = '12511', 
	@kid  = 12511,
	@bgntime  = '2013-1-13',
	@endtime  = '2014-2-17',
	@DoType  = -1--（0新增，2删除，1修改，-1不限）        
*/        
CREATE PROC [dbo].[VarLogQuery]          
 @DbName varchar(50),        
 @TbName varchar(50),         
 @Item varchar(50),         
 @value varchar(50),         
 @kid int,        
 @bgntime datetime,        
 @endtime datetime,        
 @DoType int = -1--（0新增，2删除，1修改，-1不限）        
AS        
BEGIN        
 SET NOCOUNT ON;        
 CREATE TABLE #T(
	k1 sql_variant, k2 sql_variant, k3 sql_variant,DoType varchar(10) , 
	ColName varchar(10), Oldvalue sql_variant, NewValue sql_variant, 
	DoName varchar(50), CrtDate datetime)
	insert into #T
	exec LogQuery	
		@DbName  = @DbName,
		@TbName  = @TbName, 
		@Item  = @Item, 
		@value  = @value, 
		@kid  = @kid,
		@bgntime  = @bgntime,
		@endtime  = @endtime,
		@DoType  = @DoType--（0新增，2删除，1修改，-1不限）
	IF @DbName  = 'mcapp' AND @TbName  = 'cardinfo'
	BEGIN
		;WITH CET AS
		(select CAST(k1 as varchar(50)) 卡号, 
				CASE DoType 
				WHEN '新增' THEN '初始化卡' 
				WHEN '删除' THEN '删除卡'
				ELSE	CASE CAST(NewValue AS int) 
							WHEN  1 then '新开卡' 
							WHEN -1 THEN '挂失卡' 
							WHEN -2 THEN '作废卡'
							WHEN  0 THEN '复位成新卡'  
							END 
				END	操作类型,
		ISNULL(u.name,u1.name) 姓名, t.DoName 操作人,
		CONVERT(varchar(19),crtdate,120 ) 操作时间
		from #T t 
		LEFT JOIN basicdata..[user] u on t.ColName = '用户ID' and u.userid = CAST( t.OldValue  AS int) 
		LEFT JOIN basicdata..[user] u1 on t.ColName = '用户ID' and u1.userid = CAST( t.NewValue  AS int) 

		)	SELECT 卡号, MAX(操作类型) 操作类型, MAX(姓名) 姓名, 操作人, 操作时间
		FROM CET
		GROUP BY 卡号, 操作人, 操作时间
	END
	ELSE IF @DbName  = 'BasicData' AND @TbName  = 'user'
	BEGIN
	;with cet as
	(
		select CAST(k1 as int) 用户ID, DoType 操作类型, ColName, DoName 操作人,
			ISNULL(
			CASE	WHEN ColName = 'headpic' THEN CASE WHEN CAST(Oldvalue AS VARCHAR(200)) ='AttachsFiles/default/headpic/default.jpg' THEN '无' ELSE '有' END 
						WHEN ColName = 'usertype' THEN CASE CAST(Oldvalue AS int) WHEN 0 THEN '家长' WHEN 1 THEN '老师' WHEN 97 THEN '园长' WHEN '98' THEN '管理员' ELSE '未知' END 
							WHEN ColName = 'birthday' THEN CONVERT(varchar(10),Oldvalue,120)
			ELSE CAST(Oldvalue AS VARCHAR(200)) END,'')	 
			+ ' --> ' 
			+	
			ISNULL(
			CASE	WHEN ColName = 'headpic' THEN CASE WHEN CAST(NewValue AS VARCHAR(200)) ='AttachsFiles/default/headpic/default.jpg' THEN '无' ELSE '有' END 
						WHEN ColName = 'usertype' THEN CASE CAST(Oldvalue AS int) WHEN 0 THEN '家长' WHEN 1 THEN '老师' WHEN 97 THEN '园长' WHEN '98' THEN '管理员' ELSE '未知' END 
							WHEN ColName = 'birthday' THEN CONVERT(varchar(10),NewValue,120)
			ELSE CAST(NewValue AS VARCHAR(200)) END,'') Value,
			CONVERT(varchar(19),crtdate,120 ) 操作时间
		FROM #T
	)
	select	p.用户ID, p.操作类型, p.操作人, p.操作时间,
					isnull(p.[kid],u.[kid]) 幼儿园ID,	isnull(p.[account],u.[account]) 帐号, 
					isnull(p.[name],u.[name]) 小朋友姓名, CASE WHEN p.[password] IS NULL THEN NULL ELSE '-->修改' END 密码, 
					isnull(p.[usertype],CASE CAST(u.[usertype] AS int) WHEN 0 THEN '家长' WHEN 1 THEN '老师' WHEN 97 THEN '园长' WHEN '98' THEN '管理员' ELSE '未知' END) 用户类型, 
					isnull(p.[deletetag],u.[deletetag]) 删除标志,  
					isnull(p.[birthday],CONVERT(varchar(10),u.[birthday],120)) 生日, isnull(p.[mobile],u.[mobile]) 手机, 
					CASE p.[headpic] WHEN '无 --> 有' THEN '-->新增头像' WHEN '有 --> 有' THEN '-->修改头像' WHEN '有 --> 无' THEN '-->删除头像' ELSE NULL END 头像, 
					isnull(p.[smsport],u.[smsport]) 短信通道, 
					isnull(p.[NGB_gbVersionTag],u.[NGB_gbVersionTag]) 成长档案版本, isnull(p.[gbstatus],u.[gbstatus]) 成长档案状态
		FROM cet c pivot(MAX(Value) 
			for ColName in(
					[account], [password], [usertype], 
					[deletetag], [kid], [name], [birthday], [mobile], 
					[headpic], [smsport], [NGB_gbVersionTag], [gbstatus]))p
		left join BasicData..[user] u
			on p.用户ID = u.userid
	END		
	ELSE IF @DbName  = 'basicdata' AND @TbName  = 'user_class'
	BEGIN
		;WITH CET AS
		(select DoType 操作类型, t.DoName 操作人,
		CONVERT(varchar(19),t.crtdate,120 ) 操作时间, 
		ISNULL(uc.cid,CAST(dl.Col1 AS INT)) 班级ID, 
		ISNULL(uc.userid,CAST(dl.Col2 AS INT)) 用户ID 
		from #T t 
			LEFT JOIN basicdata..[user_class] uc on CAST(t.k1 as bigint) = uc.ucid
			LEFT JOIN AppLogs..DelLog dl 
				on t.k1 = dl.Col3 
				AND dl.DbName = 'basicdata' 
				and dl.TbName  = 'user_class'

		)	SELECT	ce.操作类型, ce.操作人, ce.操作时间, ce.用户ID, 
							u.account 帐号, u.name 姓名, 班级ID, ISNULL(c.cname, CAST(dl.Col3 AS VARCHAR(50))) 班级名称
		FROM CET ce 
			LEFT JOIN BasicData..[user] u on ce.用户ID = u.userid
			LEFT JOIN BasicData..class c on ce.班级ID = c.cid
			LEFT JOIN AppLogs..DelLog dl 
				on CAST(ce.班级ID AS sql_variant) = dl.Col1
				AND dl.DbName = 'basicdata' 
				and dl.TbName  = 'class'
	--	GROUP BY 卡号, 操作人, 操作时间
	END
 
END        

GO
