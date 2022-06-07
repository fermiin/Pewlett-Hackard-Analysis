--new table for retirement titles using employees and titles tables

SELECT employees.emp_no, employees.first_name, employees.last_name, titles.title, titles.from_date, titles.to_date
INTO retirement_titles
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

INTO unique_titles
FROM retirement_titles
WHERE to_date = ('9999-01-01')
ORDER BY emp_no, to_date DESC;

--query to retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT(title)
INTO retiring_titles 
FROM unique_titles
GROUP BY title
ORDER BY count DESC;


--Mentorship eligiblilty table
SELECT employees.emp_no, employees.first_name, employees.last_name, employees.birth_date, 
dept_emp.from_date, dept_emp.to_date, 
titles.title
INTO combined_table
FROM 
    employees
        INNER JOIN
    dept_emp
        ON employees.emp_no = dept_emp.emp_no
        INNER JOIN 
    titles 
        On employees.emp_no = titles.emp_no
ORDER BY emp_no


SELECT DISTINCT ON (emp_no) emp_no,
first_name, last_name,
birth_date, from_date, to_date, 
title
INTO mentorship_eligibility
FROM combined_table
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
    AND (to_date = '9999-01-01');
ORDER BY emp_no




