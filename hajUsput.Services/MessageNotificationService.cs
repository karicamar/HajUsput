
using AutoMapper;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace hajUsput.Services
{
    public class MessageNotificationService : BaseCRUDService<Model.MessageNotification, Database.MessageNotification, MessageNotificationSearchObject, MessageNotificationInsertRequest, MessageNotificationUpdateRequest>, IMessageNotificationService
    {

        public MessageNotificationService(_180072Context context, IMapper mapper) : base(context, mapper)
        {

        }
        public async Task<List<Model.MessageNotification>> GetMessagesForUser(int userId)
        {
            var query = _context.Set<Database.MessageNotification>().AsQueryable();

            query = query.Where(x => x.ReceiverId == userId || x.SenderId == userId);

            var list = await query.ToListAsync();

            return _mapper.Map<List<Model.MessageNotification>>(list);
        }

        public async Task<Model.MessageNotification> SendMessage(MessageNotificationInsertRequest request)
        {
            var entity = _mapper.Map<Database.MessageNotification>(request);

            _context.Set<Database.MessageNotification>().Add(entity);
            await _context.SaveChangesAsync();

            return _mapper.Map<Model.MessageNotification>(entity);
        }

    }
}
