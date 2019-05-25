use GBApp
go

/*------------------------------------        
--用途：得到用户的详细信息        
--项目名称：ArchivesApply        
--说明：下载成长档案        
--时间：-1-6 11:50:29        


select *from basicdata..[user] where userid=875110
select * from [GBAPP]..[archives_apply] where kid= 24072 and term='2014-1'   
  
exec ArchivesApply_Batch_Add 24072,'2014-1' 

------------------------------------*/        
alter  PROCEDURE [dbo].[ArchivesApply_Batch_Add]        
@kid int,
@term nvarchar(6)
as
begin

INSERT INTO [GBAPP]..[archives_apply]([gbid],[gid],[gname],[cid],[cname],[kid],[kname],[userid],[username]   
,[applytime],[handletime],[telephone],[modules],[term],[status],[deletetag],[url],flag)  
select [gbid],g.[gid],g.[gname],ca.[cid],ca.[cname],k.[kid],k.[kname],u.[userid],u.[name] username
,GETDATE(),GETDATE(),u.mobile,'',gb.[term],0,1,'',1
 from BasicData..[user] u         
   inner join BasicData..user_class_all uca     
    on uca.userid =u.userid and uca.term=@term and u.usertype=0 and u.deletetag=1 and uca.deletetag=1     
   inner join BasicData..class_all ca     
    on ca.cid =uca.cid and uca.term=ca.term      
   inner join BasicData..kindergarten k     
    on k.kid=ca.kid        
   inner join NGBApp..GrowthBook gb     
    on gb.userid = u.userid and gb.term=@term        
   inner join BasicData..grade g on g.gid = ca.grade          
   where u.kid=@kid and not exists(
	select * from archives_apply a where a.gbid=gb.gbid
   )
end