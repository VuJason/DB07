CREATE TABLE SanPham(
	MaSP varchar(100),
	TenSP varchar(100),
	MoTa varchar(100),
	Gia double,
	MaLoaiSP varchar(100),
	
	primary key(MaSP)
);



CREATE TABLE LoaiSanPham(
	MaLoaiSP varchar(100),
	TenLoaiSP varchar(100),
	
	primary key(MaLoaiSP)
);


ALTER TABLE SanPham ADD CONSTRAINT FK_MaLoaiSP_SanPham
FOREIGN KEY (MaLoaiSP) REFERENCES LoaiSanPham(MaLoaiSP);


CREATE TABLE SanPham_HoaDon(
	MaSP varchar(100),
	MaHoaDon varchar(100),
	SoLuong int,
	GiaBan double,
	primary key(MaSP, MaHoaDon)
);



CREATE TABLE HoaDon(
	MaHoaDon varchar(100),
	NgayMua timestamp,
	MaKH varchar(100),
	
	primary key(MaHoaDon)
);

CREATE TABLE KhachHang(
	MaKH varchar(100),
	Ho varchar(50),
	Ten varchar(50),
	DiaChi varchar(100),
	SoDT varchar(10),
	Email varchar(100),
	primary key(MaKH)
	

);

ALTER TABLE SanPham_HoaDon ADD CONSTRAINT FK_SanPham
FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP);

ALTER TABLE SanPham_HoaDon ADD CONSTRAINT FK_HoaDon
FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon);

ALTER TABLE HoaDon ADD CONSTRAINT FK_MaKH_HoaDon
FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH);

