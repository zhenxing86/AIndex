

select * from BasicData..user_child where kid=24082 and cname='小一班'
select * from mcapp..cardinfo where userid in  (1949968,1949969,1988291,1997886,2318876)
select * from mcapp..cardinfo where card ='1328059109' 
select * from mcapp..cardinfo where gate_card ='1328059109' 

--update c set userid=1997886 from mcapp..cardinfo c where card='1307007559'
--update c set userid=1949968 from mcapp..cardinfo c where card='1307009523'
--update c set userid=1949969 from mcapp..cardinfo c where card='1307009239'

3013161600088
3013161600046
3013161600083
dbo.gate_timezones
select * from mcapp..gate_command where kid= 32210 and crtdate>='2017-09-11'
select * from mcapp..cardinfo where card ='1328059109' 
select * from mcapp..cardinfo where gate_card ='1530497386' 
select * from mcapp..gate_rtlog_history where sn='3013161600088' and crtdate>='2017-09-11' and eventtype in(22,27)
select * from mcapp..gate_rtlog_history where sn='3013161600046' and crtdate>='2017-09-11' and eventtype in(22,27)
select * from mcapp..gate_rtlog_history where sn='3013161600083' and crtdate>='2017-09-11' and eventtype in(22,27)

----------------------删除闸机指令------------------------

select * from mcapp..gate_device where kid= 31996 
delete from mcapp..gate_command where kid= 31996 and status<2

