
--32100
select * from mcapp..cardinfo where gate_card='1318561685'

select * from mcapp..gate_device where kid=32100
select * from mcapp..gate_rtlog where pin=67790

select * from mcapp..gate_rtlog_history where sn='DDG7020087012100462' and crtdate>='2018-02-28'
select * from mcapp..gate_rtlog_history where sn='DDG7040087021700198' and crtdate>='2018-02-28'