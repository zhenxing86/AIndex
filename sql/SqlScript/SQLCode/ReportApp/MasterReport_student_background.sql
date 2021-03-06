USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[MasterReport_student_background]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	yz  
-- Create date: 2014-8-14
-- Description:	幼儿家庭背景主表
--[reportapp].[dbo].[MasterReport_student_background]12511
-- =============================================
CREATE PROCEDURE [dbo].[MasterReport_student_background]
@kid int,
@mtype int = 0

AS
BEGIN

select '掌握本园幼儿的家庭背景的分布情况<br />可以更好地决定本园的定位、收费等运营策略'string
 
  if @mtype not in (2,3,4)
  begin
	select c.profession title,
	       COUNT(c.ID)cnt 
	  from BasicData..ChildDetails c
	    inner join BasicData..[user] u
	      on c.uid = u.userid
	 where u.kid = @kid
	    and u.deletetag = 1
	 group by c.profession
	 order by cnt desc
	 end
	 
	if @mtype not in (1,3,4)
  begin
	select c.education title,
	       COUNT(c.ID)cnt 
	  from BasicData..ChildDetails c
	    inner join BasicData..[user] u
	      on c.uid = u.userid
	 where u.kid = @kid
	  and u.deletetag = 1
	 group by c.education
	 order by cnt desc
	 end
	 
	 if @mtype not in (2,1,4)
  begin
	select c.isstay title,
	       COUNT(c.ID)cnt 
	  from BasicData..ChildDetails c
	    inner join BasicData..[user] u
	      on c.uid = u.userid
	      
	 where u.kid = @kid
	  and u.deletetag = 1
	 group by c.isstay
	 order by cnt desc
	 end
	 
	 if @mtype not in (2,3,1)
  begin
	select c.income title,
	       COUNT(c.ID)cnt 
	  from BasicData..ChildDetails c
	    inner join BasicData..[user] u
	      on c.uid = u.userid
	 where u.kid = @kid
	  and u.deletetag = 1
	 group by c.income
	 order by cnt desc
	 end


END

GO
