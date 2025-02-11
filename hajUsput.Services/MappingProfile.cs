using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hajUsput.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Database.User, Model.User>();
            CreateMap<Model.Requests.UserInsertRequest, Database.User>();
            CreateMap<Model.Requests.UserUpdateRequest, Database.User>();

            CreateMap<Database.Car, Model.Car>();
            CreateMap<Model.Requests.CarInsertRequest, Database.Car>();
            CreateMap<Model.Requests.CarUpdateRequest, Database.Car>();

            CreateMap<Database.Ride, Model.Ride>();
            CreateMap<Model.Requests.RideInsertRequest, Database.Ride>();
            CreateMap<Model.Requests.RideUpdateRequest, Database.Ride>();

            CreateMap<Database.Preference, Model.Preference>();
            CreateMap<Model.Requests.PreferenceUpsertRequest, Database.Preference>();
            CreateMap<Model.Requests.PreferenceUpsertRequest, Database.Preference>();

            CreateMap<Database.Gender, Model.Gender>();
            CreateMap<Model.Requests.GenderUpsertRequest, Database.Gender>();

            CreateMap<Database.Role, Model.Role>();
            CreateMap<Model.Requests.RoleUpsertRequest, Database.Role>(); 

            CreateMap<Database.UserRole, Model.UserRole>();
            CreateMap<Model.Requests.UserRoleUpsertRequest, Database.UserRole>();


            CreateMap<Database.CarMake, Model.CarMake>();
            CreateMap<Model.Requests.CarMakeUpsertRequest, Database.CarMake>();

            CreateMap<Database.Booking, Model.Booking>();
            CreateMap<Model.Requests.BookingInsertRequest, Database.Booking>();
            CreateMap<Model.Requests.BookingUpdateRequest, Database.Booking>();

            CreateMap<Database.MessageNotification, Model.MessageNotification>();
            CreateMap<Model.Requests.MessageNotificationInsertRequest, Database.MessageNotification>();
            CreateMap<Model.Requests.MessageNotificationUpdateRequest, Database.MessageNotification>();

            CreateMap<Database.ReviewRating, Model.ReviewRating>();
            CreateMap<Model.Requests.ReviewRatingInsertRequest, Database.ReviewRating>();
            CreateMap<Model.Requests.ReviewRatingUpdateRequest, Database.ReviewRating>();

            CreateMap<Database.Payment, Model.Payment>();
            CreateMap<Model.Requests.PaymentInsertRequest, Database.Payment>();
            CreateMap<Model.Requests.PaymentUpdateRequest, Database.Payment>();

            CreateMap<Database.Location, Model.Location>();
            CreateMap<Model.Requests.LocationInsertRequest, Database.Location>();
            CreateMap<Model.Requests.LocationUpdateRequest, Database.Location>();
        }
    }
}
