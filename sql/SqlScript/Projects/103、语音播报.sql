
       
select c.cname,
   STUFF(
   ( SELECT N',' + name  
        FROM (SELECT top 10 uc.name FROM [User_child] uc  
         where uc.cid = c.cid) AS Y  
        FOR XML PATH('') 
        ), 1, 1, N'')username   
    from BasicData.dbo.class c
    WHERE c.kid =12511 and c.deletetag=1
    
    
select * from basicdata..[User] u
 inner join basicdata..user_class uc 
  on u.userid= uc.userid and u.usertype=1 and u.deletetag=1
   where kid =21666 and cid=104618
--select * from McOutSchool where kid =295765
select c.card,* 
 from basicdata..user_child uc     
   inner join mcapp..cardinfo c        
    on uc.userid = c.userid and c.kid=21666
    
select c.userid, m.cdate,ROW_NUMBER()over (partition by c.userid order by m.cdate desc) rows  
--delete m      
  from McOutSchool m        
   inner join mcapp..cardinfo c        
    on m.card = c.card and c.kid=21666 and convert(nvarchar(10),m.cdate,120)='2016-02-01'

insert into McOutSchool(card,cdate) values('1303000762',GETDATE())
insert into McOutSchool(card,cdate) values('1303000763',GETDATE())
dbo.Send_And_Notice
insert into McOutSchool(card,cdate) values('1303000764',GETDATE())
insert into McOutSchool(card,cdate) values('1303000765',GETDATE())
insert into McOutSchool(card,cdate) values('1303000766',GETDATE())
insert into McOutSchool(card,cdate) values('1303000767',GETDATE())
insert into McOutSchool(card,cdate) values('1303000768',GETDATE())
insert into McOutSchool(card,cdate) values('1303000769',GETDATE())
insert into McOutSchool(card,cdate) values('1303000770',GETDATE())
insert into McOutSchool(card,cdate) values('1303000752',GETDATE())

select * from cardinfo where Card= '1303000767'
select * 
--update u set tts='ÒëÐÄ'
 from basicdata..[USER] u where userid=1054567 
 
 
 select top 1 *from mcapp..stu_mc_day_raw where kid =21666 and tw='36.2'
 select top 1 *from mcapp..stu_mc_day_raw where kid =21666 and adate>='2016-02-16 14:20'
 
 
 select  *from mcapp..Mc_Pic where crtdate>='2016-02-16'
 select  *from mcapp..stu_mc_day_raw where adate>='2016-02-16'