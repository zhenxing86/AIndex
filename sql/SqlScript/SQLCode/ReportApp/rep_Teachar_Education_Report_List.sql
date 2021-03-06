USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_Teachar_Education_Report_List]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-06-25
-- Description:	
-- Memo:		rep_Teachar_Education_Report_List 12511, '博士研究生毕业',1,10,'','',''
*/      
CREATE PROCEDURE [dbo].[rep_Teachar_Education_Report_List]       
	@kid int,      
	@education varchar(30),
	@page int,
	@size int,
	@na varchar(30),
	@mobile varchar(30),
	@job varchar(50)      
AS
BEGIN
	SET NOCOUNT ON      
      
	create table #tempList      
	(      
		row int IDENTITY(1,1),      
		na varchar(30),      
		sex varchar(30),      
		mobile varchar(30),      
		education varchar(30),      
		age varchar(30),      
		title varchar(30),      
		userid int,
		birthday varchar(20),
		headpic varchar(100), 
		headpicupdate datetime     
	)      
      
	DECLARE @pcount int      

	IF @education = '其他'
		INSERT INTO #tempList
			SELECT	u.name, case when u.gender = 2 then '女' else '男' end sex, u.mobile, 
							t.education, CommonFun.dbo.fn_age(u.birthday) age, t.title, u.userid
							,CONVERT(varchar(10),u.birthday,120),u.headpic, u.headpicupdate   
				from basicdata..teacher t        
					inner join BasicData..[user] u 
						on u.userid = t.userid  
						and u.kid = @kid   
				where u.deletetag = 1 
					and u.usertype = 1      
					and u.[name] like '%' + @na + '%' 
					and u.mobile like '%' + @mobile + '%'  
					and t.title like @job + '%' 
					and NOT exists
						(
							select * from BasicData..dict_xml d 				
								WHERE d.[Catalog] = '最高学历'
									and d.Caption <> '其他' 
									and t.education = d.Caption
						)     
	ELSE IF @education = '合计'
		INSERT INTO #tempList
			SELECT	u.name, case when u.gender = 2 then '女' else '男' end sex, u.mobile, 
							t.education, CommonFun.dbo.fn_age(u.birthday) age, t.title, u.userid
							,CONVERT(varchar(10),u.birthday,120),u.headpic, u.headpicupdate   
				from basicdata..teacher t       
					inner join BasicData..[user] u 
						on u.userid = t.userid 
						and u.kid = @kid    
				where u.deletetag = 1 
					and u.usertype = 1      
					and u.[name] like '%' + @na + '%' 
					and u.mobile like '%' + @mobile + '%'  
					and t.title like @job + '%' 
	ELSE 
	INSERT INTO #tempList
	SELECT	u.name, case when u.gender = 2 then '女' else '男' end sex, u.mobile, 
					t.education, CommonFun.dbo.fn_age(u.birthday) age, t.title, u.userid
					,CONVERT(varchar(10),u.birthday,120),u.headpic, u.headpicupdate   
		from basicdata..teacher t  
			inner join BasicData..[user] u 
				on u.userid = t.userid 
				and u.kid = @kid    
		where u.deletetag = 1 
			and u.usertype = 1      
			and [name] like '%' + @na + '%' 
			and mobile like '%' + @mobile + '%'  
			and title like @job + '%'
			and t.education = @education
      
exec [dbo].[sp_GridViewByPager] 
     '#tempList',																						--表名   
     'na, sex, mobile, education, age, title, userid, birthday,headpic,headpicupdate',      --查询字段
     'row',																									--索引字段
     @size,																									--每页记录数
     @page,																									--当前页
     'row',																									--排序条件
     '1=1',																									--WHERE条件
     1,																											--是否输出总记录条数
     0																											--是否输出行号
END   


GO
