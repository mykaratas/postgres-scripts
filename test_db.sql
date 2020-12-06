
create table public.test_groups (
	name varchar(40) unique primary key not null ,
	test_value int not null
);



create table public.test_cases (
	id serial primary key unique,
	group_name varchar(40) not null,
	status varchar(5) not null,
	foreign key (group_name) references test_groups (name)
);

insert into public.test_groups ("name",test_value) values
	 ('performance',15),
	 ('corner cases',10),
	 ('numerical stability',20),
	 ('memory usage',10);

insert into public.test_cases (group_name,status) values
	 ('memory usage','ok'),
	 ('numerical stability','ok'),
	 ('numerical stability','ok'),
	 ('memory usage','ok'),
	 ('numerical stability','ok'),
	 ('memory usage','error'),
	 ('numerical stability','ok'),
	 ('performance','error'),
	 ('performance','error');


select
	tg."name",
	count(tc.group_name) as all_test_case,
	count(tc.id) filter (where tc.status = 'ok') as passed_all_cased,
	(count(tc.id) filter (where tc.status = 'ok')) * tg.test_value as total_value
from
	public.test_groups  tg
left join public.test_cases tc on
	tc.group_name = tg."name"
	group by
	tg."name"
order by total_value desc ;
