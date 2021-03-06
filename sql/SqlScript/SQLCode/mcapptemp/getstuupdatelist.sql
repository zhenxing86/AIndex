USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[getstuupdatelist]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------  
--用途：查询记录信息   
--项目名称：  
--说明：  
--时间：2012-10-16 21:55:38  
--[getstuupdatelist] 8812,'000881201'  
--[GetStuInfoUpdateStatus] 12511,'001251102',0,'2013-08-09 09:02:01'  
--[getstuupdatelist] 8812,'00881201',0,'2013-01-05 16:32:45'  
--[getstuupdatelist] 20675,'0002067500',0,'2013-01-05 16:32:45'  
------------------------------------  
CREATE PROCEDURE [dbo].[getstuupdatelist]  
 @kid int,  
 @devid varchar(10),  
 @cnt int,  
 @l_update datetime  
 AS  
BEGIN  
 if(@cnt =0)  
 begin  
 ;with cet as  
 (  
  select uc.userid,uc.name,case uc.sex when '女' then '0' when '男' then '1' end sex,  
      c.cardno,uc.cname,uc.birthday,uc.tts,  
      ROW_NUMBER()over(partition by uc.userid order by c.cardno)rowno  
   from BasicData..user_Child uc    
     left join cardinfo c     
     on uc.userid=c.userid and c.kid= uc.kid   
   where uc.kid = @kid   
    and uc.cid > 0   
    and uc.grade<>38   
 )  
  select userid stuid, ISNULL([1],'') as card1,  
      ISNULL([2],'') card2,ISNULL([3],'') card3,ISNULL([4],'') card4,  
      name, sex, cname,CONVERT(VARCHAR(10),birthday,120) birth, tts  
   from cet   
    pivot(max(cardno) for rowno in([1],[2],[3],[4])) as p  
 end  
 else  
 begin  
 ;with cet as  
 (  
  select uc.userid,uc.name,case uc.sex when '女' then '0' when '男' then '1' end sex,  
      c.cardno,uc.cname,uc.birthday,uc.tts,  
      ROW_NUMBER()over(partition by uc.userid order by c.cardno)rowno  
   from BasicData..user_Child uc    
     left join cardinfo c     
     on uc.userid=c.userid  and c.kid= uc.kid  
   where uc.kid = @kid   
    and uc.updatetime >= @l_update   
    and uc.cid > 0   
    and uc.grade <> 38  
 )  
  select userid stuid, ISNULL([1],'') as card1,  
      ISNULL([2],'') card2,ISNULL([3],'') card3,ISNULL([4],'') card4,  
      name, sex, cname,CONVERT(VARCHAR(10),birthday,120) birth, tts  
   from cet   
    pivot(max(cardno) for rowno in([1],[2],[3],[4])) as p   
  
 end  
END  


GO
