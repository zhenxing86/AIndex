USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[MasterReport_student_background_detail]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	yz  
-- Create date: 2014-8-13
-- Description:	幼儿家庭背景明细
--[reportapp].[dbo].[MasterReport_student_background_detail] 3,12511,'中等收入'
-- =============================================
CREATE PROCEDURE [dbo].[MasterReport_student_background_detail]
@tag int,
@kid int,    
@title varchar(50)
  
AS
BEGIN

if @tag = 0

begin

  select cl.cname 班级,
         u.name 幼儿姓名
   from BasicData..ChildDetails c
	    inner join BasicData..[user] u
	      on c.uid = u.userid
	    inner join BasicData..user_class uc
	      on u.userid = uc.userid
	    inner join BasicData..class cl
	      on cl.cid =uc.cid
	 where u.kid = @kid
	    and u.deletetag = 1
	    and c.profession = @title
end

--------------------------------------------------------------------

else if @tag = 1

begin
  select cl.cname 班级,
         u.name 幼儿姓名
   from BasicData..ChildDetails c
	    inner join BasicData..[user] u
	      on c.uid = u.userid
	    inner join BasicData..user_class uc
	      on u.userid = uc.userid
	    inner join BasicData..class cl
	      on cl.cid =uc.cid
	 where u.kid = @kid
	    and u.deletetag = 1
	    and c.education = @title

end
--------------------------------------------------------------------

else if @tag = 2

begin
 
  select cl.cname 班级,
         u.name 幼儿姓名
   from BasicData..ChildDetails c
	    inner join BasicData..[user] u
	      on c.uid = u.userid
	    inner join BasicData..user_class uc
	      on u.userid = uc.userid
	    inner join BasicData..class cl
	      on cl.cid =uc.cid
	 where u.kid = @kid
	    and u.deletetag = 1
	    and c.isstay = @title
  
end
--------------------------------------------------------------------

else if @tag = 3

begin
  select cl.cname 班级,
         u.name 幼儿姓名
   from BasicData..ChildDetails c
	    inner join BasicData..[user] u
	      on c.uid = u.userid
	    inner join BasicData..user_class uc
	      on u.userid = uc.userid
	    inner join BasicData..class cl
	      on cl.cid =uc.cid
	 where u.kid = @kid
	    and u.deletetag = 1
	    and c.income = @title
end
--------------------------------------------------------------------

END

GO
