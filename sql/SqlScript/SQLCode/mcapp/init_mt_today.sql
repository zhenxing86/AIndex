USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[init_mt_today]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[init_mt_today] 
@kid int
,@d0 int
as

declare @dotime datetime,@year int,@months int,@days int
set @dotime = getdate()
set @year=year(@dotime)
set @months=month(@dotime)
set @days=day(@dotime)

if(not exists(select top 1 1 from rep_mc_teacher_signin where kid=@kid and [years]=@year and [months]=@months))
begin
insert into dbo.rep_mc_teacher_signin([kid],[userid],[uname],[years],[months]
,[d0],[d1],[d2],[d3],[d4],[d5],[d6],[d7],[d8],[d9],[d10]
,[d11],[d12],[d13],[d14],[d15],[d16],[d17],[d18],[d19],[d20]
,[d21],[d22],[d23],[d24],[d25],[d26],[d27],[d28],[d29],[d30],[d31])     
select @kid,t.teaid,t.[name],@year,@months,@d0
,dbo.Check_teacher_signin_Result_Fun(@year,@months,1,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,2 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,3 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,4 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,5 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,6 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,7 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,8 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,9 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,10 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,11 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,12 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,13 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,14 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,15 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,16 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,17 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,18 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,19 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,20 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,21 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,22 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,23 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,24 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,25 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,26 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,27 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,28 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,29 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,30 ,t.teaid)
,dbo.Check_teacher_signin_Result_Fun(@year,@months,31 ,t.teaid)
 from dbo.teainfo t where t.kid=@kid
end



exec('update dbo.rep_mc_teacher_signin set [d'+@days+']=dbo.Check_teacher_signin_Result_Fun('+@year+','+@months+','+@days+',[userid])
 where kid='+@kid+' and [years]='+@year+' and [months]='+@months)









GO
