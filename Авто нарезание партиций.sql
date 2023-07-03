-- Авто нарезание партиций
do $do$
declare
    d date;
begin
    for d in
        select generate_series(date '2023-09-18', date '2023-12-31', interval '1 day')
    loop
    execute format($f$
        create table amplitude.events_app%s%s%s partition of amplitude.events_app
        for values from (%L) to (%L)
        $f$, 
        to_char(d, 'YYYY'), to_char(d, '_MM'), to_char(d, '_DD'), d, d+ interval '1 day');
    end loop;
end 
$do$
