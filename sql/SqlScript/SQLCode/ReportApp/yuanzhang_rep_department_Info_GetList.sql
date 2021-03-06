USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[yuanzhang_rep_department_Info_GetList]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[yuanzhang_rep_department_Info_GetList]   
@kid int  
as   
  
 --with  
 --cet as  
 --(  
 --select d.did,d.dname,COUNT(u.userid) tcount  
 -- from BasicData..department d  
 --  left join BasicData..teacher t  
 --   on t.did=d.did  
 --  left join BasicData..[user] u  
 --   on t.userid=u.userid   
 --  where d.kid=@kid  
 --   and d.deletetag=1  
 --   and u.usertype=1    
 --   and u.deletetag=1  
 --  group by d.did,d.dname,d.[order]  
     
 --  )  
     
 -- select d.did,d.dname,isnull(tcount,0)   
 --  from BasicData..department d  
 --   left join cet c   
 --     on c.did=d.did   
 --    where d.deletetag=1   
 --    and d.kid=@kid  
 --   order by d.[order]  
    
With data1 as (  
select d.did, d.dname, d.superior, d.[order], COUNT(t.userid) tcount  
 from BasicData..department d   
    Left Join (Select t.did, u.userid From BasicData..teacher t, BasicData..[user] u Where t.userid = u.userid and usertype = 1 and u.deletetag = 1) t on t.did=d.did  
  where d.kid = @kid  
   and d.deletetag = 1  
  group by d.did, d.dname, d.[order], d.superior  
), data2 as (  
Select did, dname, [order], (Select Sum(tcount) From data1) tcount  
  From data1  
  Where superior = 0  
Union all  
Select did, dname, [order], tcount  
  From data1  
  Where superior > 0  
)  
Select did, dname, tcount From data2 Order by [order]  
GO
