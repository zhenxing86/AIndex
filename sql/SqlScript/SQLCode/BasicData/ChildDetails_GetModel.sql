USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[ChildDetails_GetModel]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-08-01  
-- Description:   
-- Memo:    
ChildDetails_GetModel 864592  
*/  
CREATE PROCEDURE [dbo].[ChildDetails_GetModel]  
 @id int  
AS  
 SET NOCOUNT ON   
 SELECT 1, c.ID, c.uid, c.ename, c.cardtype, c.cardno, c.hometown, c.householdtype, c.householdaddress,  
     c.isone, c.isstay, c.iscity, c.isdis, c.distype, c.isboarding, c.isonly, c.isdown, c.isaccept, c.parentname1,   
     c.parentcardno1, c.parentname2, c.parentcardno2, c.nation, u.userid, u.account, u.[name],   
     u.birthday, u.gender, u.mobile, u.enrollmentdate, c.overseas, c.country, c.cardtype1, c.cardtype2, c.[address],u.enrollmentreason,c.profession,c.education,c.income
  FROM [user] u   
   left join  [ChildDetails] c   
    on c.uid = u.userid  
  WHERE u.userid = @id  
GO
