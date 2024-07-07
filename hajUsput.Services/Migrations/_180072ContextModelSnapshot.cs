﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using hajUsput.Services.Database;

#nullable disable

namespace hajUsput.Services.Migrations
{
    [DbContext(typeof(_180072Context))]
    partial class _180072ContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "7.0.9")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("hajUsput.Services.Database.Booking", b =>
                {
                    b.Property<int>("BookingId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("BookingId"));

                    b.Property<DateTime?>("BookingDate")
                        .HasColumnType("date");

                    b.Property<string>("BookingStatus")
                        .HasMaxLength(20)
                        .IsUnicode(false)
                        .HasColumnType("varchar(20)");

                    b.Property<int?>("PassengerId")
                        .HasColumnType("int");

                    b.Property<int?>("RideId")
                        .HasColumnType("int");

                    b.HasKey("BookingId")
                        .HasName("PK__Bookings__73951AED68E99F23");

                    b.HasIndex("PassengerId");

                    b.HasIndex("RideId");

                    b.ToTable("Bookings");

                    b.HasData(
                        new
                        {
                            BookingId = 1,
                            BookingDate = new DateTime(2024, 7, 3, 20, 46, 19, 466, DateTimeKind.Local).AddTicks(5325),
                            BookingStatus = "Confirmed",
                            PassengerId = 2,
                            RideId = 1
                        });
                });

            modelBuilder.Entity("hajUsput.Services.Database.Car", b =>
                {
                    b.Property<int>("CarId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("CarId"));

                    b.Property<string>("CarType")
                        .IsRequired()
                        .HasMaxLength(50)
                        .IsUnicode(false)
                        .HasColumnType("varchar(50)");

                    b.Property<string>("Color")
                        .IsRequired()
                        .HasMaxLength(50)
                        .IsUnicode(false)
                        .HasColumnType("varchar(50)");

                    b.Property<int?>("DriverId")
                        .HasColumnType("int");

                    b.Property<string>("LicensePlateNumber")
                        .HasMaxLength(20)
                        .IsUnicode(false)
                        .HasColumnType("varchar(20)");

                    b.Property<string>("Make")
                        .IsRequired()
                        .HasMaxLength(50)
                        .IsUnicode(false)
                        .HasColumnType("varchar(50)");

                    b.Property<int?>("YearOfManufacture")
                        .HasColumnType("int");

                    b.HasKey("CarId")
                        .HasName("PK__Cars__68A0342EA4CAD173");

                    b.HasIndex("DriverId");

                    b.ToTable("Cars");

                    b.HasData(
                        new
                        {
                            CarId = 1,
                            CarType = "Sedan",
                            Color = "Red",
                            DriverId = 1,
                            LicensePlateNumber = "ABC123",
                            Make = "Toyota"
                        });
                });

            modelBuilder.Entity("hajUsput.Services.Database.Gender", b =>
                {
                    b.Property<int>("GenderId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("GenderId"));

                    b.Property<string>("GenderName")
                        .IsRequired()
                        .HasMaxLength(20)
                        .IsUnicode(false)
                        .HasColumnType("varchar(20)");

                    b.HasKey("GenderId")
                        .HasName("PK__Genders__4E24E9F7F36896DA");

                    b.ToTable("Genders");

                    b.HasData(
                        new
                        {
                            GenderId = 1,
                            GenderName = "Male"
                        },
                        new
                        {
                            GenderId = 2,
                            GenderName = "Female"
                        });
                });

            modelBuilder.Entity("hajUsput.Services.Database.Location", b =>
                {
                    b.Property<int>("LocationId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("LocationId"));

                    b.Property<string>("City")
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)");

                    b.Property<string>("Country")
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)");

                    b.HasKey("LocationId")
                        .HasName("PK__Location__E7FEA497A22466C6");

                    b.ToTable("Locations");

                    b.HasData(
                        new
                        {
                            LocationId = 1,
                            City = "New York",
                            Country = "USA"
                        },
                        new
                        {
                            LocationId = 2,
                            City = "Los Angeles",
                            Country = "USA"
                        });
                });

            modelBuilder.Entity("hajUsput.Services.Database.MessageNotification", b =>
                {
                    b.Property<int>("MessageId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("MessageId"));

                    b.Property<string>("MessageContent")
                        .HasColumnType("text");

                    b.Property<DateTime?>("MessageDate")
                        .HasColumnType("datetime");

                    b.Property<int?>("ReceiverId")
                        .HasColumnType("int");

                    b.Property<int?>("SenderId")
                        .HasColumnType("int");

                    b.HasKey("MessageId")
                        .HasName("PK__MessageN__C87C0C9C062F9B77");

                    b.HasIndex("ReceiverId");

                    b.HasIndex("SenderId");

                    b.ToTable("MessageNotifications");

                    b.HasData(
                        new
                        {
                            MessageId = 1,
                            MessageContent = "Your ride is scheduled.",
                            MessageDate = new DateTime(2024, 7, 3, 20, 46, 19, 466, DateTimeKind.Local).AddTicks(5773),
                            ReceiverId = 2,
                            SenderId = 1
                        });
                });

            modelBuilder.Entity("hajUsput.Services.Database.Payment", b =>
                {
                    b.Property<int>("PaymentId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("PaymentId"));

                    b.Property<decimal?>("Amount")
                        .HasColumnType("decimal(10, 2)");

                    b.Property<int?>("PayerId")
                        .HasColumnType("int");

                    b.Property<DateTime?>("PaymentDate")
                        .HasColumnType("date");

                    b.Property<string>("PaymentStatus")
                        .HasMaxLength(20)
                        .IsUnicode(false)
                        .HasColumnType("varchar(20)");

                    b.Property<int?>("RideId")
                        .HasColumnType("int");

                    b.HasKey("PaymentId")
                        .HasName("PK__Payments__9B556A3866677ECB");

                    b.HasIndex("PayerId");

                    b.HasIndex("RideId");

                    b.ToTable("Payments");

                    b.HasData(
                        new
                        {
                            PaymentId = 1,
                            Amount = 20.00m,
                            PayerId = 2,
                            PaymentDate = new DateTime(2024, 7, 3, 20, 46, 19, 466, DateTimeKind.Local).AddTicks(5427),
                            PaymentStatus = "Completed",
                            RideId = 1
                        });
                });

            modelBuilder.Entity("hajUsput.Services.Database.ReviewRating", b =>
                {
                    b.Property<int>("ReviewId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("ReviewId"));

                    b.Property<string>("Comments")
                        .HasColumnType("text");

                    b.Property<int?>("Rating")
                        .HasColumnType("int");

                    b.Property<DateTime?>("ReviewDate")
                        .HasColumnType("date");

                    b.Property<int?>("ReviewerId")
                        .HasColumnType("int");

                    b.Property<int?>("RideId")
                        .HasColumnType("int");

                    b.HasKey("ReviewId")
                        .HasName("PK__ReviewRa__74BC79CE3F044E1B");

                    b.HasIndex("ReviewerId");

                    b.HasIndex("RideId");

                    b.ToTable("ReviewRatings");

                    b.HasData(
                        new
                        {
                            ReviewId = 1,
                            Comments = "Great ride!",
                            ReviewDate = new DateTime(2024, 7, 3, 20, 46, 19, 466, DateTimeKind.Local).AddTicks(5662),
                            ReviewerId = 2,
                            RideId = 1
                        });
                });

            modelBuilder.Entity("hajUsput.Services.Database.Ride", b =>
                {
                    b.Property<int>("RideId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("RideId"));

                    b.Property<int?>("AvailableSeats")
                        .HasColumnType("int");

                    b.Property<DateTime>("DepartureDate")
                        .HasColumnType("date");

                    b.Property<int?>("DepartureLocationId")
                        .HasColumnType("int");

                    b.Property<int?>("DestinationLocationId")
                        .HasColumnType("int");

                    b.Property<int?>("DriverId")
                        .HasColumnType("int");

                    b.Property<int?>("Price")
                        .HasColumnType("int");

                    b.Property<string>("RideStatus")
                        .HasMaxLength(20)
                        .IsUnicode(false)
                        .HasColumnType("varchar(20)");

                    b.HasKey("RideId")
                        .HasName("PK__Rides__C5B8C4F4C377711F");

                    b.HasIndex("DepartureLocationId");

                    b.HasIndex("DestinationLocationId");

                    b.HasIndex("DriverId");

                    b.ToTable("Rides");

                    b.HasData(
                        new
                        {
                            RideId = 1,
                            DepartureDate = new DateTime(2024, 7, 3, 20, 46, 19, 466, DateTimeKind.Local).AddTicks(4827),
                            DepartureLocationId = 1,
                            DestinationLocationId = 2,
                            DriverId = 1,
                            RideStatus = "Scheduled"
                        });
                });

            modelBuilder.Entity("hajUsput.Services.Database.Role", b =>
                {
                    b.Property<int>("RoleId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("RoleId"));

                    b.Property<string>("RoleName")
                        .IsRequired()
                        .HasMaxLength(50)
                        .IsUnicode(false)
                        .HasColumnType("varchar(50)");

                    b.HasKey("RoleId")
                        .HasName("PK__Roles__8AFACE1A64D6009E");

                    b.ToTable("Roles");

                    b.HasData(
                        new
                        {
                            RoleId = 1,
                            RoleName = "Admin"
                        },
                        new
                        {
                            RoleId = 2,
                            RoleName = "User"
                        });
                });

            modelBuilder.Entity("hajUsput.Services.Database.User", b =>
                {
                    b.Property<int>("UserId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("UserId"));

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)");

                    b.Property<string>("FirstName")
                        .IsRequired()
                        .HasMaxLength(50)
                        .IsUnicode(false)
                        .HasColumnType("varchar(50)");

                    b.Property<int?>("GenderId")
                        .HasColumnType("int");

                    b.Property<bool>("IsBlocked")
                        .HasColumnType("bit");

                    b.Property<string>("LastName")
                        .IsRequired()
                        .HasMaxLength(50)
                        .IsUnicode(false)
                        .HasColumnType("varchar(50)");

                    b.Property<string>("PasswordHash")
                        .IsRequired()
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)");

                    b.Property<string>("PasswordSalt")
                        .IsRequired()
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)");

                    b.Property<string>("PhoneNumber")
                        .HasMaxLength(20)
                        .IsUnicode(false)
                        .HasColumnType("varchar(20)");

                    b.Property<DateTime?>("RegistrationDate")
                        .HasColumnType("date");

                    b.Property<string>("Username")
                        .IsRequired()
                        .HasMaxLength(50)
                        .IsUnicode(false)
                        .HasColumnType("varchar(50)");

                    b.HasKey("UserId")
                        .HasName("PK__Users__1788CC4C11AD459A");

                    b.HasIndex("GenderId");

                    b.ToTable("Users");

                    b.HasData(
                        new
                        {
                            UserId = 1,
                            Email = "admin@example.com",
                            FirstName = "Admin",
                            GenderId = 1,
                            IsBlocked = false,
                            LastName = "User",
                            PasswordHash = "adminhash",
                            PasswordSalt = "adminsalt",
                            PhoneNumber = "1234567890",
                            RegistrationDate = new DateTime(2024, 7, 3, 20, 46, 19, 466, DateTimeKind.Local).AddTicks(4625),
                            Username = "admin"
                        },
                        new
                        {
                            UserId = 2,
                            Email = "johndoe@example.com",
                            FirstName = "John",
                            GenderId = 1,
                            IsBlocked = false,
                            LastName = "Doe",
                            PasswordHash = "johnhash",
                            PasswordSalt = "johnsalt",
                            PhoneNumber = "0987654321",
                            RegistrationDate = new DateTime(2024, 7, 3, 20, 46, 19, 466, DateTimeKind.Local).AddTicks(4694),
                            Username = "johndoe"
                        });
                });

            modelBuilder.Entity("hajUsput.Services.Database.UserRole", b =>
                {
                    b.Property<int>("UserRoleId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("UserRoleId"));

                    b.Property<int?>("RoleId")
                        .HasColumnType("int");

                    b.Property<int?>("UserId")
                        .HasColumnType("int");

                    b.HasKey("UserRoleId")
                        .HasName("PK__UserRole__3D978A35A8E1E2E4");

                    b.HasIndex("RoleId");

                    b.HasIndex("UserId");

                    b.ToTable("UserRoles");

                    b.HasData(
                        new
                        {
                            UserRoleId = 1,
                            RoleId = 1,
                            UserId = 1
                        },
                        new
                        {
                            UserRoleId = 2,
                            RoleId = 2,
                            UserId = 2
                        });
                });

            modelBuilder.Entity("hajUsput.Services.Database.Booking", b =>
                {
                    b.HasOne("hajUsput.Services.Database.User", "Passenger")
                        .WithMany("Bookings")
                        .HasForeignKey("PassengerId")
                        .HasConstraintName("FK__Bookings__Passen__49C3F6B7");

                    b.HasOne("hajUsput.Services.Database.Ride", "Ride")
                        .WithMany("Bookings")
                        .HasForeignKey("RideId")
                        .HasConstraintName("FK__Bookings__RideId__48CFD27E");

                    b.Navigation("Passenger");

                    b.Navigation("Ride");
                });

            modelBuilder.Entity("hajUsput.Services.Database.Car", b =>
                {
                    b.HasOne("hajUsput.Services.Database.User", "Driver")
                        .WithMany("Cars")
                        .HasForeignKey("DriverId")
                        .HasConstraintName("FK__Cars__DriverId__4CA06362");

                    b.Navigation("Driver");
                });

            modelBuilder.Entity("hajUsput.Services.Database.MessageNotification", b =>
                {
                    b.HasOne("hajUsput.Services.Database.User", "Receiver")
                        .WithMany("MessageNotificationReceivers")
                        .HasForeignKey("ReceiverId")
                        .HasConstraintName("FK__MessageNo__Recei__5441852A");

                    b.HasOne("hajUsput.Services.Database.User", "Sender")
                        .WithMany("MessageNotificationSenders")
                        .HasForeignKey("SenderId")
                        .HasConstraintName("FK__MessageNo__Sende__534D60F1");

                    b.Navigation("Receiver");

                    b.Navigation("Sender");
                });

            modelBuilder.Entity("hajUsput.Services.Database.Payment", b =>
                {
                    b.HasOne("hajUsput.Services.Database.User", "Payer")
                        .WithMany("Payments")
                        .HasForeignKey("PayerId")
                        .HasConstraintName("FK__Payments__PayerI__5812160E");

                    b.HasOne("hajUsput.Services.Database.Ride", "Ride")
                        .WithMany("Payments")
                        .HasForeignKey("RideId")
                        .HasConstraintName("FK__Payments__RideId__571DF1D5");

                    b.Navigation("Payer");

                    b.Navigation("Ride");
                });

            modelBuilder.Entity("hajUsput.Services.Database.ReviewRating", b =>
                {
                    b.HasOne("hajUsput.Services.Database.User", "Reviewer")
                        .WithMany("ReviewRatings")
                        .HasForeignKey("ReviewerId")
                        .HasConstraintName("FK__ReviewRat__Revie__5070F446");

                    b.HasOne("hajUsput.Services.Database.Ride", "Ride")
                        .WithMany("ReviewRatings")
                        .HasForeignKey("RideId")
                        .HasConstraintName("FK__ReviewRat__RideI__4F7CD00D");

                    b.Navigation("Reviewer");

                    b.Navigation("Ride");
                });

            modelBuilder.Entity("hajUsput.Services.Database.Ride", b =>
                {
                    b.HasOne("hajUsput.Services.Database.Location", "DepartureLocation")
                        .WithMany("RideDepartureLocations")
                        .HasForeignKey("DepartureLocationId")
                        .HasConstraintName("FK__Rides__Departure__44FF419A");

                    b.HasOne("hajUsput.Services.Database.Location", "DestinationLocation")
                        .WithMany("RideDestinationLocations")
                        .HasForeignKey("DestinationLocationId")
                        .HasConstraintName("FK__Rides__Destinati__45F365D3");

                    b.HasOne("hajUsput.Services.Database.User", "Driver")
                        .WithMany("Rides")
                        .HasForeignKey("DriverId")
                        .HasConstraintName("FK__Rides__DriverId__440B1D61");

                    b.Navigation("DepartureLocation");

                    b.Navigation("DestinationLocation");

                    b.Navigation("Driver");
                });

            modelBuilder.Entity("hajUsput.Services.Database.User", b =>
                {
                    b.HasOne("hajUsput.Services.Database.Gender", "Gender")
                        .WithMany("Users")
                        .HasForeignKey("GenderId")
                        .HasConstraintName("FK__Users__GenderId__3B75D760");

                    b.Navigation("Gender");
                });

            modelBuilder.Entity("hajUsput.Services.Database.UserRole", b =>
                {
                    b.HasOne("hajUsput.Services.Database.Role", "Role")
                        .WithMany("UserRoles")
                        .HasForeignKey("RoleId")
                        .HasConstraintName("FK__UserRoles__RoleI__3F466844");

                    b.HasOne("hajUsput.Services.Database.User", "User")
                        .WithMany("UserRoles")
                        .HasForeignKey("UserId")
                        .HasConstraintName("FK__UserRoles__UserI__3E52440B");

                    b.Navigation("Role");

                    b.Navigation("User");
                });

            modelBuilder.Entity("hajUsput.Services.Database.Gender", b =>
                {
                    b.Navigation("Users");
                });

            modelBuilder.Entity("hajUsput.Services.Database.Location", b =>
                {
                    b.Navigation("RideDepartureLocations");

                    b.Navigation("RideDestinationLocations");
                });

            modelBuilder.Entity("hajUsput.Services.Database.Ride", b =>
                {
                    b.Navigation("Bookings");

                    b.Navigation("Payments");

                    b.Navigation("ReviewRatings");
                });

            modelBuilder.Entity("hajUsput.Services.Database.Role", b =>
                {
                    b.Navigation("UserRoles");
                });

            modelBuilder.Entity("hajUsput.Services.Database.User", b =>
                {
                    b.Navigation("Bookings");

                    b.Navigation("Cars");

                    b.Navigation("MessageNotificationReceivers");

                    b.Navigation("MessageNotificationSenders");

                    b.Navigation("Payments");

                    b.Navigation("ReviewRatings");

                    b.Navigation("Rides");

                    b.Navigation("UserRoles");
                });
#pragma warning restore 612, 618
        }
    }
}
