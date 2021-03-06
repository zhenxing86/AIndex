USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetListByName]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      Master谭    
-- Create date: 2013-06-20    
-- Description: 得到用户列表    
-- Memo:      
exec [user_GetListByName]  '潘渡园黄艳',21620,0,1,15 
exec [user_GetListByName2]  '',12511,0,1,15     
*/     
CREATE PROCEDURE [dbo].[user_GetListByName]    
 @name nvarchar(20),    
 @kid  int,    
 @usertype int,    
 @page int,    
 @size int    
AS      
BEGIN    
 SET NOCOUNT ON    
 DECLARE @beginRow INT    
 DECLARE @endRow INT        
    
 SET @beginRow = (@page - 1) * @size    + 1    
 SET @endRow = @page * @size      
 declare @ta table(userid int,account nvarchar(50),name nvarchar(50),gender int,mobile nvarchar(50),cname NVARCHAR(1000))
 
 if @usertype=1
 begin   
 insert into @ta(userid,account,name,gender,mobile,cname)
  SELECT m.userid, m.account, m.name, m.gender, m.mobile,     
    CAST('' AS NVARCHAR(1000))cname  
  FROM     
    (    
     SELECT ROW_NUMBER() OVER(order by u.userid DESC) AS rows,            
         u.userid, u.account, u.name, u.gender, u.mobile    
      FROM [user] u             
        left join leave_kindergarten lk on u.userid = lk.userid    
        
       where lk.userid is  null    
        and u.usertype > 0 
        and u.usertype<>98    
        and u.deletetag = 1     
        and u.kid = @kid     
        and u.name like @name + '%'
    ) AS m     
  WHERE rows BETWEEN @beginRow AND @endRow    
 end
 else
 begin
 insert into @ta(userid,account,name,gender,mobile,cname)
  SELECT m.userid, m.account, m.name, m.gender, m.mobile,     
    CAST('' AS NVARCHAR(1000))cname  
  FROM     
    (    
     SELECT ROW_NUMBER() OVER(order by u.userid DESC) AS rows,            
         u.userid, u.account, u.name, u.gender, u.mobile    
      FROM [user] u             
        left join leave_kindergarten lk on u.userid = lk.userid    
         inner join BasicData..child d on u.userid= d.userid   --过滤掉child表里面没有数据的问题数据  
       where lk.userid is  null     
        and u.kid = @kid     
        and u.name like @name + '%' 
    ) AS m     
  WHERE rows BETWEEN @beginRow AND @endRow  
 end
      
 ;WITH CET AS    
 (    
  select t.userid,    
   STUFF(( SELECT N',' + cname    
        FROM (SELECT DISTINCT c.cname FROM BasicData.dbo.user_class uc     
         inner join BasicData.dbo.class c     
          on uc.cid = c.cid     
          and c.deletetag = 1    
          and t.userid = uc.userid) AS Y    
        FOR XML PATH('')), 1, 1, N'')cname     
    from @ta t     
 )     
 UPDATE t    
  set cname = c.cname    
  FROM @ta t     
   inner JOIN CET c     
    on t.userid = c.userid     
         
 SELECT t.userid, t.account, t.name, t.gender,t.mobile,t.cname,max(c.cardno)     
 FROM @ta t    
 left join mcapp..cardinfo c    
  on t.userid=c.userid and c.usest=1    
  group by t.userid, t.account, t.name, t.gender,t.mobile,t.cname    
       
END 
GO
