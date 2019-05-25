USE BasicData
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      MasterÌ·
-- Create date: 2013-07-04
-- Description:	¹ý³ÌÓÃÓÚÅúÁ¿Éý°à
-- Memo:

select * from class where kid=17611 ORDER BY GRADE, [ORDER]
 EXEC class_Rise_array 12511,  '14242,Éý°à²âÊÔ1,36$14524,Éý°à²âÊÔ2,36$12699,Éý°à²âÊÔ3,36$12700,Éý°à²âÊÔ4,36$36406,Éý°à²âÊÔ5,36$38241,Éý°à²âÊÔ6,36'
select * from class where kid=17611 ORDER BY GRADE, [ORDER]

*/
ALTER PROCEDURE [dbo].class_Rise_array
	@kid int,
	@str varchar(8000)--¡¾cid,new_cname,new_gradeid$cid,new_cname,new_gradeid¡¿
AS
BEGIN
	SET NOCOUNT ON
	
	CREATE TABLE #T(cid int, cname nvarchar(50), grade int)
	CREATE TABLE #grade(Newgid int, Oldgid int)

	insert into #T
	select col1,col2,col3
	   from CommonFun.dbo.fn_MutiSplitTSQL(@str,'$',',')   
	   
	IF EXISTS(select cname from #T GROUP BY cname having COUNT(1)> 1)		
	BEGIN
		SELECT -1 result
		goto ERRORReturn
	END	
	IF EXISTS
		(
			select * 
				from #T t 
					inner join BasicData.dbo.class c 
						on c.kid = @kid 
						and c.cname = t.cname 
						AND c.deletetag = 1 
						and not exists(select * from #T where cid = c.cid)		
		)
	BEGIN
		SELECT -1 result
		goto ERRORReturn
	END
	
	Begin tran   
	BEGIN TRY  
		UPDATE c 
			set cname = t.cname,
					grade = t.grade,
					[order] = NULL,
					sname = ''
			output inserted.grade,deleted.grade
			into #grade(Newgid, Oldgid)		
			from BasicData.dbo.class c 
				inner join #T t 
					on c.cid = t.cid 
					and c.kid = @kid
		;WITH CET AS
		(
			SELECT *, ROW_NUMBER()OVER(PARTITION BY c.grade order by case when c.[order] is not null then 0 else 1 end,c.[order],c.cname)rowno 
				FROM BasicData.dbo.class c
				where exists(select * from #grade where Newgid = c.grade or Oldgid = c.cid)
					AND c.kid = @kid
		)	update CET set [order] = rowno	

		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran  
		SELECT -1 result 
		goto ERRORReturn        
	end Catch 
	SELECT 1 result    
	IF 1 = 0
	begin
	ERRORReturn:
	insert into	yeyErrorLog(DBName ,ProcName ,para ,Memo)
		select 'BasicData','class_Rise_array',CAST(@kid AS VARCHAR(50))+';' + @str,'Éý°àÊ§°Ü'
						return
	end	

	
	drop table 	#T
END
GO
