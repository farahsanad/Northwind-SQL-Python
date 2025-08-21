use Northwind;

-- getting to know the data
SELECT TOP 10 * FROM dbo.Customers;
SELECT TOP 10 * FROM dbo.Orders;
SELECT TOP 10 * FROM dbo.[Order Details];
SELECT TOP 10 * FROM dbo.Products;
SELECT TOP 10 * FROM dbo.Employees;


SELECT 
    o.OrderID,
    o.OrderDate,
    YEAR(o.OrderDate) AS OrderYear,
    MONTH(o.OrderDate) AS OrderMonth,
    DATENAME(WEEKDAY, o.OrderDate) AS OrderDayName,
    DATEDIFF(DAY, o.OrderDate, GETDATE()) AS DaysSinceOrder,
    c.CustomerID,
    c.CompanyName AS Customer,
    c.Country,
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS Employee,
    p.ProductID,
    p.ProductName,
    p.CategoryID,
    p.UnitPrice AS ProductUnitPrice,
    p.UnitsInStock,
    p.UnitsOnOrder,
    od.Quantity,
    od.UnitPrice AS OrderUnitPrice,
    od.Quantity * od.UnitPrice AS Total

FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
JOIN Products p ON od.ProductID = p.ProductID;


SELECT TOP 10 
    p.ProductName,
    SUM(od.UnitPrice * od.Quantity) AS TotalSales
FROM [Order Details] od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalSales DESC;


SELECT 
    e.FirstName + ' ' + e.LastName AS Employee,
    SUM(od.UnitPrice * od.Quantity) AS TotalSales
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
GROUP BY e.FirstName, e.LastName
ORDER BY TotalSales DESC;

SELECT 
    FORMAT(o.OrderDate, 'yyyy-MM') AS OrderMonth,
    SUM(od.UnitPrice * od.Quantity) AS TotalSales
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY FORMAT(o.OrderDate, 'yyyy-MM')
ORDER BY OrderMonth;

SELECT 
    c.Country,
    SUM(od.UnitPrice * od.Quantity) AS TotalSales
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.Country
ORDER BY TotalSales DESC;

SELECT TOP 5
    c.CompanyName AS Customer,
    SUM(od.UnitPrice * od.Quantity) AS TotalSales
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName
ORDER BY TotalSales DESC;


SELECT 
    c.CompanyName AS Customer,
    YEAR(o.OrderDate) AS OrderYear,
    SUM(od.UnitPrice * od.Quantity) AS TotalSales
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) IN (1996, 1998)
GROUP BY c.CompanyName, YEAR(o.OrderDate)


SELECT 
    c.CompanyName AS Customer,
    YEAR(o.OrderDate) AS OrderYear,
    SUM(od.UnitPrice * od.Quantity) AS TotalSales
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) IN (1996, 1998)
GROUP BY c.CompanyName, YEAR(o.OrderDate)