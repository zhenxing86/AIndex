USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetChildListByNameAndUserid]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-07-16  
-- Description: 得到用户列表  
-- Memo:    
EXEC  user_GetChildListByNameAndUserid '黄',561175,1,100
*/    
CREATE PROCEDURE [dbo].[user_GetChildListByNameAndUserid]  
 @name nvarchar(20),    
 @userid  int,    
 @page int,    
 @size int    
AS     
BEGIN  
 SET NOCOUNT ON  
 if @page > 1   
 BEGIN  
  DECLARE @beginRow INT  
  DECLARE @endRow INT  
  SET @beginRow = (@page - 1) * @size    + 1  
  SET @endRow = @page * @size    
      
  SELECT userid, account, name, gender, mobile,cardno   
   FROM   
     (  
      SELECT ROW_NUMBER() OVER(order by uc1.userid DESC) AS rows,   
          uc1.userid,uc1.account,uc1.name, uc1.gender,uc1.mobile,max(c.cardno) cardno
      FROM [user] uc1 
		inner join user_class uc0 on uc1.userid = uc0.userid 
		inner join user_class uc2  on uc0.cid = uc2.cid 
        left join leave_kindergarten lk on uc1.userid=lk.userid
        left join mcapp..cardinfo c on uc1.userid=c.userid and c.usest=1
       WHERE uc2.userid = @userid   
        and uc1.name like @name+'%' 
        and lk.userid is  null
        group by uc1.userid,uc1.account,uc1.name, uc1.gender,uc1.mobile               
     ) AS main_temp   
   WHERE rows BETWEEN @beginRow AND @endRow   
 END  
 ELSE  
 BEGIN   
  SET ROWCOUNT @size    
	SELECT uc1.userid,uc1.account,uc1.name, uc1.gender,uc1.mobile,max(c.cardno)cardno
		FROM [user] uc1 
			inner join user_class uc0 on uc1.userid = uc0.userid 
			inner join user_class uc2  on uc0.cid = uc2.cid 
			left join leave_kindergarten lk on uc1.userid=lk.userid
			left join mcapp..cardinfo c on uc1.userid=c.userid and c.usest=1
		WHERE uc2.userid = @userid   
			and uc1.name like @name+'%' 
			and lk.userid is  null   
		group by uc1.userid,uc1.account,uc1.name, uc1.gender,uc1.mobile       
		ORDER BY uc1.userid DESC    
  END      
END  

GO
