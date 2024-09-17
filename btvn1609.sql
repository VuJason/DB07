
-- 1)	Hiển thị tất cả thông tin của bảng "employees"
SELECT * FROM employees e; 

-- 2)	Hiển thị tên và lương của tất cả nhân viên
SELECT e.employee_name, e.salary  FROM employees e ;

-- 3)	Hiển thị thông tin của những nhân viên có lương lớn hơn 50000
SELECT * FROM employees e 
WHERE e.salary > 50000;

-- 4)	Hiển thị số lượng nhân viên trong mỗi phòng ban
SELECT d.department_name, COUNT(e.employee_id) FROM employees e 
JOIN departments d ON e.department_id = d.department_id 
GROUP BY d.department_name;

-- 5)	Sắp xếp danh sách nhân viên theo tên từ A-Z
SELECT * FROM employees e 
ORDER BY e.employee_name ASC ;

-- 6)	Hiển thị tên, lương và phòng ban của những nhân viên có lương từ 40000 đến 60000, sắp xếp theo lương giảm dần
SELECT e.employee_name, e.salary, d.department_name FROM employees e 
JOIN departments d ON e.department_id = d.department_id 
WHERE e.salary BETWEEN 40000 AND 60000;

-- 7)	Tính tổng lương của tất cả nhân viên
SELECT SUM(e.salary) AS "Tổng Lương" FROM employees e;

-- 8)	Hiển thị tên của nhân viên và tên phòng ban của họ
SELECT e.employee_name, d.department_name FROM employees e 
JOIN departments d ON e.department_id = d.department_id ;

-- 9)	Tìm những phòng ban có ít nhất 3 nhân viên
SELECT d.department_name, COUNT(e.employee_id) AS number_member FROM employees e 
JOIN departments d ON e.department_id = d.department_id 
GROUP BY d.department_name 
HAVING number_member >= 3 ;

-- 10)	Hiển thị tên nhân viên và lương của những nhân viên ở phòng ban "IT" hoặc "Sales"
SELECT e.employee_name, e.salary, d.department_name  FROM employees e 
JOIN departments d ON e.department_id = d.department_id 
WHERE d.department_name like 'IT' OR d.department_name LIKE 'Sales';



-- 11)	Hiển thị tên và ngày bắt đầu làm việc của những nhân viên được tuyển dụng sau năm 2020
SELECT e.employee_name, e.start_date FROM employees e
WHERE YEAR(e.start_date) > 2020;

-- 12)	Tính trung bình lương của nhân viên
SELECT AVG(e.salary) AS "Lương trung bình" FROM employees e;

-- 13)	Hiển thị danh sách các phòng ban và số lượng nhân viên trong mỗi phòng ban, kể cả những phòng ban không có nhân viên
SELECT d.department_name, COUNT(e.employee_name) AS "Số lượng nhân viên"  FROM employees e 
RIGHT JOIN departments d ON e.department_id = d.department_id 
GROUP BY d.department_name ;


-- 14)	Hiển thị 5 nhân viên có lương cao nhất
SELECT e.employee_name FROM employees e 
ORDER BY e.salary DESC 
LIMIT 5;

-- 15)	Tìm những nhân viên có tên bắt đầu bằng chữ "A"
SELECT e.employee_name FROM employees e 
WHERE e.employee_name like "A%";

-- 16)	Hiển thị tên nhân viên và tên quyền truy cập của những người có quyền là "Admin"
SELECT e.employee_name, ar.access_level FROM employees e
JOIN access_rights ar ON e.employee_id = ar.employee_id 
WHERE ar.access_level LIKE 'Admin';


-- 17)	Tính tổng lương cho mỗi phòng ban và sắp xếp theo tổng lương giảm dần
SELECT d.department_name, SUM(e.salary) AS "Tổng lương" FROM employees e 
JOIN departments d ON e.department_id = d.department_id 
GROUP BY d.department_name 
ORDER BY "Tổng lương" DESC 

-- 18)	Hiển thị danh sách nhân viên và ngày bắt đầu làm việc, sắp xếp theo ngày bắt đầu làm việc tăng dần
SELECT e.employee_name, e.start_date FROM employees e 
ORDER BY e.start_date  ASC;

-- 19)	Tìm những nhân viên có lương cao nhất trong từng phòng ban
SELECT  e.employee_name , dt.department_name, e.salary 
FROM employees e 
JOIN (SELECT d.department_id, d.department_name, MAX(e1.salary) as max_salary
	  FROM employees e1 
	  JOIN departments d ON e1.department_id = d.department_id 
	  GROUP BY d.department_id, d.department_name
	) dt ON e.department_id = dt.department_id AND e.salary = dt.max_salary;
 

 

-- 20)	Hiển thị danh sách nhân viên và tên quyền truy cập của họ, bao gồm những nhân viên không có quyền truy cập
SELECT e.employee_name, ar.access_level FROM employees e 
LEFT JOIN access_rights ar ON e.employee_id = ar.employee_id; 
