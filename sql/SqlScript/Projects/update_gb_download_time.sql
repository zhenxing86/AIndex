
/*
新增/修改成长档案下载时间
*/
declare
 @kid int = 20126,
 @term nvarchar(10)='2013-1',
 @bgntime datetime='2014-03-01 00:00:00',
 @endtime datetime='2014-03-31 23:59:59'
if not exists (
 select 1 from ngbapp..growthbook_permission 
  where kid=@kid and term=@term)
begin
	insert into ngbapp..growthbook_permission(kid,term,bgntime,endtime)
	select @kid,@term,@bgntime,@endtime
end
else
begin
	update ngbapp..growthbook_permission
	 set bgntime=@bgntime,endtime=@endtime
	 where kid=@kid and term=@term
end
go

--select * from ngbapp..growthbook_permission where kid=20126 and term='2013-1'

/*
修改成长档案下载时间
*/
declare
 @kid int = 20126,
 @bgntime datetime='2014-03-01 00:00:00',
 @endtime datetime='2014-03-31 23:59:59'
if exists (
 select 1 from ngbapp..growthbook_permission 
  where kid=@kid )
begin
	update ngbapp..growthbook_permission
	 set bgntime=@bgntime,endtime=@endtime
	 where kid=@kid
end