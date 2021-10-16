SELECT e.emp_no,
e.first_name,
e.last_name,
t.title,
t.from_date,
t.to_date
INTO retirement_title
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_title as rt
ORDER BY rt.emp_no ASC, rt.from_date DESC;

-- Count Retiring Employees by Title
Select COUNT(uqt.title) as title_count , uqt.title
INTO retiring_titles
FROM unique_titles as uqt
GROUP BY uqt.title
ORDER BY title_count DESC;

--



