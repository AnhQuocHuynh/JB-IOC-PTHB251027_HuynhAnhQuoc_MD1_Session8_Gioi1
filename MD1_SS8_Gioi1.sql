create table employees (
                           emp_id serial primary key,
                           emp_name varchar(100),
                           job_level int,
                           salary numeric
);

insert into employees (emp_name, job_level, salary) values
                                                        ('john doe', 1, 500),
                                                        ('jane smith', 2, 800),
                                                        ('michael brown', 3, 1200),
                                                        ('sarah lee', 4, 2000),
                                                        ('david kim', 5, 3000);

-- 1. Tạo Procedure adjust_salary(p_emp_id INT, OUT p_new_salary NUMERIC) để:
-- Nhận emp_id của nhân viên
-- Cập nhật lương theo quy tắc trên
-- Trả về p_new_salary (lương mới) sau khi cập nhật
create or replace procedure adjust_salary(p_emp_id INT, OUT p_new_salary NUMERIC)
language plpgsql
as
    $$
    declare
        emp_level int;
        begin
        select job_level
        into emp_level
        from employees
        where emp_id = p_emp_id;

        if emp_level = 1 then
                update employees
                set salary = salary * 1.05
                where emp_id = p_emp_id;
            elsif emp_level = 2 then
                update employees
                set salary = salary * 1.1
                where emp_id = p_emp_id;
            elsif emp_level = 3 then
                update employees
                set salary = salary * 1.15
                where emp_id = p_emp_id;
        else
            raise notice 'khong co quy tac tang luong cho job_level: %', emp_level;
            end if;
        select employees.salary
        into p_new_salary
        from employees
        where emp_id = p_emp_id;

        raise notice 'da cap nhat luong nhan vien id % -> luong moi: %', p_emp_id, p_new_salary;
        end;
    $$;

-- 2. Thuc thi thu
call adjust_salary(1);
select current_database(), current_schema();
