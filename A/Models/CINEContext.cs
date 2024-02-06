using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace A.Models
{
    public partial class CINEContext : DbContext
    {
        public CINEContext()
        {
        }

        public CINEContext(DbContextOptions<CINEContext> options)
            : base(options)
        {
        }

        public virtual DbSet<BaseEntity> BaseEntities { get; set; } = null!;
        public virtual DbSet<BillboardEntity> BillboardEntities { get; set; } = null!;
        public virtual DbSet<BookingEntity> BookingEntities { get; set; } = null!;
        public virtual DbSet<CustomerEntity> CustomerEntities { get; set; } = null!;
        public virtual DbSet<MovieEntity> MovieEntities { get; set; } = null!;
        public virtual DbSet<MovieGenreEnum> MovieGenreEnums { get; set; } = null!;
        public virtual DbSet<RoomEntity> RoomEntities { get; set; } = null!;
        public virtual DbSet<SeatEntity> SeatEntities { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Server=LEXSATOSHI; Database=CINE; Trusted_Connection=True; TrustServerCertificate=True ");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<BaseEntity>(entity =>
            {
                entity.ToTable("BaseEntity");

                entity.Property(e => e.Id).ValueGeneratedNever();

                entity.Property(e => e.Status)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");
            });

            modelBuilder.Entity<BillboardEntity>(entity =>
            {
                entity.ToTable("BillboardEntity");

                entity.Property(e => e.Id).ValueGeneratedNever();

                entity.Property(e => e.DateBillboard).HasColumnType("date");

                entity.HasOne(d => d.IdNavigation)
                    .WithOne(p => p.BillboardEntity)
                    .HasForeignKey<BillboardEntity>(d => d.Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_BillboardEntity_BaseEntity");

                entity.HasOne(d => d.Movie)
                    .WithMany(p => p.BillboardEntities)
                    .HasForeignKey(d => d.MovieId)
                    .HasConstraintName("FK_BillboardEntity_MovieEntity");

                entity.HasOne(d => d.Room)
                    .WithMany(p => p.BillboardEntities)
                    .HasForeignKey(d => d.RoomId)
                    .HasConstraintName("FK_BillboardEntity_RoomEntity");
            });

            modelBuilder.Entity<BookingEntity>(entity =>
            {
                entity.ToTable("BookingEntity");

                entity.Property(e => e.Id).ValueGeneratedNever();

                entity.Property(e => e.DateBooking).HasColumnType("date");

                entity.HasOne(d => d.Billboard)
                    .WithMany(p => p.BookingEntities)
                    .HasForeignKey(d => d.BillboardId)
                    .HasConstraintName("FK_BookingEntity_BillboardEntity");

                entity.HasOne(d => d.Customer)
                    .WithMany(p => p.BookingEntities)
                    .HasForeignKey(d => d.CustomerId)
                    .HasConstraintName("FK_BookingEntity_CustomerEntity");

                entity.HasOne(d => d.IdNavigation)
                    .WithOne(p => p.BookingEntity)
                    .HasForeignKey<BookingEntity>(d => d.Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_BookingEntity_BaseEntity");

                entity.HasOne(d => d.Seat)
                    .WithMany(p => p.BookingEntities)
                    .HasForeignKey(d => d.SeatId)
                    .HasConstraintName("FK_BookingEntity_SeatEntity");
            });

            modelBuilder.Entity<CustomerEntity>(entity =>
            {
                entity.ToTable("CustomerEntity");

                entity.HasIndex(e => e.DocumentNumber, "UQ__Customer__689939180DFB452F")
                    .IsUnique();

                entity.Property(e => e.Id).ValueGeneratedNever();

                entity.Property(e => e.DocumentNumber).HasMaxLength(20);

                entity.Property(e => e.Email).HasMaxLength(100);

                entity.Property(e => e.Lastname).HasMaxLength(30);

                entity.Property(e => e.NameCustomer).HasMaxLength(30);

                entity.Property(e => e.PhoneNumber).HasMaxLength(20);

                entity.HasOne(d => d.IdNavigation)
                    .WithOne(p => p.CustomerEntity)
                    .HasForeignKey<CustomerEntity>(d => d.Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CustomerEntity_BaseEntity");
            });

            modelBuilder.Entity<MovieEntity>(entity =>
            {
                entity.ToTable("MovieEntity");

                entity.Property(e => e.Id).ValueGeneratedNever();

                entity.Property(e => e.NameMovie).HasMaxLength(100);

                entity.HasOne(d => d.IdNavigation)
                    .WithOne(p => p.MovieEntity)
                    .HasForeignKey<MovieEntity>(d => d.Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_MovieEntity_BaseEntity");
            });

            modelBuilder.Entity<MovieGenreEnum>(entity =>
            {
                entity.ToTable("MovieGenreEnum");

                entity.Property(e => e.Id).ValueGeneratedNever();

                entity.Property(e => e.GenreName).HasMaxLength(20);
            });

            modelBuilder.Entity<RoomEntity>(entity =>
            {
                entity.ToTable("RoomEntity");

                entity.Property(e => e.Id).ValueGeneratedNever();

                entity.Property(e => e.NameRoom).HasMaxLength(50);

                entity.HasOne(d => d.IdNavigation)
                    .WithOne(p => p.RoomEntity)
                    .HasForeignKey<RoomEntity>(d => d.Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_RoomEntity_BaseEntity");
            });

            modelBuilder.Entity<SeatEntity>(entity =>
            {
                entity.ToTable("SeatEntity");

                entity.Property(e => e.Id).ValueGeneratedNever();

                entity.HasOne(d => d.IdNavigation)
                    .WithOne(p => p.SeatEntity)
                    .HasForeignKey<SeatEntity>(d => d.Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_SeatEntity_BaseEntity");

                entity.HasOne(d => d.Room)
                    .WithMany(p => p.SeatEntities)
                    .HasForeignKey(d => d.RoomId)
                    .HasConstraintName("FK_SeatEntity_RoomEntity");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
