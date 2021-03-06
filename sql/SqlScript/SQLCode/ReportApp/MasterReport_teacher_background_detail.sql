USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[MasterReport_teacher_background_detail]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	yz  
-- Create date: 2014-7-13
-- Description:师资力量明细
--[reportapp].[dbo].[MasterReport_teacher_background_detail] 0,12511,'未填写'
-- =============================================
CREATE PROCEDURE [dbo].[MasterReport_teacher_background_detail]
@tag int,
@kid int,
@title varchar(50)
  
AS
BEGIN

if @tag = 0

begin
  if @title <> '未填写'
  begin
  select u.name 姓名,
         t.title 职位,
         t.education 学历,
         t.post 职称,
         commonfun.dbo.fn_age(u.birthday)年龄
    from  basicdata..teacher t 
				inner join BasicData..[user] u 
					on u.userid = t.userid 
				
    where u.kid = @kid
      and t.education = @title
      and u.deletetag = 1 
				and u.usertype = 1 
    order by t.education,t.post
    end
    
  else begin
    select u.name 姓名,
         t.title 职位,
         t.education 学历,
         t.post 职称,
         commonfun.dbo.fn_age(u.birthday)年龄
    from  basicdata..teacher t 
				inner join BasicData..[user] u 
					on u.userid = t.userid 
				
    where u.kid = @kid
      and t.education is null
      and u.deletetag = 1 
				and u.usertype = 1 
    order by t.education,t.post
  end
 
end

--------------------------------------------------------------------

else

if @tag = 1

begin
  if @title <> '未填写'
  begin
  select u.name 姓名,
         t.title 职位,
         t.education 学历,
         t.post 职称,
         commonfun.dbo.fn_age(u.birthday)年龄
    from  basicdata..teacher t 
				inner join BasicData..[user] u 
					on u.userid = t.userid 
    where  u.kid = @kid
      and t.post = @title
     and u.deletetag = 1 
				and u.usertype = 1 
    order by t.education,t.post
  end
  
  else begin
   select u.name 姓名,
         t.title 职位,
         t.education 学历,
         t.post 职称,
         commonfun.dbo.fn_age(u.birthday)年龄
    from  basicdata..teacher t 
				inner join BasicData..[user] u 
					on u.userid = t.userid 
    where  u.kid = @kid
      and t.post is null
     and u.deletetag = 1 
				and u.usertype = 1 
    order by t.education,t.post
  
  end
end

------------------------------------------------------------------------
 
else

if @tag = 2

begin

if @title <> '未设置出生日期'

begin
  
declare @f int, @l int  
  
if(@title='20岁以下')  
begin  
	set @f=0  
	set @l=20  
end  
else if (@title='21-25岁')  
begin  
	set @f=21  
	set @l=25  
end  
else if (@title='26-30岁')  
begin  
	set @f=26 
	set @l=30  
end  
else if (@title='31-35岁')  
begin  
	set @f=31  
	set @l=35  
end  
else if (@title='36-40岁')  
begin  
	set @f=36  
	set @l=40  
end  
else if (@title='41-45岁')  
begin  
	set @f=41  
	set @l=45  
end  
else if (@title='46-50岁')  
begin  
	set @f=46  
	set @l=50  
end  
else if (@title='51岁以上')  
begin  
	set @f=51  
	set @l=100  
end  
 


  select 
         u.name 姓名,
         t.title 职位,
         t.education 学历,
         t.post 职称,
         commonfun.dbo.fn_age(u.birthday)年龄
    from  basicdata..teacher t 
				inner join BasicData..[user] u 
					on u.userid = t.userid 
    where  u.kid = @kid
     and u.deletetag = 1 
				and u.usertype = 1 
		and commonfun.dbo.fn_age(u.birthday)between @f and @l
    order by t.education,t.post
    
    -- select commonfun.dbo.fn_age('2001-7-1') as age

end

else begin

  select 
         u.name 姓名,
         t.title 职位,
         t.education 学历,
         t.post 职称,
         commonfun.dbo.fn_age(u.birthday)年龄
    from  basicdata..teacher t 
				inner join BasicData..[user] u 
					on u.userid = t.userid 
    where  u.kid = @kid
     and u.deletetag = 1 
				and u.usertype = 1 
		and nullif(u.birthday,'1900-01-01 00:00:00.000') is NULL
    order by t.education,t.post

end

end

END

GO
