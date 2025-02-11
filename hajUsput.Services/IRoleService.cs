using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;

namespace hajUsput.Services
{
    public interface IRoleService : ICRUDService<Role,BaseSearchObject,RoleUpsertRequest, RoleUpsertRequest>
    {
    }
}