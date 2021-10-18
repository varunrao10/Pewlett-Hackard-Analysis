DROP TABLE retirement_title
--Deliverable 1
SELECT e.emp_no,
e.first_name,
e.last_name,
t.title,
t.from_date,
t.to_date
--INTO retirement_title
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

DROP TABLE unique_titles;
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
--INTO unique_titles
FROM retirement_title as rt
ORDER BY rt.emp_no, to_date DESC

DROP TABLE retiring_titles;
-- Count Retiring Employees by Title
Select COUNT(uqt.title) as title_count , uqt.title
--INTO retiring_titles
FROM unique_titles as uqt
GROUP BY uqt.title
ORDER BY title_count DESC;

-- Deliverable 2

--Mentorship Eligibility table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date
--INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (de.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')

SELECT COUNT(DISTINCT e.emp_no) as Employees_Between_1956_to_1964
FROM employees as e
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (de.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1956-01-01' AND '1964-12-31')

