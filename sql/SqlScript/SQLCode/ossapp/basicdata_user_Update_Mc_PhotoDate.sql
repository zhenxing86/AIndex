use ossapp
go
/*    
--author: xie  ossapp    
--date：2014-03-31    
--dest:更新了晨检照片后对应修改 basicdata..[user] 的mc_photo_udate    
--memo:    
    
exec basicdata_user_Update_Mc_PhotoDate  295765    
*/    
    
alter PROCEDURE basicdata_user_Update_Mc_PhotoDate    
@userid int,  
@photopath Varchar(100) = '',  
@photoname Varchar(100) = ''  
AS      
set nocount on    
   
update BasicData..[user] set  mc_photo_udate = GETDATE() where userid =@userid    

if @photopath ='' or @photoname =''
begin
	Update mcapp.dbo.Mc_Photo Set photodate = GETDATE() where userid=@userid  
end 
else
begin
	;With Data as (  
	Select @userid userid, @photopath photopath, @photoname photoname  
	)  
	Merge mcapp.dbo.Mc_Photo a  
	Using Data b ON a.userid = b.userid and a.photopath = b.photopath and a.photoname = b.photoname  
	When Matched Then   
	Update Set photodate = GETDATE()    
	When Not Matched Then  
	Insert (userid, photopath, photoname, photodate) Values(b.userid, b.photopath, b.photoname, GETDATE());  
end

if @@ERROR<>0    
  return -1    
else return 1    
  
  
  --select * from mcapp.dbo.Mc_Photo where userid in(787094,288548,786893) and photoname ='' 
  --select * from mcapp.dbo.Mc_Photo where photodate>='2014-12-01'
  
--select * from mcapp.dbo.Mc_Photo where photoname ='' and photodate<='2014-11-01'


