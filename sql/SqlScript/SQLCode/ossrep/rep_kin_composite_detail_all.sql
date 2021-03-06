USE [ossrep]
GO
/****** Object:  StoredProcedure [dbo].[rep_kin_composite_detail_all]    Script Date: 2014/11/24 23:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[rep_kin_composite_detail_all]
@txttime1 datetime
,@txttime2 datetime
,@uid int
,@abid int
,@status nvarchar(20)
,@ty int
as 

if(@ty=1)
begin
set @status='营销客户'
end



if(@abid>0)
begin

if(@ty=2)--根据营销资料统计
begin

select kid,bf_id,kname,infofrom,developer,[status],regdatetime from rep_kin_composite
where regdatetime between @txttime1 and @txttime2
and abid=@uid 
and ((rid >0 and @status='欠费') or (rid is null and @status='试用期'))

end
else
begin
select kid,bf_id,kname,infofrom,developer,[status],regdatetime from rep_kin_composite
where regdatetime between @txttime1 and @txttime2
and abid=@uid and [status]=@status
end
 
end
else
begin

if(@ty=2)--根据营销资料统计（跟进中的@status='欠费',未跟进的：@status='试用期'）
begin

select kid,bf_id,kname,infofrom,developer,[status],regdatetime from rep_kin_composite
where regdatetime between @txttime1 and @txttime2
 and ([uid]=@uid or @uid=-1)
and ((rid >0 and @status='欠费') or (rid is null and @status='试用期'))

end
else
begin
select kid,bf_id,kname,infofrom,developer,[status],regdatetime from rep_kin_composite
where regdatetime between @txttime1 and @txttime2
 and ([uid]=@uid or @uid=-1)
 and [status]=@status
end

end





GO
