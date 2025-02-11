using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace hajUsput.Services.Database;

public partial class _180072Context : DbContext
{
    public _180072Context()
    {
    }

    public _180072Context(DbContextOptions<_180072Context> options)
        : base(options)
    {
    }

    public virtual DbSet<Booking> Bookings { get; set; }

    public virtual DbSet<Car> Cars { get; set; }
    public virtual DbSet<CarMake> CarMakes { get; set; }


    public virtual DbSet<Gender> Genders { get; set; }

    public virtual DbSet<Location> Locations { get; set; }

    public virtual DbSet<MessageNotification> MessageNotifications { get; set; }

    public virtual DbSet<Payment> Payments { get; set; }

    public virtual DbSet<ReviewRating> ReviewRatings { get; set; }

    public virtual DbSet<Ride> Rides { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    public virtual DbSet<User> Users { get; set; }

    public virtual DbSet<UserRole> UserRoles { get; set; }
    public virtual DbSet<Preference> Preferences { get; set; }

    //protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    //{
    //    if (!optionsBuilder.IsConfigured)
    //        optionsBuilder.UseSqlServer("Server=localhost,1433;Database=180072;User=sa;Password=yourStrong(!)Password;ConnectRetryCount=0;TrustServerCertificate=True");
    //}
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        //base.OnModelCreating(modelBuilder);

        Seed(modelBuilder);

        // Log or inspect modelBuilder here to ensure it's being configured
        Console.WriteLine("OnModelCreating has been called.");
        modelBuilder.Entity<Booking>(entity =>
        {
            entity.HasKey(e => e.BookingId).HasName("PK__Bookings__73951AED68E99F23");

            entity.Property(e => e.BookingId);
            entity.Property(e => e.BookingDate).HasColumnType("datetime");
            entity.Property(e => e.BookingStatus)
                .HasMaxLength(20)
                .IsUnicode(false);

            entity.HasOne(d => d.Passenger).WithMany(p => p.Bookings)
                .HasForeignKey(d => d.PassengerId)
                .HasConstraintName("FK__Bookings__Passen__49C3F6B7");

            entity.HasOne(d => d.Ride).WithMany(p => p.Bookings)
                .HasForeignKey(d => d.RideId)
                .HasConstraintName("FK__Bookings__RideId__48CFD27E");
        });

        modelBuilder.Entity<Car>(entity =>
        {
            entity.HasKey(e => e.CarId).HasName("PK__Cars__68A0342EA4CAD173");

            entity.Property(e => e.CarId);
            entity.Property(e => e.Color)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.LicensePlateNumber)
                .HasMaxLength(20)
                .IsUnicode(false);

            entity.HasOne(d => d.Driver).WithMany(p => p.Cars)
                .HasForeignKey(d => d.DriverId)
                .HasConstraintName("FK__Cars__DriverId__4CA06362");
        });

