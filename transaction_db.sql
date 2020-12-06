CREATE TABLE PUBLIC.TRANSACTIONS (
	AMOUNT INT NOT NULL ,
	DATE DATE NOT NULL
);
--
---- Given table 1
insert into public.transactions (amount, "date") values(1000, '2020-01-06');
insert into public.transactions (amount, "date") values(-10, '2020-01-14');
insert into public.transactions (amount, "date") values(-75, '2020-01-20');
insert into public.transactions (amount, "date") values(-5, '2020-01-25');
insert into public.transactions (amount, "date") values(-4, '2020-01-29');
insert into public.transactions (amount, "date") values(2000, '2020-03-10');
insert into public.transactions (amount, "date") values(-75, '2020-03-12');
insert into public.transactions (amount, "date") values(-20, '2020-03-15');
insert into public.transactions (amount, "date") values(40, '2020-03-15');
insert into public.transactions (amount, "date") values(-50, '2020-03-17');
insert into public.transactions (amount, "date") values(200, '2020-10-10');
insert into public.transactions (amount, "date") values(-200, '2020-10-10');

select
	sum(dd.sum_amount) - 60 - sum(dd.calculate) as balance
from
	(
	select
		(
		case
			when ((count(*) filter (
		where
			t.amount < 0)) >= 3)
			and (sum(t.amount) filter (
		where
			t.amount < 0) <= -100) then -5
		end) as calculate,
		sum(t.amount) as sum_amount
	from
		transactions t
	group by
		DATE_TRUNC('month', t."date") ) as dd



--select --to_char(date, 'Mon') as mon,
--
----       sum(t.amount) as "sum_amount",
----       count(t.amount) as "count_amount",
----     ((count(*) filter (where t.amount < 0)) >=  3) as negative_count,
-- --     (sum(t.amount) filter (where t.amount < 0) <= -100)  as negative_100,
----     count(*) filter (where ((count(*) filter (where t.amount < 0)) >=  3) and true)  as total_calc
--
--           ( case
--		when  ((count(*) filter (where t.amount < 0)) >=  3) and (sum(t.amount) filter (where t.amount < 0) <= -100) then sum(t.amount -5)  else sum(t.amount + 5)
--	end) as calculate
--
--
--from transactions t
--group by DATE_TRUNC('month',t."date")
--
--
--SELECT
--
--           ( case
--		when  ((count(*) filter (where t.amount < 0)) >=  3) and (sum(t.amount) filter (where t.amount < 0) <= -100) then -5
--	end) as calculate
--FROM transactions t
--group by DATE_TRUNC('month',t."date")
--
--
--select ((count(*) filter (where t.amount < 0)) >=  3) , ((count(*) filter (where t.amount < 0)) >=  3) and (sum(t.amount) filter (where t.amount < 0) <= -100) as iscalc
--from transactions t
--group by DATE_TRUNC('month',t."date")
--




