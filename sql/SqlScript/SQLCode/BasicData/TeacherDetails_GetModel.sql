USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[TeacherDetails_GetModel]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-08-01  
-- Description:   
-- Memo:    
TeacherDetails_GetModel 296418  
*/  
CREATE PROCEDURE [dbo].[TeacherDetails_GetModel]   
 @id int  
AS  
BEGIN   
 SET NOCOUNT ON  
 SELECT 1, c.ID, c.uid, c.ename, c.cardtype, c.cardno, c.hometown, c.country, c.nativeplace,   
     c.overseas, c.householdtype, c.householdaddress, c.establishment, c.isedu,   
     c.teacherno, c.workdate, c.healthinfo, c.income, c.social, c.pension, c.medical,   
     c.nation, c.address, c.lastyearinfo, c.basemoney, c.lastyearmoney,   
     c.ishousingreserve, c.isteachercert, c.issuingauthority, c.teachercerttype,   
     c.islostinsurance, c.isbusinessinsurance, c.isbirthinsurance, c.otherallowances,   
     c.achievements, u.name, u.account, u.mobile, u.enrollmentdate, u.birthday,u.gender  
  FROM [user] u  
   left join TeacherDetails c on c.uid = u.userid     
  WHERE u.userid = @id  
END  
GO
