-- 1)	Liệt kê tên nhân viên và tên phòng ban của họ
SELECT e.name, d.department_name FROM employees e 
JOIN departments d ON e.department_id = d.department_id 

-- 2)	Liệt kê tên nhân viên và tên dự án mà họ tham gia
SELECT e.name, p.project_name FROM employees e 
JOIN employee_projects ep ON e.employee_id = ep.employee_id 
JOIN projects p ON ep.project_id = p.project_id 


-- 3)	Liệt kê tên phòng ban, tên dự án và tên nhân viên tham gia dự án đó.
SELECT d.department_name, p.project_name, e.name FROM employees e 
JOIN departments d ON e.department_id = d.department_id 
JOIN projects p ON d.department_id = p.department_id 


-- 4)	Tính tổng lương của nhân viên tham gia từng dự án
SELECT p.project_name, SUM(e.salary) as tong_luong FROM employees e 
JOIN employee_projects ep ON e.employee_id = ep.employee_id 
JOIN projects p ON ep.project_id = p.project_id
GROUP BY p.project_name 

-- 5)	Liệt kê tên nhân viên, tên quản lý của họ và tên dự án họ tham gia
SELECT e.name, e2.name as manager_name, p.project_name 
FROM employees e 
LEFT JOIN employees e2 ON e.employee_id = e2.manager_id 
JOIN employee_projects ep ON e.employee_id = ep.employee_id 
JOIN projects p ON p.project_id = ep.project_id 



-- 6)	Liệt kê tên phòng ban và số lượng nhân viên tham gia dự án của từng phòng ban
SELECT d.department_name, COUNT(0) as SoLuongNhanVien
FROM employees e 
JOIN employee_projects ep ON e.employee_id = ep.employee_id 
JOIN projects p ON p.project_id = ep.project_id 
JOIN departments d ON e.department_id = d.department_id 
GROUP BY d.department_name

-- 7)	Tìm tên nhân viên có lương cao nhất tham gia trong mỗi dự án
SELECT p.project_name, e.name, e.salary
FROM employee_projects ep
JOIN employees e ON ep.employee_id = e.employee_id
JOIN projects p ON ep.project_id = p.project_id
WHERE (ep.project_id, e.salary) IN (
    SELECT ep.project_id, MAX(e.salary)
    FROM employee_projects ep
    JOIN employees e ON ep.employee_id = e.employee_id
    GROUP BY ep.project_id
);






-- 8)	Liệt kê tên dự án và tổng số nhân viên tham gia, sắp xếp theo tổng số nhân viên giảm dần
SELECT p.project_name, SUM(e.employee_id) as TongSoNhanVien FROM employees e 
JOIN employee_projects ep ON e.employee_id = ep.employee_id 
JOIN projects p ON ep.project_id = p.project_id 
GROUP BY p.project_name 
ORDER BY TongSoNhanVien DESC 


-- 9)	Tính lương trung bình của nhân viên trong từng phòng ban tham gia dự án
SELECT  d.department_name , AVG(e.salary) as LuongTrungBinh FROM employees e 
JOIN employee_projects ep ON e.employee_id = ep.employee_id 
JOIN projects p ON p.project_id = ep.project_id 
JOIN departments d ON e.department_id = d.department_id 
GROUP BY d.department_id 

-- 10)	Tìm tên nhân viên và dự án mà họ tham gia ít nhất một lần trong mỗi phòng ban
SELECT e.name , p.project_name, COUNT(0) as SL  FROM employees e 
JOIN employee_projects ep ON e.employee_id = ep.employee_id 
JOIN projects p ON p.project_id = ep.project_id 
JOIN departments d ON e.department_id = d.department_id 
GROUP BY  p.project_id , e.name 
HAVING SL > 0

SELECT e.name AS employee_name, p.project_name, d.department_name
FROM employees e
JOIN employee_projects ep ON e.employee_id = ep.employee_id
JOIN projects p ON ep.project_id = p.project_id
JOIN departments d ON p.department_id = d.department_id
GROUP BY e.name, p.project_name, d.department_name
HAVING COUNT(DISTINCT d.department_id) = (SELECT COUNT(*) FROM departments);

-- 11)	Tìm tên nhân viên và số lượng dự án mà họ tham gia nhiều nhất
SELECT  e.name , COUNT(p.project_id) as project_count 
FROM employees e
JOIN employee_projects ep ON e.employee_id = ep.employee_id 
JOIN projects p ON p.project_id = ep.project_id 
GROUP BY e.name 
ORDER BY project_count DESC 
LIMIT 1


