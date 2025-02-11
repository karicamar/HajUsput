using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;

namespace hajUsput.Services
{
    public interface IUserRoleService : ICRUDService<UserRole,UserRoleSearchObject,UserRoleUpsertRequest, UserRoleUpsertRequest>
    {

    }
}