USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetTeacherListByDid]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*   select *from basicdata..department where kid=24675      
-- Author:      Master谭        
-- Create date: 2013-06-20        
-- Description: 得到教师列表        
-- Memo:          
exec [user_GetTeacherListByDid] 74404,1,111     
*/         
CREATE PROCEDURE [dbo].[user_GetTeacherListByDid]        
 @did int,        
 @page int,        
 @size int        
AS         
BEGIN         
 SET NOCOUNT ON        
 DECLARE @beginRow INT        
 DECLARE @endRow INT            
   DECLARE @kid INT        
 SET @beginRow = (@page - 1) * @size    + 1        
 SET @endRow = @page * @size          
  select @kid=kid from basicdata..department where did=@did and deletetag=1   
    
      declare @temp_user_class table(userid int,cid int)    
      
  insert into @temp_user_class(userid,cid)     
  select u.userid,uc.cid from BasicData..[user] u    
  left join basicdata..user_class uc  on u.userid=uc.userid  and deletetag=1   
  where u.kid=@kid         
    if(@kid=22808  )      
  begin      
     SELECT m.userid, m.account, m.name, m.gender, m.mobile,         
    CAST('' AS NVARCHAR(500))cname        
  INTO #TB        
  FROM         
    (        
    SELECT ROW_NUMBER() OVER(order by c.grade desc,c.[order] desc ,ut.title) AS rows,        
         ut.userid,ut.account,ut.name,ut.gender,ut.mobile       
      FROM [User_Teacher] ut       
        INNER JOIN get_department_subsid(@did)g ON ut.did = g.did      
       left join ( select userid,MAX(cid) cid from @temp_user_class tuc group by userid) tt on ut.userid=tt.userid    
        left join BasicData..class c on tt.cid=c.cid and c.deletetag=1 and c.iscurrent=1    
      WHERE ut.usertype <> 98      
       AND ut.kid > 0       
    ) AS m         
  WHERE rows BETWEEN @beginRow AND @endRow        
           
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
    from #TB t         
 )         
 UPDATE t        
  set cname = c.cname        
  FROM #TB t         
   inner JOIN CET c         
    on t.userid = c.userid         
          
     SELECT t.*,c.cardno FROM #TB t        
 left join mcapp..cardinfo c        
  on t.userid=c.userid and c.usest=1       
   --22808结束      
  end      
  else if(@kid=5213)      
  begin      
     SELECT m.userid, m.account, m.name, m.gender, m.mobile,         
    CAST('' AS NVARCHAR(500))cname        
  INTO #TC        
  FROM         
    (        
    SELECT ROW_NUMBER() OVER(order by c.grade desc,c.[order]) AS rows,        
         ut.userid,ut.account,ut.name,ut.gender,ut.mobile       
      FROM [User_Teacher] ut       
        INNER JOIN get_department_subsid(@did)g ON ut.did = g.did      
       left join ( select userid,MAX(cid) cid from @temp_user_class tuc group by userid) tt on ut.userid=tt.userid    
        left join BasicData..class c on tt.cid=c.cid and c.deletetag=1 and c.iscurrent=1    
      WHERE ut.usertype <> 98      
       AND ut.kid > 0       
    ) AS m         
  WHERE rows BETWEEN @beginRow AND @endRow        
           
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
    from #TC t         
 )         
 UPDATE t        
  set cname = c.cname        
  FROM #TC t         
   inner JOIN CET c         
    on t.userid = c.userid         
          
     SELECT t.*,c.cardno FROM #TC t        
 left join mcapp..cardinfo c        
  on t.userid=c.userid and c.usest=1       
   --22808结束      
  end      
  else      
  begin     
  
      
      
     SELECT m.userid, m.account, m.name, m.gender, m.mobile,         
    CAST('' AS NVARCHAR(500))cname        
  INTO #TA        
  FROM         
    (        
     SELECT ROW_NUMBER() OVER(order by c.grade desc,c.[order]) AS rows,          
         ut.userid,ut.account,ut.name,ut.gender,ut.mobile        
      FROM [User_Teacher] ut       
        INNER JOIN get_department_subsid(@did)g         
        ON ut.did = g.did        
      left join ( select userid,MAX(cid) cid from @temp_user_class tuc group by userid) tt on ut.userid=tt.userid    
        left join BasicData..class c on tt.cid=c.cid and c.deletetag=1 and c.iscurrent=1    
          
      WHERE ut.usertype <> 98        
       AND ut.kid > 0        
    ) AS m         
  WHERE rows BETWEEN @beginRow AND @endRow        
           
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
    from #TA t         
 )         
 UPDATE t        
  set cname = c.cname        
  FROM #TA t         
   inner JOIN CET c         
    on t.userid = c.userid         
          
 --    SELECT t.*,c.cardno FROM #TA t        
 --left join mcapp..cardinfo c        
 -- on t.userid=c.userid and c.usest=1   
  
   SELECT t.userid, t.account, t.name, t.gender,t.mobile,t.cname,max(c.cardno)   
 FROM #TA t  
 left join mcapp..cardinfo c  
  on t.userid=c.userid and c.usest=1  
  group by t.userid, t.account, t.name, t.gender,t.mobile,t.cname  
  
       
  end      
      
             
      
END 
GO