        modelBuilder.Entity<Gender>(entity =>
        {
            entity.HasKey(e => e.GenderId).HasName("PK__Genders__4E24E9F7F36896DA");

            entity.Property(e => e.GenderId);
            entity.Property(e => e.GenderName)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Location>(entity =>
        {
            entity.HasKey(e => e.LocationId).HasName("PK__Location__E7FEA497A22466C6");

            entity.Property(e => e.LocationId);
            entity.Property(e => e.City)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.Country)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<MessageNotification>(entity =>
        {
            entity.HasKey(e => e.MessageId).HasName("PK__MessageN__C87C0C9C062F9B77");

            entity.Property(e => e.MessageId);
            entity.Property(e => e.MessageContent).HasColumnType("text");
            entity.Property(e => e.MessageDate).HasColumnType("datetime");

            entity.HasOne(d => d.Receiver).WithMany(p => p.MessageNotificationReceivers)
                .HasForeignKey(d => d.ReceiverId)
                .HasConstraintName("FK__MessageNo__Recei__5441852A");

            entity.HasOne(d => d.Sender).WithMany(p => p.MessageNotificationSenders)
                .HasForeignKey(d => d.SenderId)
                .HasConstraintName("FK__MessageNo__Sende__534D60F1");
        });

        modelBuilder.Entity<Payment>(entity =>
        {
            entity.HasKey(e => e.PaymentId).HasName("PK__Payments__9B556A3866677ECB");

            entity.Property(e => e.PaymentId);
            entity.Property(e => e.Amount).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.PaymentDate).HasColumnType("datetime");
            entity.Property(e => e.PaymentStatus)
                .HasMaxLength(20)
                .IsUnicode(false);

            entity.HasOne(d => d.Payer).WithMany(p => p.Payments)
                .HasForeignKey(d => d.PayerId)
                .HasConstraintName("FK__Payments__PayerI__5812160E");

            entity.HasOne(d => d.Ride).WithMany(p => p.Payments)
                .HasForeignKey(d => d.RideId)
                .HasConstraintName("FK__Payments__RideId__571DF1D5");
        });

        modelBuilder.Entity<ReviewRating>(entity =>
        {
            entity.HasKey(e => e.ReviewId).HasName("PK__ReviewRa__74BC79CE3F044E1B");

            entity.Property(e => e.ReviewId);
            entity.Property(e => e.Comments).HasColumnType("text");
            entity.Property(e => e.ReviewDate).HasColumnType("datetime");

            entity.HasOne(d => d.Reviewer).WithMany(p => p.ReviewRatings)
                .HasForeignKey(d => d.ReviewerId)
                .HasConstraintName("FK__ReviewRat__Revie__5070F446");

            
        });

        modelBuilder.Entity<Ride>(entity =>
        {
            entity.HasKey(e => e.RideId).HasName("PK__Rides__C5B8C4F4C377711F");

            entity.Property(e => e.RideId);
            entity.Property(e => e.DepartureDate).HasColumnType("datetime");
            entity.Property(e => e.RideStatus)
                .HasMaxLength(20)
                .IsUnicode(false);

            entity.HasOne(d => d.DepartureLocation).WithMany(p => p.RideDepartureLocations)
                .HasForeignKey(d => d.DepartureLocationId)
                .HasConstraintName("FK__Rides__Departure__44FF419A");

            entity.HasOne(d => d.DestinationLocation).WithMany(p => p.RideDestinationLocations)
                .HasForeignKey(d => d.DestinationLocationId)
                .HasConstraintName("FK__Rides__Destinati__45F365D3");

            entity.HasOne(d => d.Driver).WithMany(p => p.Rides)
                .HasForeignKey(d => d.DriverId)
                .HasConstraintName("FK__Rides__DriverId__440B1D61");
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.HasKey(e => e.RoleId).HasName("PK__Roles__8AFACE1A64D6009E");

            entity.Property(e => e.RoleId);
            entity.Property(e => e.RoleName)
                .HasMaxLength(50)
                .IsUnicode(false);
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK__Users__1788CC4C11AD459A");

            entity.Property(e => e.UserId);
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.FirstName)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.LastName)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.PasswordHash)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.PasswordSalt)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.PhoneNumber)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.RegistrationDate).HasColumnType("datetime");
            entity.Property(e => e.Username)
                .HasMaxLength(50)
                .IsUnicode(false);

            entity.HasOne(d => d.Gender).WithMany(p => p.Users)
                .HasForeignKey(d => d.GenderId)
                .HasConstraintName("FK__Users__GenderId__3B75D760");
        });

        modelBuilder.Entity<UserRole>(entity =>
        {
            entity.HasKey(e => e.UserRoleId).HasName("PK__UserRole__3D978A35A8E1E2E4");

            entity.Property(e => e.UserRoleId);

            entity.HasOne(d => d.Role).WithMany(p => p.UserRoles)
                .HasForeignKey(d => d.RoleId)
                .HasConstraintName("FK__UserRoles__RoleI__3F466844");

            entity.HasOne(d => d.User).WithMany(p => p.UserRoles)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__UserRoles__UserI__3E52440B");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
