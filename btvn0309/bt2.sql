CREATE TABLE KhachHang(
	MaKH varchar(100),
	TaiKhoan varchar(100),
	MatKhau varchar(100),
	Email varchar(100),
	DiaChi varchar(100),
	HoTen varchar(100),
	NgaySinh varchar(100),
	GioiTinh varchar(4),
	DienThoai varchar(10),
	MaDonHang varchar(100),
	primary key (MaKH)

);

CREATE TABLE DonHang(
	MaDonHang varchar(100),
	DaThanhToan boolean,
	NgayGiao timestamp,
	NgayDat timestamp,
	TinhTrangGH varchar(20),
	primary key(MaDonHang)
);

CREATE TABLE ChuDe(
	MaChuDe varchar(100),
	TenChuDe varchar(100),
	MaSach varchar(100),
	primary key(MaChuDe)
);

CREATE TABLE DonHang_Sach(
	MaDonHang varchar(100),
	MaSach varchar(100),
	SoLuong int,
	DonGia double,
	primary key(MaDonHang, MaSach)
);

CREATE TABLE Sach(
	MaSach varchar(100),
	TenSach varchar(100),
	GiaBan double,
	MoTa varchar(100),
	AnhBia varchar(100),
	NgayCapNhat timestamp,
	SoLuongTon int,
	primary key (MaSach)
);

CREATE TABLE TacGia(
	MaTacGia varchar(100),
	TenTacGia varchar(50),
	DiaChi varchar(100),
	TieuSu varchar(100),
	DienThoai varchar(10),
	primary key(MaTacGia)
);

CREATE TABLE TacGia_Sach(
	MaTacGia varchar(100),
	MaSach varchar(100),
	VaiTro varchar(50),
	ViTri varchar(50),
	primary key(MaTacGia, MaSach)
);

CREATE TABLE NhaXuatBan(
	MaNSX varchar(100),
	TenNSB varchar(50),
	DiaChi varchar(50),
	DienThoai varchar(10),
	MaSach varchar(100),
	primary key(MaNSX)
);

ALTER TABLE KhachHang ADD CONSTRAINT FK_MaDonHang_KhachHang
FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang);

ALTER TABLE ChuDe ADD CONSTRAINT FK_MaSach_ChuDe
FOREIGN KEY (MaSach) REFERENCES Sach(MaSach);

ALTER TABLE NhaXuatBan ADD CONSTRAINT FK_MaSach_NXB
FOREIGN KEY (MaSach) REFERENCES Sach(MaSach);

ALTER TABLE DonHang_Sach ADD CONSTRAINT FK_MaDonHang_MaSach_DonHang
FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang);

ALTER TABLE DonHang_Sach ADD CONSTRAINT FK_MaDonHang_MaSach_Sach
FOREIGN KEY (MaSach) REFERENCES Sach(MaSach);

ALTER TABLE TacGia_Sach ADD CONSTRAINT FK_MaTacGia_MaSach_TacGia
FOREIGN KEY (MaTacGia) REFERENCES TacGia(MaTacGia);

ALTER TABLE TacGia_Sach ADD CONSTRAINT FK_MaTacGia_MaSach_Sach
FOREIGN KEY (MaSach) REFERENCES Sach(MaSach);




