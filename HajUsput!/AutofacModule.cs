using Autofac;
using AutoMapper;
using hajUsput.Services;
using hajUsput.Model;
using hajUsput.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using User = hajUsput.Model.User;
using System.Reflection;

public class AutofacModule : Autofac.Module
{
    protected override void Load(ContainerBuilder builder)
    {
        builder.Register(context =>
        {
            var config = new MapperConfiguration(cfg =>
            {
                cfg.AddProfile(new MappingProfile());
            });
            return config.CreateMapper();
        }).As<IMapper>().InstancePerLifetimeScope();

        //builder.Register(ctx => new MapperConfiguration(cfg =>
        //{

        //        cfg.AddProfile(new MappingProfile());
        //}));

        //builder.Register(ctx => ctx.Resolve<MapperConfiguration>()
        //                           .CreateMapper(ctx.Resolve))
        //       .As<IMapper>();


        //builder.Register(context => new MapperConfiguration(cfg =>
        //{
        //    cfg.CreateMap <hajUsput.Services.Database.User, User>();
        //    //etc...
        //})).AsSelf().SingleInstance();
        //builder.Register(c =>
        //{
        //    //This resolves a new context that can be used later.
        //    var context = c.Resolve<IComponentContext>();
        //    var config = context.Resolve<MapperConfiguration>();
        //    return config.CreateMapper(context.Resolve);
        //})
        //.As<IMapper>()
        //.InstancePerLifetimeScope();
        builder.RegisterAssemblyTypes(Assembly.Load("hajUsput.Services"))
              .Where(type => type.IsClass)
              .AsImplementedInterfaces();

        
        //builder.RegisterType<UserService>().As<IUserService>().InstancePerDependency();
        //builder.RegisterAssemblyTypes(Assembly.Load("hajUsput.Services"))
        //     .Where(t => t.Namespace.Contains("Services"))
        //     .As(t => t.GetInterfaces().FirstOrDefault(i => i.Name == "I" + t.Name));
    }
}