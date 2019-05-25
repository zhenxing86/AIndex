
use KWebCMS
go

--sendMobileCode
select commonfun.dbo.fn_cellphone('18122131135')
select * 
--update c set send_count=0
from KWebCMS..Register_Mobile_Code c where mobile='18122131135'   
select * from sms..sms_message_yx_temp where recmobile='18122131135' and writetime>='2019-05-05'

--basicdata..basicdata_user_QuerySmsList 665588      