-- 1)	Liệt kê tên sản phẩm và tên nhà cung cấp cho tất cả các sản phẩm có giá lớn hơn 15.00
	SELECT p.ProductName, s.SupplierName FROM Products p 
	JOIN Suppliers s ON p.SupplierID = s.SupplierID 
	WHERE p.Price > 15.00
	
 
-- 2)	Tìm tất cả các đơn hàng được thực hiện bởi khách hàng ở "Mexico"
	SELECT * FROM Orders o 
	JOIN Customers c ON o.CustomerID = c.CustomerID 
	WHERE c.Country LIKE "Mexico"
	


-- 3)	Tìm số lượng đơn hàng được thực hiện trong mỗi quốc gia
		SELECT c.Country, SUM(od.Quantity) AS so_luong_don_hang FROM OrderDetails od 
		JOIN Orders o ON od.OrderID = o.OrderID 
		JOIN Customers c ON o.CustomerID = c.CustomerID 
		GROUP BY c.Country 


-- 4)	Liệt kê tất cả các nhà cung cấp và số lượng loại sản phẩm mà họ cung cấp
	SELECT s.SupplierName, COUNT(p.ProductID) as so_luong_san_pham_cung_cap FROM Products p 
	RIGHT JOIN Suppliers s ON p.SupplierID = s.SupplierID 
	GROUP BY s.SupplierName 


-- 5)	Liệt kê tên sản phẩm và giá của các sản phẩm đắt hơn sản phẩm "Chang"
	SELECT p.ProductName, p.Price FROM Products p 
	WHERE p.Price > (SELECT p2.Price from Products p2
					WHERE p2.ProductName LIKE "Chang"
					);


-- 6)	Tìm tổng số lượng sản phẩm bán ra trong tháng 5 năm 2024
	SELECT p.ProductName, SUM(od.Quantity ) , o.OrderDate FROM Products p 
	JOIN OrderDetails od on p.ProductID = od.OrderDetailID 
	JOIN Orders o on od.OrderID = o.OrderID 
	WHERE MONTH(o.OrderDate) = 5 AND YEAR(o.OrderDate) = 2024 
	GROUP BY p.ProductName, o.OrderDate ; 

-- 7)	Tìm tên của các khách hàng chưa từng đặt hàng
	SELECT * FROM Customers c 
	WHERE c.CustomerID NOT IN (
	SELECT o.CustomerID FROM Orders o 
	)
	
	

-- 8)	Liệt kê các đơn hàng với tổng số tiền lớn hơn 200.00


-- 9)	Tìm tên sản phẩm và số lượng trung bình được đặt hàng cho mỗi đơn hàng


-- 10)	Tìm khách hàng có tổng giá trị đơn hàng cao nhất
	SELECT o.OrderID FROM Orders o 
	JOIN OrderDetails od ON o.OrderID = od.OrderID 
	JOIN Products p ON p.ProductID = od.ProductID 
	GROUP BY o.OrderID 
	

-- 11)	Tìm các đơn hàng có tổng giá trị nằm trong top 10 cao nhất


-- 12)	Tìm tên khách hàng và số lượng đơn hàng của họ, chỉ bao gồm các khách hàng có số lượng đơn hàng lớn hơn mức trung bình


-- 13)	Tìm sản phẩm có giá trị đơn hàng trung bình cao nhất (dựa trên giá sản phẩm và số lượng).



-- 14)	Liệt kê các sản phẩm chưa bao giờ được đặt hàng bởi khách hàng đến từ "USA"



-- 15)	Tìm nhà cung cấp có số lượng sản phẩm cung cấp nhiều nhất.



