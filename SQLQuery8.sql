--2. Viết các câu lệnh để tạo các bảng như thiết kế câu 1
CREATE TABLE Asm5_Users (
	ID INT  PRIMARY KEY identity(1,1) ,
	HoTen nvarchar(255) NOT NULL,
	DiaChi nvarchar(255) NOT NULL,
	Ngaysinh Date NOT NULL check( Ngaysinh < getdate())
	
);

CREATE TABLE Asm5_Tels (
	ID INT  PRIMARY KEY identity(1,1),
	SoDT varchar(50) NOT NULL unique,
	UserID INT NOT NULL FOREIGN KEY  REFERENCES Asm5_Users(ID)
);
--drop table  Asm5_Users
--drop table Asm5_Tels
--delete  from  Asm5_Users

--3. Viết các câu lệnh để thêm dữ liệu vào các bảng
insert into Asm5_Users(HoTen,Ngaysinh,DiaChi)
values (N'Nguyễn Văn An','1987-11-18',N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội');



insert into Asm5_Tels(SoDT,UserID)
values ('987654321',1),('09873452',1),('09832323',1),('09434343',1);



--4. Viết các câu lênh truy vấn để
--a) Liệt kê danh sách những người trong danh bạ

select * from  Asm5_Users;

--b) Liệt kê danh sách số điện thoại có trong danh bạ

select * from Asm5_Tels;

--5. Viết các câu lệnh truy vấn để lấy
--a) Liệt kê danh sách người trong danh bạ theo thứ thự alphabet.
select * from  Asm5_Users order by HoTen asc;
--b) Liệt kê các số điện thoại của người có thên là Nguyễn Văn An.
select   A.ID, A.SoDT, B.HoTen from  Asm5_Tels A 
left join Asm5_Users B on A.UserID = B.ID 
where UserID in (select ID from Asm5_Users where HoTen like N'Nguyễn Văn An');
--c) Liệt kê những người có ngày sinh là 12/12/09
select * from Asm5_Users where Ngaysinh = '2009-12-12';
--6. Viết các câu lệnh truy vấn để
--a) Tìm số lượng số điện thoại của mỗi người trong danh bạ.
select UserID,count(SoDT) as SoLgDT from Asm5_Tels group by UserID
--b) Tìm tổng số người trong danh bạ sinh vào thang 12.
select Count(ID) as SoNg from Asm5_Users where Ngaysinh like '%-12-%';
--c) Hiển thị toàn bộ thông tin về người, của từng số điện thoại.
select   A.ID, A.SoDT, A.UserID, B.HoTen, B.DiaChi, B.Ngaysinh from  Asm5_Tels A 
left join Asm5_Users B on A.UserID = B.ID ;

--d) Hiển thị toàn bộ thông tin về người, của số điện thoại 123456789.
select * from Asm5_Users where ID in
(select UserID from Asm5_Tels where SoDT like '123456789');

--7. Thay đổi những thư sau từ cơ sở dữ liệu
--a) Viết câu lệnh để thay đổi trường ngày sinh là trước ngày hiện tại.
alter table Asm5_Users  add constraint check_pointBD check(NgaySinh < getdate());

--b) Viết câu lệnh để xác định các trường khóa chính và khóa ngoại của các bảng.
select ID from dbo.Asm5_Users;
select ID from dbo.Asm5_Tels;
select UserID from dbo.Asm5_Tels;

--c) Viết câu lệnh để thêm trường ngày bắt đầu liên lạc.

alter table Asm5_Tels add NgayBatDauLienLac date;

--8. Thực hiện các yêu cầu sau

--a) Thực hiện các chỉ mục sau(Index)
-- IX_HoTen : đặt chỉ mục cho cột Họ và tên

create index ChiMucHOTEN on Asm5_Users(HoTen);

-- IX_SoDienThoai: đặt chỉ mục cho cột Số điện thoại

Create index ChiMucDT on Asm5_Tels(SoDT);

--b) Viết các View sau:
--View_SoDienThoai: hiển thị các thông tin gồm Họ tên, Số điện thoại

CREATE VIEW View_SoDienThoai AS
SELECT	Asm5_Tels.SoDT, Asm5_Users.HoTen
FROM	Asm5_Tels INNER JOIN
			Asm5_Users ON Asm5_Tels.UserID = Asm5_Users.ID

select * from View_SoDienThoai

--View_SinhNhat: Hiển thị những người có sinh nhật trong tháng hiện tại (Họ tên, Ngày
--sinh, Số điện thoại)

CREATE VIEW View_SinhNhat AS
SELECT	 Asm5_Users.HoTen , Asm5_Users.Ngaysinh, Asm5_Tels.SoDT
FROM	Asm5_Tels INNER JOIN
			Asm5_Users ON Asm5_Tels.UserID = Asm5_Users.ID

select * from View_SinhNhat

--c) Viết các Store Procedure sau:
--SP_Them_DanhBa: Thêm một người mới vào danh bạ

--SP_Tim_DanhBa: Tìm thông tin liên hệ của một người theo tên (gần đúng)
