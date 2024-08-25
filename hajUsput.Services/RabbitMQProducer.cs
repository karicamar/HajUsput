﻿using RabbitMQ.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hajUsput.Services
{
    public class RabbitMQProducer
    {
        private readonly IConnection _connection;
        private readonly IModel _channel;

        public RabbitMQProducer()
        {
            var factory = new ConnectionFactory() { HostName = "localhost", Port = 5672 };
            _connection = factory.CreateConnection();
            _channel = _connection.CreateModel();
            _channel.QueueDeclare(queue: "emailQueue", durable: false, exclusive: false, autoDelete: false, arguments: null);
        }

        public void SendMessage(string message)
        {
            var body = Encoding.UTF8.GetBytes(message);
            _channel.BasicPublish(exchange: "", routingKey: "emailQueue", basicProperties: null, body: body);
            Console.WriteLine(" [x] Sent {0}", message);
        }
    }
}