-- 12)	Tìm tên phòng ban và số lượng dự án mà phòng ban đó quản lý nhiều nhất
SELECT d.department_name, COUNT(p.project_id) as project_count
FROM departments d 
JOIN projects p ON d.department_id = p.department_id 
GROUP BY d.department_name 
ORDER BY project_count DESC 
LIMIT 1



-- 13)	Tìm tên nhân viên có lương thấp nhất trong từng dự án
SELECT p.project_name, e.name AS employee_name, e.salary
FROM employee_projects ep
JOIN employees e ON ep.employee_id = e.employee_id
JOIN projects p ON ep.project_id = p.project_id
WHERE (ep.project_id, e.salary) IN (
    SELECT ep.project_id, MIN(e.salary)
    FROM employee_projects ep
    JOIN employees e ON ep.employee_id = e.employee_id
    GROUP BY ep.project_id
    HAVING COUNT(ep.employee_id) > 1
);


-- 14)	Liệt kê tên tất cả các dự án không có nhân viên tham gia
 SELECT p.project_name 
 FROM employees e 
 JOIN employee_projects ep ON e.employee_id = ep.employee_id 
 RIGHT JOIN projects p ON p.project_id = ep.project_id
 WHERE e.employee_id IS NULL 
 


-- 15)	Tìm tên nhân viên có lương cao nhất và thấp nhất trong mỗi phòng ban
SELECT d.department_name, 
       e.name AS nhanvienluongcaonhat, e.salary, 
       e2.name AS nhanvienluongthapnhat, e2.salary 
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN employees e2 ON d.department_id = e2.department_id
WHERE e.salary = (
    SELECT MAX(e3.salary) 
    FROM employees e3 
    WHERE e3.department_id = d.department_id
)
AND e2.salary = (
    SELECT MIN(e4.salary) 
    FROM employees e4 
    WHERE e4.department_id = d.department_id
)
GROUP BY d.department_name, e.name, e.salary, e2.name, e2.salary ;




-- 16)	Tính tổng lương và số lượng nhân viên cho từng dự án trong mỗi phòng ban
SELECT d.department_name, p.project_name, COUNT(e.employee_id) AS demnhanvien, SUM(e.salary) AS tongLuong
FROM employee_projects ep
JOIN employees e ON ep.employee_id = e.employee_id
JOIN projects p ON ep.project_id = p.project_id
JOIN departments d ON p.department_id = d.department_id
GROUP BY d.department_name, p.project_name;


-- 17)	Tìm tên các nhân viên không tham gia bất kỳ dự án nào
SELECT e.name 
FROM employees e
LEFT JOIN employee_projects ep ON e.employee_id = ep.employee_id
WHERE ep.employee_id IS NULL;


-- 18)	Tính tổng số dự án mà mỗi phòng ban đang quản lý
SELECT d.department_name, COUNT(p.project_id) AS tongDuAn
FROM departments d
JOIN projects p ON d.department_id = p.department_id
GROUP BY d.department_name;


-- 19)	Tìm tên nhân viên và tên dự án mà nhân viên có lương cao nhất tham gia trong từng phòng ban
SELECT d.department_name, p.project_name, e.name , e.salary
FROM employee_projects ep
JOIN employees e ON ep.employee_id = e.employee_id
JOIN projects p ON ep.project_id = p.project_id
JOIN departments d ON p.department_id = d.department_id
WHERE (d.department_id, e.salary) IN (
    SELECT d.department_id, MAX(e.salary)
    FROM employee_projects ep
    JOIN employees e ON ep.employee_id = e.employee_id
    JOIN projects p ON ep.project_id = p.project_id
    JOIN departments d ON p.department_id = d.department_id
    GROUP BY d.department_id
);


-- 20)	Tính tổng lương của nhân viên trong mỗi phòng ban theo từng dự án mà không có nhân viên tham gia dự án
SELECT d.department_name, p.project_name, SUM(e.salary) AS tongLuong
FROM projects p
JOIN departments d ON p.department_id = d.department_id
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
LEFT JOIN employees e ON e.department_id = d.department_id
WHERE ep.project_id IS NULL
GROUP BY d.department_name, p.project_name;


