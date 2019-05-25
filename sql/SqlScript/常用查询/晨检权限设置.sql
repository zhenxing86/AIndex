use mcapp
go

-- Paradef: @result int(0：电话号码不合格，1：设置成功，2：已存在3个，不能再设置,-1：保存失败)       
--@state 0:删除、1：园长短信、2：校医短信、3：老师短信、4：幼儿离园、5：老师考勤、6：老师管理时光树幼儿资料、7：管理员、园长、老师管理时光树老师资料    
mc_sms_man_setting @kid=12511,@cid=46141,@userid=479936,@state=3,@oldstate=0,@douserid=0,@ipaddr=''