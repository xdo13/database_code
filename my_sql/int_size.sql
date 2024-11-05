create table hongong4(
tinyint_col TINYINT,
smallint_col smallINT,
int_col INT,
bigint_col bigint);

insert into hongong4 values(127, 32767, 2147483647, 9000000000000000000);

select * from hongong4;