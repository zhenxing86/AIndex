USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[queryItemCheck_v2]    Script Date: 05/14/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter PROCEDURE [dbo].[queryItemCheck_v2] 
@bid int,
@item varchar(100)	
AS
set @item=CommonFun.dbo.FilterSQLInjection(@item)

   declare @userId int
   declare @term varchar(50)
   create table #temp
  (
     uid int,
     checktime datetime,
     checkresult varchar(100),
     value int,
     tw varchar(50)
  )
  
  create table #tempItem
  (
     uid int,
     type varchar(20),
     ctime datetime,
     status int,
     stw varchar(50)
  )
  select @userId=uid,@term=term from BaseInfo where id = @bid
  insert into #temp(uid,checktime,checkresult,value,tw)
  select userId,checktime,result, status,tw from HealthApp..CheckRecord where userId = @userid 

  if(@item='tw')
    begin
      exec ('select '+@item+',checktime from HealthApp..CheckRecord where bid='+@bid+' and '+@item+'>=38')
    end
  else
    begin
      
      insert into #tempItem(uid,type,ctime,status,stw)
      select uid,case when (checkresult like '%'+@item+',%') then @item else '' end,checktime,value,tw from #temp
      select * from #tempItem
        
    end

      drop table #tempItem
      drop table #temp
GO
