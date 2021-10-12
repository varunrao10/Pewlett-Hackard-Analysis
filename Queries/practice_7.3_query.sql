SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';


-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info
DROP TABLE retirement_info

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

------------------------------------------------------------------------------
-- Joining departments and dept_manager tables
SELECT dep.dept_name,
     m.emp_no,
     m.from_date,
     m.to_date
FROM departments as dep
INNER JOIN managers as m
ON dep.dept_no = m.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT rinfo.emp_no,
	rinfo.first_name,
	rinfo.last_name,
	demp.to_date
FROM retirement_info as rinfo
LEFT JOIN dept_emp as demp
ON rinfo.emp_no = demp.emp_no;

-- Create new table for current employees
SELECT rinfo.emp_no,
	rinfo.first_name,
	rinfo.last_name,
	demp.to_date
INTO current_emp
FROM retirement_info as rinfo
LEFT JOIN dept_emp as demp
ON rinfo.emp_no = demp.emp_no
WHERE demp.to_date = ('9999-01-01');

select * from current_emp
-------------------------------------------------
-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO retire_by_department
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;


SELECT * FROM salaries
ORDER BY to_date DESC;

--Create Employee info table including people who will retire soon but are still working
SELECT e.emp_no, e.first_name, e.last_name, e.gender, s.salary, de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON e.emp_no = s.emp_no
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');


-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM managers AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);

-- new current employee table with department info
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
 INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no);

--Tailored list relevant to sales team (Skill drill)
SELECT ri.emp_no,
ri.first_name,
ri.last_name,
d.dept_name
FROM retirement_info as ri
INNER JOIN dept_emp as de
ON (ri.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE (d.dept_name = 'Sales')

--Tailored list relevant to sales AND development team for mentor program (Skill drill)
SELECT ri.emp_no,
ri.first_name,
ri.last_name,
d.dept_name
FROM retirement_info as ri
INNER JOIN dept_emp as de
ON (ri.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE (d.dept_name IN ('Sales', 'Development'))