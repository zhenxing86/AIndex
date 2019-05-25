/*--程序默认迟到/早退时间
DateTime time1 = Convert.ToDateTime(time + " " + (e.Time1 == null ? "8:00" : e.Time1) + " :01.001");
DateTime time2 = Convert.ToDateTime(time + " " + (e.Time2 == null ? "12:00" : e.Time2) + " :01.001");
DateTime time3 = Convert.ToDateTime(time + " " + (e.Time3 == null ? "14:00" : e.Time3) + " :01.001");
DateTime time4 = Convert.ToDateTime(time + " " + (e.Time4 == null ? "17:30" : e.Time4) + " :01.001");
DateTime time5 = Convert.ToDateTime(time + " " + (e.Time5 == null ? "20:00" : e.Time5) + " :01.001");
DateTime time6 = Convert.ToDateTime(time + " " + (e.Time6 == null ? "22:00" : e.Time6) + " :01.001");
*/

 默认迟到：8:00--12:00  早退： 14:00--17:30

                 
declare
@kid int ='22010'
,@time1 nvarchar(10)='07:40'
,@time2 nvarchar(10)='12:00'
,@time3 nvarchar(10)='14:00'
,@time4 nvarchar(10)='17:30'
,@time5 nvarchar(10)='20:00'
,@time6 nvarchar(10)='22:00'
;With Data as (  
	select kid,1 usertype,did,@time1 time1,@time2 time2,@time3 time3,@time4 time4,@time5 time5,@time6 time6
	 from BasicData..department
	 where kid =@kid 
)  
Merge cardapp..attendancetimeset a
Using Data b On a.kid=b.kid and a.departmentid=b.did
When Matched Then  
Update Set time1=b.time1,time2=b.time2,time3=b.time3,time4=b.time4,time5=b.time5,time6=b.time6
When not Matched Then  
Insert (kid,usertype,departmentid,time1,time2,time3,time4,time5,time6) 
 Values(b.kid,b.usertype,b.did,b.time1,b.time2,b.time3,b.time4,b.time5,b.time6); 

--7：30  下班时间为5：30

--24152	 福州中茵名仕幼儿园这家幼儿园的考勤那里的上班时间麻烦帮改成设置在7:46
--select *from cardapp..attendancetimeset  where kid =22010


declare
@kid int ='3638'
,@time1 nvarchar(10)='07:30'
,@time2 nvarchar(10)='12:00'
,@time3 nvarchar(10)='14:40'
,@time4 nvarchar(10)='17:40'
,@time5 nvarchar(10)='20:00'
,@time6 nvarchar(10)='22:00'
;With Data as (  
	select kid,1 usertype,did,@time1 time1,@time2 time2,@time3 time3,@time4 time4,@time5 time5,@time6 time6
	 from BasicData..department
	 where kid =@kid and did<>50607
)  
Merge cardapp..attendancetimeset a
Using Data b On a.kid=b.kid and a.departmentid=b.did
When Matched Then  
Update Set time1=b.time1,time2=b.time2,time3=b.time3,time4=b.time4,time5=b.time5,time6=b.time6
When not Matched Then  
Insert (kid,usertype,departmentid,time1,time2,time3,time4,time5,time6) 
 Values(b.kid,b.usertype,b.did,b.time1,b.time2,b.time3,b.time4,b.time5,b.time6); 
 
---]

declare
@kid int ='3638'
,@time1 nvarchar(10)='07:30'
,@time2 nvarchar(10)='10:30'
,@time3 nvarchar(10)='11:30'
,@time4 nvarchar(10)='14:40'
,@time5 nvarchar(10)='16:00'
,@time6 nvarchar(10)='17:20'
;With Data as (  
	select kid,1 usertype,did,@time1 time1,@time2 time2,@time3 time3,@time4 time4,@time5 time5,@time6 time6
	 from BasicData..department
	 where kid =@kid and did=50607
)  
Merge cardapp..attendancetimeset a
Using Data b On a.kid=b.kid and a.departmentid=b.did
When Matched Then  
Update Set time1=b.time1,time2=b.time2,time3=b.time3,time4=b.time4,time5=b.time5,time6=b.time6
When not Matched Then  
Insert (kid,usertype,departmentid,time1,time2,time3,time4,time5,time6) 
 Values(b.kid,b.usertype,b.did,b.time1,b.time2,b.time3,b.time4,b.time5,b.time6); 
 
 
 
