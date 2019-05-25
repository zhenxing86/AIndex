--[26224]深圳市罗湖区鹿茵幼儿园第一篇食谱幼儿园反映收不到短信，对方表示上传的时候勾选 下周食谱 发送短信。麻烦技术帮忙查询一下原因，谢谢！

select * from KWebCMS..recipe where siteid=26224
select * from KWebCMS..recipe_sms where siteid=26224 and contentid=583359  --5712 583359


select * from BasicData..User_Child where kid=26224

insert into KWebCMS..recipe_sms_error( siteid,categoryid,contentid,title,sendtime,content,errorlog,Sendusercount,sendsmscount)                 
   values( @siteid,@categoryid,@contentid,@title,@sendtime,@content,'短信数量不足',@total_man_num,@total_smscount)  
   
select * from KWebCMS..recipe_sms_error where siteid=26224    
select * from sms..sms_batch where kid=26224


INSERT INTO sms_batch(sender, smscontent, Sendusercount, sendsmscount, sendtime,                         
      kid, sendtype, recobjid, sendmode, xuanwu, yimei, xian, cid,smstype,appsend)                          
      SELECT @douserid, @content, @man_num, @smscount, @sendtime, @siteid, 3,                         
       @recuserid, 1, ISNULL(@xuanwu,0), ISNULL(@yimei,0), ISNULL(@xian,0), @cid, 7,0                                           
      select @taskid = ident_current('sms_batch')       
      set @taskids = @taskids+','+ cast(@taskid as varchar)    