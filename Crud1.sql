--Read All Employees
CREATE PROC [DBO].[USP_GET_Employees]
AS
BEGIN
SELECT Id,FirstName,LastName,DateOfBirth,Email,Salary FROM DBO.Employees WITH (NOLOCK)
END



--GetById
CREATE PROC [DBO].[USP_GET_EmployeeById]
(
@Id INT
)
AS
BEGIN
SELECT Id,FirstName,LastName,DateOfBirth,Email,Salary FROM DBO.Employees WITH (NOLOCK)
WHERE Id=@Id
END



--Insert
ALTER PROC [DBO].[USP_Insert_Employee]
(
@FirstName   VARCHAR(50),
@LastName    VARCHAR(50),
@DateOfBirth DATE,
@Email       VARCHAR(50),
@Salary      FLOAT
)
AS
BEGIN

BEGIN TRY

BEGIN TRAN
INSERT INTO DBO.Employees(FirstName,LastName,DateOfBirth,Email,Salary)
VALUES
(
@FirstName,
@LastName,
@DateOfBirth,
@Email,
@Salary
)
COMMIT TRAN
END TRY
BEGIN CATCH
ROLLBACK TRAN
END CATCH
END


--Update
CREATE PROC [DBO].[USP_Update_Employee]
(
@Id          INT,
@FirstName   VARCHAR(50),
@LastName    VARCHAR(50),
@DateOfBirth DATE,
@Email       VARCHAR(50),
@Salary      FLOAT
)
AS
BEGIN
Declare @RowCount INT=0
BEGIN TRY
SET @RowCount=(SELECT COUNT(1) FROM DBO.Employees WITH (NOLOCK) WHERE Id=@Id)
IF(@RowCount>0)
BEGIN
BEGIN TRAN
UPDATE DBO.Employees
SET
FirstName=@FirstName,
LastName=@LastName,
DateOfBirth=@DateOfBirth,
Email=@Email,
Salary=@Salary
WHERE Id=@Id
COMMIT TRAN
END
END TRY
BEGIN CATCH
ROLLBACK TRAN
END CATCH
END


--DELETE
CREATE PROC [DBO].[USP_Delete_Employee]
(
@Id          INT
)
AS
BEGIN
Declare @RowCount INT=0
BEGIN TRY
SET @RowCount=(SELECT COUNT(1) FROM DBO.Employees WITH (NOLOCK) WHERE Id=@Id)
IF(@RowCount>0)
BEGIN
BEGIN TRAN
DELETE FROM DBO.Employees
WHERE Id=@Id
COMMIT TRAN
END
END TRY
BEGIN CATCH
ROLLBACK TRAN
END CATCH
END
