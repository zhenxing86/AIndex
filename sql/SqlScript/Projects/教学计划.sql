select top 6 planbookid,classid,classname,grade,term,[year],createdate 
 fROM ebook..PB_PlanBook
 
 where planbookid=21475
 
 
 select * from BasicData..class where cid=
 
 中三班	36
 
 update ebook..PB_PlanBook set classname='中三班',grade='中班' where planbookid=21475
 update ebook..PB_PlanBook set classname='小三班',grade='小班' where planbookid=27152
 
  select * from basicdata..[user] where account='13870161147'
  
  717418
 
 select top 6 planbookid,classid,classname,term,[year],createdate 
 fROM ebook..PB_PlanBook p
  inner join BasicData..class c
   on p.classid = c.cid 
	and c.kid=21297
 
 where planbookid=27152
 
 