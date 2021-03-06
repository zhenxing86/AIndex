USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[getstuinfolist]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------  
--用途：查询记录信息   
--项目名称：  
--说明：  
--时间：2012-10-16 21:55:38  
--[#getstuinfolist] 12511,'001251101'  
--[getstuinfolist] 17150,'001715001'  
------------------------------------  
CREATE PROCEDURE [dbo].[getstuinfolist]  
 @kid int,  
 @devid varchar(10)  
 AS  
BEGIN  
 SET NOCOUNT ON  
 create table #stuinfolist(oid int)  
  
 insert into #stuinfolist(oid)  
  select oid   
   from stuid_tmp   
   where devid = @devid  
  
 ;with cet as  
 (  
  select uc.userid,uc.name,case uc.sex when '女' then '0' when '男' then '1' end sex,  
      c.cardno, uc.cname, uc.birthday, uc.tts, uc.sname, 
      ROW_NUMBER()over(partition by uc.userid order by c.cardno)rowno  
   from BasicData..user_Child uc    
     inner join cardinfo c     
     on uc.userid=c.userid    
   where uc.kid = @kid   
    and uc.userid not in(select oid from #stuinfolist)  
 )  
  select userid stuid, ISNULL([1],'') as card1,  
      ISNULL([2],'') card2,ISNULL([3],'') card3,ISNULL([4],'') card4,  
      name, sex, cname,CONVERT(VARCHAR(10),birthday,120) birth, tts ,sname 
   from cet   
    pivot(max(cardno) for rowno in([1],[2],[3],[4])) as p  
END  
GO
